-- Insert a sample delivery boy user
INSERT INTO users (username, email, password, full_name, phone, address, role_id, is_active) VALUES
('deliveryboy_sample', 'deliveryboy@sample.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'Sample Delivery Boy', '0771234567', '123 Sample Street, Sample City', 4, TRUE);

-- Get the user ID of the inserted user
SET @delivery_boy_id = LAST_INSERT_ID();

-- Insert delivery boy details
INSERT INTO delivery_boy_details (user_id, vehicle_make, vehicle_model, vehicle_number, license_number, driving_experience) VALUES
(@delivery_boy_id, 'Toyota', 'Corolla', 'SAM123', 'DL1234567890', 5);