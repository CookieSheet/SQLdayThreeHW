-- = Wednesday Homework = --

-- 1. List all customers who live in Texas (use JOINs)
-- In all fairness there are no customers from the city of Texas
SELECT customer.customer_id, customer.first_name, city
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
WHERE city = 'Texas';

-- They are from the district texas
SELECT customer.customer_id, first_name, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name

SELECT customer.customer_id, first_name, last_name, amount
FROM payment
FULL JOIN customer
ON  payment.customer_id = customer.customer_id
WHERE amount > 6.99;
	
-- 3. Show all customers names who have made payments over $175(use subqueries)

SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id, first_name, last_name;

-- 4. List all customers that live in Nepal (use the city table)

SELECT customer.customer_id, customer.first_name, customer.last_name, customer.email, city, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal'

-- 5. Which staff member had the most transactions?

SELECT staff.first_name, staff.last_name, COUNT(staff.staff_id)
FROM staff
FULL JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY staff.staff_id DESC;


-- 6. How many movies of each rating are there?

SELECT DISTINCT rating, COUNT(rating) 
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT DISTINCT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT DISTINCT customer_id
	FROM payment
	WHERE amount > 6.99
)
GROUP BY first_name, last_name;


-- 8. How many free rentals did our stores give away?

SELECT COUNT(amount)
FROM payment
WHERE amount = 0.00;

