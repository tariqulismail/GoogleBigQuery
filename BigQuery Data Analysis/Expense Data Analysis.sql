
--Find The All Item
SELECT *
FROM `personalfinancedata.Expenses.ExpenseData`


--Find The unique Item
SELECT distinct ITEM
FROM `personalfinancedata.Expenses.ExpenseData`

--Duplicate checking
with cte as (
SELECT *,
row_number() over (partition by date, location, item) as rownumber
FROM `personalfinancedata.Expenses.ExpenseData`)

select * from cte where rownumber > 1


--How many unique days money spent

SELECT extract(year from date) Year, extract(month from date) Month, count(distinct date) Day
FROM `personalfinancedata.Expenses.ExpenseData`
group by extract(year from date) , extract(month from date)


--Yearly cost by item
SELECT item, round(sum(cost),2) cost
FROM `personalfinancedata.Expenses.ExpenseData`
where extract(year from date) = 2019
group by item

--Show only the item with highest cost in each location

with datanew as  (
SELECT item,  location ,  sum(cost) as totalcost
FROM `personalfinancedata.Expenses.ExpenseData`
group by location , item)

select  item, location ,  rank() over(partition by item order by totalcost desc) as ranking
from datanew
qualify ranking=1


