# Distinct

# How many distinct renters per month -> month-wise customer_id seggregation

SELECT
	LEFT(r.rental_date, 7) as Month, count(distinct r.customer_id) as "Unique renters"
FROM 
	rental r
GROUP BY
	1
;

SELECT
	LEFT(r.rental_date, 7) as Month, count(r.rental_id) as "total rentals" ,count(distinct r.customer_id) as "Unique renters", count(r.rental_id)/count(distinct r.customer_id) as "Avg rentals per renter"
FROM 
	rental r
GROUP BY
	1
;


# Number of distinct films rented each month -> month-wise distinct film_ids

SELECT
	LEFT(r.rental_date, 7) as "Month", count(distinct i.film_id) as "Unique films rented"
FROM
	rental r, inventory i
WHERE
	i.inventory_id = r.inventory_id
GROUP BY
	1
;

SELECT
	LEFT(r.rental_date, 7) as "Month", count(r.rental_id) as "Total rentals", count(distinct i.film_id) as "Unique films rented", count(r.rental_id)/count(distinct i.film_id) as "Avg rentals per film"
FROM
	rental r, inventory i
WHERE
	i.inventory_id = r.inventory_id
GROUP BY
	1
;