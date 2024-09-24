#brainbuster 2

# which rating do we have the most films in

SELECT
	count(film_id), rating
FROM
	film
group by
	rating
;

#which rating is most prevalent in each price

SELECT
	rental_rate, rating, count(rating)
FROM
	film
GROUP BY
	rating
;


