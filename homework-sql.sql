use sakila; 
-- 1a  
select first_name, last_name
from actor; 
-- 1b
select upper(concat(first_name, " ", last_name)) as 'Actor Name'
from actor;
-- 2a
select actor_id, first_name, last_name
from actor
where first_name = "Joe";
-- 2b
select actor_id, first_name, last_name
from actor
where last_name like '%GEN%';
-- 2c
select actor_id, last_name, first_name
from actor
where last_name like '%LI%';
-- 2d
select country_id, country
from country
where country IN  ('Afghanistan', 'Bangladesh', 'China');
-- 3a
alter table actor 
add column description blob;
-- 3b
alter table actor
drop column description;
-- 4a
select last_name, count(*) as 'number of actors'
from actor group by last_name;
-- 4b
select last_name, count(*) as 'Number of Actors' 
from actor group by last_name having count(*) >=2;
-- 4c
update actor 
set first_name = 'HARPO'
where First_name = "Groucho" and last_name = "Williams";
-- 4d
update actor
set first_name = 'Groucho'
where First_name = "Harbo" and last_name = "Williams";
-- 5a
show create table address; 
-- 6a
select first_name, last_name, address.address 
from staff 
join address 
on address.address_id = staff.address_id;
-- 6b
select payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date
from staff inner join payment on
staff.staff_id = payment.staff_id and payment_date like '2005-08%'; 
-- 6c
select f.title as 'Film Title', count(factors.actor_id) as `Number of Actors`
from film_actor factors
INNER JOIN film f 
ON factors.film_id= f.film_id
GROUP BY f.title;
-- 6d
select title, count(inventory_id) 
from film 
join inventory 
on film.film_id = inventory.film_id where title = "Hunchback Impossible";
-- 6e
select last_name, first_name, SUM(amount) 
from payment 
join customer 
on payment.customer_id = customer.customer_id 
group by payment.customer_id 
order by last_name;
-- 7a
select title 
from film where language_id in
	(select language_id 
	from language
	where name = "English" )
and (title like "K%") or (title like "Q%");
-- 7b
select last_name, first_name
from actor
where actor_id in
	(select actor_id from film_actor
	where film_id in 
	(select film_id from film
	where title = "Alone Trip"));
-- 7c
SELECT first_name, last_name, email 
FROM customer cus
JOIN address a 
ON (cus.address_id = a.address_id)
JOIN city cty
ON (cty.city_id = a.city_id)
JOIN country
ON (country.country_id = cty.country_id)
WHERE country.country= 'Canada';
-- 7d
select title, category 
from film_list 
where category = 'Family';
-- 7e
select f.title, count(rental_id) as 'Times Rented'
from rental r
join inventory i
on (r.inventory_id = i.inventory_id)
join film f
on (i.film_id = f.film_id)
group by f.title
order by `Times Rented` desc;
-- 7f
select store.store_id, SUM(amount) 
from store
join staff on store.store_id = staff.store_id
join payment p on p.staff_id = staff.staff_id
group by store.store_id 
order by sum(amount);
-- 7g
select store.store_id, city, country 
from store
join customer on store.store_id = customer.store_id
join staff on store.store_id = staff.store_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;
-- 7h
select c.name as 'Genres', sum(p.amount) as 'Gross' 
from category c
join film_category fc 
on (c.category_id=fc.category_id)
join inventory i 
on (fc.film_id=i.film_id)
join rental r 
on (i.inventory_id=r.inventory_id)
join payment p 
on (r.rental_id=p.rental_id)
group by c.name ORDER BY Gross  LIMIT 5;
-- 8a
create view top_grossing as (
select c.name, sum(p.amount)
from category c
inner join film_category fc
inner join inventory i
on i.film_id = fc.film_id
inner join rental r
on r.inventory_id = i.inventory_id
inner join payment p
group by name Limit 5);
-- 8b
Select * From top_grossing;
-- 8c
DROP VIEW top_grossing;











