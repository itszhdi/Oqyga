package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.EventFilterRequest;
import com.oqyga.OqygaBackend.dto.EventResponse;
import com.oqyga.OqygaBackend.dto.TicketTypeDTO;
import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Ticket;
import com.oqyga.OqygaBackend.repositories.EventRepository;
import com.oqyga.OqygaBackend.specifications.EventSpecification;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
import java.time.LocalDate;
import java.util.Comparator;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EventService {

    private final EventRepository eventRepository;

    public EventService(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    @Transactional
    public List<EventResponse> getAllEvents(EventFilterRequest filterRequest, String languageCode) {
        log.info("Получение всех мероприятий с фильтрами: priceFrom={}, priceTo={}, cityId={}, dateFrom={}, dateTo={}, categoryId={}",
                filterRequest.getPriceFrom(), filterRequest.getPriceTo(), filterRequest.getCityId(),
                filterRequest.getDateFrom(), filterRequest.getDateTo(), filterRequest.getCategoryId());

        Specification<Event> spec = EventSpecification.filterEvents(
                filterRequest.getPriceFrom(),
                filterRequest.getPriceTo(),
                filterRequest.getCityId(),
                filterRequest.getDateFrom(),
                filterRequest.getDateTo(),
                filterRequest.getTimeFrom(),
                filterRequest.getTimeTo(),
                filterRequest.getAgeRestrictionId(),
                filterRequest.getCategoryId()
        );

        List<Event> events = eventRepository.findAll(spec);
        log.debug("Найдено мероприятий: {}", events.size());

        LocalDate today = LocalDate.now();

        Comparator<Event> customComparator = (e1, e2) -> {
            LocalDate d1 = e1.getEventDate();
            LocalDate d2 = e2.getEventDate();
            boolean isPast1 = d1.isBefore(today);
            boolean isPast2 = d2.isBefore(today);

            if (isPast1 != isPast2) {
                return isPast1 ? 1 : -1;
            }
            if (isPast1) {
                return d2.compareTo(d1);
            } else {
                return d1.compareTo(d2);
            }
        };

        log.debug("Сортировка мероприятий по датам");
        return events.stream()
                .sorted(customComparator)
                .map(event -> mapToDTO(event, languageCode))
                .collect(Collectors.toList());
    }

    @Transactional
    public EventResponse getEventById(Integer eventId, String languageCode) {
        log.info("Получение мероприятия по ID: {}, язык: {}", eventId, languageCode);

        Optional<Event> eventOptional = eventRepository.findByIdWithTickets(eventId);
        Event event = eventOptional.orElseThrow(() -> {
            log.error("Мероприятие с ID {} не найдено", eventId);
            return new ResponseStatusException(HttpStatus.NOT_FOUND, "Мероприятие с ID " + eventId + " не найдено.");
        });

        return mapToDTO(event, languageCode);
    }

    @Transactional(readOnly = true)
    public List<EventResponse> getEventsByOrganisator(Integer organisatorId, String languageCode) {
        log.info("Получение мероприятий организатора с ID: {}", organisatorId);

        List<Event> events = eventRepository.findByOrganisator_OrganisatorId(organisatorId);

        return events.stream()
                .map(event -> mapToDTO(event, languageCode))
                .collect(Collectors.toList());
    }

    private String getLocalizedText(String ru, String en, String kk, String lang) {
        if ("kk".equalsIgnoreCase(lang)) return (kk != null && !kk.isEmpty()) ? kk : ru;
        if ("en".equalsIgnoreCase(lang)) return (en != null && !en.isEmpty()) ? en : ru;
        return ru;
    }

    private EventResponse mapToDTO(Event event, String languageCode) {
        EventResponse dto = new EventResponse();
        dto.setEventId(event.getEventId());

        dto.setEventName(getLocalizedText(event.getEventName(), event.getEventNameEn(), event.getEventNameKk(), languageCode));
        dto.setDescription(getLocalizedText(event.getDescription(), event.getDescriptionEn(), event.getDescriptionKk(), languageCode));
        dto.setEventPlace(getLocalizedText(event.getEvent_place(), event.getEventPlaceEn(), event.getEventPlaceKk(), languageCode));

        dto.setEventDate(event.getEventDate());
        dto.setEventTime(event.getEventTime());
        dto.setPoster(event.getPoster());
        dto.setPeopleAmount(event.getPeopleAmount());

        int occupiedPlaces = 0;
        if (event.getTickets() != null) {
            occupiedPlaces = event.getTickets().stream()
                    .filter(t -> t.getUser() != null)
                    .mapToInt(t -> t.getQuantity() != null ? t.getQuantity() : 0)
                    .sum();
            log.debug("Занято мест для мероприятия {}: {}", event.getEventId(), occupiedPlaces);
        }

        boolean isSoldOut = event.getPeopleAmount() != null && occupiedPlaces >= event.getPeopleAmount();
        dto.setSoldOut(isSoldOut);
        if (isSoldOut) {
            log.debug("Мероприятие {} распродано", event.getEventId());
        }

        if (event.getTickets() != null) {
            List<Ticket> templateTickets = event.getTickets().stream()
                    .filter(t -> t.getUser() == null)
                    .collect(Collectors.toList());

            List<Float> uniquePrices = templateTickets.stream()
                    .map(Ticket::getPrice)
                    .filter(java.util.Objects::nonNull)
                    .distinct()
                    .sorted()
                    .collect(Collectors.toList());

            if (!uniquePrices.isEmpty()) {
                dto.setMinPrice(uniquePrices.get(0));
                dto.setMaxPrice(uniquePrices.get(uniquePrices.size() - 1));
                dto.setAllPrices(uniquePrices);
                log.debug("Диапазон цен для мероприятия {}: от {} до {}", event.getEventId(), dto.getMinPrice(), dto.getMaxPrice());
            }

            dto.setTicketTypes(templateTickets.stream().map(t -> {
                TicketTypeDTO typeDto = new TicketTypeDTO();
                typeDto.setId(t.getTicketId());
                typeDto.setPrice(t.getPrice());
                typeDto.setQuantity(t.getQuantity());
                typeDto.setDescription(t.getSeatDetails());
                return typeDto;
            }).collect(Collectors.toList()));
        }

        if (event.getAgeRestriction() != null) {
            dto.setAgeRestriction(new com.oqyga.OqygaBackend.dto.AgeRestriction(
                    event.getAgeRestriction().getAgeId(), event.getAgeRestriction().getAgeCategory()));
        }
        if (event.getCategory() != null) {
            String catName = getLocalizedText(event.getCategory().getCategoryName(),
                    event.getCategory().getCategoryNameEn(), event.getCategory().getCategoryNameKk(), languageCode);
            dto.setCategory(new com.oqyga.OqygaBackend.dto.Category(event.getCategory().getCategoryId(), catName));
        }
        if (event.getCity() != null) {
            String cityName = getLocalizedText(event.getCity().getCityName(),
                    event.getCity().getCityNameEn(), event.getCity().getCityNameKk(), languageCode);
            dto.setCity(new com.oqyga.OqygaBackend.dto.City(event.getCity().getCityId(), cityName));
        }

        return dto;
    }
}