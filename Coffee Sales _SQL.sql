

Select *
   From [Coffee Sales] ;


Select Transaction_id, transaction_date, 
Cast ( transaction_time as time) as transaction_time ,
    transaction_qty, store_id , store_location, product_id ,unit_price ,product_category ,
	Product_type, product_detail 
	    From [Coffee Sales] ;


UPDATE [Coffee Sales]                              -----------Same process of casting the transaction time to time format 
SET transaction_time = CAST(transaction_time AS TIME);


Alter Table [Coffee Sales]
    Add Sales  Float  ;

	Update [Coffee Sales]                             ----------- Creating a new column as sales
	    Set Sales = Transaction_qty * Unit_price ; 


	Select cast (Sum (Sales ) as decimal(10,3) ) as Total_Sales ------------Total Sales 
		    From [Coffee Sales] ;



		SELECT Round(SUM(unit_price * transaction_qty),2 ) AS Total_Sales
		FROM [Coffee Sales]
		WHERE MONTH(TRY_CONVERT(DATE, transaction_date)) = 5;     ----------May Month 


UPDATE [Coffee Sales]
SET transaction_date = TRY_CONVERT(DATE, transaction_date);

		SELECT 
			MONTH(transaction_date) AS Month,
			ROUND(SUM(Sales), 2) AS Total_Sales,
			ROUND(
				SUM(Sales) - LAG(SUM(Sales), 1) OVER (ORDER BY MONTH(transaction_date)),
				2
			) AS Month_Sales_Diff,
			ROUND(
				(SUM(Sales) - LAG(SUM(Sales), 1) OVER (ORDER BY MONTH(transaction_date)))
				* 100.0 /
				NULLIF(LAG(SUM(Sales), 1) OVER (ORDER BY MONTH(transaction_date)), 0),
				2
			) AS MoM_Increase_Percentage
		FROM [Coffee Sales]
		WHERE MONTH(transaction_date) IN (4, 5)
		GROUP BY MONTH(transaction_date)
		ORDER BY MONTH(transaction_date);


---------------------------Total Orders ----------------

   Select Cast ( Count( Transaction_id) as Decimal(10,2) ) as Total_Orders 
        From [Coffee Sales] ;


   Select Cast ( Count( Transaction_id) as Decimal(10,2) ) as Total_Orders 
        From [Coffee Sales] 
		   Where MONTH ( Transaction_date) = 3 ;



	SELECT 
			MONTH(transaction_date) AS Month,
			ROUND(Count(transaction_id) , 2) AS Total_Orders,
			ROUND(
				Count(transaction_id) - LAG(Count(transaction_id), 1) OVER (ORDER BY MONTH(transaction_date)),
				2
			) AS Month_Sales_Diff,
			ROUND(
				(Count(transaction_id) - LAG(Count(transaction_id), 1) OVER (ORDER BY MONTH(transaction_date)))
				* 100.0 /
				NULLIF(LAG(Count(transaction_id), 1) OVER (ORDER BY MONTH(transaction_date)), 0),
				2
			) AS MoM_Increase_Percentage
		FROM [Coffee Sales]
		WHERE MONTH(transaction_date) IN (4, 5)
		GROUP BY MONTH(transaction_date)
		ORDER BY MONTH(transaction_date);


		Select  Sum( Transaction_qty) as Total_Qty_Sold          -------------Total Quantity Sold 
		   From [Coffee Sales] 
		   Where month(transaction_date) = 5 ;


		   SELECT 
    MONTH(transaction_date) AS month,
    Cast (SUM(transaction_qty) as Decimal(10,2) ) AS total_quantity_sold,       -----------MOM Total Quantity Sold
    (SUM(transaction_qty) - LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
		FROM 
			[Coffee Sales]
		WHERE 
			MONTH(transaction_date) IN (3, 4)   -- for April and May
		GROUP BY 
			MONTH(transaction_date)
		ORDER BY 
			MONTH(transaction_date);


			Select Round(Sum(Sales),3) as Total_Sales ,
			       Sum( Transaction_qty) as Total_Quantity_Sold ,
				   Count( Transaction_Id ) as Total_Orders
				    From [Coffee Sales]
					   Where Transaction_date = '2023-12-05' ;


			Select Concat( Round(Sum(Sales)/1000,3), 'k') as Total_Sales ,
			        Sum( Transaction_qty)  as Total_Quantity_Sold ,
				   Count( Transaction_Id ) as Total_Orders
				    From [Coffee Sales]
					   Where Transaction_date = '2023-12-05' ;



----------------Weekends = Sun and Sat ----------------
---------------Weekdays  = Mon to Fri ---------------------------


SELECT *,
    CASE 
        WHEN DATENAME(WEEKDAY, transaction_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type
FROM [Coffee Sales];

		SELECT 
			CASE 
				WHEN DATENAME(WEEKDAY, transaction_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
				ELSE 'Weekday'
			END AS Day_Type,
			COUNT(*) AS Transaction_Count
		FROM [Coffee Sales]
		WHERE MONTH(transaction_date) = 5
		GROUP BY 
			CASE 
				WHEN DATENAME(WEEKDAY, transaction_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
				ELSE 'Weekday'
			END;



	Select Store_location , Sum(Unit_price * Transaction_qty) as  Total_Sales 
						From [Coffee Sales]
						  Where MONTH (transaction_date) = '5' ------------April Month
						  Group by Store_location
							 Order by Total_Sales Desc ;








		       

