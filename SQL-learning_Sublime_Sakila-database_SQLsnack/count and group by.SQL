# count and group by
# how many films we are renting at each rental_rate

SELECT
	count(film_id), rental_rate
FROM
	film 
GROUP BY
	rental_rate 
;