----------------------------------------------------------------------
-- 1. Создание таблицы users
----------------------------------------------------------------------
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255),
    user_photo TEXT,
    role VARCHAR(50)
);

----------------------------------------------------------------------
-- 2. Создание таблицы organisators
----------------------------------------------------------------------
CREATE TABLE organisators (
    organisator_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

----------------------------------------------------------------------
-- 3. Создание таблицы age_restrictions
----------------------------------------------------------------------
CREATE TABLE age_restrictions (
    age_id SERIAL PRIMARY KEY,
    age_category VARCHAR(30) NOT NULL UNIQUE
);

----------------------------------------------------------------------
-- 4. Создание таблицы categories
----------------------------------------------------------------------
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

----------------------------------------------------------------------
-- 5. Создание таблицы cities
----------------------------------------------------------------------
CREATE TABLE cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL UNIQUE
);

----------------------------------------------------------------------
-- 6. Создание таблицы promocodes
----------------------------------------------------------------------
CREATE TABLE promocodes (
    promocode_id SERIAL PRIMARY KEY,
    promocode VARCHAR(200) NOT NULL UNIQUE,
    price_charge FLOAT
);

----------------------------------------------------------------------
-- 7. Создание таблицы events (с внешними ключами)
----------------------------------------------------------------------
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(200) NOT NULL,
    event_date DATE,
    event_place VARCHAR(200),
    event_time TIME,
    description TEXT,
    poster TEXT,
    people_amount INTEGER,

    -- Внешние ключи
    age_id INT,
    category_id INT,
    city_id INT,
    organisator_id INT,

    FOREIGN KEY (age_id) REFERENCES age_restrictions (age_id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE SET NULL,
    FOREIGN KEY (city_id) REFERENCES cities (city_id) ON DELETE SET NULL,
    FOREIGN KEY (organisator_id) REFERENCES organisators (organisator_id) ON DELETE CASCADE
);

-- Создание индексов для ускорения поиска по внешним ключам в events
CREATE INDEX idx_events_age_id ON events (age_id);
CREATE INDEX idx_events_category_id ON events (category_id);
CREATE INDEX idx_events_city_id ON events (city_id);
CREATE INDEX idx_events_organisator_id ON events (organisator_id);


----------------------------------------------------------------------
-- 8. Создание таблицы tickets (ManyToOne с users и events)
----------------------------------------------------------------------
CREATE TABLE tickets (
    ticket_id SERIAL PRIMARY KEY,
    price FLOAT NOT NULL,

    -- Внешние ключи
    user_id INT NOT NULL,
    event_id INT NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events (event_id) ON DELETE CASCADE
);

CREATE INDEX idx_tickets_user_id ON tickets (user_id);
CREATE INDEX idx_tickets_event_id ON tickets (event_id);

ALTER TABLE tickets ADD CONSTRAINT uq_user_event UNIQUE (user_id, event_id);