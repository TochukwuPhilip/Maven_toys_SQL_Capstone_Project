![image](https://github.com/user-attachments/assets/6cd41e69-bc87-4474-afcc-a523c97427ac)
USE maven_toys;
-- A preview of all the tables
 SELECT * FROM products;
 SELECT * FROM stores;
 SELECT * FROM sales;
 SELECT * FROM inventory;
 ![image](https://github.com/user-attachments/assets/aebc392a-5470-4067-837c-e87998ded6f7)


 -- 1. Which product categories drive the biggest profits? Is this the same across store locations?
SELECT  P.Product_Category, (P.Product_Price-P.Product_Cost) AS Store_Profit, st.Store_Location
 FROM products P
	JOIN sales S ON P.Product_ID = S.Product_ID
		JOIN stores st ON st.Store_ID = S.Store_ID
			GROUP BY P.Product_Category, st.Store_Location, (P.Product_Price-P.Product_Cost)
				ORDER BY (P.Product_Price-P.Product_Cost) DESC;
![image](https://github.com/user-attachments/assets/06c032f7-15a0-43d0-a3d2-13a832939f24)

 -- 2. How much money is tied up in inventory at the toy stores? How long will it last?
 SELECT V.Store_ID,V.Stock_On_Hand, AVG(P.Product_Cost*V.Stock_On_Hand) Cost_of_Inventory, st.Store_Open_Date, 
	(DATEDIFF(DAY,st.Store_Open_Date,GETDATE())) Length_of_Days
		FROM inventory V
			JOIN products P ON P.Product_ID = V.Product_ID
				JOIN stores st ON st.Store_ID = V.Store_ID 
					GROUP BY V.Stock_On_Hand, V.Store_ID, st.Store_Open_Date
						ORDER BY V.Stock_On_Hand DESC, (DATEDIFF(DAY,st.Store_Open_Date,GETDATE())) DESC;
![image](https://github.com/user-attachments/assets/d7d83503-9144-40d1-b530-3ac70c5dcd17)
 -- 3. Are sales being lost with out-of-stock products at certain locations?
 SELECT S.Units, V.Stock_On_Hand, P.Product_ID, st.Store_Location
	FROM products P
		JOIN sales S ON P.Product_ID = S.Product_ID
			JOIN inventory V ON V.Store_ID = S.Store_ID
				JOIN stores st ON st.Store_ID = V.Store_ID
					WHERE V.Stock_On_Hand =0;
![image](https://github.com/user-attachments/assets/10815f06-a218-47e4-bf35-cffeaf726bb1)

      
    
