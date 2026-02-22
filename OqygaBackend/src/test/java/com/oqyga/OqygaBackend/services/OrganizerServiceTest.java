package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.EventRequestDTO;
import com.oqyga.OqygaBackend.dto.TicketTypeDTO;
import com.oqyga.OqygaBackend.entities.*;
import com.oqyga.OqygaBackend.repositories.*;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.io.TempDir;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.util.ReflectionTestUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrganizerServiceTest {

    @Mock
    private EventRepository eventRepository;
    @Mock
    private AgeRestrictionRepository ageRestrictionRepository;
    @Mock
    private CategoryRepository categoryRepository;
    @Mock
    private CityRepository cityRepository;
    @Mock
    private OrganisatorRepository organisatorRepository;
    @Mock
    private TicketRepository ticketRepository;

    @InjectMocks
    private OrganizerService organizerService;

    @TempDir
    Path tempDir;

    private EventRequestDTO eventDTO;
    private MockMultipartFile posterFile;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(organizerService, "uploadDir", tempDir.toString());
        ReflectionTestUtils.setField(organizerService, "uploadUrlPath", "/uploads/");

        organizerService.init();

        TicketTypeDTO ticketType = new TicketTypeDTO();
        ticketType.setPrice((float) 134.50);
        ticketType.setQuantity(50);
        ticketType.setDescription("VIP");

        eventDTO = new EventRequestDTO();
        eventDTO.setEventName("Test Event");
        eventDTO.setEventDate(LocalDate.now().plusDays(10));
        eventDTO.setEventTime(LocalTime.of(18, 0));
        eventDTO.setEvent_place("Concert Hall");
        eventDTO.setDescription("Description");
        eventDTO.setAgeRestrictionId(1);
        eventDTO.setCategoryId(1);
        eventDTO.setCityId(1);
        eventDTO.setOrganisatorId(1);
        eventDTO.setTicketTypes(List.of(ticketType));

        posterFile = new MockMultipartFile(
                "poster",
                "test-poster.jpg",
                "image/jpeg",
                "test image content".getBytes()
        );
    }

    @Test
    void addEvent_Success() throws IOException {
        // Arrange (Настройка моков)
        when(ageRestrictionRepository.findById(1)).thenReturn(Optional.of(new AgeRestriction()));
        when(categoryRepository.findById(1)).thenReturn(Optional.of(new Category()));
        when(cityRepository.findById(1)).thenReturn(Optional.of(new City()));
        when(organisatorRepository.findById(1)).thenReturn(Optional.of(new Organisator()));

        when(eventRepository.save(any(Event.class))).thenAnswer(invocation -> {
            Event event = invocation.getArgument(0);
            event.setEventId(100); // Симулируем присвоение ID базой данных
            return event;
        });

        Event result = organizerService.addEvent(eventDTO, posterFile);

        assertThat(result).isNotNull();
        assertThat(result.getEventName()).isEqualTo("Test Event");
        assertThat(result.getPeopleAmount()).isEqualTo(50); // Проверка подсчета мест
        assertThat(result.getPoster()).startsWith("/uploads/event_posters/"); // Проверка пути постера

        Path posterDir = tempDir.resolve("event_posters");
        assertThat(Files.list(posterDir).count()).isEqualTo(1);

        verify(ticketRepository, times(1)).saveAll(anyList());
    }

    @Test
    void addEvent_EntityNotFound() {
        when(ageRestrictionRepository.findById(1)).thenReturn(Optional.of(new AgeRestriction()));
        when(categoryRepository.findById(1)).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () ->
                organizerService.addEvent(eventDTO, posterFile)
        );
    }

    @Test
    void updateEvent_Success() throws IOException {
        // Arrange
        Integer eventId = 100;
        Event existingEvent = new Event();
        existingEvent.setEventId(eventId);
        existingEvent.setEventName("Old Name");
        existingEvent.setPoster("/uploads/event_posters/old-poster.jpg");

        Path oldPosterPath = tempDir.resolve("event_posters").resolve("old-poster.jpg");
        Files.createDirectories(oldPosterPath.getParent());
        Files.write(oldPosterPath, "old content".getBytes());

        when(eventRepository.findById(eventId)).thenReturn(Optional.of(existingEvent));
        when(ageRestrictionRepository.findById(any())).thenReturn(Optional.of(new AgeRestriction()));
        when(categoryRepository.findById(any())).thenReturn(Optional.of(new Category()));
        when(cityRepository.findById(any())).thenReturn(Optional.of(new City()));
        when(organisatorRepository.findById(any())).thenReturn(Optional.of(new Organisator()));
        when(eventRepository.save(any(Event.class))).thenAnswer(inv -> inv.getArgument(0));

        // Act
        Event updatedEvent = organizerService.updateEvent(eventId, eventDTO, posterFile);

        // Assert
        assertThat(updatedEvent.getEventName()).isEqualTo("Test Event");
        assertThat(updatedEvent.getPoster()).isNotEqualTo("/uploads/event_posters/old-poster.jpg");

        assertThat(Files.exists(oldPosterPath)).isFalse();

        verify(ticketRepository, times(1)).deleteAll(any());
        verify(ticketRepository, times(1)).saveAll(anyList());
    }

    @Test
    void deleteEvent_Success() throws IOException {
        // Arrange
        Integer eventId = 100;
        Event existingEvent = new Event();
        existingEvent.setEventId(eventId);
        existingEvent.setPoster("/uploads/event_posters/delete-me.jpg");

        // Создаем файл для удаления
        Path posterPath = tempDir.resolve("event_posters").resolve("delete-me.jpg");
        Files.createDirectories(posterPath.getParent());
        Files.write(posterPath, "content".getBytes());

        when(eventRepository.findById(eventId)).thenReturn(Optional.of(existingEvent));

        // Act
        organizerService.deleteEvent(eventId);

        // Assert
        verify(eventRepository, times(1)).deleteById(eventId);
        assertThat(Files.exists(posterPath)).isFalse(); // Файл должен быть удален
    }

    @Test
    void getPreviousVenues_Success() {
        // Arrange
        Integer orgId = 1;
        List<String> venues = List.of("Hall A", "Stadium B");
        when(eventRepository.findDistinctPlacesByOrganisatorId(orgId)).thenReturn(venues);

        // Act
        List<String> result = organizerService.getPreviousVenues(orgId);

        // Assert
        assertThat(result).hasSize(2);
        assertThat(result).contains("Hall A");
    }
}