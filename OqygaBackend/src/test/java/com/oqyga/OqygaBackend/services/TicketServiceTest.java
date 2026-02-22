package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.*;
import com.oqyga.OqygaBackend.entities.*;
import com.oqyga.OqygaBackend.repositories.*;
import com.stripe.exception.StripeException;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TicketServiceTest {

    @Mock private TicketRepository ticketRepository;
    @Mock private EventRepository eventRepository;
    @Mock private UserRepository userRepository;
    @Mock private PromocodeRepository promocodeRepository;
    @Mock private CardService cardService;

    @InjectMocks
    private TicketService ticketService;

    private User user;
    private Event event;
    private Ticket purchaseTicket;
    private Promocode promocode;

    @BeforeEach
    void setUp() {
        user = new User();
        user.setUserId(1);
        user.setUserName("testuser");

        event = new Event();
        event.setEventId(100);
        event.setEventName("Концерт");
        event.setEventNameEn("Concert");
        event.setEvent_place("Место");

        promocode = new Promocode();
        promocode.setPromocode("SALE10");
        promocode.setPriceCharge(0.1f); // 10% скидка
    }

    @Test
    @DisplayName("Валидация промокода: Успешно")
    void validatePromocode_Success() {
        when(promocodeRepository.findByPromocode("SALE10")).thenReturn(Optional.of(promocode));
        float result = ticketService.validatePromocode("SALE10");
        assertEquals(0.1f, result);
    }

    @Test
    @DisplayName("Валидация промокода: Не найден")
    void validatePromocode_NotFound() {
        when(promocodeRepository.findByPromocode("NONE")).thenReturn(Optional.empty());
        assertThrows(EntityNotFoundException.class, () -> ticketService.validatePromocode("NONE"));
    }


    @Test
    @DisplayName("Покупка: Ошибка - Мероприятие не найдено")
    void purchaseTickets_EventNotFound() {
        TicketPurchase request = new TicketPurchase();
        request.setEventId(999);
        when(eventRepository.findById(999)).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () -> ticketService.purchaseTickets(request));
    }

    @Test
    @DisplayName("Покупка: Ошибка - Пользователь уже купил билет на это событие")
    void purchaseTickets_DuplicatePurchase() {
        TicketPurchase request = new TicketPurchase();
        request.setEventId(100);
        request.setUserId(1);

        when(eventRepository.findById(100)).thenReturn(Optional.of(event));
        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(1, 100))
                .thenReturn(Collections.singletonList(new Ticket()));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> ticketService.purchaseTickets(request));
        assertEquals(HttpStatus.BAD_REQUEST, ex.getStatusCode());
        assertTrue(ex.getReason().contains("already has a ticket"));
    }

    @Test
    @DisplayName("Покупка: Ошибка - Места в категории закончились")
    void purchaseTickets_NoTicketsLeft() {
        TicketPurchase request = new TicketPurchase();
        request.setEventId(100);
        request.setUserId(1);

        TicketPurchase.PurchaseSeat seat = new TicketPurchase.PurchaseSeat();
        seat.setTicketTypeId(50);
        request.setSeats(Collections.singletonList(seat));

        Ticket template = new Ticket();
        template.setEvent(event);
        template.setQuantity(0); // Мест нет

        when(eventRepository.findById(100)).thenReturn(Optional.of(event));
        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(ticketRepository.findById(50)).thenReturn(Optional.of(template));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> ticketService.purchaseTickets(request));
        assertEquals(HttpStatus.BAD_REQUEST, ex.getStatusCode());
        assertTrue(ex.getReason().contains("No tickets left"));
    }

    @Test
    @DisplayName("Покупка: Успешный процесс (Новая карта + Сохранение)")
    void purchaseTickets_Success_NewCard() throws StripeException {
        // Arrange
        TicketPurchase request = new TicketPurchase();
        request.setEventId(100);
        request.setUserId(1);
        request.setPromocode("SALE10");
        request.setNewPaymentMethodId("pm_token");
        request.setSaveNewCard(true);

        TicketPurchase.PurchaseSeat seatReq = new TicketPurchase.PurchaseSeat();
        seatReq.setTicketTypeId(50);
        seatReq.setRow(1);
        seatReq.setNumber(10);
        request.setSeats(Collections.singletonList(seatReq));

        Ticket template = new Ticket();
        template.setTicketId(50);
        template.setEvent(event);
        template.setPrice(1000f);
        template.setQuantity(5);
        template.setSeatDetails("VIP");

        when(eventRepository.findById(100)).thenReturn(Optional.of(event));
        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(promocodeRepository.findByPromocode("SALE10")).thenReturn(Optional.of(promocode));
        when(ticketRepository.findById(50)).thenReturn(Optional.of(template));

        // Мокаем сохранение билета пользователя
        Ticket savedTicket = new Ticket();
        savedTicket.setTicketId(777);
        savedTicket.setPrice(900f); // 1000 - 10%
        savedTicket.setQuantity(1);
        when(ticketRepository.save(any(Ticket.class))).thenReturn(savedTicket);

        // Act
        PurchasedTicketDTO result = ticketService.purchaseTickets(request);

        // Assert
        assertNotNull(result);
        assertEquals(900f, result.getPrice()); // Проверка скидки
        verify(cardService, times(1)).saveCard(any(CardRequest.class)); // Проверка сохранения карты
        verify(ticketRepository).save(argThat(t -> t.getQuantity() == 4)); // Проверка уменьшения остатка шаблона
    }

    @Test
    @DisplayName("Покупка: Ошибка - Платный билет без метода оплаты")
    void purchaseTickets_NoPaymentMethodProvided() {
        TicketPurchase request = new TicketPurchase();
        request.setEventId(100);
        request.setUserId(1);

        TicketPurchase.PurchaseSeat seat = new TicketPurchase.PurchaseSeat();
        seat.setTicketTypeId(50);
        request.setSeats(Collections.singletonList(seat));

        Ticket template = new Ticket();
        template.setEvent(event);
        template.setPrice(500f); // Платный
        template.setQuantity(5);

        when(eventRepository.findById(100)).thenReturn(Optional.of(event));
        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(ticketRepository.findById(50)).thenReturn(Optional.of(template));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> ticketService.purchaseTickets(request));
        assertEquals(HttpStatus.BAD_REQUEST, ex.getStatusCode());
    }
}