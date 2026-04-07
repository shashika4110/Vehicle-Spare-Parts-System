-- Warranty Claims Table for University Project CRUD Operations
-- This demonstrates proper warranty management system

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
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    store_response TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    processed_at TIMESTAMP NULL,
    processed_by BIGINT NULL,
    FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES spare_parts(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (processed_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_customer (customer_id),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
);

-- Add some sample warranty claims for testing
INSERT INTO warranty_claims (claim_number, customer_id, product_id, order_id, purchase_date, warranty_expiry_date, issue_description, customer_comments, status, created_at)
SELECT 
    CONCAT('WC-', UPPER(SUBSTRING(MD5(RAND()), 1, 8))),
    o.customer_id,
    oi.spare_part_id,
    o.id,
    o.order_date,
    DATE_ADD(o.order_date, INTERVAL 12 MONTH),
    'Product defect found after delivery',
    'The product stopped working properly',
    'PENDING',
    NOW()
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.status = 'DELIVERED'
LIMIT 3;

SELECT 'Warranty Claims table created successfully!' as status;
