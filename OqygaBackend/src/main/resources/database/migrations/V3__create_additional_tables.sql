----------------------------------------------------------------------
-- 1. Создание таблицы languages
----------------------------------------------------------------------

CREATE TABLE languages (
    language_id SERIAL PRIMARY KEY,
    language VARCHAR(100) NOT NULL UNIQUE
);

----------------------------------------------------------------------
-- 1. Создание таблицы cards
----------------------------------------------------------------------

CREATE TABLE cards (
    token_id SERIAL PRIMARY KEY,
    payment_token TEXT NOT NULL UNIQUE,
    last_four_digits VARCHAR(4) NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);