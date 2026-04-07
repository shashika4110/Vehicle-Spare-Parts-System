-- Admin User Management - Database Verification Queries
-- Use these queries to verify the admin user management system is working correctly

-- ============================================
-- 1. CHECK ADMIN USER EXISTS
-- ============================================
-- This should return the admin user with role_id = 1
SELECT id, username, email, full_name, role_id, is_active 
FROM users 
WHERE username = 'admin';

-- Expected Result:
-- id | username | email              | full_name    | role_id | is_active
-- 1  | admin    | admin@vehicle.com  | System Admin | 1       | 1


-- ============================================
-- 2. VIEW ALL ROLES
-- ============================================
-- Check all available roles in the system
SELECT * FROM roles;

-- Expected Result:
-- id | name           | description
-- 1  | ADMIN          | System Administrator with full access
-- 2  | STORE_OWNER    | Store owner managing inventory and orders
-- 3  | CUSTOMER       | Customer who can place orders
-- 4  | DELIVERY_STAFF | Delivery personnel


-- ============================================
-- 3. COUNT USERS BY ROLE
-- ============================================
-- See how many users exist for each role
SELECT 
    r.name AS role_name,
    COUNT(u.id) AS user_count
FROM roles r
LEFT JOIN users u ON r.id = u.role_id
GROUP BY r.id, r.name
ORDER BY r.id;

-- Expected Result (may vary):
-- role_name      | user_count
-- ADMIN          | 1
-- STORE_OWNER    | 1
-- CUSTOMER       | 1
-- DELIVERY_STAFF | 1


-- ============================================
-- 4. VIEW ALL USERS WITH ROLE NAMES
-- ============================================
-- See complete user list with role names
SELECT 
    u.id,
    u.username,
    u.email,
    u.full_name,
    r.name AS role,
    u.is_active,
    u.created_at
FROM users u
JOIN roles r ON u.role_id = r.id
ORDER BY u.id;


-- ============================================
-- 5. CHECK ACTIVE USERS
-- ============================================
-- See only active users
SELECT 
    u.id,
    u.username,
    u.full_name,
    r.name AS role
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE u.is_active = TRUE;


-- ============================================
-- 6. CHECK INACTIVE USERS
-- ============================================
-- See only inactive/disabled users
SELECT 
    u.id,
    u.username,
    u.full_name,
    r.name AS role
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE u.is_active = FALSE;


-- ============================================
-- 7. VERIFY PASSWORD ENCRYPTION
-- ============================================
-- Check that passwords are encrypted (BCrypt hashes start with $2a$)
SELECT 
    username,
    CASE 
        WHEN password LIKE '$2a$%' THEN 'Encrypted (BCrypt)'
        WHEN password LIKE '$2b$%' THEN 'Encrypted (BCrypt)'
        ELSE 'Not Encrypted!'
    END AS password_status
FROM users;

-- All users should show "Encrypted (BCrypt)"


-- ============================================
-- 8. FIND DUPLICATE USERNAMES (Should be empty)
-- ============================================
-- Check for duplicate usernames (there should be none)
SELECT username, COUNT(*) as count
FROM users
GROUP BY username
HAVING COUNT(*) > 1;

-- Expected Result: Empty (no duplicates)


-- ============================================
-- 9. FIND DUPLICATE EMAILS (Should be empty)
-- ============================================
-- Check for duplicate emails (there should be none)
SELECT email, COUNT(*) as count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;

-- Expected Result: Empty (no duplicates)


-- ============================================
-- 10. RECENTLY CREATED USERS
-- ============================================
-- See users created in the last 7 days
SELECT 
    u.username,
    u.full_name,
    r.name AS role,
    u.created_at
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE u.created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
ORDER BY u.created_at DESC;


-- ============================================
-- 11. RECENTLY UPDATED USERS
-- ============================================
-- See users modified in the last 7 days
SELECT 
    u.username,
    u.full_name,
    r.name AS role,
    u.updated_at
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE u.updated_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
ORDER BY u.updated_at DESC;


-- ============================================
-- 12. USER STATISTICS SUMMARY
-- ============================================
-- Complete statistics overview
SELECT 
    'Total Users' AS metric,
    COUNT(*) AS count
FROM users
UNION ALL
SELECT 
    'Active Users' AS metric,
    COUNT(*) AS count
FROM users
WHERE is_active = TRUE
UNION ALL
SELECT 
    'Inactive Users' AS metric,
    COUNT(*) AS count
FROM users
WHERE is_active = FALSE
UNION ALL
SELECT 
    'Admin Users' AS metric,
    COUNT(*) AS count
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE r.name = 'ADMIN'
UNION ALL
SELECT 
    'Store Owners' AS metric,
    COUNT(*) AS count
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE r.name = 'STORE_OWNER'
UNION ALL
SELECT 
    'Customers' AS metric,
    COUNT(*) AS count
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE r.name = 'CUSTOMER'
UNION ALL
SELECT 
    'Delivery Staff' AS metric,
    COUNT(*) AS count
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE r.name = 'DELIVERY_STAFF';


-- ============================================
-- TESTING QUERIES
-- ============================================

-- After creating a test user through admin-users.html, verify it was created:
SELECT * FROM users WHERE username = 'testuser1';

-- After updating a user, check the updated_at timestamp changed:
SELECT username, full_name, updated_at 
FROM users 
WHERE username = 'testuser1';

-- After deleting a user, verify it's gone:
SELECT * FROM users WHERE username = 'testuser1';
-- Should return empty after deletion


-- ============================================
-- MANUAL USER CREATION (if needed)
-- ============================================

-- Create a test admin user manually
INSERT INTO users (username, email, password, full_name, phone, address, role_id, is_active)
VALUES (
    'testadmin',
    'testadmin@example.com',
    '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', -- password123
    'Test Admin',
    '1234567890',
    '123 Test Street',
    1, -- ADMIN role
    TRUE
);

-- Create a test customer manually
INSERT INTO users (username, email, password, full_name, phone, address, role_id, is_active)
VALUES (
    'testcustomer',
    'testcustomer@example.com',
    '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', -- password123
    'Test Customer',
    '0987654321',
    '456 Customer Ave',
    3, -- CUSTOMER role
    TRUE
);


-- ============================================
-- CLEANUP QUERIES (Use with caution!)
-- ============================================

-- Delete test users (BE CAREFUL!)
-- DELETE FROM users WHERE username LIKE 'test%';

-- Deactivate a user instead of deleting
-- UPDATE users SET is_active = FALSE WHERE username = 'testuser1';

-- Reactivate a user
-- UPDATE users SET is_active = TRUE WHERE username = 'testuser1';


-- ============================================
-- NOTES
-- ============================================
-- 1. All passwords in the system are BCrypt encrypted
-- 2. The default password for seeded users is: password123
-- 3. The BCrypt hash: $2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6
--    decrypts to: password123
-- 4. Never store plain text passwords in the database
-- 5. Use the admin-users.html interface for user management (recommended)
-- 6. Direct database modifications should only be used for debugging
