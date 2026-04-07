-- Update all passwords to BCrypt hash for 'password123'
UPDATE users SET password = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy';

-- Verify the update
SELECT username, SUBSTRING(password, 1, 20) as password_prefix FROM users;
