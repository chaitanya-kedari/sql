# Connecting tables



#Brainbuster 3

# list by film name, category and language

SELECT
	film.title, film_list.category, language.name
FROM
	film, language, film_list
WHERE
	film.language_id = language.language_id 
	and 
	film.film_id = film_list.FID
;


# How many times each movie is rented out

SELECT 
  f.film_id, f.title, count(r.rental_id) as rented
FROM 
  film f, rental r, inventory i
WHERE
  f.film_id = i.film_id 
  and 
  i.inventory_id = r.inventory_id
GROUP BY
  1
;

# Revenue per movie, revenue = price * qty -> rental rate * no of times rented

SELECT
	f.title as "Movie Title", count(r.rental_id) as "No of times rented", f.rental_rate as "Rental Price", count(r.rental_id) * f.rental_rate as "Revenue"
FROM
	film f, inventory i, rental r 
WHERE 
	f.film_id = i.film_id
	and
	i.inventory_id = r.inventory_id
GROUP BY
	1
;

# Find out highest revenue contributing movies 

SELECT
	f.title as "Movie Title", count(r.rental_id) as "No of times rented", f.rental_rate as "Rental Price", count(r.rental_id) * f.rental_rate as "Revenue"
FROM
	film f, inventory i, rental r 
WHERE 
	f.film_id = i.film_id
	and
	i.inventory_id = r.inventory_id
GROUP BY
	1
ORDER BY
	4 desc
;
# default for ORDER BY is ascending order















