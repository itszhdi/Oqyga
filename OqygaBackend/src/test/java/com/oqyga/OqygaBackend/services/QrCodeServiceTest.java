package com.oqyga.OqygaBackend.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oqyga.OqygaBackend.dto.QrCodePayload;
import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Ticket;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.TicketRepository;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class QrCodeServiceTest {

    @Mock
    private TicketRepository ticketRepository;

    @Spy
    private ObjectMapper objectMapper = new ObjectMapper();

    @InjectMocks
    private QrCodeService qrCodeService;

    private User user;
    private Event event;
    private Ticket ticket1;
    private Ticket ticket2;

    @BeforeEach
    void setUp() {
        user = new User();
        user.setUserId(1);

        event = new Event();
        event.setEventId(100);
        event.setEventName("Концерт");
        event.setEventNameEn("Concert");
        event.setEvent_place("Дворец");
        event.setEventPlaceEn("Palace");
        event.setEventDate(LocalDate.now());
        event.setEventTime(LocalTime.now());
        event.setPoster("http://image.url");

        ticket1 = new Ticket();
        ticket1.setTicketId(10);
        ticket1.setUser(user);
        ticket1.setEvent(event);
        ticket1.setPrice(5000f);
        ticket1.setQuantity(2);
        ticket1.setSeatDetails("Ряд 1, Место 5-6");

        ticket2 = new Ticket();
        ticket2.setTicketId(11);
        ticket2.setUser(user);
        ticket2.setEvent(event);
        ticket2.setPrice(3000f);
        ticket2.setQuantity(1);
        ticket2.setSeatDetails("Ряд 5, Место 10");
    }

    @Test
    @DisplayName("Должен успешно формировать Payload с локализацией и суммой билетов")
    void getTicketDetails_Success() {
        // Arrange
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(1, 100))
                .thenReturn(Arrays.asList(ticket1, ticket2));

        // Act
        QrCodePayload payload = qrCodeService.getTicketDetails(1, 100, "en");

        // Assert
        assertNotNull(payload);
        assertEquals("Concert", payload.getEventName()); // Проверка локализации EN
        assertEquals("Palace", payload.getEventLocation());
        assertEquals(3, payload.getTotalTickets()); // 2 + 1
        assertEquals(2, payload.getTicketGroups().size());
        verify(ticketRepository).findByUser_UserIdAndEvent_EventId(1, 100);
    }

    @Test
    @DisplayName("Должен выбрасывать EntityNotFoundException, если билеты не найдены")
    void getTicketDetails_NotFound() {
        // Arrange
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(anyInt(), anyInt()))
                .thenReturn(Collections.emptyList());

        // Act & Assert
        assertThrows(EntityNotFoundException.class, () ->
                qrCodeService.getTicketDetails(1, 100, "ru")
        );
    }

    @Test
    @DisplayName("Должен получать детали билета по Ticket ID")
    void getTicketDetailsByTicketId_Success() {
        // Arrange
        when(ticketRepository.findById(10)).thenReturn(Optional.of(ticket1));
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(1, 100))
                .thenReturn(Collections.singletonList(ticket1));

        // Act
        QrCodePayload payload = qrCodeService.getTicketDetailsByTicketId(10, "ru");

        // Assert
        assertNotNull(payload);
        assertEquals("Концерт", payload.getEventName());
        verify(ticketRepository).findById(10);
    }

    @Test
    @DisplayName("Должен успешно генерировать QR код в виде массива байтов")
    void generateQrCodeForUserEvent_Success() {
        // Arrange
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(1, 100))
                .thenReturn(Collections.singletonList(ticket1));

        // Act
        byte[] qrCode = qrCodeService.generateQrCodeForUserEvent(1, 100, "ru");

        // Assert
        assertNotNull(qrCode);
        assertTrue(qrCode.length > 0);
        // Проверяем "магические числа" PNG формата (первые байты)
        assertEquals((byte) 0x89, qrCode[0]);
        assertEquals((byte) 'P', qrCode[1]);
        assertEquals((byte) 'N', qrCode[2]);
        assertEquals((byte) 'G', qrCode[3]);
    }

    @Test
    @DisplayName("Должен успешно генерировать QR код по ID билета")
    void generateQrCodeForTicketId_Success() {
        // Arrange
        when(ticketRepository.findById(10)).thenReturn(Optional.of(ticket1));
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(1, 100))
                .thenReturn(Collections.singletonList(ticket1));

        // Act
        byte[] qrCode = qrCodeService.generateQrCodeForTicketId(10, "ru");

        // Assert
        assertNotNull(qrCode);
        assertTrue(qrCode.length > 0);
    }

    @Test
    @DisplayName("Должен выбрасывать RuntimeException при ошибке сериализации JSON")
    void generateQrCode_SerializationError() throws JsonProcessingException {
        // Arrange
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(1, 100))
                .thenReturn(Collections.singletonList(ticket1));

        // Заставляем ObjectMapper выбросить ошибку при попытке записи любого объекта в String
        doThrow(new RuntimeException("JSON Error")).when(objectMapper).writeValueAsString(any());

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class, () ->
                qrCodeService.generateQrCodeForUserEvent(1, 100, "ru")
        );
        assertTrue(exception.getMessage().contains("Failed to generate QR code"));
    }

    @Test
    @DisplayName("Проверка логики локализации (RU по умолчанию)")
    void localization_FallbackToRussian() {
        // Arrange
        event.setEventNameKk(""); // Пустое значение для казахского
        when(ticketRepository.findByUser_UserIdAndEvent_EventId(1, 100))
                .thenReturn(Collections.singletonList(ticket1));

        // Act
        QrCodePayload payload = qrCodeService.getTicketDetails(1, 100, "kk");

        // Assert
        assertEquals("Концерт", payload.getEventName());
    }
}