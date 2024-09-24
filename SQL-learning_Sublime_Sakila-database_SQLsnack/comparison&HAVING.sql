#comparison&HAVING

# USERS WHO HAVE RENTED ATLEAST 3 TIMES -> customer_id wise, count(rentals) >= 3

SELECT
	r.customer_id, count(r.rental_id)
FROM
	rental r
GROUP BY
	1
HAVING
	count(r.rental_id) >= 3
;

#having has to come last after all the calculation is done, similar to 'filter' in excel


##BRAINBUSTER##

#How much revenue has store-1 made over PG-13 & R-rated movies -> store-1, total revenue, selected categories in full list

SELECT
	i.store_id as Store, f.rating as Rating, SUM(p.amount) as Revenue
FROM
	payment p, film f, rental r, inventory i
WHERE
	p.rental_id = r.rental_id
	AND
	r.inventory_id = i.inventory_id
	and
	i.film_id = f.film_id
	and
	f.rating in ("PG-13", "R")
	and 
	i.store_id = 1
GROUP BY
	1, 2
;

#same as above, but in between June-8, July-19 in 2005
SELECT
	i.store_id as Store, f.rating as Rating, SUM(p.amount) as Revenue
FROM
	payment p, film f, rental r, inventory i
WHERE
	p.rental_id = r.rental_id
	AND r.inventory_id = i.inventory_id
	AND i.film_id = f.film_id
	AND f.rating in ("PG-13", "R")
	AND	i.store_id = 1
	AND r.rental_date between "2005-06-08" and '2005-07-19'
GROUP BY
	1, 2
;



















