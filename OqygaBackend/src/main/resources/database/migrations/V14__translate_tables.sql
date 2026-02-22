----------------------------------------------------------------------
-- Добавление строк для переводов
----------------------------------------------------------------------

-- Миграция для таблицы categories
ALTER TABLE categories
    ADD COLUMN category_name_en VARCHAR(100),
    ADD COLUMN category_name_kk VARCHAR(100);

-- Миграция для таблицы cities
ALTER TABLE cities
    ADD COLUMN city_name_en VARCHAR(100),
    ADD COLUMN city_name_kk VARCHAR(100);

-- Миграция для таблицы events
ALTER TABLE events
    ADD COLUMN event_name_en VARCHAR(200),
    ADD COLUMN event_name_kk VARCHAR(200),
    ADD COLUMN event_place_en VARCHAR(200),
    ADD COLUMN event_place_kk VARCHAR(200),
    ADD COLUMN description_en TEXT,
    ADD COLUMN description_kk TEXT;