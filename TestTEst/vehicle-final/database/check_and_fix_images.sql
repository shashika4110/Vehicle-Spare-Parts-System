
USE vehicle_spareparts_db;

-- ========================================
-- STEP 1: Check if image_url column exists
-- ========================================
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'vehicle_spareparts_db'
  AND TABLE_NAME = 'spare_parts'
  AND COLUMN_NAME = 'image_url';

-- If the above returns no rows, run this:
-- ALTER TABLE spare_parts ADD COLUMN image_url VARCHAR(255) AFTER warranty_months;


-- ========================================
-- STEP 2: Check current products and their image status
-- ========================================
SELECT 
    id,
    part_number,
    part_name,
    category,
    brand,
    price,
    stock_quantity,
    warranty_months,
    CASE 
        WHEN image_url IS NOT NULL AND image_url != '' THEN CONCAT('✅ ', LEFT(image_url, 50), '...')
        ELSE '❌ No Image'
    END AS image_status
FROM spare_parts
ORDER BY id;


-- ========================================
-- STEP 3: MANUAL UPDATE - Add images to specific products
-- ========================================
-- Replace the ID numbers with your actual product IDs

-- Example: Update product ID 1 with brake pad image
-- UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=800' WHERE id = 1;

-- Example: Update product ID 2 with brake disc image
-- UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=800' WHERE id = 2;

-- Example: Update product ID 3 with oil filter image
-- UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800' WHERE id = 3;


-- ========================================
-- STEP 4: BULK UPDATE - Add default images by category
-- ========================================

-- Update all Brake products
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=800'
WHERE category = 'Brakes' 
  AND (image_url IS NULL OR image_url = '' OR image_url = 'null');

-- Update all Filter products
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800'
WHERE category = 'Filters' 
  AND (image_url IS NULL OR image_url = '' OR image_url = 'null');

-- Update all Engine products
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=800'
WHERE category = 'Engine' 
  AND (image_url IS NULL OR image_url = '' OR image_url = 'null');

-- Update all Tire products
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800'
WHERE category = 'Tires' 
  AND (image_url IS NULL OR image_url = '' OR image_url = 'null');

-- Update all Battery products
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1609877200136-1e673936b1e0?w=800'
WHERE (category = 'Battery' OR category = 'Electrical')
  AND (image_url IS NULL OR image_url = '' OR image_url = 'null');

-- Update all Suspension products
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=800'
WHERE category = 'Suspension' 
  AND (image_url IS NULL OR image_url = '' OR image_url = 'null');

-- Default image for any remaining products without images
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=800'
WHERE (image_url IS NULL OR image_url = '' OR image_url = 'null');


-- ========================================
-- STEP 5: Verify all products now have images
-- ========================================
SELECT 
    COUNT(*) as total_products,
    SUM(CASE WHEN image_url IS NOT NULL AND image_url != '' AND image_url != 'null' THEN 1 ELSE 0 END) as with_images,
    SUM(CASE WHEN image_url IS NULL OR image_url = '' OR image_url = 'null' THEN 1 ELSE 0 END) as without_images
FROM spare_parts;


-- ========================================
-- STEP 6: View all products with their image URLs
-- ========================================
SELECT 
    id,
    part_name,
    category,
    brand,
    price,
    stock_quantity,
    image_url
FROM spare_parts
ORDER BY category, part_name;
