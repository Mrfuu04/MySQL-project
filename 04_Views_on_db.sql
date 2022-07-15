use kinopoisk;

/*				VIEWS				*/
-- представление пользователей без конф. информации
create or replace view get_user_inf as 
	select us.id, concat(pro.firstname, ' ', pro.lastname) as `name`, 
	timestampdiff(year, pro.birthday, curdate()) as age,
		case
			when pro.gender = 'm' then 'Муж'
			when pro.gender = 'f' then 'Жен'
			end as gender,
	us.email 
	from users us
		left join profiles pro on us.id = pro.user_id;
	


-- отображает кол-во фильмов для страны
create or replace view get_countries_total as 
	select c.name, tc.films from countries c
		left join (select count(film_id) as films,
										country_id 
									from film_country
									group by country_id
								) as tc on c.id = tc.country_id
				group by c.id
				order by tc.films desc;


-- отображает все ревью на фильм и кол-во оценок
create or replace view get_film_review as 		
	select pro.user_id, concat(pro.firstname, ' ', pro.lastname) as `username`, fil.name as film, rev.name as review_name, 
	date(rev.created_at) as created, rev.body, rev.is_positive, tl.likes, tl2.dislikes
		from reviews rev
			left join films fil on fil.id = rev.film_id
			left join 
					(select count(1) as likes, review_id from review_rating where is_good = 1 group by review_id)	
											as tl on rev.id = tl.review_id
			left join 
					(select count(1) as dislikes, review_id from review_rating where is_good = 0 group by review_id) 
											as tl2 on rev.id = tl2.review_id
			left join profiles pro on pro.user_id = rev.user_id;

		
	