-- =======================================================
-- QUICK FIX: Show Claim Warranty Button
-- =======================================================
-- Run this SQL in MySQL Workbench to change order status to DELIVERED
-- This will make the "Claim Warranty" button appear!
-- =======================================================

-- Change your order from APPROVED to DELIVERED
UPDATE orders 
SET status = 'DELIVERED' 
WHERE order_number = 'ORD6673359F';

-- Verify the change was successful
SELECT 
    order_number,
    status,
    order_date,
    total_amount,
    customer_id
FROM orders 
WHERE order_number = 'ORD6673359F';

-- Expected Result:
-- order_number: ORD6673359F
-- status: DELIVERED  <-- Should now show DELIVERED
-- order_date: 2025-10-20
-- total_amount: 2500.00

-- =======================================================
-- NEXT STEPS:
-- 1. Copy the UPDATE command above
-- 2. Open MySQL Workbench
-- 3. Paste and Execute
-- 4. Refresh your "My Orders" page in browser
-- 5. You will see "🛡️ Claim Warranty" button!
-- =======================================================
