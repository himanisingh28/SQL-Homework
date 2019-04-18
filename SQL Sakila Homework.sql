use sakila;

/*Question 1a */
SELECT first_name, last_name from sakila.actor;

/*Question 1b*/
SELECT concat(first_name, ' ', last_name) as 'Actor Name' from sakila.actor;

/*Question 2a*/
Select actor_id, first_name, last_name from sakila.actor where first_name = 'Joe'; 

/*Question 2b*/
Select * from sakila.actor where last_name like '%GEN%'; 

/*Question 2c*/
Select last_name, first_name from sakila.actor where last_name like '%LI%'; 

/*Question 2d*/
Select country_id, country from sakila.country where country in ('Afghanistan', 'Bangladesh', 'China');

/*Question 3a*/
alter table actor
add column Description blob after first_name;

/*Question 3b*/
alter table actor
drop column Description;

/*Question 4a*/
select last_name, count(last_name) 
from actor group by last_name having count(last_name) > 1;

/*Question 4b*/

select last_name, count(*)
from actor group by last_name having count(*) > 2;

/*Question 4c*/
UPDATE actor set first_name = 'HARPO' where actor_id = '172'; 

/*Question 4d*/
UPDATE actor set first_name = 'GROUCHO' where actor_id = '172'; 

/*Question 5a*/
Show create table address;

/*Question 6a*/
select staff.first_name, staff.last_name, address.address 
from staff inner join address on staff.address_id = address.address_id;

/*Question 6b */
select staff.first_name, staff.last_name, payment.staff_id, sum(payment.amount) from payment inner join staff on staff.staff_id = payment.staff_id
where payment.payment_date like '%2005-08%' group by staff_id;

/*Question 6c*/
select film.film_id, film.title, count(*) as 'no. of actors'
from film_actor inner join film on film.film_id = film_actor.film_id group by film.title;

/*Question 6d*/
select count(inventory_id) as 'count of inventory copies' from inventory where film_id in 
(select film_id from film where title = 'Hunchback Impossible');

/*Question 6e*/
select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Payment' 
from payment inner join customer on
payment.customer_id = customer.customer_id 
group by customer.customer_id 
order by customer.last_name ASC;

/*Question 7a*/
select title from film where 
title like 'K%' or title like 'Q%' and 
film.language_id 
in (select language.language_id from language where language.name = 'English'); 

/*Question 7b*/
select actor.first_name, actor.last_name from actor where actor.actor_id in 
(select actor_id from film_actor where film_actor.film_id in 
(select film_id from film where title = 'Alone trip'));

/*Question 7c*/
select customer.first_name, customer.last_name, customer.email from customer 
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id where
country = 'Canada';

/*Question 7d*/
select film.title from film where film_id in 
(select film_id from film_category where category_id in 
(select category_id from category where category.name = 'Family'));

/*Question 7e*/
select film.title, count(rental_id) from rental 
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id group by film.title order by count(rental_id) DESC;

/*Question 7f*/
select store.store_id, sum(payment.amount) from payment 
inner join rental on payment.rental_id = rental.rental_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join store on inventory.store_id = store.store_id group by store.store_id;

/*Question 7g*/
select store.store_id, country.country, city.city from country 
inner join city on country.country_id = city.country_id
inner join address on address.city_id = city.city_id
inner join store on store.address_id = address.address_id group by store.store_id;

/*Question 7h*/
select category.name as 'Genre', sum(payment.amount) as 'Gross Revenue'from payment 
inner join rental on payment.rental_id = rental.rental_id
inner join inventory on inventory.inventory_id = rental.inventory_id
inner join film_category on film_category.film_id = inventory.film_id
inner join category on category.category_id = film_category.category_id group by category.name order by sum(payment.amount) DESC LIMIT 5;

/*Question 8a*/
create view top_five_genres as select category.name as 'Genre', sum(payment.amount) as 'Gross Revenue'from payment 
inner join rental on payment.rental_id = rental.rental_id
inner join inventory on inventory.inventory_id = rental.inventory_id
inner join film_category on film_category.film_id = inventory.film_id
inner join category on category.category_id = film_category.category_id group by category.name order by sum(payment.amount) DESC LIMIT 5;

/*Question 8b*/
select * from top_five_genres;

/*Question 8c*/
drop view top_five_genres;