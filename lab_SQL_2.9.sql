USE sakila;

-- 1. How many distinct (different) actors' last names are there?
SELECT count(distinct(last_name)) FROM actor;

-- 2. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE
WHEN WEEKDAY(rental_date) <= 4 then 'workday'
ELSE 'weekend'
END AS 'day_type'
FROM rental;

-- 3. Get all films with ARMAGEDDON in the title.
SELECT * FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- 4. Get 10 the longest films.
SELECT film_id, title, length FROM film
ORDER BY length DESC
LIMIT 10;

-- 5. How many films include Behind the Scenes content?
SELECT count(film_id) FROM sakila.film 
WHERE special_features LIKE '%Behind the scenes%';

-- 6. Which kind of movies (rating) have a mean duration of more than two hours?
SELECT round(AVG(length),2)  AS average_length, rating FROM sakila.film
GROUP BY rating HAVING average_length > 120;

-- 7.Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT title, length, 
RANK() OVER (ORDER BY length DESC) AS 'rank' 
FROM sakila.film
WHERE length IS NOT NULL AND length NOT LIKE '%0%'