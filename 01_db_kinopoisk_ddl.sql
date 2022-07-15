
drop database if exists kinopoisk;
create database kinopoisk;

use kinopoisk;

-- GENERALS

drop table if exists genres;
create table genres(
	id serial primary key,
	genre VARCHAR(30) unique not null,
	index genres_name_idx(genre) -- индекс на жанр
);

drop table if exists trailers;
create table trailers (
	id serial primary key,
	trailer VARCHAR(255)
);

drop table if exists countries;
create table countries (
	id serial primary key,
	name VARCHAR(50) unique not null
);

drop table if exists film_type;
create table film_type (
	id serial primary key,
	film_type enum('serial', 'movie')
); -- Здесь будем определять фильм или сериал

drop table if exists person_type;
create table person_type (
	id serial primary key,
	person_type enum('actor', 'actress', 'producer', 'director', 'writer')
); -- Тип персоны

drop table if exists images;
create table images(
	id serial primary key,
	image VARCHAR(255)
); -- Здесь хранится все изображения

drop table if exists studios;
create table studios (
	id serial primary key,
	name VARCHAR(100) not null
); -- Киностудии

-- USERS
drop table if exists users;
create table users(
	id serial primary key,
	password_hash VARCHAR(100),
	email VARCHAR(50) not null unique
);


drop table if exists profile;
create table profiles(
	id serial primary key,
	user_id bigint unsigned not null,
	created_at TIMESTAMP default now(),
	firstname VARCHAR(20), -- default null
	lastname VARCHAR(20), -- default null
	birthday DATE, -- default null	
	gender VARCHAR(15),
	about VARCHAR(500), -- default null
	interests VARCHAR(255), -- default null
	image_id BIGINT unsigned, -- user_avatar
	
	foreign key(user_id) references users(id)
		on delete restrict
		on update cascade,
	foreign key(image_id) references images(id)
		on delete set null
		on update cascade
); -- Users table

drop table if exists messages;
create table messages(
	id serial primary key,
	from_user_id BIGINT unsigned not null,
	to_user_id BIGINT unsigned not null,
	body TEXT,
	created_at timestamp default now(),
	
	foreign key(from_user_id) references users(id),
	foreign key(to_user_id) references users(id),
	check(from_user_id <> to_user_id) -- Проверка, чтобы пользователь не мог написать сам себе
); -- Messages


-- FILMS

drop table if exists films;
create table films (
	id serial primary key,
	name VARCHAR(100) not null,
	original_name VARCHAR(100) default null,
	index film_name_idx(name),
	index film_originalname_idx(original_name)
);

drop table if exists film_info;
create table film_info (
	id serial primary key,
	film_id BIGINT unsigned not null,
	description TEXT,
	`date` YEAR default null,
	film_type_id BIGINT unsigned not null,
	
	foreign key(film_id) references films(id),
	foreign key(film_type_id) references film_type(id)
);

drop table if exists film_genre;
create table film_genre (
	id serial primary key,
	film_id BIGINT unsigned not null,
	genre_id BIGINT unsigned not null,
	
	foreign key(film_id) references films(id),
	foreign key(genre_id) references genres(id)
);

drop table if exists film_images;
create table film_images (
	id serial primary key,
	film_id BIGINT unsigned not null,
	image_id BIGINT unsigned not null,
	
	foreign key(film_id) references films(id),
	foreign key(image_id) references images(id)
);

drop table if exists film_trailers;
create table film_trailers (
	id serial primary key,
	film_id BIGINT unsigned not null,
	trailer_id BIGINT unsigned not null,
	
	foreign key(film_id) references films(id),
	foreign key(trailer_id) references trailers(id)
);
	
drop table if exists film_studio;
create table film_studio (
	id serial primary key,
	film_id BIGINT unsigned not null,
	studio_id BIGINT unsigned not null,
	
	foreign key(film_id) references films(id),
	foreign key(studio_id) references studios(id)
);

drop table if exists film_country;
create table film_country (
	id serial primary key,
	film_id BIGINT unsigned not null,
	country_id BIGINT unsigned not null,
	
	foreign key(film_id) references films(id),
	foreign key(country_id) references countries(id)
);
	
-- PERSONS

drop table if exists persons;
create table persons (
	id serial primary key,
	name VARCHAR(100),
	lastname VARCHAR(100),
	birthday DATE default null,
	birthplace VARCHAR(250) default null,
	
	index name_lastname_person_idx(name, lastname)
);
	
drop table if exists person_info;
create table person_info (
	id serial primary key,
	person_id BIGINT unsigned not null,
	person_type_id BIGINT unsigned not null, -- Определяем тип персоны
	facts VARCHAR(500) default null,
	
	foreign key(person_id) references persons(id),
	foreign key(person_type_id) references person_type(id)
);

drop table if exists person_photo;
create table person_photo (
	id serial primary key,
	person_id BIGINT unsigned not null,
	image_id BIGINT unsigned not null,
	
	foreign key(person_id) references persons(id),
	foreign key(image_id) references images(id)
);
		
drop table if exists person_film;
create table person_film (
	id serial primary key,
	person_id BIGINT unsigned not null,
	film_id BIGINT unsigned not null,
	`role` BIGINT unsigned not null,
	
	foreign key(person_id) references persons(id)
	on update cascade,
	foreign key(film_id) references films(id)
	on update cascade,
	foreign key(`role`) references person_type(id)
);

-- NEWS
drop table if exists news;
create table news (
	id serial primary key,
	name VARCHAR(100) not null,
	body TEXT not null,
	film_id BIGINT unsigned not null,
	foreign key(film_id) references films(id),
	
	index news_name_idx(name)
);

-- USERS FAVOURITES

drop table if exists favourite_persons;
create table favourite_persons (
	id serial primary key,
	user_id BIGINT unsigned not null,
	person_id BIGINT unsigned not null,
	
	foreign key(user_id) references users(id),
	foreign key(person_id) references persons(id)
);

drop table if exists favourite_films;
create table favourite_films (
	id serial primary key,
	user_id BIGINT unsigned not null,
	film_id BIGINT unsigned not null,
	
	foreign key(user_id) references users(id),
	foreign key(film_id) references films(id)
);

-- RATINGS

drop table if exists rating;
create table rating (
	id serial primary key,
	rating enum ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'),
	user_id BIGINT unsigned not null,
	film_id BIGINT unsigned not null,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
	
	foreign key(user_id) references users(id),
	foreign key(film_id) references films(id)
	on delete cascade
	on update cascade
);


-- REVIEWS

drop table if exists reviews;
create table reviews (
	id serial primary key,
	name VARCHAR(150) not null,
	body TEXT not null,
	user_id BIGINT unsigned not null,
	film_id BIGINT unsigned not null,
	is_positive bool not null,
	
	foreign key(user_id) references users(id),
	foreign key(film_id) references films(id)
);
	
drop table if exists review_rating;
create table review_rating (
	id serial primary key,
	user_id BIGINT unsigned not null,
	review_id BIGINT unsigned not null,
	is_good bool not null,
	
	foreign key(user_id) references users(id),
	foreign key(review_id) references reviews(id)
);
	
-- Немного поправил rating для подсчета average
alter table rating change rating rating VARCHAR(50);
alter table rating change rating rating BIGINT;	
alter table rating add constraint check_rating check (rating.rating in (0,1,2,3,4,5,6,7,8,9,10));

-- Поправил 
alter table film_type modify film_type enum('serial','movie') not null;
