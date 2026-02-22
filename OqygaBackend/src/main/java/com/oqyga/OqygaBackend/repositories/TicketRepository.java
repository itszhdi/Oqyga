package com.oqyga.OqygaBackend.repositories;

import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Integer>, JpaSpecificationExecutor<Ticket> {

    List<Ticket> findByEvent_EventIdAndPriceAndUserIsNullOrderByTicketIdAsc(
            Integer eventId, Float price);

    List<Ticket> findByUser_UserIdAndEvent_EventId(Integer userId, Integer eventId);

    @Query("SELECT t FROM Ticket t JOIN FETCH t.event WHERE t.user.userId = :userId")
    List<Ticket> findByUser_UserId(Integer userId);

    List<Ticket> findByEventAndUserIsNull(Event event);

    @Query("SELECT t FROM Ticket t LEFT JOIN FETCH t.user LEFT JOIN FETCH t.event")
    List<Ticket> findAllWithDetails();
}