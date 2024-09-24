# ARITHMETIC - SUM()

# Which customer has paid us the most money -> customer-wise, times rented * rental rate

SELECT
	c.customer_id, count(r.rental_id) * f.rental_rate as Revenue
FROM
	film f, inventory i, rental r, customer c
WHERE
	f.film_id = i.film_id
	and
	i.inventory_id = r.inventory_id
	and
	r.customer_id = c.customer_id
GROUP BY
	1
ORDER BY
	2 desc
;
#same problem, correct solution from payment table, above one is wrong

SELECT
  customer_id, SUM(amount)
FROM
  payment
group by
  customer_id
ORDER BY 
  2 desc
;

#What store has historically brought in the most revenue? -> store-wise revenue/payment 

SELECT
	i.store_id, SUM(p.amount)
FROM
	rental r, payment p, inventory i
WHERE
	i.inventory_id = r.inventory_id
	and
	r.rental_id = p.rental_id
GROUP BY
	1
ORDER BY
	2 desc
;

SELECT *
FROM sales_by_store;

#Gives wrong answer for above problem with below syntax (connecting tables with customer_id)
SELECT
	i.store_id, SUM(p.amount)
FROM
	rental r, payment p, inventory i
WHERE
	i.inventory_id = r.inventory_id
	and
	r.customer_id = p.customer_id
GROUP BY
	1
ORDER BY
	2 desc
;


























