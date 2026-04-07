@echo off
echo ===============================================
echo  UPDATE PRODUCT IMAGES WITH GOOGLE URLS
echo ===============================================
echo.
echo This will add unique images to all products
echo.
pause

echo Running SQL script...
mysql -u root -p vehicle_spareparts_db < database\update_product_images.sql

echo.
echo ===============================================
echo  DONE! Check the output above for results
echo ===============================================
pause

