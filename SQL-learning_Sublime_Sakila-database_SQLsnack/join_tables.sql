#join tables

# 2 data sets which have overlap information, connected by that overlap info, but independently has other information

#Active customer list has some customers and their favorite color
#Reward customer list has some of these customers+some other, and their number of purchases (super users, if you will)
# Joining these 2, using JOIN, apart from using WHERE syntax for simplification and scalability

--WHERE--

SELECT
	ac.customer_id,
	ac.fav_color,
	rc.num_purchases
FROM
	active_customers ac,
	reward_customers rc
WHERE
	ac.customer_id = rc.customer_id
;

--JOIN--

SELECT
	ac.customer_id,
	ac.fav_color,
	rc.num_purchases
FROM
	active_customers ac
	JOIN reward_customers rc ON ac.customer_id = rc.customer_id
;

--LEFT JOIN--
#keep one data set (on the left/first in the syntax) as universal set, add other as subset (might have some null values in comparison with universale set)

SELECT
	ac.customer_id,
	ac.fav_color,
	rc.num_purchases
FROM
	active_customers ac
	LEFT JOIN reward_customers rc ON ac.customer_id = rc.customer_id
;

#BRAINBUSTER#

#part-1: Active customers list: create temporary table with all columns from customer table with (active=1) and phone number from address table
#answer - 584

SELECT
	c.*, a.phone
FROM
	customer c,
	address a 
WHERE 
  c.address_id = a.address_id
  and
  c.active = 1
;

SELECT
	c.*, 
	a.phone
FROM
	customer c
	JOIN address a ON c.address_id = a.address_id
WHERE 
  c.active = 1
;

#JOIN does same work as INNER JOIN

#part-2: Reward customers list (178): customers with atleast 30 rentals i.e. customer_id, number of rentals, last rental date

SELECT
	r.customer_id as customer, 
	count(distinct r.rental_id) as num_rentals, 
	MAX(r.rental_date) as last_rental_date
FROM
	rental r
GROUP BY
	1
HAVING
	num_rentals >= 30
;

#putting condition in WHERE vs HAVING. If the condition is an aggregate function like num_rentals here, HAVING at the end is appropriate. Otherwise, WHERE works.

#Part-3.1: Reward users who are ALSO active users -> customer_id, email, first_name
#answer - 173

SELECT
	rc.customer_id, 
	ac.email,
	ac.first_name
FROM
	(SELECT
		r.customer_id, 
		count(distinct r.rental_id) as num_rentals, 
		MAX(r.rental_date) as last_rental_date
	FROM
		rental r
	GROUP BY
		1
	HAVING
		num_rentals >= 30
	) as rc,
	(SELECT
		c.*, a.phone
	FROM
		customer c,
		address a 
	WHERE 
	  c.address_id = a.address_id
	  and
	  c.active = 1
	) as ac
WHERE
	rc.customer_id = ac.customer_id
;

#same answer with JOIN

SELECT
	rc.customer_id, 
	ac.email,
	ac.first_name
FROM
	(SELECT
		r.customer_id, 
		count(distinct r.rental_id) as num_rentals, 
		MAX(r.rental_date) as last_rental_date
	FROM
		rental r
	GROUP BY
		1
	HAVING
		num_rentals >= 30
	) as rc
	JOIN 
	(SELECT
		c.*, a.phone
	FROM
		customer c,
		address a 
	WHERE 
	  c.address_id = a.address_id
	  and
	  c.active = 1
	) as ac 
	ON rc.customer_id = ac.customer_id
;
#answer - 173

#Same answer with temporary tables (not running on SQLsnack)

drop temporary table if exists rc;
create temporary table rc 
SELECT
	r.customer_id, 
	count(distinct r.rental_id) as num_rentals, 
	MAX(r.rental_date) as last_rental_date
FROM
	rental r
GROUP BY
	1
HAVING
	num_rentals >= 30
;

drop temporary table if exists ac;
create temporary table ac
SELECT
		c.*, a.phone
FROM
		customer c,
		address a 
WHERE 
	  c.address_id = a.address_id
	  and
	  c.active = 1
;

SELECT
	rc.customer_id, 
	ac.email,
	ac.first_name
FROM 
	rc JOIN ac ON rc.customer_id = ac.customer_id
;

#Part 3.2: All reward users -> customer_id, email, phone (for those who are also active users)

SELECT
	rc.customer_id,
	ac.email,
	ac.phone
FROM
	(SELECT
		r.customer_id, count(r.rental_id) 
	FROM
		rental r
	GROUP BY 1
	HAVING
		count(r.rental_id) >= 30
	) as rc 
	LEFT JOIN
	(SELECT
		c.*, a.phone
	FROM
		customer c
		LEFT JOIN address a ON c.address_id = a.address_id
	WHERE
		c.active = 1
	) as ac
	ON rc.customer_id = ac.customer_id
;

#answer - 178 (but not comprehensive)

#udemy answer (on the back of temporary tables rc,ac created earlier)
#This ensures some emails are not lost (reward users but not active users emails might get lost with my answer above), hence connected a comprehensive dataset for emails i.e. customer table

SELECT
	rc.customer_id,
	c.email,
	ac.phone
FROM
	rc 
	JOIN customer c ON rc.customer_id = c.customer_id
	LEFT JOIN ac ON rc.customer_id = ac.customer_id
GROUP BY 1
;
















