-- Quick Fix: Change Order to DELIVERED to Show Warranty Button

-- Update your order to DELIVERED status
UPDATE orders 
SET status = 'DELIVERED' 
WHERE order_number = 'ORD6673359F';

-- Verify the change
SELECT order_number, status, order_date, total_amount 
FROM orders 
WHERE order_number = 'ORD6673359F';

-- Alternative: Update by date if you have multiple orders from today
-- UPDATE orders 
-- SET status = 'DELIVERED' 
-- WHERE DATE(order_date) = '2025-10-20' AND status = 'APPROVED';

-- After running this SQL:
-- 1. Refresh your "My Orders" page
-- 2. You will see "🛡️ Claim Warranty" button appear!
