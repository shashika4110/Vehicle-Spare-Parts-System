-- =========================================================
-- COMPLETE SQL SETUP FOR WARRANTY CLAIM WORKFLOW
-- =========================================================
-- Database: vehicle_spareparts_db
-- Purpose: Enable complete warranty claim workflow
-- =========================================================

-- Step 1: Use the database
USE vehicle_spareparts_db;

-- =========================================================
-- PART 1: CHANGE ORDER STATUS TO DELIVERED
-- =========================================================

-- This makes the "Claim Warranty" button appear on My Orders page
UPDATE orders 
SET status = 'DELIVERED' 
WHERE order_number = 'ORD6673359F';

-- Verify the order is now DELIVERED
SELECT 
    id,
    order_number,
    status,
    order_date,
    total_amount,
    customer_id
FROM orders 
WHERE order_number = 'ORD6673359F';

-- =========================================================
-- PART 2: CHECK WARRANTY CLAIMS TABLE EXISTS
-- =========================================================

-- Create warranty_claims table if it doesn't exist
CREATE TABLE IF NOT EXISTS warranty_claims (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    claim_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    purchase_date DATE NOT NULL,
    warranty_expiry_date DATE NOT NULL,
    issue_description TEXT NOT NULL,
    customer_comments TEXT,
    status VARCHAR(20) DEFAULT 'PENDING',
    store_response TEXT,
    processed_by_id BIGINT,
    processed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES spare_parts(id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (processed_by_id) REFERENCES users(id),
    
    INDEX idx_customer (customer_id),
    INDEX idx_status (status),
    INDEX idx_claim_number (claim_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- PART 3: VIEW ALL ORDERS FOR CUSTOMER
-- =========================================================

-- See all orders for john_customer (customer_id = 1)
SELECT 
    o.id,
    o.order_number,
    o.status,
    o.order_date,
    o.total_amount,
    o.payment_method,
    u.username as customer_name
FROM orders o
JOIN users u ON o.customer_id = u.id
WHERE u.username = 'john_customer'
ORDER BY o.order_date DESC;

-- =========================================================
-- PART 4: VIEW ORDER ITEMS (Products in Order)
-- =========================================================

-- See what products are in the order
SELECT 
    oi.id,
    oi.order_id,
    sp.id as product_id,
    sp.part_name,
    sp.part_number,
    oi.quantity,
    oi.unit_price,
    oi.total_price,
    sp.warranty_months
FROM order_items oi
JOIN spare_parts sp ON oi.spare_part_id = sp.id
WHERE oi.order_id = (SELECT id FROM orders WHERE order_number = 'ORD6673359F');

-- =========================================================
-- PART 5: CHECK EXISTING WARRANTY CLAIMS
-- =========================================================

-- View all warranty claims
SELECT 
    wc.id,
    wc.claim_number,
    wc.status,
    wc.issue_description,
    wc.customer_comments,
    wc.store_response,
    wc.created_at,
    u.username as customer_name,
    sp.part_name as product_name,
    o.order_number
FROM warranty_claims wc
JOIN users u ON wc.customer_id = u.id
JOIN spare_parts sp ON wc.product_id = sp.id
JOIN orders o ON wc.order_id = o.id
ORDER BY wc.created_at DESC;

-- =========================================================
-- PART 6: SAMPLE DATA - CREATE TEST WARRANTY CLAIM (OPTIONAL)
-- =========================================================

-- Uncomment below to create a test warranty claim manually:
/*
INSERT INTO warranty_claims (
    claim_number,
    customer_id,
    product_id,
    order_id,
    purchase_date,
    warranty_expiry_date,
    issue_description,
    customer_comments,
    status
)
SELECT 
    CONCAT('WC-', UPPER(SUBSTRING(MD5(RAND()), 1, 8))),  -- Generate unique claim number
    o.customer_id,
    oi.spare_part_id,
    o.id,
    DATE(o.order_date),
    DATE_ADD(DATE(o.order_date), INTERVAL sp.warranty_months MONTH),
    'Product defective - making strange noise',
    'Installed by certified mechanic, issue started immediately',
    'PENDING'
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN spare_parts sp ON oi.spare_part_id = sp.id
WHERE o.order_number = 'ORD6673359F'
LIMIT 1;
*/

-- =========================================================
-- PART 7: APPROVE A WARRANTY CLAIM (Store Owner Action)
-- =========================================================

-- Uncomment and replace CLAIM_NUMBER to approve a claim:
/*
UPDATE warranty_claims
SET 
    status = 'APPROVED',
    store_response = 'Claim approved. We will ship replacement parts within 3 business days.',
    processed_by_id = (SELECT id FROM users WHERE username = 'storeowner'),
    processed_at = NOW()
WHERE claim_number = 'WC-XXXXXXXX';  -- Replace with actual claim number
*/

-- =========================================================
-- PART 8: REJECT A WARRANTY CLAIM (Store Owner Action)
-- =========================================================

-- Uncomment and replace CLAIM_NUMBER to reject a claim:
/*
UPDATE warranty_claims
SET 
    status = 'REJECTED',
    store_response = 'Claim rejected. Product inspection shows improper installation which is not covered under warranty.',
    processed_by_id = (SELECT id FROM users WHERE username = 'storeowner'),
    processed_at = NOW()
WHERE claim_number = 'WC-XXXXXXXX';  -- Replace with actual claim number
*/

-- =========================================================
-- PART 9: VERIFY USERS EXIST
-- =========================================================

-- Check if customer exists
SELECT id, username, full_name, email, role 
FROM users 
WHERE username = 'john_customer';

-- Check if store owner exists
SELECT id, username, full_name, email, role 
FROM users 
WHERE username = 'storeowner';

-- =========================================================
-- PART 10: CHECK DATABASE TABLES
-- =========================================================

-- List all tables in database
SHOW TABLES;

-- Check warranty_claims table structure
DESCRIBE warranty_claims;

-- Count records in each table
SELECT 'users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'spare_parts', COUNT(*) FROM spare_parts
UNION ALL
SELECT 'warranty_claims', COUNT(*) FROM warranty_claims;

-- =========================================================
-- QUICK REFERENCE QUERIES
-- =========================================================

-- View all DELIVERED orders (should show warranty button)
SELECT order_number, status, order_date, total_amount
FROM orders
WHERE status = 'DELIVERED'
ORDER BY order_date DESC;

-- View all PENDING warranty claims
SELECT claim_number, status, issue_description, created_at
FROM warranty_claims
WHERE status = 'PENDING'
ORDER BY created_at DESC;

-- =========================================================
-- CLEANUP (OPTIONAL - USE WITH CAUTION!)
-- =========================================================

-- Uncomment to delete all warranty claims (for testing):
-- DELETE FROM warranty_claims WHERE 1=1;

-- Uncomment to reset order status back to APPROVED:
-- UPDATE orders SET status = 'APPROVED' WHERE order_number = 'ORD6673359F';

-- =========================================================
-- END OF SQL SCRIPT
-- =========================================================
-- 
-- NEXT STEPS:
-- 1. Run Part 1 to change order to DELIVERED
-- 2. Refresh "My Orders" page in browser
-- 3. Click "Claim Warranty" button that now appears
-- 4. Fill the form and submit
-- 5. Check Part 5 query to see your new claim
-- 6. Login as store owner to approve/reject
-- 
-- =========================================================
