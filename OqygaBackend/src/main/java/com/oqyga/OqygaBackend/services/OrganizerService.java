package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.EventRequestDTO;
import com.oqyga.OqygaBackend.dto.TicketTypeDTO;
import com.oqyga.OqygaBackend.entities.*;
import com.oqyga.OqygaBackend.repositories.*;
import jakarta.annotation.PostConstruct;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrganizerService {

    @Value("${file.upload-dir}")
    private String uploadDir;
    @Value("${file.upload-url-path}")
    private String uploadUrlPath;

    private Path rootStoragePath;
    private Path posterStoragePath;

    private final EventRepository eventRepository;
    private final AgeRestrictionRepository ageRestrictionRepository;
    private final CategoryRepository categoryRepository;
    private final CityRepository cityRepository;
    private final OrganisatorRepository organisatorRepository;
    private final TicketRepository ticketRepository;

    @PostConstruct
    public void init() {
        log.info("Инициализация директорий для загрузки файлов: {}", uploadDir);
        try {
            this.rootStoragePath = Paths.get(uploadDir).toAbsolutePath().normalize();
            this.posterStoragePath = this.rootStoragePath.resolve("event_posters");
            Files.createDirectories(this.rootStoragePath);
            Files.createDirectories(this.posterStoragePath);
            log.info("Директории успешно созданы: rootPath={}, posterPath={}", rootStoragePath, posterStoragePath);
        } catch (IOException e) {
            log.error("Не удалось создать директории для загрузки файлов: {}", e.getMessage(), e);
            throw new RuntimeException("Не удалось создать директории.", e);
        }
    }

    @Transactional
    public Event addEvent(EventRequestDTO eventDTO, MultipartFile posterFile) throws IOException {
        log.info("Добавление нового мероприятия: название={}, организатор ID={}", eventDTO.getEventName(), eventDTO.getOrganisatorId());

        Event event = new Event();

        if (posterFile != null && !posterFile.isEmpty()) {
            log.debug("Сохранение постера для мероприятия: размер файла={} bytes", posterFile.getSize());
            String posterPath = savePoster(posterFile);
            event.setPoster(posterPath);
            log.debug("Постер сохранен: путь={}", posterPath);
        }

        mapDtoToEvent(eventDTO, event);

        int totalSeats = 0;
        if (eventDTO.getTicketTypes() != null) {
            totalSeats = eventDTO.getTicketTypes().stream()
                    .filter(t -> t.getQuantity() != null)
                    .mapToInt(TicketTypeDTO::getQuantity)
                    .sum();
            log.debug("Подсчитано общее количество мест: {}", totalSeats);
        }
        event.setPeopleAmount(totalSeats);
        Event savedEvent = eventRepository.save(event);
        log.info("Мероприятие сохранено: ID={}, название={}", savedEvent.getEventId(), savedEvent.getEventName());

        saveTicketTemplates(savedEvent, eventDTO.getTicketTypes());

        log.info("Мероприятие успешно добавлено: ID={}", savedEvent.getEventId());
        return savedEvent;
    }

    @Transactional
    public Event updateEvent(Integer eventId, EventRequestDTO eventDTO, MultipartFile posterFile) throws IOException {
        log.info("Обновление мероприятия: ID={}, название={}", eventId, eventDTO.getEventName());

        Event existingEvent = eventRepository.findById(eventId)
                .orElseThrow(() -> {
                    log.error("Мероприятие не найдено для обновления: ID={}", eventId);
                    return new EntityNotFoundException("Событие не найдено");
                });

        log.debug("Мероприятие найдено для обновления: ID={}, текущее название={}", eventId, existingEvent.getEventName());

        if (posterFile != null && !posterFile.isEmpty()) {
            log.debug("Обновление постера для мероприятия ID={}", eventId);
            if (existingEvent.getPoster() != null && !existingEvent.getPoster().isEmpty()) {
                log.debug("Удаление старого постера: {}", existingEvent.getPoster());
                deletePoster(existingEvent.getPoster());
            }
            String newPosterPath = savePoster(posterFile);
            existingEvent.setPoster(newPosterPath);
            log.debug("Новый постер сохранен: путь={}", newPosterPath);
        }

        mapDtoToEvent(eventDTO, existingEvent);

        int totalSeats = 0;
        if (eventDTO.getTicketTypes() != null) {
            totalSeats = eventDTO.getTicketTypes().stream()
                    .filter(t -> t.getQuantity() != null)
                    .mapToInt(TicketTypeDTO::getQuantity)
                    .sum();
            log.debug("Подсчитано общее количество мест для обновленного мероприятия: {}", totalSeats);
        }
        existingEvent.setPeopleAmount(totalSeats);

        Event savedEvent = eventRepository.save(existingEvent);
        log.debug("Обновленное мероприятие сохранено: ID={}", savedEvent.getEventId());

        List<Ticket> oldTemplates = ticketRepository.findByEventAndUserIsNull(savedEvent);
        log.debug("Удаление старых шаблонов билетов: количество={}", oldTemplates.size());
        ticketRepository.deleteAll(oldTemplates);

        saveTicketTemplates(savedEvent, eventDTO.getTicketTypes());

        log.info("Мероприятие успешно обновлено: ID={}", savedEvent.getEventId());
        return savedEvent;
    }

    @Transactional
    public void deleteEvent(Integer eventId) throws IOException {
        log.info("Удаление мероприятия: ID={}", eventId);

        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> {
                    log.error("Мероприятие не найдено для удаления: ID={}", eventId);
                    return new EntityNotFoundException("Событие не найдено");
                });

        log.debug("Мероприятие найдено для удаления: ID={}, название={}", eventId, event.getEventName());

        if (event.getPoster() != null && !event.getPoster().isEmpty()) {
            log.debug("Удаление постера мероприятия: {}", event.getPoster());
            deletePoster(event.getPoster());
        }
        eventRepository.deleteById(eventId);
        log.info("Мероприятие успешно удалено: ID={}", eventId);
    }

    private void saveTicketTemplates(Event event, List<TicketTypeDTO> ticketTypes) {
        if (ticketTypes == null || ticketTypes.isEmpty()) {
            log.debug("Нет типов билетов для сохранения для мероприятия ID={}", event.getEventId());
            return;
        }

        log.debug("Сохранение шаблонов билетов для мероприятия ID={}: количество типов={}", event.getEventId(), ticketTypes.size());
        List<Ticket> templates = ticketTypes.stream()
                .map(type -> Ticket.builder()
                        .event(event)
                        .price(type.getPrice())
                        .quantity(type.getQuantity())
                        .seatDetails(type.getDescription())
                        .user(null)
                        .build())
                .collect(Collectors.toList());

        ticketRepository.saveAll(templates);
        log.debug("Шаблоны билетов сохранены: количество={}", templates.size());
    }

    private void mapDtoToEvent(EventRequestDTO dto, Event event) {
        log.debug("Маппинг DTO в Event: название={}", dto.getEventName());

        event.setEventName(dto.getEventName());
        event.setEventDate(dto.getEventDate());
        event.setEvent_place(dto.getEvent_place());
        event.setEventTime(dto.getEventTime());
        event.setDescription(dto.getDescription());

        if (dto.getAgeRestrictionId() != null) {
            log.debug("Установка возрастного ограничения: ID={}", dto.getAgeRestrictionId());
            event.setAgeRestriction(ageRestrictionRepository.findById(dto.getAgeRestrictionId())
                    .orElseThrow(() -> {
                        log.error("Возрастное ограничение не найдено: ID={}", dto.getAgeRestrictionId());
                        return new EntityNotFoundException("Age restriction not found");
                    }));
        }
        if (dto.getCategoryId() != null) {
            log.debug("Установка категории: ID={}", dto.getCategoryId());
            event.setCategory(categoryRepository.findById(dto.getCategoryId())
                    .orElseThrow(() -> {
                        log.error("Категория не найдена: ID={}", dto.getCategoryId());
                        return new EntityNotFoundException("Category not found");
                    }));
        }
        if (dto.getCityId() != null) {
            log.debug("Установка города: ID={}", dto.getCityId());
            event.setCity(cityRepository.findById(dto.getCityId())
                    .orElseThrow(() -> {
                        log.error("Город не найден: ID={}", dto.getCityId());
                        return new EntityNotFoundException("City not found");
                    }));
        }
        if (dto.getOrganisatorId() != null) {
            log.debug("Установка организатора: ID={}", dto.getOrganisatorId());
            event.setOrganisator(organisatorRepository.findById(dto.getOrganisatorId())
                    .orElseThrow(() -> {
                        log.error("Организатор не найден: ID={}", dto.getOrganisatorId());
                        return new EntityNotFoundException("Organisator not found");
                    }));
        }

        log.debug("Маппинг DTO в Event завершен");
    }

    public List<String> getPreviousVenues(Integer organisatorId) {
        log.info("Получение предыдущих площадок организатора: ID={}", organisatorId);
        List<String> venues = eventRepository.findDistinctPlacesByOrganisatorId(organisatorId);
        log.debug("Найдено площадок: {}", venues.size());
        return venues;
    }

    private String savePoster(MultipartFile file) throws IOException {
        String originalFileName = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        log.debug("Сохранение постера: оригинальное имя={}, размер={} bytes", originalFileName, file.getSize());

        String fileExtension = "";
        int dotIndex = originalFileName.lastIndexOf(".");
        if (dotIndex >= 0) {
            fileExtension = originalFileName.substring(dotIndex);
        }
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        Path targetLocation = this.posterStoragePath.resolve(uniqueFileName);
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

        String posterUrl = uploadUrlPath + "event_posters/" + uniqueFileName;
        log.debug("Постер сохранен: уникальное имя={}, URL={}", uniqueFileName, posterUrl);
        return posterUrl;
    }

    private void deletePoster(String posterUrlPath) throws IOException {
        if (posterUrlPath == null || posterUrlPath.isEmpty()) {
            log.debug("Путь к постеру пустой, удаление не требуется");
            return;
        }
        log.debug("Удаление постера: URL={}", posterUrlPath);
        String fileName = posterUrlPath.substring(posterUrlPath.lastIndexOf('/') + 1);
        Path filePath = this.posterStoragePath.resolve(fileName).normalize();
        boolean deleted = Files.deleteIfExists(filePath);
        if (deleted) {
            log.debug("Постер успешно удален: файл={}", fileName);
        } else {
            log.warn("Файл постера не найден для удаления: файл={}", fileName);
        }
    }
}