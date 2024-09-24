# Left, Min, Max

# How many rentals we had each month -> month-wise, number of rentals

SELECT
	left(r.rental_date, 7), count(r.rental_id)
FROM 
	rental r
GROUP BY
	1
ORDER BY
	2 desc
;

#What was the first time a movie was rented, and last time the movie is rented

SELECT
	f.title, MIN(r.rental_date) as "First rented", MAX(r.rental_date) as "Last rented"
FROM
	film f, inventory i, rental r
WHERE
	f.film_id = i.film_id
	and
	i.inventory_id = r.inventory_id
GROUP BY
	f.film_id
;
#grouping by id instead of title, in case there's duplication in title



#Every customer's last rental date
SELECT
	r.customer_id, MAX(r.rental_date)
FROM 
	rental r 
GROUP BY
	1
;

SELECT
	concat(c.first_name, " ", c.last_name), c.email, MAX(r.rental_date)
FROM 
	rental r, customer c
WHERE
	r.customer_id = c.customer_id
GROUP BY
	r.customer_id
;

	
#Revenue by month

SELECT
	LEFT(r.rental_date, 7), SUM(p.amount) 
FROM
	rental r, payment p
WHERE
	p.rental_id = r.rental_id
GROUP BY
	1
;

#Got wrong answer again, when connected tables with customer_id instead of rental_id
#customer_id could appear multiple times, since the same customer made rentals multiple times, matching the table by that parameter is incorrect

SELECT
	left(p.payment_date, 7) as Month, SUM(p.amount) as "Monthly Revenue"
FROM
	payment p
GROUP BY
	1
;

























