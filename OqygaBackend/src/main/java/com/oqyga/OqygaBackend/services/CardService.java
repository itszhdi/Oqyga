package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.CardRequest;
import com.oqyga.OqygaBackend.dto.CardResponse;
import com.oqyga.OqygaBackend.entities.Card;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.CardRepository;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import com.oqyga.OqygaBackend.security.SecurityUtils;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Customer;
import com.stripe.model.PaymentMethod;
import com.stripe.param.CustomerCreateParams;
import com.stripe.param.PaymentMethodAttachParams;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
public class CardService {

    @Value("${stripe.api.key}")
    private String stripeApiKey;

    private final CardRepository cardRepository;
    private final UserRepository userRepository;
    private final SecurityUtils securityUtils;

    public CardService(CardRepository cardRepository,
                       UserRepository userRepository,
                       SecurityUtils securityUtils) {
        this.cardRepository = cardRepository;
        this.userRepository = userRepository;
        this.securityUtils = securityUtils;
    }

    @PostConstruct
    public void init() {
        if (stripeApiKey != null && !stripeApiKey.isEmpty()) {
            Stripe.apiKey = stripeApiKey;
            log.info("Stripe API запущен.");
        }
    }

    @Transactional(readOnly = true)
    public List<CardResponse> getUserCards(int userId) {
        List<Card> cards = cardRepository.findByUserUserId(userId);
        return cards.stream()
                .map(card -> CardResponse.builder()
                        .id(card.getToken_id())
                        .lastFourDigits(card.getLast_four_digits())
                        .brand(card.getBrand())
                        .message("Saved")
                        .build())
                .collect(Collectors.toList());
    }

    public String getDecryptedToken(int cardId) {
        Card card = cardRepository.findById(cardId)
                .orElseThrow(() -> new RuntimeException("Card not found"));
        return securityUtils.decrypt(card.getPayment_token());
    }

    @Transactional
    public Card saveCard(CardRequest request) throws StripeException {
        log.info("Начат saveCard процесс для userId: {}", request.getUserId());

        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        PaymentMethod paymentMethod = PaymentMethod.retrieve(request.getPaymentMethodId());

        String rawFingerprint = paymentMethod.getCard().getFingerprint();
        String cardBrand = paymentMethod.getCard().getBrand();

        String hashedFingerprint = securityUtils.hash(rawFingerprint);

        if (cardRepository.existsByUserUserIdAndFingerprint(user.getUserId(), hashedFingerprint)) {
            log.warn("Попытка добавить дубликат карты (fingerprint match). UserId: {}", user.getUserId());
            throw new RuntimeException("Эта карта уже добавлена");
        }

        if (user.getStripeCustomerId() == null || user.getStripeCustomerId().isEmpty()) {
            CustomerCreateParams params = CustomerCreateParams.builder()
                    .setEmail(user.getEmail())
                    .setName(user.getUsername())
                    .build();
            Customer customer = Customer.create(params);
            user.setStripeCustomerId(customer.getId());
            userRepository.save(user);
        }

        log.info("Прикрепление PaymentMethod к Пользователю...");
        PaymentMethodAttachParams attachParams = PaymentMethodAttachParams.builder()
                .setCustomer(user.getStripeCustomerId())
                .build();
        paymentMethod = paymentMethod.attach(attachParams);

        String encryptedToken = securityUtils.encrypt(paymentMethod.getId());

        Card card = Card.builder()
                .payment_token(encryptedToken)
                .last_four_digits(paymentMethod.getCard().getLast4())
                .brand(cardBrand)
                .fingerprint(hashedFingerprint)
                .user(user)
                .build();

        log.info("Карта успешно сохранена.");

        return cardRepository.save(card);
    }

    @Transactional
    public void deleteCard(int cardId, int userId) {
        log.info("Запрос на удаление карты ID: {} пользователем ID: {}", cardId, userId);

        Card card = cardRepository.findById(cardId)
                .orElseThrow(() -> new RuntimeException("Карта не найдена"));

        if (card.getUser().getUserId() != userId) {
            log.error("Попытка удаления чужой карты. UserID: {}, CardOwnerID: {}", userId, card.getUser().getUserId());
            throw new RuntimeException("Доступ запрещен: это не ваша карта");
        }
        try {
            String paymentMethodId = securityUtils.decrypt(card.getPayment_token());

            PaymentMethod paymentMethod = PaymentMethod.retrieve(paymentMethodId);
            paymentMethod.detach();
            log.info("Карта {} успешно отвязана от Stripe Customer", paymentMethodId);

        } catch (StripeException e) {
            log.warn("Ошибка при отвязке карты в Stripe (возможно, она уже удалена): {}", e.getMessage());
        } catch (Exception e) {
            log.error("Ошибка расшифровки или удаления: {}", e.getMessage());
            throw new RuntimeException("Ошибка при удалении карты");
        }
        cardRepository.delete(card);
        log.info("Карта ID: {} успешно удалена из БД", cardId);
    }
}