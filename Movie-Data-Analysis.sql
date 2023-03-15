use sakila;


-- TASK-01
-- DISPLAY THE FIRSTNAME, LASTNAME, ACTORID AND LAST UPDATED COLUMN
select * 
from actor;



-- TASK-02
--
/* A) Part - DISPLAY THE FULL NAME OF ACTORS */
select concat(first_name,"  ",last_name) as FullName
from actor;

/* B) Part - FIRSTNAME ALONG WITH THE COUNT OF REPEATED FIRSTNAMES */
select first_name, count(first_name) as No_of_times
from actor
group by first_name
having No_of_times > 1;

/* C) Part - LASTNAME ALONG WITH THE COUNT OF REPEATED LASTNAMES*/
select last_name, count(last_name) as No_of_times
from actor
group by last_name
having No_of_times > 1;



-- TASK-03
-- DISPALY THE COUNT OF MOVIES GROUPED BY RATINGS
select rating, count(film_id) as Count_of_movies
from film
group by rating;



-- TASK-04
-- DISPLAY THE AVERAGE RENTAL RATES BASED ON MOVIE RATINGS
select rating, round(avg(rental_rate) , 2) as Average_Rental_Rate
from film
group by rating;



-- TASK-05
-- 
/* A) Part - DISPLAY THE MOVIES WHERE THE REPLACEMENT COST IS UPTO 9 */
select title
from film
where replacement_cost <= 9;

/* B) Part - DISPLAY THE MOVIES WHERE THE REPLACEMENT COST IS BETWEEN 15 AND 20 */
select title, replacement_cost
from film
where replacement_cost between 15 and 20;

/* C) Part - DISPLAY THE MOVIES WITH THE HIGHEST REPLACEMENT COST AND LOWEST RENTAL COST */
select title, replacement_cost, rental_rate
from film
order by replacement_cost DESC, rental_rate;



-- TASK-06
-- LIST OF ALL THE MOVIES ALONG WITH THE NUMBER OF ACTORS IN MOVIES
select f.title, count(a.actor_id) as number_of_actors
from film f inner join film_actor fa
on f.film_id = fa.film_id
inner join actor a
on fa.actor_id = a.actor_id
group by title
order by number_of_actors DESC;

select f.title, (select count(actor_id)
			    from actor
                where actor_id in (select actor_id
								  from film_actor fa
                                  where fa.film_id = f.film_id)) as Number_of_actors
from film f
group by title;



-- TASK-07
-- MOVIE TITLES STARTING WITH LETTER 'K' OR 'Q'
select title
from film
where title LIKE "K%" or title LIKE "Q%";



-- TASK-08
-- DISPLAY THE FIRSTNAMES AND LASTNAMES OF ALL ACTORS WHO ARE A PART OF MOVIE - "AGENT TRUMAN"
select a.first_name, a.last_name, f.title
from film f inner join film_actor fa
on f.film_id = fa.film_id
inner join actor a
on fa.actor_id = a.actor_id
where f.title = "AGENT TRUMAN";



-- TASK-09
-- DISPLAY THE NAMES OF THE MOVIES OF FAMILY CATEGORY
select f.title, c.name
from film f inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where name = "Family"; 



-- TASK-10
-- NAMES OF THE MOST FREQUENTLY RENTED MOVIES IN DESCENDING ORDER
select f.title, count(r.rental_id) as Times_rented
from film f inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id
group by title
order by times_rented DESC;

select f.title, (select count(rental_id)
			    from rental
                where inventory_id in (select inventory_id
									   from inventory i
                                       where i.film_id = f.film_id) ) as Times_rented
from film f
group by title
order by Times_rented DESC;


-- TASK-11
-- Calculate and display the number of movie categories where the average difference between the replacement cost and the rental rate is areater than 15
create view view_2 as
select t3.name as categories, ( avg(replacement_cost) - avg(rental_rate) ) as difference
from film t1 inner join film_category t2
on t1.film_id = t2.film_id
inner join category t3
on t2.category_id = t3.category_id
group by categories
having difference > 15;

select count(*) as Number_of_Categories from view_2;



-- TASK-12
-- DISPLAY THE NAMES OF CATEGORY AND NUMBER OF MOVIES OF EACH CATEGORY.
select c.name, count(f.film_id) as Number_of_movies
from film f inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
group by name
having Number_of_movies between 60 and 70 
order by Number_of_movies;

