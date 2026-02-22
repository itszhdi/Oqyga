package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.EventFilterRequest;
import com.oqyga.OqygaBackend.dto.EventResponse;
import com.oqyga.OqygaBackend.entities.*;
import com.oqyga.OqygaBackend.repositories.EventRepository;
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

import java.time.LocalDate;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class EventServiceTest {

    @Mock
    private EventRepository eventRepository;

    @InjectMocks
    private EventService eventService;

    private Event event;
    private Category category;
    private City city;

    @BeforeEach
    void setUp() {
        category = new Category();
        category.setCategoryId(1);
        category.setCategoryName("Концерт");
        category.setCategoryNameEn("Concert");

        city = new City();
        city.setCityId(1);
        city.setCityName("Алматы");

        event = new Event();
        event.setEventId(1);
        event.setEventName("Фестиваль");
        event.setEventNameEn("Festival");
        event.setEventDate(LocalDate.now().plusDays(10)); // Будущее событие
        event.setCategory(category);
        event.setCity(city);
        event.setPeopleAmount(100);
    }

    @Test
    @DisplayName("Должен вернуть список мероприятий с правильной сортировкой")
    void getAllEvents_ShouldReturnSortedEvents() {
        // Arrange
        Event pastEvent = new Event();
        pastEvent.setEventId(2);
        pastEvent.setEventDate(LocalDate.now().minusDays(5));

        Event futureEvent = new Event();
        futureEvent.setEventId(3);
        futureEvent.setEventDate(LocalDate.now().plusDays(1));

        when(eventRepository.findAll(any(Specification.class))).thenReturn(Arrays.asList(pastEvent, futureEvent));

        // Act
        List<EventResponse> result = eventService.getAllEvents(new EventFilterRequest(), "ru");

        // Assert
        assertEquals(2, result.size());
        assertEquals(3, result.get(0).getEventId()); // Будущее событие должно быть первым
        assertEquals(2, result.get(1).getEventId()); // Прошедшее в конце
    }

    @Test
    @DisplayName("Должен вернуть детали мероприятия по ID")
    void getEventById_Success() {
        // Arrange
        when(eventRepository.findByIdWithTickets(1)).thenReturn(Optional.of(event));

        // Act
        EventResponse response = eventService.getEventById(1, "en");

        // Assert
        assertNotNull(response);
        assertEquals("Festival", response.getEventName()); // Проверка локализации EN
        verify(eventRepository, times(1)).findByIdWithTickets(1);
    }

    @Test
    @DisplayName("Должен выбросить 404 ошибку, если мероприятие не найдено")
    void getEventById_NotFound() {
        // Arrange
        when(eventRepository.findByIdWithTickets(99)).thenReturn(Optional.empty());

        // Act & Assert
        ResponseStatusException exception = assertThrows(ResponseStatusException.class, () -> {
            eventService.getEventById(99, "ru");
        });

        assertEquals(HttpStatus.NOT_FOUND, exception.getStatusCode());
        assertTrue(exception.getReason().contains("не найдено"));
    }

    @Test
    @DisplayName("Должен правильно определять Sold Out статус")
    void mapToDTO_ShouldMarkAsSoldOut() {
        // Arrange
        event.setPeopleAmount(10);

        // Билет, который уже купил пользователь (занятое место)
        Ticket soldTicket = new Ticket();
        soldTicket.setUser(new User()); // У билета есть пользователь
        soldTicket.setQuantity(10);

        event.setTickets(Collections.singletonList(soldTicket));
        when(eventRepository.findByIdWithTickets(1)).thenReturn(Optional.of(event));

        // Act
        EventResponse response = eventService.getEventById(1, "ru");

        // Assert
        assertTrue(response.isSoldOut());
    }

    @Test
    @DisplayName("Должен корректно рассчитывать диапазон цен")
    void mapToDTO_ShouldCalculatePriceRange() {
        // Arrange
        Ticket t1 = new Ticket();
        t1.setPrice(1000f);
        t1.setUser(null); // Шаблонный билет

        Ticket t2 = new Ticket();
        t2.setPrice(5000f);
        t2.setUser(null); // Шаблонный билет

        event.setTickets(Arrays.asList(t1, t2));
        when(eventRepository.findByIdWithTickets(1)).thenReturn(Optional.of(event));

        // Act
        EventResponse response = eventService.getEventById(1, "ru");

        // Assert
        assertEquals(1000f, response.getMinPrice());
        assertEquals(5000f, response.getMaxPrice());
        assertEquals(2, response.getAllPrices().size());
    }

    @Test
    @DisplayName("Должен вернуть мероприятия по ID организатора")
    void getEventsByOrganisator_Success() {
        // Arrange
        when(eventRepository.findByOrganisator_OrganisatorId(10)).thenReturn(Collections.singletonList(event));

        // Act
        List<EventResponse> result = eventService.getEventsByOrganisator(10, "ru");

        // Assert
        assertEquals(1, result.size());
        verify(eventRepository).findByOrganisator_OrganisatorId(10);
    }
}