-- ================================================================
-- SQL Script to Add Product Images to ALL Spare Parts
-- Run this script to populate imageUrl for products
-- Uses high-quality Unsplash images matched to product categories
-- ================================================================

-- First, let's see what we have
SELECT 'Current Status' as info;
SELECT 
    COUNT(*) as total_products,
    COUNT(image_url) as products_with_images,
    COUNT(*) - COUNT(image_url) as products_without_images
FROM spare_parts;

-- ================================================================
-- BRAKE SYSTEM PARTS
-- ================================================================

-- Brake Pads
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400' 
WHERE (category LIKE '%Brake%' OR part_name LIKE '%Brake%' OR part_name LIKE '%Pad%') 
  AND (image_url IS NULL OR image_url = '');

-- Brake Pads
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400' 
WHERE (category LIKE '%Brake%' OR part_name LIKE '%Brake%' OR part_name LIKE '%Pad%') 
  AND (image_url IS NULL OR image_url = '');

-- Brake Discs/Rotors
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=400'
WHERE (part_name LIKE '%Disc%' OR part_name LIKE '%Rotor%' OR part_name LIKE '%Drum%')
  AND (image_url IS NULL OR image_url = '');

-- Brake Calipers
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&q=80'
WHERE (part_name LIKE '%Caliper%' OR part_name LIKE '%Brake Kit%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- ENGINE PARTS
-- ================================================================

-- Engine Oil & Lubricants
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1615906655593-ad0386982a0f?w=400'
WHERE (part_name LIKE '%Engine Oil%' OR part_name LIKE '%Lubricant%' OR part_name LIKE '%Motor Oil%')
  AND (image_url IS NULL OR image_url = '');

-- Engine Components (Pistons, Valves, etc.)
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400' 
WHERE (category LIKE '%Engine%' OR part_name LIKE '%Engine%' OR part_name LIKE '%Piston%' OR part_name LIKE '%Valve%' OR part_name LIKE '%Cylinder%') 
  AND (image_url IS NULL OR image_url = '');

-- Timing Belts & Chains
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=85'
WHERE (part_name LIKE '%Timing%' OR part_name LIKE '%Belt%' OR part_name LIKE '%Chain%')
  AND (image_url IS NULL OR image_url = '');

-- Engine Gaskets
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1487754180451-c456f719a1fc?w=400'
WHERE (part_name LIKE '%Gasket%' OR part_name LIKE '%Seal%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- SUSPENSION SYSTEM
-- ================================================================

-- Shock Absorbers & Struts
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400' 
WHERE (category LIKE '%Suspension%' OR part_name LIKE '%Shock%' OR part_name LIKE '%Spring%' OR part_name LIKE '%Strut%' OR part_name LIKE '%Damper%') 
  AND (image_url IS NULL OR image_url = '');

-- Control Arms & Bushings
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=75'
WHERE (part_name LIKE '%Control Arm%' OR part_name LIKE '%Bushing%' OR part_name LIKE '%Ball Joint%')
  AND (image_url IS NULL OR image_url = '');

-- Stabilizer Bars
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=65'
WHERE (part_name LIKE '%Stabilizer%' OR part_name LIKE '%Sway Bar%' OR part_name LIKE '%Anti-Roll%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- ELECTRICAL SYSTEM
-- ================================================================

-- Car Batteries
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1609465801928-66ba88457b6f?w=400' 
WHERE (category LIKE '%Electrical%' OR category LIKE '%Battery%' OR part_name LIKE '%Battery%') 
  AND (image_url IS NULL OR image_url = '');

-- Alternators
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=85'
WHERE (part_name LIKE '%Alternator%' OR part_name LIKE '%Generator%')
  AND (image_url IS NULL OR image_url = '');

-- Starters
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=75'
WHERE (part_name LIKE '%Starter%' OR part_name LIKE '%Starting Motor%')
  AND (image_url IS NULL OR image_url = '');

-- Spark Plugs
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1614359036694-99af7fc54c91?w=400'
WHERE (part_name LIKE '%Spark%' OR part_name LIKE '%Plug%' OR part_name LIKE '%Ignition Plug%')
  AND (image_url IS NULL OR image_url = '');

-- Ignition Coils
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=65' 
WHERE (part_name LIKE '%Ignition%' OR part_name LIKE '%Coil%') 
  AND (image_url IS NULL OR image_url = '');

-- Fuses & Relays
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=55'
WHERE (part_name LIKE '%Fuse%' OR part_name LIKE '%Relay%')
  AND (image_url IS NULL OR image_url = '');

-- Wiring & Cables
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=45'
WHERE (part_name LIKE '%Wire%' OR part_name LIKE '%Cable%' OR part_name LIKE '%Harness%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- FILTERS
-- ================================================================

-- Oil Filters
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=400' 
WHERE (category LIKE '%Filter%' OR part_name LIKE '%Oil Filter%') 
  AND (image_url IS NULL OR image_url = '');

-- Air Filters
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=400&q=80' 
WHERE (part_name LIKE '%Air Filter%') 
  AND (image_url IS NULL OR image_url = '');

-- Fuel Filters
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=400&q=70' 
WHERE (part_name LIKE '%Fuel Filter%') 
  AND (image_url IS NULL OR image_url = '');

-- Cabin Air Filters
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=400&q=90'
WHERE (part_name LIKE '%Cabin%' OR part_name LIKE '%AC Filter%' OR part_name LIKE '%HVAC Filter%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- WHEELS & TIRES
-- ================================================================

-- Alloy Wheels
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1617654112368-307921291f42?w=400' 
WHERE (category LIKE '%Wheel%' OR category LIKE '%Tire%' OR part_name LIKE '%Wheel%' OR part_name LIKE '%Rim%' OR part_name LIKE '%Alloy%') 
  AND (image_url IS NULL OR image_url = '');

-- Tires
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1606016159991-1177d0aa9e40?w=400'
WHERE (part_name LIKE '%Tire%' OR part_name LIKE '%Tyre%')
  AND (image_url IS NULL OR image_url = '');

-- Wheel Bearings
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=50'
WHERE (part_name LIKE '%Bearing%' OR part_name LIKE '%Hub%')
  AND (image_url IS NULL OR image_url = '');

-- Wheel Nuts & Bolts
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=400&q=85'
WHERE (part_name LIKE '%Nut%' OR part_name LIKE '%Bolt%' OR part_name LIKE '%Stud%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- TRANSMISSION & CLUTCH
-- ================================================================

-- Clutch Kits
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1487754180451-c456f719a1fc?w=400&q=80' 
WHERE (category LIKE '%Transmission%' OR part_name LIKE '%Clutch%') 
  AND (image_url IS NULL OR image_url = '');

-- Transmission Parts
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=70' 
WHERE (part_name LIKE '%Transmission%' OR part_name LIKE '%Gear%' OR part_name LIKE '%Gearbox%') 
  AND (image_url IS NULL OR image_url = '');

-- Flywheel
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1487754180451-c456f719a1fc?w=400&q=60'
WHERE (part_name LIKE '%Flywheel%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- COOLING SYSTEM
-- ================================================================

-- Radiators
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=85' 
WHERE (category LIKE '%Cooling%' OR part_name LIKE '%Radiator%') 
  AND (image_url IS NULL OR image_url = '');

-- Water Pumps
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=75'
WHERE (part_name LIKE '%Water Pump%' OR part_name LIKE '%Coolant Pump%')
  AND (image_url IS NULL OR image_url = '');

-- Thermostats
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=65' 
WHERE (part_name LIKE '%Thermostat%') 
  AND (image_url IS NULL OR image_url = '');

-- Cooling Fans
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=55' 
WHERE (part_name LIKE '%Fan%' OR part_name LIKE '%Cooling Fan%') 
  AND (image_url IS NULL OR image_url = '');

-- Hoses
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=40'
WHERE (part_name LIKE '%Hose%' OR part_name LIKE '%Pipe%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- LIGHTING SYSTEM
-- ================================================================

-- Headlight Bulbs
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=85' 
WHERE (category LIKE '%Light%' OR part_name LIKE '%Headlight%' OR part_name LIKE '%Bulb%') 
  AND (image_url IS NULL OR image_url = '');

-- LED Lights
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=75'
WHERE (part_name LIKE '%LED%' OR part_name LIKE '%Light%')
  AND (image_url IS NULL OR image_url = '');

-- Tail Lights
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=65'
WHERE (part_name LIKE '%Tail%' OR part_name LIKE '%Rear Light%')
  AND (image_url IS NULL OR image_url = '');

-- Fog Lights
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=55'
WHERE (part_name LIKE '%Fog%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- FUEL SYSTEM
-- ================================================================

-- Fuel Pumps
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=80' 
WHERE (category LIKE '%Fuel%' OR part_name LIKE '%Fuel Pump%') 
  AND (image_url IS NULL OR image_url = '');

-- Fuel Injectors
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=70'
WHERE (part_name LIKE '%Injector%')
  AND (image_url IS NULL OR image_url = '');

-- Fuel Tanks
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=60'
WHERE (part_name LIKE '%Tank%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- EXHAUST SYSTEM
-- ================================================================

-- Mufflers
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&q=75' 
WHERE (category LIKE '%Exhaust%' OR part_name LIKE '%Muffler%') 
  AND (image_url IS NULL OR image_url = '');

-- Exhaust Pipes
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&q=65'
WHERE (part_name LIKE '%Exhaust%' OR part_name LIKE '%Pipe%')
  AND (image_url IS NULL OR image_url = '');

-- Catalytic Converters
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&q=55'
WHERE (part_name LIKE '%Catalytic%' OR part_name LIKE '%Converter%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- STEERING SYSTEM
-- ================================================================

-- Steering Racks
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=85' 
WHERE (category LIKE '%Steering%' OR part_name LIKE '%Steering%' OR part_name LIKE '%Rack%') 
  AND (image_url IS NULL OR image_url = '');

-- Power Steering Pumps
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=75'
WHERE (part_name LIKE '%Power Steering%')
  AND (image_url IS NULL OR image_url = '');

-- Steering Wheels
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=400'
WHERE (part_name LIKE '%Steering Wheel%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- BODY PARTS & ACCESSORIES
-- ================================================================

-- Bumpers
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1619405399517-d7fce0f13302?w=400'
WHERE (part_name LIKE '%Bumper%')
  AND (image_url IS NULL OR image_url = '');

-- Mirrors
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1563720360172-67b8f3dce741?w=400'
WHERE (part_name LIKE '%Mirror%')
  AND (image_url IS NULL OR image_url = '');

-- Wipers
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=400&q=60' 
WHERE (part_name LIKE '%Wiper%' OR part_name LIKE '%Blade%') 
  AND (image_url IS NULL OR image_url = '');

-- Door Handles
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1563720360172-67b8f3dce741?w=400&q=80'
WHERE (part_name LIKE '%Handle%' OR part_name LIKE '%Door%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- TOOLS & ACCESSORIES
-- ================================================================

-- Tool Kits
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=400' 
WHERE (part_name LIKE '%Tool%' OR part_name LIKE '%Kit%') 
  AND (image_url IS NULL OR image_url = '');

-- Jacks & Lifts
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=400&q=80'
WHERE (part_name LIKE '%Jack%' OR part_name LIKE '%Lift%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- INTERIOR PARTS
-- ================================================================

-- Seats
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1519874179391-3ebc752241dd?w=400'
WHERE (part_name LIKE '%Seat%')
  AND (image_url IS NULL OR image_url = '');

-- Floor Mats
UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=400'
WHERE (part_name LIKE '%Mat%' OR part_name LIKE '%Carpet%')
  AND (image_url IS NULL OR image_url = '');

-- ================================================================
-- FINAL DEFAULT - Any remaining parts without images
-- ================================================================

UPDATE spare_parts SET image_url = 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400' 
WHERE (image_url IS NULL OR image_url = '');

-- ================================================================
-- VERIFICATION QUERIES
-- ================================================================

SELECT '===========================================' as divider;
SELECT 'IMAGE UPDATE COMPLETE!' as status;
SELECT '===========================================' as divider;

-- Show final count
SELECT 
    'Total Products' as description, 
    COUNT(*) as count,
    '✅' as status
FROM spare_parts
UNION ALL
SELECT 
    'With Images' as description, 
    COUNT(*) as count,
    '✅' as status
FROM spare_parts 
WHERE image_url IS NOT NULL AND image_url != ''
UNION ALL
SELECT 
    'Without Images' as description, 
    COUNT(*) as count,
    CASE WHEN COUNT(*) = 0 THEN '✅' ELSE '❌' END as status
FROM spare_parts 
WHERE image_url IS NULL OR image_url = '';

-- Show breakdown by category
SELECT '===========================================' as divider;
SELECT 'BREAKDOWN BY CATEGORY' as info;
SELECT '===========================================' as divider;

SELECT 
    category, 
    COUNT(*) as total_count,
    COUNT(image_url) as with_images,
    CONCAT(ROUND((COUNT(image_url) / COUNT(*)) * 100, 1), '%') as percentage
FROM spare_parts 
GROUP BY category
ORDER BY total_count DESC;

-- Show sample of updated products
SELECT '===========================================' as divider;
SELECT 'SAMPLE OF UPDATED PRODUCTS' as info;
SELECT '===========================================' as divider;

SELECT 
    part_name,
    category,
    brand,
    SUBSTRING(image_url, 1, 60) as image_url_preview,
    '...' as more
FROM spare_parts 
WHERE image_url IS NOT NULL AND image_url != ''
LIMIT 10;

SELECT '===========================================' as divider;
SELECT '✅ ALL PRODUCTS NOW HAVE IMAGES!' as final_status;
SELECT '===========================================' as divider;
