USE maven_toys;

 SELECT * FROM products;
 SELECT * FROM stores;
 SELECT * FROM sales;
 SELECT * FROM inventory;
 

 -- 1. Which product categories drive the biggest profits? Is this the same across store locations?
SELECT  P.Product_Category, (P.Product_Price-P.Product_Cost) AS Store_Profit, st.Store_Location
 FROM products P
	JOIN sales S ON P.Product_ID = S.Product_ID
		JOIN stores st ON st.Store_ID = S.Store_ID
			GROUP BY P.Product_Category, st.Store_Location, (P.Product_Price-P.Product_Cost)
				ORDER BY (P.Product_Price-P.Product_Cost) DESC;

 -- 2. How much money is tied up in inventory at the toy stores? How long will it last?
 SELECT V.Store_ID,V.Stock_On_Hand, AVG(P.Product_Cost*V.Stock_On_Hand) Cost_of_Inventory, st.Store_Open_Date, 
	(DATEDIFF(DAY,st.Store_Open_Date,GETDATE())) Length_of_Days
		FROM inventory V
			JOIN products P ON P.Product_ID = V.Product_ID
				JOIN stores st ON st.Store_ID = V.Store_ID 
					GROUP BY V.Stock_On_Hand, V.Store_ID, st.Store_Open_Date
						ORDER BY V.Stock_On_Hand DESC, (DATEDIFF(DAY,st.Store_Open_Date,GETDATE())) DESC;
						
 -- 3. Are sales being lost with out-of-stock products at certain locations?
 SELECT S.Units, V.Stock_On_Hand, P.Product_ID, st.Store_Location
	FROM products P
		JOIN sales S ON P.Product_ID = S.Product_ID
			JOIN inventory V ON V.Store_ID = S.Store_ID
				JOIN stores st ON st.Store_ID = V.Store_ID
					WHERE V.Stock_On_Hand =0;