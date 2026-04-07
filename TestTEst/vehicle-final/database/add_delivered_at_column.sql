-- Add delivered_at column to orders table
ALTER TABLE orders ADD COLUMN delivered_at DATETIME AFTER approved_at;

-- Update existing DELIVERED orders with a timestamp
UPDATE orders 
SET delivered_at = NOW() 
WHERE status = 'DELIVERED' AND delivered_at IS NULL;
