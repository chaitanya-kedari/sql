#IN

# Number of rentals in the sports, comedy, and family

SELECT
	fl.category, count(r.rental_id)
FROM
	film_list fl, rental r, inventory i
WHERE
	fl.FID = i.film_id
	and
	i.inventory_id = r.inventory_id
	and
	fl.category in ("Comedy", "Sports", "Family")
GROUP BY
	1
;

#answer slightly different due to FID and film_id not matching probably

#check out Udemy syntax

***

#for one category
SELECT
	fl.category, count(r.rental_id)
FROM
	film_list fl, rental r, inventory i
WHERE
	fl.FID = i.film_id
	and
	i.inventory_id = r.inventory_id
	and
	fl.category = "Comedy"
GROUP BY
	1
;


