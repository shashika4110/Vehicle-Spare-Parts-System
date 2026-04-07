-- Migration Script: Add image_url column if not exists and update existing products with sample images
-- Run this script in MySQL Workbench or command line

USE vehicle_spareparts_db;

-- Check if image_url column exists, if not add it
ALTER TABLE spare_parts 
ADD COLUMN IF NOT EXISTS image_url VARCHAR(255) AFTER warranty_months;

-- Update existing products with sample images (if they don't have images)
-- You can customize these URLs based on your actual products

-- Brake Pads
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=800'
WHERE category = 'Brakes' 
  AND part_name LIKE '%Brake Pad%' 
  AND (image_url IS NULL OR image_url = '');

-- Brake Discs
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=800'
WHERE category = 'Brakes' 
  AND part_name LIKE '%Brake Disc%' 
  AND (image_url IS NULL OR image_url = '');

-- Oil Filters
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800'
WHERE category = 'Filters' 
  AND part_name LIKE '%Oil Filter%' 
  AND (image_url IS NULL OR image_url = '');

-- Air Filters
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=800'
WHERE category = 'Filters' 
  AND part_name LIKE '%Air Filter%' 
  AND (image_url IS NULL OR image_url = '');

-- Spark Plugs
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=800'
WHERE category LIKE '%Engine%' 
  AND part_name LIKE '%Spark Plug%' 
  AND (image_url IS NULL OR image_url = '');

-- Tires
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800'
WHERE category = 'Tires' 
  AND (image_url IS NULL OR image_url = '');

-- Batteries
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1609877200136-1e673936b1e0?w=800'
WHERE category LIKE '%Battery%' 
  AND (image_url IS NULL OR image_url = '');

-- Engine Parts (general)
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=800'
WHERE category = 'Engine' 
  AND (image_url IS NULL OR image_url = '');

-- Wipers
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=800'
WHERE part_name LIKE '%Wiper%' 
  AND (image_url IS NULL OR image_url = '');

-- Belts
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=800'
WHERE part_name LIKE '%Belt%' 
  AND (image_url IS NULL OR image_url = '');

-- Verify the updates
SELECT 
    id,
    part_number,
    part_name,
    category,
    price,
    stock_quantity,
    CASE 
        WHEN image_url IS NOT NULL AND image_url != '' THEN '✅ Has Image'
        ELSE '❌ No Image'
    END AS image_status,
    image_url
FROM spare_parts
ORDER BY category, part_name;

-- Count products with and without images
SELECT 
    CASE 
        WHEN image_url IS NOT NULL AND image_url != '' THEN 'With Image'
        ELSE 'Without Image'
    END AS status,
    COUNT(*) as count
FROM spare_parts
GROUP BY 
    CASE 
        WHEN image_url IS NOT NULL AND image_url != '' THEN 'With Image'
        ELSE 'Without Image'
    END;
