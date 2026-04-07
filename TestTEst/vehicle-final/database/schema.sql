-- Drop database if exists
DROP DATABASE IF EXISTS vehicle_spareparts_db;

-- Create database
CREATE DATABASE vehicle_spareparts_db;
USE vehicle_spareparts_db;

-- Create Roles Table
CREATE TABLE roles (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Users Table
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role_id BIGINT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    INDEX idx_email (email),
    INDEX idx_username (username),
    INDEX idx_role (role_id)
);

-- Create Spare Parts Table
CREATE TABLE spare_parts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    part_number VARCHAR(50) NOT NULL UNIQUE,
    part_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50),
    vehicle_model VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    reorder_level INT DEFAULT 10,
    warranty_months INT DEFAULT 6,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_part_number (part_number),
    INDEX idx_category (category),
    INDEX idx_part_name (part_name)
);

-- Create Orders Table
CREATE TABLE orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(50) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    payment_method VARCHAR(30),
    payment_status VARCHAR(30) DEFAULT 'PENDING',
    shipping_address TEXT NOT NULL,
    notes TEXT,
    approved_by BIGINT,
    approved_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (approved_by) REFERENCES users(id),
    INDEX idx_order_number (order_number),
    INDEX idx_customer (customer_id),
    INDEX idx_status (status),
    INDEX idx_order_date (order_date)
);

-- Create Order Items Table
CREATE TABLE order_items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    spare_part_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    warranty_months INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (spare_part_id) REFERENCES spare_parts(id),
    INDEX idx_order (order_id),
    INDEX idx_spare_part (spare_part_id)
);

-- Create Deliveries Table
CREATE TABLE deliveries (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    delivery_number VARCHAR(50) NOT NULL UNIQUE,
    order_id BIGINT NOT NULL,
    delivery_staff_id BIGINT,
    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    assigned_at TIMESTAMP NULL,
    dispatched_at TIMESTAMP NULL,
    delivered_at TIMESTAMP NULL,
    delivery_address TEXT NOT NULL,
    tracking_notes TEXT,
    customer_signature VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (delivery_staff_id) REFERENCES users(id),
    INDEX idx_delivery_number (delivery_number),
    INDEX idx_order (order_id),
    INDEX idx_status (status),
    INDEX idx_delivery_staff (delivery_staff_id)
);

-- Create Warranty Table
CREATE TABLE warranties (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    warranty_number VARCHAR(50) NOT NULL UNIQUE,
    order_item_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    spare_part_id BIGINT NOT NULL,
    purchase_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    status VARCHAR(30) DEFAULT 'ACTIVE',
    claim_status VARCHAR(30),
    claim_date TIMESTAMP NULL,
    claim_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_item_id) REFERENCES order_items(id),
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (spare_part_id) REFERENCES spare_parts(id),
    INDEX idx_warranty_number (warranty_number),
    INDEX idx_customer (customer_id),
    INDEX idx_status (status),
    INDEX idx_expiry_date (expiry_date)
);

-- Create Feedback Table
CREATE TABLE feedback (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id BIGINT NOT NULL,
    order_id BIGINT,
    spare_part_id BIGINT,
    feedback_type VARCHAR(30) NOT NULL,
    rating INT,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING',
    response TEXT,
    responded_by BIGINT,
    responded_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (spare_part_id) REFERENCES spare_parts(id),
    FOREIGN KEY (responded_by) REFERENCES users(id),
    INDEX idx_customer (customer_id),
    INDEX idx_status (status),
    INDEX idx_type (feedback_type)
);

-- Create Audit Log Table
CREATE TABLE audit_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id BIGINT,
    old_value TEXT,
    new_value TEXT,
    ip_address VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_user (user_id),
    INDEX idx_entity (entity_type, entity_id),
    INDEX idx_created_at (created_at)
);

-- Create Delivery Boy Details Table
CREATE TABLE delivery_boy_details (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    vehicle_make VARCHAR(50) NOT NULL,
    vehicle_model VARCHAR(50) NOT NULL,
    vehicle_number VARCHAR(20) NOT NULL,
    license_number VARCHAR(50) NOT NULL,
    driving_experience INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uk_vehicle_number (vehicle_number),
    UNIQUE KEY uk_license_number (license_number),
    INDEX idx_user_id (user_id)
);

-- Insert Default Roles
INSERT INTO roles (name, description) VALUES
('ADMIN', 'System Administrator with full access'),
('STORE_OWNER', 'Store owner managing inventory and orders'),
('CUSTOMER', 'Customer purchasing spare parts'),
('DELIVERY_STAFF', 'Delivery personnel handling shipments'),
('FINANCE_OFFICER', 'Finance officer managing payments and reports');

-- Insert Sample Users (Password: password123)
-- BCrypt hash for 'password123': $2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6
INSERT INTO users (username, email, password, full_name, phone, address, role_id, is_active) VALUES
('admin', 'admin@vehicle.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'System Admin', '0771234567', '123 Admin Street, Colombo', 1, TRUE),
('storeowner', 'owner@vehicle.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'Store Owner', '0772234567', '456 Store Avenue, Colombo', 2, TRUE),
('john_customer', 'john@email.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'John Doe', '0773234567', '789 Customer Road, Kandy', 3, TRUE),
('jane_customer', 'jane@email.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'Jane Smith', '0774234567', '321 Buyer Lane, Galle', 3, TRUE),
('delivery1', 'delivery1@vehicle.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'Delivery Staff 1', '0775234567', '654 Delivery St, Colombo', 4, TRUE),
('delivery2', 'delivery2@vehicle.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'Delivery Staff 2', '0776234567', '987 Transport Ave, Kandy', 4, TRUE),
('finance', 'finance@vehicle.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'Finance Officer', '0777234567', '147 Finance Road, Colombo', 5, TRUE);

-- Insert Sample Spare Parts
INSERT INTO spare_parts (part_number, part_name, category, brand, vehicle_model, description, price, stock_quantity, reorder_level, warranty_months, is_active) VALUES
('BP001', 'Brake Pad Set', 'Brakes', 'Bosch', 'Toyota Corolla', 'High-quality ceramic brake pads', 4500.00, 50, 10, 12, TRUE),
('BP002', 'Brake Disc', 'Brakes', 'Brembo', 'Honda Civic', 'Ventilated brake disc', 8500.00, 30, 8, 12, TRUE),
('EF001', 'Engine Oil Filter', 'Filters', 'Mann', 'Universal', 'Premium oil filter', 850.00, 100, 20, 6, TRUE),
('EF002', 'Air Filter', 'Filters', 'K&N', 'Universal', 'High-flow air filter', 2500.00, 75, 15, 6, TRUE),
('SP001', 'Spark Plug Set', 'Engine', 'NGK', 'Universal', 'Iridium spark plugs (4 pcs)', 3200.00, 60, 12, 12, TRUE),
('BA001', 'Car Battery', 'Electrical', 'Exide', 'Universal', '12V 60Ah maintenance-free battery', 15500.00, 25, 5, 24, TRUE),
('WB001', 'Wiper Blade Set', 'Accessories', 'Bosch', 'Universal', 'Premium wiper blades', 1800.00, 80, 15, 6, TRUE),
('HL001', 'Headlight Bulb', 'Lighting', 'Philips', 'Universal', 'H4 halogen bulb', 950.00, 120, 25, 6, TRUE),
('TS001', 'Tire Set', 'Tires', 'Michelin', 'Universal', '185/65R15 all-season tires (4 pcs)', 45000.00, 20, 5, 12, TRUE),
('SH001', 'Shock Absorber', 'Suspension', 'Monroe', 'Toyota Corolla', 'Gas-charged shock absorber', 6500.00, 40, 8, 12, TRUE),
('CB001', 'Clutch Kit', 'Transmission', 'Exedy', 'Honda Civic', 'Complete clutch kit', 18500.00, 15, 5, 12, TRUE),
('RA001', 'Radiator', 'Cooling', 'Denso', 'Toyota Corolla', 'Aluminum radiator', 12500.00, 20, 5, 12, TRUE),
('AL001', 'Alternator', 'Electrical', 'Bosch', 'Universal', '12V 90A alternator', 16500.00, 18, 5, 18, TRUE),
('ST001', 'Starter Motor', 'Electrical', 'Valeo', 'Universal', '12V starter motor', 14500.00, 22, 5, 18, TRUE),
('FP001', 'Fuel Pump', 'Fuel System', 'Bosch', 'Honda Civic', 'Electric fuel pump', 8500.00, 28, 6, 12, TRUE);

-- Insert Sample Orders
INSERT INTO orders (order_number, customer_id, total_amount, status, payment_method, payment_status, shipping_address, approved_by) VALUES
('ORD001', 3, 13450.00, 'APPROVED', 'CREDIT_CARD', 'PAID', '789 Customer Road, Kandy', 2),
('ORD002', 4, 52300.00, 'APPROVED', 'BANK_TRANSFER', 'PAID', '321 Buyer Lane, Galle', 2),
('ORD003', 3, 9350.00, 'PENDING', 'CASH_ON_DELIVERY', 'PENDING', '789 Customer Road, Kandy', NULL);

-- Insert Sample Order Items
INSERT INTO order_items (order_id, spare_part_id, quantity, unit_price, subtotal, warranty_months) VALUES
(1, 1, 2, 4500.00, 9000.00, 12),
(1, 3, 1, 850.00, 850.00, 6),
(1, 4, 1, 2500.00, 2500.00, 6),
(1, 7, 1, 1800.00, 1800.00, 6),
(2, 9, 1, 45000.00, 45000.00, 12),
(2, 5, 2, 3200.00, 6400.00, 12),
(2, 3, 1, 850.00, 850.00, 6),
(3, 2, 1, 8500.00, 8500.00, 12),
(3, 8, 1, 950.00, 950.00, 6);

-- Insert Sample Deliveries
INSERT INTO deliveries (delivery_number, order_id, delivery_staff_id, status, assigned_at, delivery_address) VALUES
('DEL001', 1, 5, 'DISPATCHED', NOW(), '789 Customer Road, Kandy'),
('DEL002', 2, 6, 'PENDING', NOW(), '321 Buyer Lane, Galle');

-- Insert Sample Warranties
INSERT INTO warranties (warranty_number, order_item_id, customer_id, spare_part_id, purchase_date, expiry_date, status) VALUES
('WAR001', 1, 3, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 12 MONTH), 'ACTIVE'),
('WAR002', 2, 3, 3, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 6 MONTH), 'ACTIVE'),
('WAR003', 5, 4, 9, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 12 MONTH), 'ACTIVE');

-- Insert Sample Feedback
INSERT INTO feedback (customer_id, order_id, spare_part_id, feedback_type, rating, subject, message, status) VALUES
(3, 1, 1, 'PRODUCT_REVIEW', 5, 'Excellent Brake Pads', 'Very good quality brake pads. Installation was easy and performance is great!', 'APPROVED'),
(4, 2, 9, 'PRODUCT_REVIEW', 4, 'Good Tires', 'Great tires for the price. Smooth ride and good grip.', 'PENDING'),
(3, NULL, NULL, 'COMPLAINT', 2, 'Delivery Delay', 'My order took longer than expected to arrive.', 'PENDING');

-- Insert Sample Audit Logs
INSERT INTO audit_logs (user_id, action, entity_type, entity_id, new_value, ip_address) VALUES
(1, 'CREATE_USER', 'USER', 3, 'Created customer account', '192.168.1.100'),
(2, 'APPROVE_ORDER', 'ORDER', 1, 'Order approved for delivery', '192.168.1.101'),
(5, 'UPDATE_DELIVERY', 'DELIVERY', 1, 'Status changed to DISPATCHED', '192.168.1.102');

-- Create Views for Reporting
CREATE VIEW vw_low_stock_parts AS
SELECT 
    id, part_number, part_name, category, stock_quantity, reorder_level,
    (reorder_level - stock_quantity) as shortage
FROM spare_parts
WHERE stock_quantity <= reorder_level AND is_active = TRUE;

CREATE VIEW vw_order_summary AS
SELECT 
    o.id, o.order_number, o.order_date, o.status, o.total_amount,
    u.full_name as customer_name, u.email as customer_email,
    COUNT(oi.id) as total_items,
    d.status as delivery_status
FROM orders o
JOIN users u ON o.customer_id = u.id
LEFT JOIN order_items oi ON o.id = oi.order_id
LEFT JOIN deliveries d ON o.id = d.order_id
GROUP BY o.id, o.order_number, o.order_date, o.status, o.total_amount, 
         u.full_name, u.email, d.status;

CREATE VIEW vw_sales_report AS
SELECT 
    DATE(o.order_date) as sale_date,
    COUNT(DISTINCT o.id) as total_orders,
    SUM(o.total_amount) as total_revenue,
    COUNT(oi.id) as total_items_sold
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.status IN ('APPROVED', 'COMPLETED')
GROUP BY DATE(o.order_date)
ORDER BY sale_date DESC;

-- Grant necessary permissions (adjust as needed)
-- GRANT ALL PRIVILEGES ON vehicle_spareparts_db.* TO 'root'@'localhost';
-- FLUSH PRIVILEGES;

SELECT 'Database schema created successfully!' as Status;
