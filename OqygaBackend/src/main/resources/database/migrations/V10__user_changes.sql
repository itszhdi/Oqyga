----------------------------------------------------------------------
-- Изменение пользователя
----------------------------------------------------------------------

ALTER TABLE users

    -- столбец для языка
    ADD COLUMN language_id INT DEFAULT 2 REFERENCES languages (language_id) ON DELETE CASCADE,

    -- столбец для восстановления пароля
    ADD COLUMN otp VARCHAR(10),

    -- столбец для refresh tokens
    ADD COLUMN refresh_token VARCHAR(250),

    -- столбец для даты истечения срока действия OTP
    ADD COLUMN otp_expiry_date TIMESTAMP;