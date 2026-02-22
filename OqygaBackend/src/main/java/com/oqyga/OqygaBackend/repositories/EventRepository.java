package com.oqyga.OqygaBackend.repositories;
import com.oqyga.OqygaBackend.entities.City;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import com.oqyga.OqygaBackend.entities.Event;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.Query;

public interface EventRepository extends JpaRepository<Event, Integer>, JpaSpecificationExecutor<Event> {

    Event findByEventId(Integer eventId);
    Event findByEventName(String eventName);
    List<Event> findByCity(City city);

    @Query("SELECT e FROM Event e LEFT JOIN FETCH e.tickets WHERE e.eventId = :eventId")
    Optional<Event> findByIdWithTickets(@Param("eventId") Integer eventId);

    List<Event> findByOrganisator_OrganisatorId(Integer organisatorId);

    @Query("SELECT DISTINCT e.event_place FROM Event e WHERE e.organisator.organisatorId = :organisatorId AND e.event_place IS NOT NULL AND e.event_place <> ''")
    List<String> findDistinctPlacesByOrganisatorId(@Param("organisatorId") Integer organisatorId);

}