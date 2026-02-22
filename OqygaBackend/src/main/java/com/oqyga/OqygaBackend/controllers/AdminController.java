package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.entities.*;
import com.oqyga.OqygaBackend.services.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final AdminService adminService;

    // Получение всех пользователей
    @GetMapping("/users")
    public ResponseEntity<List<User>> getAllUsers() {
        return ResponseEntity.ok(adminService.getAllUsers());
    }

    // Удаление пользователя
    @DeleteMapping("/users/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Integer id) {
        adminService.deleteUser(id);
        return ResponseEntity.ok("User deleted successfully");
    }

    // Смена роли
    @PutMapping("/users/{id}/promote")
    public ResponseEntity<User> promoteToOrganisator(@PathVariable Integer id) {
        return ResponseEntity.ok(adminService.promoteToOrganisator(id));
    }

    @PutMapping("/users/{id}/demote")
    public ResponseEntity<User> demoteToUser(@PathVariable Integer id) {
        return ResponseEntity.ok(adminService.demoteToUser(id));
    }

    // Заблокировать пользователя
    @PutMapping("/users/{id}/block")
    public ResponseEntity<String> blockUser(@PathVariable Integer id) {
        adminService.toggleBlockUser(id, true);
        return ResponseEntity.ok("User blocked successfully");
    }

    // Разблокировать пользователя
    @PutMapping("/users/{id}/unblock")
    public ResponseEntity<String> unblockUser(@PathVariable Integer id) {
        adminService.toggleBlockUser(id, false);
        return ResponseEntity.ok("User unblocked successfully");
    }

    // Получить все мероприятия
    @GetMapping("/events")
    public ResponseEntity<List<Event>> getAllEvents() {
        return ResponseEntity.ok(adminService.getAllEvents());
    }

    // Удалить мероприятие
    @DeleteMapping("/events/{eventId}")
    public ResponseEntity<String> deleteEvent(@PathVariable Integer eventId) {
        adminService.deleteEvent(eventId);
        return ResponseEntity.ok("Event deleted successfully");
    }

    // Получить список всех городов
    @GetMapping("/cities")
    public ResponseEntity<List<City>> getAllCities() {
        return ResponseEntity.ok(adminService.getAllCities());
    }

    // Добавить город
    // Пример JSON тела:
    // {
    //   "cityName": "Алматы",
    //   "cityNameEn": "Almaty",
    //   "cityNameKk": "Almaty"
    // }
    @PostMapping("/cities")
    public ResponseEntity<City> addCity(@RequestBody City city) {
        return ResponseEntity.ok(adminService.addCity(city));
    }

    // Удалить город
    // АЙЫМ ВНИМАНИЕ - тут если удалить существующий город - то удаляются все билеты, все мероприятия и все связанное
    @DeleteMapping("/cities/{id}")
    public ResponseEntity<String> deleteCity(@PathVariable Integer id) {
        adminService.deleteCity(id);
        return ResponseEntity.ok("City deleted successfully");
    }

    // Получить все промокоды
    @GetMapping("/promocodes")
    public ResponseEntity<List<Promocode>> getAllPromocodes() {
        return ResponseEntity.ok(adminService.getAllPromocodes());
    }

    // Создать новый промокод
    // Body: { "promocode": "SALE50", "priceCharge": 50.0 }
    @PostMapping("/promocodes")
    public ResponseEntity<Promocode> createPromocode(@RequestBody Promocode promocode) {
        return ResponseEntity.ok(adminService.createPromocode(promocode));
    }

    // Изменить существующий промокод
    // Body: { "promocode": "SALE_NEW", "priceCharge": 100.0 }
    @PutMapping("/promocodes/{id}")
    public ResponseEntity<Promocode> updatePromocode(@PathVariable Integer id, @RequestBody Promocode promocode) {
        return ResponseEntity.ok(adminService.updatePromocode(id, promocode));
    }

    // Удалить промокод
    @DeleteMapping("/promocodes/{id}")
    public ResponseEntity<String> deletePromocode(@PathVariable Integer id) {
        adminService.deletePromocode(id);
        return ResponseEntity.ok("Promocode deleted successfully");
    }

    @GetMapping("/tickets")
    public ResponseEntity<List<Ticket>> getAllTickets() {
        return ResponseEntity.ok(adminService.getAllTickets());
    }

    @DeleteMapping("/tickets/{id}")
    public ResponseEntity<String> deleteTicket(@PathVariable Integer id) {
        adminService.deleteTicket(id);
        return ResponseEntity.ok("Ticket deleted successfully");
    }

}