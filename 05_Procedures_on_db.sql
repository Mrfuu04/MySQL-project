use kinopoisk;
/*				TRIGGERS				*/

-- Запрет на добавление пустых полей в поле firstname в таблице profiles
drop trigger if exists tr_profiles_frstname;
delimiter //
create trigger tr_profiles_frstname before insert 
	on profiles
	for each row 
	begin 
		if length(ltrim(rtrim(new.firstname))) = 0 then 
			signal sqlstate '45000' set message_text = 'Firstname is empty';
		end if;
	end//
delimiter ;


-- Запрет на добавление пустых полей в поле name в таблице films
drop trigger if exists tr_films_name;
delimiter //
create trigger tr_films_name before insert 
	on films
	for each row 
	begin 
		if length(ltrim(rtrim(new.name))) = 0 then 
			signal sqlstate '45000' set message_text = 'Firstname is empty';
		end if;
	end//
delimiter ;


/*				PROCEDURES				*/
-- добавление пользователя
drop procedure if exists sp_add_user;
delimiter //
create procedure sp_add_user(email VARCHAR(50), password_hash VARCHAR(100),
							out status VARCHAR(200))
begin
		declare _rollback BOOL default 0;
		declare error_code VARCHAR(100);
		declare error_str VARChAR(100);
	
		declare continue handler for sqlexception 
				begin
						set _rollback = 1;
						get stacked diagnostics condition 1
							error_code = returned_sqlstate, error_str = message_text;
						set status := concat('Error code:', error_code, 'Message: ', error_str);
				end;
		
		start transaction;
		insert into users (email, password_hash) values
			(email, password_hash);
		insert into profiles (user_id) values
			(last_insert_id());
		
		if _rollback = 1 then
			rollback;
		else
			set status := 'OK!';
			commit;
		end if;
end //
delimiter ;



-- Добавление фильма

drop procedure if exists sp_add_film;
delimiter //
create procedure sp_add_film(name VARCHAR(100), film_type enum('movie','serial'), `date` year, description text,
							out status VARCHAR(200))
begin
		declare _rollback BOOL default 0;
		declare error_code VARCHAR(100);
		declare error_str VARChAR(100);
		declare _film_type_id INT;
		declare continue handler for sqlexception 
				begin
						set _rollback = 1;
						get stacked diagnostics condition 1
							error_code = returned_sqlstate, error_str = message_text;
						set status := concat('Error code:', error_code, 'Message: ', error_str);
				end;
			
		if film_type = 'movie'
				then set _film_type_id = 1;
		else
				set _film_type_id = 0;
		end if;
		-- проверка на пустое значение name
		if length(ltrim(rtrim(name))) = 0 then set _rollback = 1;
										set status = 'Пустое имя';
		end if;
	
		start transaction;
		insert into films (name) values
			(name);
		insert into film_info (film_id, film_type_id, `date`, description) values
			(last_insert_id(), _film_type_id, `date`, description);
		if _rollback = 1 then
			rollback;
		else
			set status := 'OK!';
			commit;
		end if;
end//
delimiter ; 






