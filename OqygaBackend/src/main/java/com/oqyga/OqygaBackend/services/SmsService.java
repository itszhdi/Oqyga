package com.oqyga.OqygaBackend.services;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.client.RestTemplate;
import java.util.Map;

@Service
@Slf4j
public class SmsService {

    @Value("${BOT_API_URL:${bot.api.url}}")
    private String nodeApiUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * Отправляет сообщение в WhatsApp через Node.js бота.
     */
    public void sendWhatsAppMessage(String phoneNumber, String message) {
        // 1. Создаем тело запроса
        Map<String, String> requestBody = Map.of(
                "phone", phoneNumber,
                "message", message
        );

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Map<String, String>> entity = new HttpEntity<>(requestBody, headers);

            log.info("Отправка сообщения на Node.js бот для номера: {}", phoneNumber);
            restTemplate.postForEntity(nodeApiUrl, entity, String.class);

            log.info("Сообщение успешно передано Node.js боту для {}", phoneNumber);
        } catch (Exception e) {
            
            log.error("Ошибка связи с Node.js ботом: {}", e.getMessage());
            throw new RuntimeException("Сервис отправки сообщений временно недоступен: " + e.getMessage());
        }
    }
}