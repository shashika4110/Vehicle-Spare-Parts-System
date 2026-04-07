# 🖼️ Product Images Setup Guide

## Overview
Your customer dashboard now supports **unique images for each product**! This guide explains how to add and manage product images using Google/Unsplash URLs.

---

## ✅ What's Been Updated

### 1. **Backend (Already Configured)**
- ✅ `SparePart` entity has `imageUrl` field
- ✅ `OrderItemResponse` DTO includes image URLs
- ✅ `OrderService` automatically maps images from products to order items

### 2. **Frontend (Enhanced)**
- ✅ Product grid shows images (clickable for full view)
- ✅ Order items display larger **80x80px** thumbnails
- ✅ Order item images are **clickable** to view full-size
- ✅ Hover effects and smooth transitions
- ✅ Automatic fallback to default image if URL fails

### 3. **Database Script (Ready to Run)**
- ✅ `update_product_images.sql` - Adds unique images to all 15 products
- ✅ `UPDATE_PRODUCT_IMAGES.bat` - Easy-to-run batch file

---

## 🚀 Quick Start

### Step 1: Run the Image Update Script

**Option A: Using Batch File (Easiest)**
```bash
cd "vehicle final"
UPDATE_PRODUCT_IMAGES.bat
```

**Option B: Using MySQL Command**
```bash
mysql -u root -p vehicle_spareparts_db < database/update_product_images.sql
```

**Option C: Using MySQL Workbench**
1. Open MySQL Workbench
2. Open file: `database/update_product_images.sql`
3. Execute the script

### Step 2: Restart Your Application
```bash
cd "vehicle final"
run.bat
```

### Step 3: Test It Out
1. Login as customer (john@email.com / password123)
2. Browse products - you'll see unique images!
3. Go to "My Orders" tab - order items now have beautiful thumbnails
4. Click any image to view full-size

---

## 📸 Image Features

### Product Grid
- ✓ High-quality product images
- ✓ Click to view full-size modal
- ✓ Fallback to default image if URL fails
- ✓ Warranty badge overlay

### Order Items
- ✓ **80x80px** clickable thumbnails
- ✓ Hover effects (border highlight + image zoom)
- ✓ Click to view full-size image
- ✓ Part number and details shown
- ✓ Warranty badge for warrantied items

---

## 🎨 Adding Your Own Images

### Method 1: Using Unsplash URLs
1. Go to https://unsplash.com
2. Search for the vehicle part (e.g., "brake pads")
3. Right-click on image → "Copy image address"
4. Use format: `https://images.unsplash.com/photo-XXXXX?w=400&h=400&fit=crop`

### Method 2: Using Google Images
1. Search Google Images for vehicle parts
2. Click on image → Right-click → "Copy image address"
3. **Make sure it's a direct image URL** (ends with .jpg, .png, .jpeg, .webp)

### Method 3: Using Your Own Hosted Images
Upload images to any hosting service and use the direct URL.

---

## 📝 Add Images to New Products

When adding a new product via admin panel or SQL, include the `image_url`:

### SQL Example:
```sql
INSERT INTO spare_parts 
(part_number, part_name, category, brand, price, stock_quantity, image_url) 
VALUES 
('BP003', 'Ceramic Brake Pads', 'Brakes', 'Brembo', 5500.00, 40,
 'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=400');
```

### Update Existing Product:
```sql
UPDATE spare_parts 
SET image_url = 'YOUR_IMAGE_URL_HERE'
WHERE part_number = 'BP001';
```

---

## 🔧 Current Product Images

The `update_product_images.sql` script adds these images:

| Part Number | Product Name | Category | Image Source |
|------------|--------------|----------|--------------|
| BP001 | Brake Pad Set | Brakes | Unsplash - Brake pads |
| BP002 | Brake Disc | Brakes | Unsplash - Brake disc |
| EF001 | Engine Oil Filter | Filters | Unsplash - Oil filter |
| EF002 | Air Filter | Filters | Unsplash - Air filter |
| SP001 | Spark Plug Set | Engine | Unsplash - Spark plugs |
| BA001 | Car Battery | Electrical | Unsplash - Car battery |
| WB001 | Wiper Blade Set | Accessories | Unsplash - Wipers |
| HL001 | Headlight Bulb | Lighting | Unsplash - Headlight |
| TS001 | Tire Set | Tires | Unsplash - Tires |
| SH001 | Shock Absorber | Suspension | Unsplash - Suspension |
| CB001 | Clutch Kit | Transmission | Unsplash - Clutch |
| RA001 | Radiator | Cooling | Unsplash - Radiator |
| AL001 | Alternator | Electrical | Unsplash - Alternator |
| ST001 | Starter Motor | Electrical | Unsplash - Starter |
| FP001 | Fuel Pump | Fuel System | Unsplash - Fuel pump |

---

## 🎯 Best Practices

### Image URLs
- ✅ Use **direct image URLs** (ending in .jpg, .png, .webp)
- ✅ Prefer **https** over http
- ✅ Use CDN URLs (Unsplash, Imgur, CloudFlare) for fast loading
- ✅ Recommended size: **400x400 to 800x800 pixels**
- ❌ Avoid extremely large images (slow loading)
- ❌ Don't use URLs that require authentication

### Image Quality
- Use clear, well-lit product photos
- Square images work best (1:1 aspect ratio)
- White or light backgrounds preferred
- Show the product clearly

---

## 🐛 Troubleshooting

### Images Not Showing?

**1. Check Database:**
```sql
SELECT part_name, image_url FROM spare_parts WHERE image_url IS NULL;
```

**2. Check Browser Console:**
- Press F12 → Console tab
- Look for "Failed to load" errors

**3. Test Image URL:**
- Copy the URL from database
- Paste in browser address bar
- If it doesn't show an image, the URL is invalid

**4. Clear Browser Cache:**
- Press Ctrl + Shift + Delete
- Clear cached images and files

### Fallback Image
If an image URL fails, the system automatically shows:
- Default vehicle parts image for products
- Gear icon for order items

---

## 💡 Advanced Customization

### Change Image Size in Orders
Edit `customer-dashboard.html` line 466:
```html
<!-- Change w-20 h-20 to your preferred size -->
<div class="w-24 h-24 flex-shrink-0 ...">
```

Size classes: `w-16 h-16` (64px), `w-20 h-20` (80px), `w-24 h-24` (96px), `w-32 h-32` (128px)

### Change Default Fallback Image
Edit line 471:
```javascript
onerror="this.onerror=null; this.src='YOUR_DEFAULT_IMAGE_URL';"
```

---

## 📞 Support

If you need help:
1. Check this guide
2. Review the SQL script output for errors
3. Check browser console (F12)
4. Verify image URLs work in browser

---

## ✨ Enjoy Your Beautiful Product Images!

Your customers will now see:
- 🎨 Unique images for every product
- 🔍 Clickable images for full view
- 💫 Smooth hover effects
- 📱 Responsive design on all devices

