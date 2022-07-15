-- Заполнение db_kinopoisk_ddl.sql
use kinopoisk;

-- adding counties
insert into countries (name) values
	('USA'), ('Russia'), ('Germany'), ('Mexico'), ('France'), ('Italy');

-- adding images
insert into images (image) values
	('test_image_1'),('test_image_2'),('test_image_3'),('test_image_4'),('test_image_5'),
	('test_image_6'),('test_image_7'),('test_image_8'),('test_image_9'),('test_image_10');

-- adding film_types
insert into film_type (film_type) values
	('movie'), ('serial');

-- adding genres
insert into genres (genre) values
	('Ужасы'), ('Комедия'), ('Драма'), ('Фэнтези'), ('Боевик'), ('Триллер'),
	('Детектив'), ('Фантистика');

-- adding studios
insert into studios (name) values
	('Paramount Pictures'), ('Lionsgate'), ('Warner bros.');

-- adding users
insert into users (password_hash, email) values
	('Age3#t45AzCeh@!', 'test1@gmail.com'),
	('Aasg@!rgzCeh@!', 'test2@gmail.com'),
	('ASgxcb%$Ceh@!', 'test3@gmail.com'),
	('sdhg#$#^#Dhhc', 'test4@gmail.com'),
	('Ghxvn$#Yfjkkd@@1', 'test5@gmail.com'),
	('ASfbd$^$&#235bv', 'test6@gmail.com'),
	('ADGxxchfy%#^@r6', 'test7@gmail.com'),
	('SDHhjr564^$@tk!!', 'test8@gmail.com');


alter table profiles change gender gender ENUM('m', 'f'); -- Подправил столбец "пол"

insert into profiles (user_id, firstname, lastname, birthday, gender) values
	(1, 'Сергей', 'Андреев', '1995-08-01', 'm'),
	(2, 'Анна', 'Сергеева', '1994-09-11', 'f'),
	(3, 'Олег', 'Андреев', '1985-01-25', 'm'),
	(4, 'Александр', 'Пушкин', '2000-02-12', 'm'),
	(5, 'Алефтина', 'Федорова', '1976-03-14', 'f'),
	(6, 'Степан', 'Угрюмов', '1994-09-19', 'm'),
	(7, 'Алексей', 'Муромский', '1963-02-21', 'm'),
	(8, '', 'Андреев', '1995-08-01', 'm');


insert into messages (from_user_id, to_user_id, body) values
	(1, 8, 'Привет'),
	(1, 6, 'Как дела?'),
	(4, 2, 'test message'),
	(7, 1, 'test message 2');

-- adding persons
insert into person_type (person_type) values
	('actor'),
	('actress'),
	('producer'),
	('director'),
	('writer');

alter table persons modify name VARCHAR(200) not null; -- поправил name, lastname
alter table persons modify lastname VARCHAR(200) not null; 
alter table persons add original_name VARCHAR(200) after lastname;


insert into persons (name, lastname, original_name, birthday, birthplace) values
	('Бен', 'Аффлек', 'Ben Affleck', '1972-08-15', 'Беркли, Калифорния'),
	('Дженнифер', 'Гарнер', 'Jennifer Garner', '1972-04-17', 'Хьюстон США'),
	('Джаред', 'Лето', 'Jared Leto', '1971-12-26', 'Боссьер Сити США'),
	('Уилл', 'Смит', 'Will Smith', '1968-09-25', 'Филадельфия США'),
	('Шайа', 'ЛаБаф', 'Shia LaBeouf', '1986-06-11', 'Лос-Анджелес США'),
	('Меган', 'Фокс', 'Megan Fox', '1986-05-16', 'Роквуд США'),
	('Майкл', 'Бэй', 'Michael Bay', '1965-02-17', 'Лос-Анджелес США'),
	('Джон', 'Красински', 'John Krasinski', '1979-10-20', 'Ньютон США');

insert into person_photo (person_id, image_id) values
	(1, 1), (2, 2), (5, 3), (7, 4);

insert into person_info (person_id, person_type_id) values
	(1, 1), (2, 2), (3, 1), (4, 1), (5, 1), (6, 2), (7, 3), (7, 4), (7, 5),
	(8, 1), (8, 4), (8, 5);


insert into favourite_persons (user_id, person_id) values
	(1, 3), (1, 5), (2, 1), (4, 1), (4, 6), (6, 2);

-- adding trailers
insert into trailers (trailer) values
	('trailer_test_1'), ('trailer_test_2'), ('trailer_test_3'), ('trailer_test_4'), 
	('trailer_test_5'), ('trailer_test_6');

-- adding films
insert into films (name, original_name) values
	('Оффис', 'The office'), ('Перл-Харбор', 'Pearl Harbor'),
	('Я, робот', 'I, robot'), ('Трансформеры', 'Transformers'),
	('Константин: повелитель тьмы', 'Constantine'), ('Господин Никто', 'Mr. Nobody');

insert into film_trailers (film_id, trailer_id) values
	(1, 6), (2, 3), (3, 1), (4, 2), (5, 4), (6, 5);

insert into film_genre (film_id, genre_id) values
	(1, 2), (2, 5), (2, 3), (3, 5), (3, 6), (3, 8), (4, 5), (4, 8),
	(5, 4), (5, 5), (5, 7), (6, 3), (6, 8);

insert into film_info (film_id, description, `date`, film_type_id) values
	(1, 'Комедийный сериал', '2007', 2), (2, 'Фильм про войну', '2001', 1),
	(3, 'Фильм с Уиллом Смитом про робота', '2004', 1), (4, 'Трансформеры', '2007', 1),
	(5, NULL, '2005', 1), (6, NULL, '2011', 1);

insert into film_images (film_id, image_id) values
	(1, 5), (2, 6), (3, 7), (4, 8), (5, 9), (6, 10);


insert into film_country (film_id, country_id) values
	(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (6, 5);


insert into film_studio (film_id, studio_id) values
	(1, 1), (2, 1), (3, 3), (4, 3), (5, 2), (6, 1);

insert into film_images (film_id, image_id) values
	(2, 5), (4, 6), (6, 7);


insert into person_film (person_id, film_id, `role`) values
	(1, 2, 1), (2, 1, 2), (3, 4, 5), (4, 3, 2), (5, 4, 1), (6, 6, 2), (7, 1, 1), (8, 3, 1);

-- add ratings
insert into rating (rating, user_id, film_id) values
	(5, 1, 2), (10, 1, 3), (1, 3, 5), (10, 5, 6), (10, 4, 6);

insert into reviews (name, body, user_id, film_id, is_positive) values
	('Тест_Ревью_1', 'Тело ревью', 1, 4, 1), ('Тест_Ревью_2', 'Тело ревью', 2, 5, 0),
	('Тест_Ревью_3', 'Тело ревью', 1, 2, 0), ('Тест_Ревью_4', 'Тело ревью', 5, 3, 1);

insert into review_rating (user_id, review_id, is_good) values
	(3, 1, 1), (5, 1, 1), (2, 1, 0), (1, 4, 0);












