-- Check if feedback table exists and has data
USE vehicle_spareparts_db;

-- Check table structure
DESCRIBE feedback;

-- Check all feedback entries
SELECT 
    id,
    customer_id,
    subject,
    message,
    rating,
    feedback_type,
    status,
    created_at
FROM feedback
ORDER BY created_at DESC;

-- Count feedback
SELECT COUNT(*) as total_feedback FROM feedback;

-- Check if customer_id exists in users table
SELECT 
    u.user_id,
    u.username,
    u.full_name,
    COUNT(f.id) as feedback_count
FROM users u
LEFT JOIN feedback f ON u.user_id = f.customer_id
GROUP BY u.user_id, u.username, u.full_name;
