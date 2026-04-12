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
