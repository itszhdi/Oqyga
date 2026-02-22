package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.entities.*;
import com.oqyga.OqygaBackend.repositories.*;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AdminServiceTest {

    @Mock private UserRepository userRepository;
    @Mock private OrganisatorRepository organisatorRepository;
    @Mock private EventRepository eventRepository;
    @Mock private CityRepository cityRepository;
    @Mock private PromocodeRepository promocodeRepository;
    @Mock private TicketRepository ticketRepository;

    @InjectMocks
    private AdminService adminService;

    private User testUser;
    private Promocode testPromocode;

    @BeforeEach
    void setUp() {
        testUser = User.builder()
                .userId(1)
                .userName("testUser")
                .role(Role.USER)
                .isBlocked(false)
                .build();

        testPromocode = Promocode.builder()
                .promocodeId(1)
                .promocode("SALE10")
                .priceCharge(0.12345f)
                .build();
    }

    @Test
    @DisplayName("Получение всех пользователей")
    void getAllUsers_ShouldReturnList() {
        when(userRepository.findAll()).thenReturn(List.of(testUser));
        List<User> result = adminService.getAllUsers();
        assertEquals(1, result.size());
        verify(userRepository, times(1)).findAll();
    }

    @Test
    @DisplayName("Удаление существующего пользователя")
    void deleteUser_ShouldDelete_WhenUserExists() {
        when(userRepository.existsById(1)).thenReturn(true);
        adminService.deleteUser(1);
        verify(userRepository).deleteById(1);
    }

    @Test
    @DisplayName("Удаление пользователя: ошибка, если не найден")
    void deleteUser_ShouldThrowException_WhenUserNotFound() {
        when(userRepository.existsById(1)).thenReturn(false);
        assertThrows(EntityNotFoundException.class, () -> adminService.deleteUser(1));
    }

    @Test
    @DisplayName("Повышение пользователя до организатора")
    void promoteToOrganisator_ShouldChangeRoleAndCreateEntity() {
        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));
        when(userRepository.save(any(User.class))).thenReturn(testUser);

        User promoted = adminService.promoteToOrganisator(1);

        assertEquals(Role.ORGANISATOR, promoted.getRole());
        assertNotNull(promoted.getOrganisator());
        verify(userRepository).save(testUser);
    }

    @Test
    @DisplayName("Блокировка/Разблокировка пользователя")
    void toggleBlockUser_ShouldChangeStatus() {
        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));
        when(userRepository.save(any(User.class))).thenReturn(testUser);

        User blocked = adminService.toggleBlockUser(1, true);
        assertTrue(blocked.isBlocked());

        User unblocked = adminService.toggleBlockUser(1, false);
        assertFalse(unblocked.isBlocked());
    }

    @Test
    @DisplayName("Понижение организатора до пользователя")
    void demoteToUser_ShouldRemoveOrganisatorAndChangeRole() {
        testUser.setRole(Role.ORGANISATOR);
        Organisator org = new Organisator();
        testUser.setOrganisator(org);

        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));
        when(userRepository.save(any(User.class))).thenReturn(testUser);

        User demoted = adminService.demoteToUser(1);

        assertEquals(Role.USER, demoted.getRole());
        assertNull(demoted.getOrganisator());
        verify(organisatorRepository).delete(org);
    }


    @Test
    @DisplayName("Получение всех событий")
    void getAllEvents_ShouldReturnList() {
        Event event = new Event();
        when(eventRepository.findAll()).thenReturn(List.of(event));

        List<Event> result = adminService.getAllEvents();

        assertEquals(1, result.size());
        verify(eventRepository).findAll();
    }

    @Test
    @DisplayName("Удаление события: успех")
    void deleteEvent_ShouldDelete_WhenExists() {
        when(eventRepository.existsById(1)).thenReturn(true);
        adminService.deleteEvent(1);
        verify(eventRepository).deleteById(1);
    }

    @Test
    @DisplayName("Удаление события: ошибка, если не найдено")
    void deleteEvent_ShouldThrowException_WhenNotFound() {
        when(eventRepository.existsById(1)).thenReturn(false);
        assertThrows(EntityNotFoundException.class, () -> adminService.deleteEvent(1));
    }

    @Test
    @DisplayName("Получение всех городов")
    void getAllCities_ShouldReturnList() {
        City city = new City();
        when(cityRepository.findAll()).thenReturn(List.of(city));

        List<City> result = adminService.getAllCities();

        assertEquals(1, result.size());
        verify(cityRepository).findAll();
    }

    @Test
    @DisplayName("Добавление города")
    void addCity_ShouldSaveAndReturnCity() {
        City city = new City();
        city.setCityName("New City");
        when(cityRepository.save(city)).thenReturn(city);

        City saved = adminService.addCity(city);

        assertEquals("New City", saved.getCityName());
        verify(cityRepository).save(city);
    }

    @Test
    @DisplayName("Удаление города вместе с его событиями")
    void deleteCity_ShouldDeleteEventsThenCity() {
        City city = new City();
        city.setCityId(1);
        Event event = new Event();

        when(cityRepository.findById(1)).thenReturn(Optional.of(city));
        when(eventRepository.findByCity(city)).thenReturn(List.of(event));

        adminService.deleteCity(1);

        verify(eventRepository).deleteAll(List.of(event));
        verify(cityRepository).delete(city);
    }

    @Test
    @DisplayName("Удаление города: ошибка, если не найден")
    void deleteCity_ShouldThrowException_WhenNotFound() {
        when(cityRepository.findById(1)).thenReturn(Optional.empty());
        assertThrows(EntityNotFoundException.class, () -> adminService.deleteCity(1));
    }

    @Test
    @DisplayName("Получение всех промокодов")
    void getAllPromocodes_ShouldReturnList() {
        when(promocodeRepository.findAll()).thenReturn(List.of(testPromocode));
        List<Promocode> result = adminService.getAllPromocodes();
        assertEquals(1, result.size());
        verify(promocodeRepository).findAll();
    }

    @Test
    @DisplayName("Создание промокода с округлением значения")
    void createPromocode_ShouldRoundValueAndSave() {
        when(promocodeRepository.findByPromocode("SALE10")).thenReturn(Optional.empty());
        when(promocodeRepository.save(any(Promocode.class))).thenAnswer(i -> i.getArguments()[0]);

        Promocode saved = adminService.createPromocode(testPromocode);
        assertEquals(0.12f, saved.getPriceCharge());
        verify(promocodeRepository).save(any(Promocode.class));
    }

    @Test
    @DisplayName("Создание промокода: ошибка, если имя занято")
    void createPromocode_ShouldThrowException_WhenNameExists() {
        when(promocodeRepository.findByPromocode("SALE10")).thenReturn(Optional.of(testPromocode));
        assertThrows(EntityExistsException.class, () -> adminService.createPromocode(testPromocode));
    }

    @Test
    @DisplayName("Обновление промокода")
    void updatePromocode_ShouldUpdateFieldsAndRound() {
        Promocode updatedData = new Promocode();
        updatedData.setPromocode("NEW_NAME");
        updatedData.setPriceCharge(0.555f); // Должно стать 0.56

        when(promocodeRepository.findById(1)).thenReturn(Optional.of(testPromocode));
        when(promocodeRepository.save(any(Promocode.class))).thenAnswer(i -> i.getArguments()[0]);

        Promocode result = adminService.updatePromocode(1, updatedData);

        assertEquals("NEW_NAME", result.getPromocode());
        assertEquals(0.56f, result.getPriceCharge());
    }

    @Test
    @DisplayName("Удаление промокода")
    void deletePromocode_ShouldInvokeDelete() {
        when(promocodeRepository.existsById(1)).thenReturn(true);
        adminService.deletePromocode(1);
        verify(promocodeRepository).deleteById(1);
    }

    @Test
    @DisplayName("Удаление промокода: ошибка, если не найден")
    void deletePromocode_ShouldThrowException_WhenNotFound() {
        when(promocodeRepository.existsById(1)).thenReturn(false);
        assertThrows(EntityNotFoundException.class, () -> adminService.deletePromocode(1));
    }

    @Test
    @DisplayName("Получение всех билетов")
    void getAllTickets_ShouldReturnList() {
        Ticket ticket = new Ticket();
        when(ticketRepository.findAll()).thenReturn(List.of(ticket));

        List<Ticket> result = adminService.getAllTickets();

        assertEquals(1, result.size());
        verify(ticketRepository).findAll();
    }

    @Test
    @DisplayName("Удаление билета: успех")
    void deleteTicket_ShouldDelete_WhenExists() {
        when(ticketRepository.existsById(1)).thenReturn(true);
        adminService.deleteTicket(1);
        verify(ticketRepository).deleteById(1);
    }

    @Test
    @DisplayName("Удаление билета: ошибка, если не найден")
    void deleteTicket_ShouldThrowException_WhenNotFound() {
        when(ticketRepository.existsById(1)).thenReturn(false);
        assertThrows(EntityNotFoundException.class, () -> adminService.deleteTicket(1));
    }
}