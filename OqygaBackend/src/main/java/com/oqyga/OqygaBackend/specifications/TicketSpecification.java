package com.oqyga.OqygaBackend.specifications;

import com.oqyga.OqygaBackend.dto.TicketFilterRequest;
import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Ticket;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import org.springframework.data.jpa.domain.Specification;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TicketSpecification {

    public static Specification<Ticket> filterUserTickets(Integer userId, TicketFilterRequest filters) {
        return (Root<Ticket> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            List<Predicate> predicates = new ArrayList<>();


            predicates.add(cb.equal(root.get("user").get("userId"), userId));
            Join<Ticket, Event> eventJoin = root.join("event");

            // по статусу (active/inactive)
            if (filters.getStatus() != null && !filters.getStatus().isEmpty()) {
                if ("active".equalsIgnoreCase(filters.getStatus())) {
                    predicates.add(cb.greaterThanOrEqualTo(eventJoin.get("eventDate"), LocalDate.now()));
                } else if ("inactive".equalsIgnoreCase(filters.getStatus())) {
                    predicates.add(cb.lessThan(eventJoin.get("eventDate"), LocalDate.now()));
                }
            }

            // по городу, категории, дате
            if (filters.getCityId() != null) {
                predicates.add(cb.equal(eventJoin.get("city").get("cityId"), filters.getCityId()));
            }
            if (filters.getCategoryId() != null) {
                predicates.add(cb.equal(eventJoin.get("category").get("categoryId"), filters.getCategoryId()));
            }
            if (filters.getDateFrom() != null) {
                predicates.add(cb.greaterThanOrEqualTo(eventJoin.get("eventDate"), filters.getDateFrom()));
            }
            if (filters.getDateTo() != null) {
                predicates.add(cb.lessThanOrEqualTo(eventJoin.get("eventDate"), filters.getDateTo()));
            }

            query.distinct(true);
            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}