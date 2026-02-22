package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.*;
import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Promocode;
import com.oqyga.OqygaBackend.entities.Ticket;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.EventRepository;
import com.oqyga.OqygaBackend.repositories.PromocodeRepository;
import com.oqyga.OqygaBackend.repositories.TicketRepository;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import com.oqyga.OqygaBackend.specifications.TicketSpecification;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class TicketService {

    private final TicketRepository ticketRepository;
    private final EventRepository eventRepository;
    private final UserRepository userRepository;
    private final PromocodeRepository promocodeRepository;
    private final CardService cardService;

    @Transactional(readOnly = true)
    public float validatePromocode(String code) {
        return promocodeRepository.findByPromocode(code)
                .map(Promocode::getPriceCharge)
                .orElseThrow(() -> new EntityNotFoundException("Promocode not found"));
    }

    @Transactional
    public PurchasedTicketDTO purchaseTickets(TicketPurchase purchase) {
        log.info("Начало процесса покупки билетов: userId={}, eventId={}, количество мест={}, промокод={}",
                purchase.getUserId(), purchase.getEventId(),
                purchase.getSeats() != null ? purchase.getSeats().size() : 0,
                purchase.getPromocode());

        // 1. Поиск мероприятия
        Event event = eventRepository.findById(purchase.getEventId())
                .orElseThrow(() -> {
                    log.error("Ошибка: Мероприятие не найдено. eventId={}", purchase.getEventId());
                    return new EntityNotFoundException("Event not found");
                });

        // 2. Поиск пользователя
        User user = userRepository.findById(purchase.getUserId())
                .orElseThrow(() -> {
                    log.error("Ошибка: Пользователь не найден. userId={}", purchase.getUserId());
                    return new EntityNotFoundException("User not found");
                });

        // 3. Проверка на дубликаты
        List<Ticket> existingTickets = ticketRepository.findByUser_UserIdAndEvent_EventId(user.getUserId(), event.getEventId());
        if (!existingTickets.isEmpty()) {
            log.warn("Предупреждение: Пользователь userId={} уже имеет билеты на мероприятие eventId={}", user.getUserId(), event.getEventId());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "User already has a ticket purchase record for this event.");
        }

        // 4. Расчет скидки по промокоду
        float discountRate = 0.0f;
        if (purchase.getPromocode() != null && !purchase.getPromocode().isEmpty()) {
            log.debug("Проверка промокода: {}", purchase.getPromocode());
            Promocode promo = promocodeRepository.findByPromocode(purchase.getPromocode())
                    .orElseThrow(() -> {
                        log.error("Ошибка: Невалидный промокод {}", purchase.getPromocode());
                        return new EntityNotFoundException("Invalid promocode");
                    });
            discountRate = promo.getPriceCharge() != null ? promo.getPriceCharge() : 0.0f;
            log.info("Применен промокод {}. Скидка: {}%", purchase.getPromocode(), discountRate * 100);
        }

        int totalQuantity = 0;
        float totalPurchasePrice = 0.0f;
        List<String> seatDetailsList = new ArrayList<>();

        // 5. Обработка выбранных мест
        log.debug("Начало обработки мест...");
        for (TicketPurchase.PurchaseSeat seatRequest : purchase.getSeats()) {
            Ticket ticketTemplate = ticketRepository.findById(seatRequest.getTicketTypeId())
                    .orElseThrow(() -> {
                        log.error("Ошибка: Тип билета не найден. ticketTypeId={}", seatRequest.getTicketTypeId());
                        return new EntityNotFoundException("Ticket type not found");
                    });

            if (ticketTemplate.getEvent().getEventId() != event.getEventId()) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Ticket type does not belong to this event");
            }

            if (ticketTemplate.getQuantity() <= 0) {
                log.warn("Ошибка: Места закончились для категории {}", ticketTemplate.getSeatDetails());
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "No tickets left for this category");
            }

            ticketTemplate.setQuantity(ticketTemplate.getQuantity() - 1);
            ticketRepository.save(ticketTemplate);

            String specificSeatDetails = String.format("Ряд %d, Место %d", seatRequest.getRow(), seatRequest.getNumber());
            seatDetailsList.add(specificSeatDetails);

            totalQuantity++;
            totalPurchasePrice += ticketTemplate.getPrice();
        }

        // 6. Итоговый расчет цены с учетом скидки
        float discountAmount = totalPurchasePrice * discountRate;
        float finalPrice = totalPurchasePrice - discountAmount;
        if (finalPrice < 0) finalPrice = 0;

        log.info("Расчет завершен: Базовая цена={}, Скидка={}, Итого к оплате={}",
                totalPurchasePrice, discountAmount, finalPrice);

        // 7. Логика оплаты
        if (finalPrice > 0) {
            if (purchase.getSavedCardId() != null) {
                log.info("Оплата: Использование сохраненной карты ID={}", purchase.getSavedCardId());
            }
            else if (purchase.getNewPaymentMethodId() != null && !purchase.getNewPaymentMethodId().isEmpty()) {
                log.info("Оплата: Использование новой карты. Токен Stripe: {}", purchase.getNewPaymentMethodId());

                if (purchase.isSaveNewCard()) {
                    log.info("Пользователь выбрал сохранить карту для будущих покупок.");
                    try {
                        CardRequest cardReq = new CardRequest();
                        cardReq.setUserId(user.getUserId());
                        cardReq.setPaymentMethodId(purchase.getNewPaymentMethodId());
                        cardService.saveCard(cardReq);
                        log.info("Карта успешно привязана к профилю пользователя.");
                    } catch (Exception e) {
                        log.error("Ошибка при сохранении карты: {}. Продолжаем покупку без сохранения.", e.getMessage());
                    }
                }
            } else {
                log.error("Ошибка: Попытка купить платный билет без указания метода оплаты.");
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Payment method is required for this purchase.");
            }
        } else {
            log.info("Оплата: Сумма 0 (бесплатно или 100% скидка). Метод оплаты не требуется.");
        }

        String combinedSeatDetails = String.join("; ", seatDetailsList);
        Ticket userTicket = Ticket.builder()
                .event(event)
                .user(user)
                .price(finalPrice)
                .seatDetails(combinedSeatDetails)
                .quantity(totalQuantity)
                .build();

        Ticket savedTicket = ticketRepository.save(userTicket);
        log.info("Билет сохранен в БД. ticketId={}, для пользователя={}", savedTicket.getTicketId(), user.getUsername());

        return PurchasedTicketDTO.builder()
                .ticketId(savedTicket.getTicketId())
                .price(savedTicket.getPrice())
                .quantity(savedTicket.getQuantity())
                .seatDetails(savedTicket.getSeatDetails())
                .userId(user.getUserId())
                .eventId(event.getEventId())
                .build();
    }

    private String getLocalizedText(String ru, String en, String kk, String lang) {
        if ("kk".equalsIgnoreCase(lang)) return (kk != null && !kk.isEmpty()) ? kk : ru;
        if ("en".equalsIgnoreCase(lang)) return (en != null && !en.isEmpty()) ? en : ru;
        return ru;
    }

    @Transactional(readOnly = true)
    public List<MyTicketResponse> getTicketsForUser(Integer userId, TicketFilterRequest filterRequest, String language) {
        Specification<Ticket> spec = TicketSpecification.filterUserTickets(userId, filterRequest);
        List<Ticket> userTickets = ticketRepository.findAll(spec);

        return userTickets.stream()
                .map(ticket -> {

                    MyTicketResponse response = MyTicketResponse.fromEntity(ticket);


                    Event event = ticket.getEvent();
                    response.setEventName(getLocalizedText(event.getEventName(), event.getEventNameEn(), event.getEventNameKk(), language));
                    response.setEventPlace(getLocalizedText(event.getEvent_place(), event.getEventPlaceEn(), event.getEventPlaceKk(), language));

                    return response;
                })
                .collect(Collectors.toList());
    }
}