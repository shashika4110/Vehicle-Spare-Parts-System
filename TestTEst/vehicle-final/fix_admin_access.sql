-- ========================================
-- FIX: Access Denied - Admin User Setup
-- ========================================
-- Run this SQL script to fix admin access issues

USE vehicle_spareparts_db;

-- ========================================
-- STEP 1: Check Current Roles
-- ========================================
SELECT '=== CHECKING ROLES ===' AS step;
SELECT * FROM roles;

-- Expected roles:
-- 1 | ADMIN
-- 2 | STORE_OWNER
-- 3 | CUSTOMER
-- 4 | DELIVERY_STAFF


-- ========================================
-- STEP 2: Check Admin User Status
-- ========================================
SELECT '=== CHECKING ADMIN USER ===' AS step;
SELECT 
    u.id,
    u.username,
    u.email,
    u.full_name,
    u.role_id,
    r.name as role_name,
    u.is_active,
    CASE 
        WHEN u.password LIKE '$2a$%' THEN 'Password Encrypted ✓'
        ELSE 'Password NOT Encrypted ✗'
    END as password_status
FROM users u
LEFT JOIN roles r ON u.role_id = r.id
WHERE u.username = 'admin';

-- If no results, admin user doesn't exist!
-- If role_name is NOT 'ADMIN', there's a role problem!


-- ========================================
-- STEP 3: Fix Admin User Role (if needed)
-- ========================================
SELECT '=== FIXING ADMIN ROLE ===' AS step;

-- Update admin user to have ADMIN role (role_id = 1)
UPDATE users 
SET role_id = 1,
    is_active = TRUE
WHERE username = 'admin';

-- Verify the fix
SELECT 'Admin role updated!' AS status;


-- ========================================
-- STEP 4: Create Admin User (if missing)
-- ========================================
-- Only run if admin user doesn't exist

-- First, check if admin exists
SELECT 
    CASE 
        WHEN EXISTS(SELECT 1 FROM users WHERE username = 'admin') 
        THEN 'Admin user EXISTS - skip creation'
        ELSE 'Admin user MISSING - creating now...'
    END AS admin_status;

-- Create admin user if it doesn't exist
-- Password: password123 (BCrypt hash)
INSERT IGNORE INTO users (username, email, password, full_name, phone, address, role_id, is_active)
VALUES (
    'admin',
    'admin@vehicle.com',
    '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6',
    'System Admin',
    '0771234567',
    '123 Admin Street, Colombo',
    1,  -- ADMIN role
    TRUE
);


-- ========================================
-- STEP 5: Verify Admin User is Fixed
-- ========================================
SELECT '=== VERIFICATION ===' AS step;

SELECT 
    u.id,
    u.username,
    u.email,
    u.full_name,
    r.name as role_name,
    u.is_active,
    u.created_at,
    CASE 
        WHEN r.name = 'ADMIN' AND u.is_active = TRUE 
        THEN '✓ READY TO USE'
        WHEN r.name != 'ADMIN' 
        THEN '✗ WRONG ROLE'
        WHEN u.is_active = FALSE 
        THEN '✗ USER INACTIVE'
        ELSE '✗ PROBLEM'
    END as status
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE u.username = 'admin';


-- ========================================
-- STEP 6: Check All Admin Users
-- ========================================
SELECT '=== ALL ADMIN USERS ===' AS step;

SELECT 
    u.id,
    u.username,
    u.email,
    u.full_name,
    u.is_active
FROM users u
JOIN roles r ON u.role_id = r.id
WHERE r.name = 'ADMIN';


-- ========================================
-- OPTIONAL: Create Additional Admin User
-- ========================================
-- Uncomment to create a backup admin account

/*
INSERT INTO users (username, email, password, full_name, phone, role_id, is_active)
VALUES (
    'admin2',
    'admin2@vehicle.com',
    '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6',
    'Backup Admin',
    '0771234568',
    1,
    TRUE
);
*/


-- ========================================
-- OPTIONAL: Reset Admin Password
-- ========================================
-- If you need to reset admin password to "password123"

/*
UPDATE users 
SET password = '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6'
WHERE username = 'admin';

SELECT 'Admin password reset to: password123' AS message;
*/


-- ========================================
-- FINAL CHECK: User Counts
-- ========================================
SELECT '=== USER STATISTICS ===' AS step;

SELECT 
    r.name as role_name,
    COUNT(u.id) as total_users,
    SUM(CASE WHEN u.is_active = TRUE THEN 1 ELSE 0 END) as active_users,
    SUM(CASE WHEN u.is_active = FALSE THEN 1 ELSE 0 END) as inactive_users
FROM roles r
LEFT JOIN users u ON r.id = u.role_id
GROUP BY r.id, r.name
ORDER BY r.id;


-- ========================================
-- SUCCESS MESSAGE
-- ========================================
SELECT '=== ✓ ADMIN FIX COMPLETE ===' AS result;
SELECT 'Now try logging in with:' AS instruction;
SELECT 'Username: admin' AS username;
SELECT 'Password: password123' AS password;
SELECT 'URL: http://localhost:8080/login.html' AS login_url;
SELECT 'Then go to: http://localhost:8080/admin-users.html' AS admin_page;


-- ========================================
-- TROUBLESHOOTING QUERIES
-- ========================================

-- If still having issues, run these:

-- 1. Check if roles table is populated
-- SELECT * FROM roles;

-- 2. Check all users with their roles
-- SELECT u.username, r.name as role, u.is_active 
-- FROM users u 
-- JOIN roles r ON u.role_id = r.id;

-- 3. Check for users without valid roles
-- SELECT * FROM users WHERE role_id NOT IN (SELECT id FROM roles);

-- 4. Check for duplicate usernames
-- SELECT username, COUNT(*) FROM users GROUP BY username HAVING COUNT(*) > 1;
