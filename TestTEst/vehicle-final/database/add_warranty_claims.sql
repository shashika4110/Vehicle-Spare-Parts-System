-- Add more warranty records with different statuses and claims

-- Additional warranties with claims
INSERT INTO warranties (warranty_number, order_item_id, customer_id, spare_part_id, purchase_date, expiry_date, status, claim_status, claim_date, claim_notes) VALUES
('WAR004', 3, 3, 5, DATE_SUB(CURDATE(), INTERVAL 3 MONTH), DATE_ADD(CURDATE(), INTERVAL 9 MONTH), 'ACTIVE', 'PENDING', NOW(), 'Air filter is not functioning properly. Engine performance has decreased.'),
('WAR005', 4, 4, 7, DATE_SUB(CURDATE(), INTERVAL 6 MONTH), DATE_ADD(CURDATE(), INTERVAL 6 MONTH), 'ACTIVE', 'APPROVED', DATE_SUB(NOW(), INTERVAL 2 DAY), 'Alternator failed completely. Car won\'t start. Requesting replacement.'),
('WAR006', 6, 3, 10, DATE_SUB(CURDATE(), INTERVAL 8 MONTH), DATE_ADD(CURDATE(), INTERVAL 4 MONTH), 'ACTIVE', 'REJECTED', DATE_SUB(NOW(), INTERVAL 5 DAY), 'Suspension spring broken. Need replacement urgently.'),
('WAR007', 7, 4, 2, DATE_SUB(CURDATE(), INTERVAL 4 MONTH), DATE_ADD(CURDATE(), INTERVAL 8 MONTH), 'ACTIVE', NULL, NULL, NULL),
('WAR008', 8, 3, 8, DATE_SUB(CURDATE(), INTERVAL 15 MONTH), DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 'EXPIRED', NULL, NULL, NULL),
('WAR009', 9, 4, 4, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), DATE_ADD(CURDATE(), INTERVAL 4 MONTH), 'ACTIVE', 'PENDING', DATE_SUB(NOW(), INTERVAL 1 DAY), 'Fuel filter clogged prematurely. Expecting better quality.'),
('WAR010', 10, 3, 11, DATE_SUB(CURDATE(), INTERVAL 5 MONTH), DATE_ADD(CURDATE(), INTERVAL 7 MONTH), 'ACTIVE', 'APPROVED', DATE_SUB(NOW(), INTERVAL 3 DAY), 'Radiator leaking coolant. Manufacturing defect suspected.');

-- Update claim rejection reason for WAR006
UPDATE warranties 
SET claim_notes = CONCAT(claim_notes, '\n\nREJECTION REASON: Physical damage detected. Warranty does not cover accidental damage or misuse.')
WHERE warranty_number = 'WAR006';
