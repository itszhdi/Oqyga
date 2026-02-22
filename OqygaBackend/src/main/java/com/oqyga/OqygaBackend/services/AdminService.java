package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.entities.*;
import com.oqyga.OqygaBackend.repositories.*;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.EntityExistsException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;
    private final OrganisatorRepository organisatorRepository;
    private final EventRepository eventRepository;
    private final CityRepository cityRepository;
    private final PromocodeRepository promocodeRepository;
    private final TicketRepository ticketRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public void deleteUser(Integer userId) {
        if (!userRepository.existsById(userId)) {
            throw new EntityNotFoundException("User not found with id: " + userId);
        }
        userRepository.deleteById(userId);
    }

    @Transactional
    public User promoteToOrganisator(Integer userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + userId));

        if (user.getRole() == Role.ORGANISATOR) {
            return user;
        }

        user.setRole(Role.ORGANISATOR);

        if (user.getOrganisator() == null) {
            Organisator organisator = new Organisator();
            organisator.setUser(user);
            user.setOrganisator(organisator);
        }

        return userRepository.save(user);
    }

    public User toggleBlockUser(Integer userId, boolean shouldBlock) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + userId));

        user.setBlocked(shouldBlock);
        return userRepository.save(user);
    }

    @Transactional
    public User demoteToUser(Integer userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + userId));

        if (user.getRole() != Role.ORGANISATOR) {
            return user;
        }

        Organisator organisator = user.getOrganisator();

        if (organisator != null) {
            user.setOrganisator(null);

            organisatorRepository.delete(organisator);
        }

        user.setRole(Role.USER);
        return userRepository.save(user);
    }


    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    @Transactional
    public void deleteEvent(Integer eventId) {
        if (!eventRepository.existsById(eventId)) {
            throw new EntityNotFoundException("Event not found with id: " + eventId);
        }
        eventRepository.deleteById(eventId);
    }

    public List<City> getAllCities() {
        return cityRepository.findAll();
    }

    public City addCity(City city) {
        return cityRepository.save(city);
    }

    @Transactional
    public void deleteCity(Integer cityId) {
        City city = cityRepository.findById(cityId)
                .orElseThrow(() -> new EntityNotFoundException("City not found with id: " + cityId));
        List<Event> events = eventRepository.findByCity(city);

        eventRepository.deleteAll(events);
        cityRepository.delete(city);
    }

    public List<Promocode> getAllPromocodes() {
        return promocodeRepository.findAll();
    }
    public Promocode createPromocode(Promocode promocode) {
        if (promocodeRepository.findByPromocode(promocode.getPromocode()).isPresent()) {
            throw new EntityExistsException("Promocode with this name already exists");
        }

        if (promocode.getPriceCharge() != null) {
            promocode.setPriceCharge(roundToTwo(promocode.getPriceCharge()));
        }

        return promocodeRepository.save(promocode);
    }

    public Promocode updatePromocode(Integer id, Promocode updatedPromocode) {
        Promocode existingPromocode = promocodeRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Promocode not found with id: " + id));

        existingPromocode.setPromocode(updatedPromocode.getPromocode());

        if (updatedPromocode.getPriceCharge() != null) {
            existingPromocode.setPriceCharge(roundToTwo(updatedPromocode.getPriceCharge()));
        }

        return promocodeRepository.save(existingPromocode);
    }

    private float roundToTwo(float value) {
        return Math.round(value * 100.0f) / 100.0f;
    }

    public void deletePromocode(Integer id) {
        if (!promocodeRepository.existsById(id)) {
            throw new EntityNotFoundException("Promocode not found with id: " + id);
        }
        promocodeRepository.deleteById(id);
    }

    public List<Ticket> getAllTickets() {
        return ticketRepository.findAll();
    }

    @Transactional
    public void deleteTicket(Integer ticketId) {
        if (!ticketRepository.existsById(ticketId)) {
            throw new EntityNotFoundException("Ticket not found with id: " + ticketId);
        }
        ticketRepository.deleteById(ticketId);
    }


}