-- ==========================================
-- 1. UPDATE USER
-- ==========================================

ALTER TABLE users
ADD COLUMN is_blocked BOOLEAN DEFAULT FALSE NOT NULL;