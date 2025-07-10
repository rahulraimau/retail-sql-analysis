
create database Retail_data

--Q1.
select count(*) as ROWS from Customer_data
select count(*) AS Rows from prod_cat_info_data
select count(*) As Rows from Transactions_data

--Q2.
select count(total_amt) from Transactions_data
  where total_amt like '-%'

--Q3.
select convert(date,DOB,105)as Dates from Customer_data
select convert(Date,Tran_Date,105)as Tran_Date from Transactions_data


--Q4.
select datediff(DAY,Min(CONVERT(Date,Tran_date,105)),Max(CONVERT(Date,Tran_Date,105))) as A,
datediff(MONTH,Min(CONVERT(Date,Tran_date,105)),Max(CONVERT(Date,Tran_Date,105))) As B,
datediff(YEAR,Min(CONVERT(Date,Tran_date,105)),Max(CONVERT(Date,Tran_Date,105))) As C
from Transactions_data


--Q5.
select prod_cat from prod_cat_info_data
where Prod_subcat like 'DIY'

--Data Analysis--
--Q1.

select Top 1
Store_type,Count(Transaction_id) as total 
from Transactions_data
Group by Store_type
order by Count(Transaction_id) Desc


--Q2.
select Gender ,count (customer_id)as countG
from Customer_data
where Gender IN ('M','F')
group by Gender
order by countG desc

--Q3.

select top 1 city_code, count (customer_id) as total from Customer_data
group by city_code
order by total desc

--Q4.
select Count (Prod_subcat) as Total
from prod_cat_info_data
where Prod_cat='Books'
group by prod_cat


--Q5.
select top 1 Qty
from Transactions_data
order by Qty Desc


--Q6.
select sum(total_amt) as total from Transactions_data as T
 inner join prod_cat_info_data as T1 on T1.prod_cat_code=T.prod_cat_code and T1.prod_sub_cat_code=T.prod_subcat_code
 where prod_cat in ('Books','Electronics')

 --Q7.
 select Count (Customer_id) as Total from Customer_data 
 where customer_ID IN
 (
 select Cust_ID
 From Transactions_data as T
 inner join Customer_data as T2 on T2.customer_Id=T.cust_id
 where total_amt not like '-%'
 group by cust_id
 having Count (transaction_id)>10
 )

 --Q8.
 
 
 Select Sum (Total_amt) as Total from Transactions_data as T
 inner join prod_cat_info_data as T1 on T1.prod_cat_code=T.prod_cat_code and T1.prod_sub_cat_code=T.prod_subcat_code
 where prod_cat in ('Clothing','Electronics')
 and Store_type ='Flagship Store'


 --Q9.

 Select Prod_Subcat,sum(total_amt) from Transactions_data as T
 inner join Customer_data as T2 on T2.customer_Id=T.Cust_id
 inner join prod_cat_info_data as T1 on T1.prod_cat_code=T.prod_cat_code and T1.prod_sub_cat_code=T.prod_subcat_code
 where prod_cat= 'Electronics' and Gender='M'
 group by prod_subcat_code,prod_subcat


select*from customer_data
select*from prod_cat_info_data
select* from Transactions_data
 

--Q10.
 select top 5 prod_subcat_code ,(sum(Total_amt)/(select sum(Total_amt) from Transactions_data))*100 as Percentage_of_sales,(count(case when Qty<0 then Qty else Null end)/sum(Qty))*100  as Percentage_of_return from Transactions_data as T
 inner join prod_cat_info_data as P on P.prod_sub_cat_code=T.prod_subcat_code
 group by prod_subcat_code
 order by Sum(total_amt) Desc


--Q11.
 select cust_id,sum(Total_amt) as revenue from Transactions_data
 where cust_id In (select Customer_id from Customer_data
 where DATEDIFF(Year,convert(Date,DOB,103),Getdate()) Between 25 and 35)
 and convert (Date,Tran_date,103) between Dateadd(Day,-30,(select max(convert(Date,Tran_date,103)) from Transactions_data))
and (select Max(convert(date,Tran_date,103)) from Transactions_data)
 group by cust_id



--Q12.
 select top 1 Prod_cat,Sum(Total_amt) from Transactions_data as T
 inner join prod_cat_info_data T1 on T1.prod_cat_code=T.prod_cat_code and T1.prod_sub_cat_code=T.prod_subcat_code
 where total_amt<0
 and convert (date,Tran_date,103) Between DATEADD(Month,-3,(select MAX(convert (Date,tran_date,103)) from Transactions_data))
 and (select MAX(convert(date,Tran_date,103)) From transactions_data)
 group by Prod_cat
 order by sum(Total_amt) desc

 --Q13.
 select top 1 store_type,sum(Total_amt)as Total_sales,Sum (Qty)as Total_quantity from Transactions_data
 group by Store_type
 order by Total_quantity desc
 
 --Q14.
 select Prod_cat,Avg(Total_amt) as Avg from Transactions_data as  T
 inner join prod_cat_info_data as T1 on T1.prod_cat_code=T.prod_cat_code and T1.prod_sub_cat_code=T.prod_subcat_code
 group by prod_cat
 having AVG(total_amt)>(select Avg (Total_amt) from Transactions_data)


--Q15.
 select Prod_cat,Prod_subcat,Avg(total_amt) as Average_rev,sum (Total_amt) as Revenue from Transactions_data as T
  inner join prod_cat_info_data as T1 on T1.prod_cat_code=T.prod_cat_code and T1.prod_sub_cat_code=T.prod_subcat_code
  where prod_cat IN
  (select top 5 prod_cat from Transactions_data as T
   inner join prod_cat_info_data as T1 on T1.prod_cat_code=T.prod_cat_code and T1.prod_sub_cat_code=T.prod_subcat_code
 group by Prod_cat 
 order by sum (Qty) Desc)
 group by prod_cat,prod_subcat




