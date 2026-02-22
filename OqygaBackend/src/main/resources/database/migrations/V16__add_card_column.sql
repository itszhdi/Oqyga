-- ==========================================
-- 1. UPDATE USER
-- ==========================================

ALTER TABLE users
ADD COLUMN stripe_customer_id VARCHAR(255);