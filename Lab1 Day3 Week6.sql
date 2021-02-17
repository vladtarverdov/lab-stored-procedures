 use sakila;
 drop procedure if exists actionmovies;
 
 delimiter //
 create procedure actionmovies (in param1 char(20))
 begin
 
 select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name COLLATE utf8mb4_general_ci = param1
  group by first_name, last_name, email;
    end;
// delimiter ;
 drop procedure if exists actionmovies;
 



call actionmovies ("action");
drop procedure if exists movie_count;
  delimiter //

create procedure movie_count (in param1 int)
 begin
  select name, number_films from (select count(f.title) as number_films, c.name from film as f
  join film_category as fc using (film_id)
  join category as c using (category_id)
  group by c.name) as sub1
  where number_films > param1;
  
  end;
  
  // 
  delimiter ;
  
  call movie_count (25);

