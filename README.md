# MySQL-project

## _Пример упрощенной модели хранения данных веб-сайта [kinopoisk.ru](https://www.kinopoisk.ru/)_
___
### Краткое описание:
_Данная БД предоставляет информацию о кинофильмах, телесериалах, в том числе кадры, 
	трейлеры, постеры, обои, а также данные о персонах, связанных с кино- и телепроизводством: актёрах, режиссёрах, продюсерах,
	сценаристах, операторах, композиторах, художниках и монтажёрах. 
	Посетители могут ставить оценки фильмам и сериалам, добавлять их в ожидаемые, писать рецензии._
___
### Задачи которые решает БД:
* #### _Регистрация пользователей (в БД содержится следующая информация о юзере для публикации на профиле):_
  * Имя, фамилия, e-mail, хэш пароля, пол, аватар, дата рождения, о себе, интересы, рецензии и оценки фильмов/сериалов,
        список просмотренных фильмов/сериалов и буду смотреть (пользователь ставит отметку на фильм/сериал, который
        хочет посмотреть и он отображается в профиле).
        Также будет осуществлена возможность обмена сообщениями между пользователями для этого в БД будут сохранять также
        входящие и исходящие сообщения.
        Список избранных звезд,
        Список избранных фильмов.
  	<br>
* #### _Таблицы фильмов/сериалов (в БД содержится следующая информация о фильме/сериал)_:
    * Название, аватар, описание, трейлер, рейтинг и кол-во голосов, год выхода, жанр, страна, длительность фильма, каст, режиссер, продюссер, сценарист,
        рецензии на фильм от пользователей, интересные факты о фильме, кадры из фильма.
	<br>
* #### _Таблицы персон (в БД содерижится следующая информация о персонах(звездах)):_
    * Имя, аватар, карьера(актер, продюссер и тд), дата рождения, место рождения, всего фильмов, всего сериалов и ссылки на них,
        награды, фото, факты.
	<br>
* #### _Таблицы новостей (в БД содержатся новости о фильмах/сериалах):_
    * Название новости, описание, ссылка на фильм/сериал.
___
