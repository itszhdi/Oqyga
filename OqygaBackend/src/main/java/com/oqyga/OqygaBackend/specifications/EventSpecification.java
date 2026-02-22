package com.oqyga.OqygaBackend.specifications;
import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Ticket;
import jakarta.persistence.criteria.*;
import org.springframework.data.jpa.domain.Specification;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class EventSpecification {

    public static Specification<Event> filterEvents(
            Double priceFrom, Double priceTo,
            Integer cityId,
            LocalDate dateFrom, LocalDate dateTo,
            LocalTime timeFrom, LocalTime timeTo,
            Integer ageRestrictionId,
            Integer categoryId) {

        return (Root<Event> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (query.getResultType() != Long.class) {
                query.distinct(true);
            }

            // Фильтр по Городу
            if (cityId != null) {
                predicates.add(cb.equal(root.get("city").get("cityId"), cityId));
            }

            // Фильтр по Категории
            if (categoryId != null) {
                predicates.add(cb.equal(root.get("category").get("categoryId"), categoryId));
            }

            // Фильтр по Возрастному рейтингу
            if (ageRestrictionId != null) {
                predicates.add(cb.equal(root.get("ageRestriction").get("ageId"), ageRestrictionId));
            }

            // Фильтр по Дате
            if (dateFrom != null && dateTo != null) {
                predicates.add(cb.between(root.get("eventDate"), dateFrom, dateTo));
            } else if (dateFrom != null) {
                predicates.add(cb.greaterThanOrEqualTo(root.get("eventDate"), dateFrom));
            } else if (dateTo != null) {
                predicates.add(cb.lessThanOrEqualTo(root.get("eventDate"), dateTo));
            }

            // Фильтр по Времени
            if (timeFrom != null && timeTo != null) {
                predicates.add(cb.between(root.get("eventTime"), timeFrom, timeTo));
            }

            if (priceFrom != null || priceTo != null) {
                Join<Event, Ticket> ticketJoin = root.join("tickets", JoinType.INNER);

                Expression<Float> priceExpression = ticketJoin.get("price"); // Цена билета

                if (priceFrom != null) {
                    // Цена билета >= priceFrom
                    predicates.add(cb.greaterThanOrEqualTo(priceExpression, priceFrom.floatValue()));
                }
                if (priceTo != null) {
                    // Цена билета <= priceTo
                    predicates.add(cb.lessThanOrEqualTo(priceExpression, priceTo.floatValue()));
                }
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}