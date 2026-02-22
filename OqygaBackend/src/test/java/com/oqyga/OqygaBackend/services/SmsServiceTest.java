package com.oqyga.OqygaBackend.services;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class SmsServiceTest {

    @Mock
    private RestTemplate restTemplate;

    @InjectMocks
    private SmsService smsService;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(smsService, "restTemplate", restTemplate);
    }

//    @Test
//    void sendWhatsAppMessage_Success() {
//        String phone = "77011234567";
//        String message = "Hello!";
//        Map<String, String> expectedRequest = Map.of("phone", phone, "message", message);
//
//        smsService.sendWhatsAppMessage(phone, message);
//
//        verify(restTemplate).postForEntity(
//                eq("http://localhost:3000/api/send-otp"),
//                eq(expectedRequest),
//                eq(String.class)
//        );
//    }

    @Test
    void sendWhatsAppMessage_Error_ShouldThrowRuntimeException() {
        when(restTemplate.postForEntity(any(), any(), any()))
                .thenThrow(new RestClientException("Connection refused"));

        Exception exception = assertThrows(RuntimeException.class,
                () -> smsService.sendWhatsAppMessage("123", "test"));

        assertTrue(exception.getMessage().contains("Сервис отправки сообщений временно недоступен"));
    }
}