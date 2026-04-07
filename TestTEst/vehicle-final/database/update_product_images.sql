-- Update Product Images with Unique URLs for Each Spare Part
-- Execute this script to add different images to all products

USE vehicle_spareparts_db;

-- Update Brake Pad Set with brake pads image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=400&h=400&fit=crop'
WHERE part_number = 'BP001';

-- Update Brake Disc with brake disc image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=400&h=400&fit=crop'
WHERE part_number = 'BP002';

-- Update Engine Oil Filter with oil filter image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&h=400&fit=crop'
WHERE part_number = 'EF001';

-- Update Air Filter with air filter image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&h=400&fit=crop'
WHERE part_number = 'EF002';

-- Update Spark Plug Set with spark plugs image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1609877200136-1e673936b1e0?w=400&h=400&fit=crop'
WHERE part_number = 'SP001';

-- Update Car Battery with battery image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=400&h=400&fit=crop'
WHERE part_number = 'BA001';

-- Update Wiper Blade Set with wiper blades image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=400&fit=crop'
WHERE part_number = 'WB001';

-- Update Headlight Bulb with headlight image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&h=400&fit=crop'
WHERE part_number = 'HL001';

-- Update Tire Set with tires image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1606765962248-7ff407b51667?w=400&h=400&fit=crop'
WHERE part_number = 'TS001';

-- Update Shock Absorber with suspension image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=400&h=400&fit=crop'
WHERE part_number = 'SH001';

-- Update Clutch Kit with clutch parts image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1615906655593-ad0dd8b0c2e7?w=400&h=400&fit=crop'
WHERE part_number = 'CB001';

-- Update Radiator with radiator image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=400&h=400&fit=crop'
WHERE part_number = 'RA001';

-- Update Alternator with alternator image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1615906655593-ad0dd8b0c2e7?w=400&h=400&fit=crop'
WHERE part_number = 'AL001';

-- Update Starter Motor with starter motor image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1617469767053-d3b523a0b982?w=400&h=400&fit=crop'
WHERE part_number = 'ST001';

-- Update Fuel Pump with fuel pump image
UPDATE spare_parts 
SET image_url = 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=400&h=400&fit=crop'
WHERE part_number = 'FP001';

-- Verify the updates
SELECT 
    part_number,
    part_name,
    category,
    CASE 
        WHEN image_url IS NOT NULL AND image_url != '' THEN '✓ Has Image'
        ELSE '✗ No Image'
    END as image_status,
    image_url
FROM spare_parts
ORDER BY part_number;

SELECT '✅ All product images updated successfully!' as Status;

