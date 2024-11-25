-- Insigth into Dataset
SELECT *
FROM e_waste;

-- Unique Electronics Products
SELECT DISTINCT(Item_Name)
FROM e_waste;

-- Electronic Products Counts
SELECT Item_Name, COUNT(Item_Name) Count_of_Items
FROM e_waste
GROUP BY Item_Name;

-- Electronic Products by Brand
SELECT Item_Name, Brand, COUNT(Item_Name) Count_Brands
FROM e_waste
GROUP BY Item_Name, Brand;

-- General Working Condition of the Electronic Products
SELECT Condition, COUNT(Condition) Count_Condition
FROM e_waste
GROUP BY Condition
ORDER BY Count_Condition DESC;

-- Electronic Products Frequency by Condition
SELECT Item_Name, Condition, COUNT(Condition) Count_Condition
FROM e_waste
GROUP BY Item_Name, Condition
ORDER BY Count_Condition DESC;

-- Electronics Product Frequency by Brand and Condition
SELECT Item_Name, Brand, Condition, COUNT(Condition) Count_Brands
FROM e_waste
GROUP BY Item_Name, Brand, Condition
ORDER BY Count_Brands DESC;

-- Broken Electronic Products Counts
SELECT Item_Name, Brand, Condition, COUNT(Condition) Count_Condition
FROM e_waste
WHERE Condition='Broken'
GROUP BY Item_Name, Brand, Condition
ORDER BY Count_Condition DESC;

-- Electronic Products Where Gathered
SELECT Item_Name, Location, COUNT(Location) as Counts
FROM e_waste
GROUP BY Item_Name, Location
ORDER BY Counts DESC;

-- Recycled Price (USD) and Weight Statistics of Electronic Products
SELECT Item_Name, 
	COUNT(Item_Name) as Counts_of_Items, 
	SUM(Weight_kg) AS Total_Weight, AVG(Weight_kg) as Avg_Weight, 
	SUM(Recycled_Price_USD) AS Total_Price, AVG(Recycled_Price_USD) as Avg_Price  
FROM e_waste
GROUP BY Item_Name;

-- E-Waste Collection by Collector and Item
SELECT Item_Name,
	[E-Waste_Collector], 
	COUNT([E-Waste_Collector]) as Collect_Products ,
	SUM(COUNT([E-Waste_Collector])) OVER (PARTITION BY [E-Waste_Collector]) AS Total_Collect_Products
FROM e_waste
GROUP BY Item_Name, [E-Waste_Collector]
ORDER BY Collect_Products DESC;

-- What Are E-waste Products Used For and Where to Exported ?
SELECT End_Use, 
	Exported_To,  
	COUNT(End_Use) as Total_Used  
FROM e_waste
GROUP BY End_Use, Exported_To
ORDER BY Total_Used DESC;

-- Toxic Components of Electronic Products
SELECT Item_Name, 
	Toxic_Components, 
	COUNT(Toxic_Components) as Toxic_Componentss,
	SUM(COUNT(Toxic_Components)) OVER (PARTITION BY Toxic_Components) AS Total_Toxic_Components
FROM e_waste
WHERE Toxic_Components != 'None'
GROUP BY Item_Name, Toxic_Components
ORDER BY Toxic_Componentss, Total_Toxic_Components;

-- Product vs Brand Carbon Footprint Comparision
SELECT 
    'Brand' AS Category, 
    Brand AS Name, 
    AVG(Carbon_Footprint) AS Avg_Carbon_Footprint
FROM e_waste
GROUP BY Brand
UNION ALL
SELECT 
    'Item_Name' AS Category, 
    Item_Name AS Name, 
    AVG(Carbon_Footprint) AS Avg_Carbon_Footprint
FROM e_waste
GROUP BY Item_Name;




