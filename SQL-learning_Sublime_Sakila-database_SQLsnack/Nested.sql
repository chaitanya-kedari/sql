# Nested queries & Temporary tables

#Nested

# How many money are customers with > 20 rentals bringing in

#1. list of customers with >20 rentals, and 2. sum of respective revenues, grouped by customers


#rpc - rentals per customer is the nested block


SELECT 
  rpc.total_rentals, 
  count(distinct rpc.Customer), 
  SUM(rpc.Revenue), 
  SUM(rpc.Revenue)/rpc.total_rentals as Rev_per_rental
FROM
	(SELECT
	p.customer_id as Customer, count(p.rental_id) as total_rentals, SUM(p.amount) as Revenue
	FROM
	payment p
	GROUP BY
	1
	HAVING 
  	count(p.rental_id) > 20
	) as rpc
GROUP BY
  1
;


#another version

SELECT 
  rpc.total_rentals, 
  count(distinct rpc.Customer), 
  SUM(rpc.Revenue), 
  SUM(rpc.Revenue)/rpc.total_rentals as Rev_per_rental
FROM
	(SELECT
		p.customer_id as Customer, 
		count(p.rental_id) as total_rentals, 
		SUM(p.amount) as Revenue
	FROM
		payment p
	GROUP BY
		1
	) as rpc
WHERE
	rpc.total_rentals > 20
GROUP BY
  1
;

##Temporary Table##
# same as above but separating the nested block and setting aside as temporary table to refer to, in the rest of the code

create temporary table rpc as
SELECT
	p.customer_id as Customer, 
	count(p.rental_id) as total_rentals, 
	SUM(p.amount) as Revenue
FROM
	payment p
GROUP BY
	1
;

SELECT
	rpc.total_rentals,
	SUM(rpc.Revenue)
FROM
	rpc
WHERE
	rpc.total_rentals > 20
GROUP BY
	1
;

#temporary tables don't work in SQLsnack and many other SQL environments