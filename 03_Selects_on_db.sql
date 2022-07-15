use kinopoisk;

/*				Выборки с пользователями		*/
-- Выборка всех избранных персон пользователя
select p.user_id, concat(p.firstname,' ', p.lastname) as `user`, per.original_name 
from profiles as p 
	join favourite_persons as fp on p.user_id = fp.user_id 
	join persons as per on fp.person_id = per.id
		where p.user_id = 1;
		

-- Выборка кол-ва входящих и исходящих сообщений (раздельно)
select pro.user_id, concat(pro.firstname, ' ', pro.lastname) as `user`,
(select count(*) from messages where pro.user_id = from_user_id) as total_from,
(select count(*) from messages where pro.user_id = to_user_id) as total_to
from profiles pro
	left join messages m on pro.user_id = m.from_user_id or pro.user_id = m.to_user_id
		-- where pro.user_id = 1     -- Возможно подключить индивидуальную выборку
			group by pro.user_id order by pro.user_id;


	
-- Выборка всех избранных фильмов пользователя
select concat(pro.firstname, ' ', pro.lastname) as `user`, f.name  from profiles pro 
	join favourite_films ff on ff.user_id = pro.user_id
	join films f on ff.film_id = f.id
		where pro.id = 1;
	

-- Выборка всех обзоров пользователя и их оценки 

select concat(pro.firstname, ' ', pro.lastname) as `user`, films.name, rev.body, rev.is_positive, 
(select count(is_good) from review_rating where is_good = 1 and review_id = rev.id) as likes,
(select count(is_good) from review_rating where is_good = 0 and review_id = rev.id) as dislikes
from reviews rev
	join profiles pro on pro.user_id = rev.user_id
	join films on films.id = rev.film_id
		where pro.user_id = 1;

	
-- Выборка всех рейтингов пользователя
select concat(pro.firstname, ' ', pro.lastname) as `user`, fi.name, r.rating from rating r
	join profiles pro on pro.user_id = r.user_id
	join films fi on fi.id = r.film_id
		where pro.user_id = 1 order by rating;
	
	

/*				Выборки с персонами   			*/
-- Выборка всех фильмов персоны (или нескольких) и его роль
select concat(p.name, ' ', p.lastname) as person, f.name as film,
per_type.person_type as `type` from persons p
	join person_film pf on p.id = pf.person_id 
	join films f on f.id = pf.film_id
	join person_info per_inf on per_inf.person_id = p.id
	join person_type per_type on per_inf.person_type_id = per_type.id
		where p.name in ('Джаред', 'Бен') order by person;


-- Выборка кол-ва фильмов персоны
select concat(p.name, ' ', p.lastname) as person, count(*) total
from persons p
	join person_film pf on p.id = pf.person_id 
	join films f on f.id = pf.film_id	 
		-- where p.id = 1  -- Возможно подключить индивидуальную выборку
		group by person order by person;

	
-- Выборка ролей персоны
select concat(p.name, ' ', p.lastname) as person, pt.person_type as `role` from persons p
	join person_info per_inf on per_inf.person_id = p.id
	join person_type pt on per_inf.person_type_id = pt.id
		where p.id = 1
			order by person, `role`;


/*				Выборки с фильмами   			*/
-- Выборка фильмов по жанрам
select f.id, f.name, g.genre from films f
	join film_genre fg on f.id = fg.film_id 
	join genres g on g.id = fg.genre_id
		where genre = 'Боевик' order by f.id;


-- Средний рейтинг фильма
select fil.name, avg(r.rating) from films fil
	left join rating r on r.film_id = fil.id
		where fil.id = 1 group by fil.id;

	
-- Сколько пользователей добавили в избранное
select fil.name, count(ff.id) from films fil
	left join favourite_films ff on ff.film_id = fil.id
		where fil.id = 1
			group by fil.id;
	
		
-- Сколько раз поставили фильму оценку
select fil.name, count(r.id) from films fil
	left join rating r on r.film_id = fil.id
		where fil.id = 4
			group by fil.id;
		