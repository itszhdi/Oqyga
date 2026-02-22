package com.oqyga.OqygaBackend.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.oqyga.OqygaBackend.dto.QrCodePayload;
import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Ticket;
import com.oqyga.OqygaBackend.repositories.TicketRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j // Аннотация для логгера
@Service
@RequiredArgsConstructor
public class QrCodeService {

    private final TicketRepository ticketRepository;
    private final ObjectMapper objectMapper;

    private String getLocalizedText(String ru, String en, String kk, String lang) {
        log.debug("Локализация текста. Выбранный язык: {}", lang);
        if ("kk".equalsIgnoreCase(lang)) return (kk != null && !kk.isEmpty()) ? kk : ru;
        if ("en".equalsIgnoreCase(lang)) return (en != null && !en.isEmpty()) ? en : ru;
        return ru;
    }

    @Transactional(readOnly = true)
    public QrCodePayload getTicketDetails(Integer userId, Integer eventId, String language) {
        log.info("Запрос деталей билета для QR: userId={}, eventId={}, lang={}", userId, eventId, language);

        List<Ticket> tickets = ticketRepository.findByUser_UserIdAndEvent_EventId(userId, eventId);

        if (tickets.isEmpty()) {
            log.error("Билеты не найдены для пользователя {} на мероприятие {}", userId, eventId);
            throw new EntityNotFoundException("Билеты не найдены для user " + userId + " и event " + eventId);
        }

        Ticket firstTicket = tickets.get(0);
        Event event = firstTicket.getEvent();

        String eventName = getLocalizedText(event.getEventName(), event.getEventNameEn(), event.getEventNameKk(), language);
        String eventLocation = getLocalizedText(event.getEvent_place(), event.getEventPlaceEn(), event.getEventPlaceKk(), language);

        log.debug("Локализованные данные: name='{}', location='{}'", eventName, eventLocation);

        int totalTickets = tickets.stream()
                .mapToInt(Ticket::getQuantity)
                .sum();

        List<QrCodePayload.TicketGroup> ticketGroups = tickets.stream()
                .map(ticket -> QrCodePayload.TicketGroup.builder()
                        .price(ticket.getPrice())
                        .quantity(ticket.getQuantity())
                        .seatDetails(ticket.getSeatDetails())
                        .build())
                .collect(Collectors.toList());

        return QrCodePayload.builder()
                .userId(userId)
                .eventId(eventId)
                .eventName(eventName)
                .eventDate(event.getEventDate().toString())
                .eventTime(event.getEventTime().toString())
                .eventLocation(eventLocation)
                .totalTickets(totalTickets)
                .posterUrl(event.getPoster())
                .ticketGroups(ticketGroups)
                .build();
    }

    @Transactional(readOnly = true)
    public QrCodePayload getTicketDetailsByTicketId(Integer ticketId, String language) {
        log.info("Запрос деталей билета по ticketId: {}, lang: {}", ticketId, language);
        Ticket ticket = ticketRepository.findById(ticketId)
                .orElseThrow(() -> {
                    log.error("Билет с ID {} не найден", ticketId);
                    return new EntityNotFoundException("Билет с ID " + ticketId + " не найден");
                });

        return getTicketDetails(ticket.getUser().getUserId(), ticket.getEvent().getEventId(), language);
    }

    public byte[] generateQrCodeForUserEvent(Integer userId, Integer eventId, String language) {
        log.info("Генерация QR для userId={}, eventId={}", userId, eventId);
        QrCodePayload payload = getTicketDetails(userId, eventId, language);
        return generateQrCode(payload);
    }

    public byte[] generateQrCodeForTicketId(Integer ticketId, String language) {
        log.info("Генерация QR для ticketId={}", ticketId);
        QrCodePayload payload = getTicketDetailsByTicketId(ticketId, language);
        return generateQrCode(payload);
    }

    private byte[] generateQrCode(QrCodePayload payload) {
        try {
            log.debug("Сериализация payload в JSON для QR-кода");
            String jsonPayload = objectMapper.writeValueAsString(payload);

            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(jsonPayload, BarcodeFormat.QR_CODE, 350, 350);

            ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);

            byte[] bytes = pngOutputStream.toByteArray();
            log.info("QR-код успешно сгенерирован. Размер: {} байт", bytes.length);
            return bytes;
        } catch (Exception e) {
            log.error("Ошибка при генерации QR-кода: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to generate QR code", e);
        }
    }
}