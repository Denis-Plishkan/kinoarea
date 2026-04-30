-- =============================================
-- KINOAREA SEED DATA
-- Тестовые данные для базы
-- =============================================

-- =============================================
-- PERSONS (Актёры и режиссёры)
-- =============================================

INSERT INTO persons (id, name, original_name, slug, photo_url, gender, birth_date, birth_place, biography) VALUES
-- Актёры
('a1000000-0000-0000-0000-000000000001', 'Леонардо ДиКаприо', 'Leonardo DiCaprio', 'leonardo-dicaprio',
 'https://image.tmdb.org/t/p/w500/wo2hJpn04vbtmh0B9utCFdsQhxM.jpg', 'male', '1974-11-11', 'Лос-Анджелес, Калифорния, США',
 'Леонардо Вильгельм ДиКаприо — американский актёр и продюсер. Лауреат премии «Оскар», трёх премий «Золотой глобус» и премии BAFTA.'),

('a1000000-0000-0000-0000-000000000002', 'Брэд Питт', 'Brad Pitt', 'brad-pitt',
 'https://image.tmdb.org/t/p/w500/huV2cdcolEUwJy37QvH914vup7d.jpg', 'male', '1963-12-18', 'Шони, Оклахома, США',
 'Уильям Брэдли Питт — американский актёр и продюсер. Лауреат двух премий «Оскар» и двух премий «Золотой глобус».'),

('a1000000-0000-0000-0000-000000000003', 'Марго Робби', 'Margot Robbie', 'margot-robbie',
 'https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg', 'female', '1990-07-02', 'Далби, Квинсленд, Австралия',
 'Марго Элис Робби — австралийская актриса и продюсер. Номинант на премию «Оскар».'),

('a1000000-0000-0000-0000-000000000004', 'Киллиан Мёрфи', 'Cillian Murphy', 'cillian-murphy',
 'https://image.tmdb.org/t/p/w500/dm6V24NjjvjMiCtbMkc8Y2WPm2e.jpg', 'male', '1976-05-25', 'Дублин, Ирландия',
 'Киллиан Мёрфи — ирландский актёр. Лауреат премии «Оскар» за лучшую мужскую роль в фильме «Оппенгеймер».'),

('a1000000-0000-0000-0000-000000000005', 'Тимоти Шаламе', 'Timothée Chalamet', 'timothee-chalamet',
 'https://image.tmdb.org/t/p/w500/BE2sdjpgsa2rNTFa66f7upkaOP.jpg', 'male', '1995-12-27', 'Нью-Йорк, США',
 'Тимоти Хэл Шаламе — американский и французский актёр. Номинант на премию «Оскар».'),

('a1000000-0000-0000-0000-000000000006', 'Зендея', 'Zendaya', 'zendaya',
 'https://image.tmdb.org/t/p/w500/tyNBpXKbT0cRhGIJtq8Pxxn4Z5I.jpg', 'female', '1996-09-01', 'Окленд, Калифорния, США',
 'Зендея Мари Стормер Коулман — американская актриса и певица. Лауреат двух премий «Эмми».'),

('a1000000-0000-0000-0000-000000000007', 'Роберт Дауни мл.', 'Robert Downey Jr.', 'robert-downey-jr',
 'https://image.tmdb.org/t/p/w500/im9SAqJPZKEbVZGmjXuLI4O7RvM.jpg', 'male', '1965-04-04', 'Нью-Йорк, США',
 'Роберт Джон Дауни младший — американский актёр и продюсер. Лауреат премий «Оскар», «Золотой глобус» и BAFTA.'),

('a1000000-0000-0000-0000-000000000008', 'Эмили Блант', 'Emily Blunt', 'emily-blunt',
 'https://image.tmdb.org/t/p/w500/nPJXaRYBoON5rRxfHGmYLN8Tpeb.jpg', 'female', '1983-02-23', 'Лондон, Англия',
 'Эмили Оливия Лия Блант — британская и американская актриса. Лауреат премий SAG и «Золотой глобус».'),

-- Режиссёры
('a1000000-0000-0000-0000-000000000101', 'Кристофер Нолан', 'Christopher Nolan', 'christopher-nolan',
 'https://image.tmdb.org/t/p/w500/xuAIuYSmsUzKlUMBFGVZaWsY3DZ.jpg', 'male', '1970-07-30', 'Лондон, Англия',
 'Кристофер Эдвард Нолан — британский и американский кинорежиссёр, сценарист и продюсер. Лауреат премии «Оскар».'),

('a1000000-0000-0000-0000-000000000102', 'Дени Вильнёв', 'Denis Villeneuve', 'denis-villeneuve',
 'https://image.tmdb.org/t/p/w500/zdDx9Xs93UIrJFWYApYR28J8M6b.jpg', 'male', '1967-10-03', 'Квебек, Канада',
 'Дени Вильнёв — канадский кинорежиссёр и сценарист. Номинант на премию «Оскар».'),

('a1000000-0000-0000-0000-000000000103', 'Квентин Тарантино', 'Quentin Tarantino', 'quentin-tarantino',
 'https://image.tmdb.org/t/p/w500/1gjcpAa99FAOWGnrUvHEXXsRs7o.jpg', 'male', '1963-03-27', 'Ноксвилл, Теннесси, США',
 'Квентин Джером Тарантино — американский кинорежиссёр, сценарист, продюсер и актёр. Лауреат двух премий «Оскар» за лучший сценарий.'),

('a1000000-0000-0000-0000-000000000104', 'Мартин Скорсезе', 'Martin Scorsese', 'martin-scorsese',
 'https://image.tmdb.org/t/p/w500/9U9Y5GQuWX3EZy39B8nkk4NY01S.jpg', 'male', '1942-11-17', 'Нью-Йорк, США',
 'Мартин Чарльз Скорсезе — американский кинорежиссёр, сценарист и продюсер. Лауреат премии «Оскар».'),

('a1000000-0000-0000-0000-000000000105', 'Гай Ричи', 'Guy Ritchie', 'guy-ritchie',
 'https://image.tmdb.org/t/p/w500/9zc7AZLJ7JGlIifpvYFebWuEpVi.jpg', 'male', '1968-09-10', 'Хатфилд, Англия',
 'Гай Стюарт Ричи — британский кинорежиссёр, сценарист и продюсер.');

-- =============================================
-- MOVIES (Фильмы)
-- =============================================

INSERT INTO movies (id, title, original_title, slug, type, year, release_date, runtime_minutes, description, tagline, rating_kinoarea, rating_imdb, votes_count, budget, box_office_world, poster_url, backdrop_url, mpaa, is_in_cinema, is_expected, premiere_russia, premiere_world) VALUES

-- Оппенгеймер (2023)
('m1000000-0000-0000-0000-000000000001', 'Оппенгеймер', 'Oppenheimer', 'oppenheimer', 'movie', 2023, '2023-07-21', 180,
 'История жизни американского физика Роберта Оппенгеймера, который стоял во главе первых разработок ядерного оружия.',
 'Мир навсегда изменится', 8.7, 8.4, 125000, 100000000, 952000000,
 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
 'https://image.tmdb.org/t/p/original/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg',
 'R', false, false, '2023-08-24', '2023-07-21'),

-- Дюна: Часть вторая (2024)
('m1000000-0000-0000-0000-000000000002', 'Дюна: Часть вторая', 'Dune: Part Two', 'dune-part-two', 'movie', 2024, '2024-03-01', 166,
 'Пол Атрейдес объединяется с Чани и фременами, чтобы отомстить заговорщикам, уничтожившим его семью.',
 'Да начнётся священная война', 8.5, 8.5, 98000, 190000000, 714000000,
 'https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
 'https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg',
 'PG-13', false, false, '2024-02-29', '2024-03-01'),

-- Однажды в Голливуде (2019)
('m1000000-0000-0000-0000-000000000003', 'Однажды в... Голливуде', 'Once Upon a Time... in Hollywood', 'once-upon-a-time-in-hollywood', 'movie', 2019, '2019-07-26', 161,
 'В 1969 году в Лос-Анджелесе всё меняется: телеактёр Рик Далтон и его дублёр Клифф Бут пытаются найти себя в новом Голливуде.',
 'В Голливуде всё возможно', 8.1, 7.6, 87000, 90000000, 377000000,
 'https://image.tmdb.org/t/p/w500/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg',
 'https://image.tmdb.org/t/p/original/8moTOzunF7p40oR5XhlDvJckOSW.jpg',
 'R', false, false, '2019-08-08', '2019-07-26'),

-- Начало (2010)
('m1000000-0000-0000-0000-000000000004', 'Начало', 'Inception', 'inception', 'movie', 2010, '2010-07-16', 148,
 'Кобб — талантливый вор, лучший в опасном искусстве извлечения: он крадёт ценные секреты из глубин подсознания во время сна.',
 'Твой разум — место преступления', 8.8, 8.8, 245000, 160000000, 839000000,
 'https://image.tmdb.org/t/p/w500/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg',
 'https://image.tmdb.org/t/p/original/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg',
 'PG-13', false, false, '2010-07-22', '2010-07-16'),

-- Интерстеллар (2014)
('m1000000-0000-0000-0000-000000000005', 'Интерстеллар', 'Interstellar', 'interstellar', 'movie', 2014, '2014-11-07', 169,
 'Когда засуха, пыльные бури и вымирание растений приводят человечество к продовольственному кризису, группа исследователей отправляется через червоточину в космосе.',
 'Человечество родилось на Земле. Оно не должно здесь умереть', 8.9, 8.7, 198000, 165000000, 773000000,
 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
 'https://image.tmdb.org/t/p/original/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
 'PG-13', false, false, '2014-11-06', '2014-11-07'),

-- Джокер (2019)
('m1000000-0000-0000-0000-000000000006', 'Джокер', 'Joker', 'joker-2019', 'movie', 2019, '2019-10-04', 122,
 'Готэм, начало 1980-х. Комик Артур Флек живёт с больной матерью и ходит на приём к психотерапевту. Он пытается нести людям позитив, но мир отталкивает его.',
 'Поставь счастливое лицо', 8.4, 8.4, 176000, 55000000, 1074000000,
 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
 'https://image.tmdb.org/t/p/original/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg',
 'R', false, false, '2019-10-03', '2019-10-04'),

-- Убийцы цветочной луны (2023)
('m1000000-0000-0000-0000-000000000007', 'Убийцы цветочной луны', 'Killers of the Flower Moon', 'killers-of-the-flower-moon', 'movie', 2023, '2023-10-20', 206,
 'В 1920-х годах богатые нефтью земли индейцев осейдж привлекают белых поселенцев. Начинается серия загадочных убийств.',
 'Правда приходит в своё время', 8.0, 7.6, 56000, 200000000, 157000000,
 'https://image.tmdb.org/t/p/w500/dB6Krk806zeqd0YNp2ngQ9zXteH.jpg',
 'https://image.tmdb.org/t/p/original/1X7vow16X7CnCoexXh4H4F2yDJv.jpg',
 'R', false, false, '2023-10-19', '2023-10-20'),

-- Тёмный рыцарь (2008)
('m1000000-0000-0000-0000-000000000008', 'Тёмный рыцарь', 'The Dark Knight', 'the-dark-knight', 'movie', 2008, '2008-07-18', 152,
 'Бэтмен поднимает ставки в войне с криминалом. Вместе с лейтенантом Джимом Гордоном и прокурором Харви Дентом он намерен покончить с преступностью.',
 'Почему так серьёзно?', 9.0, 9.0, 287000, 185000000, 1006000000,
 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
 'https://image.tmdb.org/t/p/original/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg',
 'PG-13', false, false, '2008-08-14', '2008-07-18'),

-- Бойцовский клуб (1999)
('m1000000-0000-0000-0000-000000000009', 'Бойцовский клуб', 'Fight Club', 'fight-club', 'movie', 1999, '1999-10-15', 139,
 'Страховой работник страдает от бессонницы. В поисках выхода он находит странную терапию — группы поддержки. И знакомится с Тайлером Дёрденом.',
 'Первое правило бойцовского клуба: не упоминать о бойцовском клубе', 8.8, 8.8, 234000, 63000000, 101000000,
 'https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
 'https://image.tmdb.org/t/p/original/hZkgoQYus5vegHoetLkCJzb17zJ.jpg',
 'R', false, false, '2000-01-13', '1999-10-15'),

-- Джентльмены (2019)
('m1000000-0000-0000-0000-000000000010', 'Джентльмены', 'The Gentlemen', 'the-gentlemen', 'movie', 2019, '2020-01-24', 113,
 'Наркобарон хочет продать свой бизнес и уйти на покой. Но желающие перехватить империю начинают плести интриги.',
 'Криминальная комедия', 8.3, 7.8, 145000, 22000000, 115000000,
 'https://image.tmdb.org/t/p/w500/jtrhTYB7xSrJxR1vusu99nvnZ1g.jpg',
 'https://image.tmdb.org/t/p/original/fT8reLrpMHJ4dRxNGr9bHj4HbvY.jpg',
 'R', false, false, '2020-02-13', '2020-01-24'),

-- Барби (2023)
('m1000000-0000-0000-0000-000000000011', 'Барби', 'Barbie', 'barbie-2023', 'movie', 2023, '2023-07-21', 114,
 'Барби переживает экзистенциальный кризис и отправляется в реальный мир, чтобы найти настоящее счастье.',
 'Она всё может. А он просто Кен', 7.5, 6.9, 89000, 145000000, 1442000000,
 'https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg',
 'https://image.tmdb.org/t/p/original/nHf61UzkfFno5X1ofIhugCPus2R.jpg',
 'PG-13', false, false, '2023-07-20', '2023-07-21'),

-- Форсаж 10 (2023)
('m1000000-0000-0000-0000-000000000012', 'Форсаж 10', 'Fast X', 'fast-x', 'movie', 2023, '2023-05-19', 141,
 'Доминик Торетто и его семья становятся мишенью Данте, сына наркобарона Эрнана Рейеса.',
 'Конец дороги начинается', 6.8, 5.8, 67000, 340000000, 714000000,
 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdclSiC.jpg',
 'https://image.tmdb.org/t/p/original/4XM8DUTQb3lhLemJC51Jx4a2EuA.jpg',
 'PG-13', false, false, '2023-05-18', '2023-05-19'),

-- Аватар 2 (2022)
('m1000000-0000-0000-0000-000000000013', 'Аватар: Путь воды', 'Avatar: The Way of Water', 'avatar-the-way-of-water', 'movie', 2022, '2022-12-16', 192,
 'Джейк Салли живёт со своей семьёй на Пандоре. Когда знакомая угроза возвращается, он вынужден искать убежище у морского народа.',
 'Вернись на Пандору', 8.1, 7.6, 112000, 460000000, 2320000000,
 'https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
 'https://image.tmdb.org/t/p/original/s16H6tpK2utvwDtzZ8Qy4qm5Emw.jpg',
 'PG-13', false, false, '2022-12-15', '2022-12-16'),

-- Достать ножи (2019)
('m1000000-0000-0000-0000-000000000014', 'Достать ножи', 'Knives Out', 'knives-out', 'movie', 2019, '2019-11-27', 130,
 'После смерти знаменитого автора детективов сыщик Бенуа Блан расследует убийство среди эксцентричной семьи покойного.',
 'У каждого свои скелеты в шкафу', 8.0, 7.9, 98000, 40000000, 312000000,
 'https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg',
 'https://image.tmdb.org/t/p/original/4HWAQu28e2yaWrtupFPGFkdNU7V.jpg',
 'PG-13', false, false, '2019-11-28', '2019-11-27'),

-- Паразиты (2019)
('m1000000-0000-0000-0000-000000000015', 'Паразиты', 'Parasite', 'parasite-2019', 'movie', 2019, '2019-05-30', 132,
 'Обычная корейская семья жила в полуподвале и еле сводила концы с концами. Однажды сын устраивается репетитором в богатую семью.',
 'Поступай так, как они', 8.6, 8.5, 156000, 11400000, 266000000,
 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
 'https://image.tmdb.org/t/p/original/TU9NIjwzjoKPwQHoHshkFcQUCG.jpg',
 'R', false, false, '2019-07-04', '2019-05-30');

-- =============================================
-- MOVIE-GENRE RELATIONS
-- =============================================

-- Получаем ID жанров
-- Оппенгеймер: Драма, Биография, История
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000001', id FROM genres WHERE slug IN ('drama', 'biography', 'history');

-- Дюна 2: Фантастика, Приключения, Драма
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000002', id FROM genres WHERE slug IN ('sci-fi', 'adventure', 'drama');

-- Однажды в Голливуде: Драма, Комедия
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000003', id FROM genres WHERE slug IN ('drama', 'comedy');

-- Начало: Фантастика, Боевик, Триллер
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000004', id FROM genres WHERE slug IN ('sci-fi', 'action', 'thriller');

-- Интерстеллар: Фантастика, Драма, Приключения
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000005', id FROM genres WHERE slug IN ('sci-fi', 'drama', 'adventure');

-- Джокер: Драма, Триллер, Криминал
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000006', id FROM genres WHERE slug IN ('drama', 'thriller', 'crime');

-- Убийцы цветочной луны: Драма, Криминал, История
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000007', id FROM genres WHERE slug IN ('drama', 'crime', 'history');

-- Тёмный рыцарь: Боевик, Драма, Криминал
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000008', id FROM genres WHERE slug IN ('action', 'drama', 'crime');

-- Бойцовский клуб: Драма, Триллер
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000009', id FROM genres WHERE slug IN ('drama', 'thriller');

-- Джентльмены: Боевик, Комедия, Криминал
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000010', id FROM genres WHERE slug IN ('action', 'comedy', 'crime');

-- Барби: Комедия, Приключения, Фэнтези
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000011', id FROM genres WHERE slug IN ('comedy', 'adventure', 'fantasy');

-- Форсаж 10: Боевик, Приключения
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000012', id FROM genres WHERE slug IN ('action', 'adventure');

-- Аватар 2: Фантастика, Приключения
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000013', id FROM genres WHERE slug IN ('sci-fi', 'adventure');

-- Достать ножи: Детектив, Комедия, Драма
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000014', id FROM genres WHERE slug IN ('detective', 'comedy', 'drama');

-- Паразиты: Драма, Триллер, Комедия
INSERT INTO movie_genres (movie_id, genre_id)
SELECT 'm1000000-0000-0000-0000-000000000015', id FROM genres WHERE slug IN ('drama', 'thriller', 'comedy');

-- =============================================
-- MOVIE-COUNTRY RELATIONS
-- =============================================

-- США фильмы
INSERT INTO movie_countries (movie_id, country_id)
SELECT m.id, c.id FROM movies m, countries c
WHERE m.slug IN ('oppenheimer', 'inception', 'interstellar', 'the-dark-knight', 'fight-club', 'barbie-2023', 'fast-x', 'knives-out')
AND c.code = 'USA';

-- Дюна: США + Канада
INSERT INTO movie_countries (movie_id, country_id)
SELECT 'm1000000-0000-0000-0000-000000000002', id FROM countries WHERE code IN ('USA', 'CAN');

-- Однажды в Голливуде: США + Великобритания
INSERT INTO movie_countries (movie_id, country_id)
SELECT 'm1000000-0000-0000-0000-000000000003', id FROM countries WHERE code IN ('USA', 'GBR');

-- Джокер: США
INSERT INTO movie_countries (movie_id, country_id)
SELECT 'm1000000-0000-0000-0000-000000000006', id FROM countries WHERE code = 'USA';

-- Убийцы цветочной луны: США
INSERT INTO movie_countries (movie_id, country_id)
SELECT 'm1000000-0000-0000-0000-000000000007', id FROM countries WHERE code = 'USA';

-- Джентльмены: Великобритания + США
INSERT INTO movie_countries (movie_id, country_id)
SELECT 'm1000000-0000-0000-0000-000000000010', id FROM countries WHERE code IN ('GBR', 'USA');

-- Аватар 2: США
INSERT INTO movie_countries (movie_id, country_id)
SELECT 'm1000000-0000-0000-0000-000000000013', id FROM countries WHERE code = 'USA';

-- Паразиты: Южная Корея
INSERT INTO movie_countries (movie_id, country_id)
SELECT 'm1000000-0000-0000-0000-000000000015', id FROM countries WHERE code = 'KOR';

-- =============================================
-- MOVIE-PERSON RELATIONS (Актёры и режиссёры)
-- =============================================

-- Оппенгеймер
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000004', 'actor', 'Дж. Роберт Оппенгеймер', 1),
('m1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000008', 'actor', 'Кэтрин Оппенгеймер', 2),
('m1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000007', 'actor', 'Льюис Штраус', 3),
('m1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000101', 'director', NULL, 1);

-- Дюна: Часть вторая
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000005', 'actor', 'Пол Атрейдес', 1),
('m1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000006', 'actor', 'Чани', 2),
('m1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000102', 'director', NULL, 1);

-- Однажды в Голливуде
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000001', 'actor', 'Рик Далтон', 1),
('m1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000002', 'actor', 'Клифф Бут', 2),
('m1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003', 'actor', 'Шэрон Тейт', 3),
('m1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000103', 'director', NULL, 1);

-- Начало
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000001', 'actor', 'Кобб', 1),
('m1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000101', 'director', NULL, 1);

-- Интерстеллар
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000005', 'a1000000-0000-0000-0000-000000000101', 'director', NULL, 1);

-- Убийцы цветочной луны
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000007', 'a1000000-0000-0000-0000-000000000001', 'actor', 'Эрнест Беркхарт', 1),
('m1000000-0000-0000-0000-000000000007', 'a1000000-0000-0000-0000-000000000007', 'actor', 'Уильям Хейл', 2),
('m1000000-0000-0000-0000-000000000007', 'a1000000-0000-0000-0000-000000000104', 'director', NULL, 1);

-- Тёмный рыцарь
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000008', 'a1000000-0000-0000-0000-000000000101', 'director', NULL, 1);

-- Бойцовский клуб
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000009', 'a1000000-0000-0000-0000-000000000002', 'actor', 'Тайлер Дёрден', 1);

-- Джентльмены
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000010', 'a1000000-0000-0000-0000-000000000105', 'director', NULL, 1);

-- Барби
INSERT INTO movie_persons (movie_id, person_id, role, character_name, billing_order) VALUES
('m1000000-0000-0000-0000-000000000011', 'a1000000-0000-0000-0000-000000000003', 'actor', 'Барби', 1);

-- =============================================
-- TRAILERS (YouTube)
-- =============================================

INSERT INTO trailers (movie_id, title, youtube_url, youtube_id, is_main) VALUES
('m1000000-0000-0000-0000-000000000001', 'Оппенгеймер — Официальный трейлер', 'https://www.youtube.com/watch?v=uYPbbksJxIg', 'uYPbbksJxIg', true),
('m1000000-0000-0000-0000-000000000002', 'Дюна: Часть вторая — Официальный трейлер', 'https://www.youtube.com/watch?v=Way9Dexny3w', 'Way9Dexny3w', true),
('m1000000-0000-0000-0000-000000000003', 'Однажды в Голливуде — Трейлер', 'https://www.youtube.com/watch?v=ELeMaP8EPAA', 'ELeMaP8EPAA', true),
('m1000000-0000-0000-0000-000000000004', 'Начало — Официальный трейлер', 'https://www.youtube.com/watch?v=YoHD9XEInc0', 'YoHD9XEInc0', true),
('m1000000-0000-0000-0000-000000000005', 'Интерстеллар — Официальный трейлер', 'https://www.youtube.com/watch?v=zSWdZVtXT7E', 'zSWdZVtXT7E', true),
('m1000000-0000-0000-0000-000000000006', 'Джокер — Финальный трейлер', 'https://www.youtube.com/watch?v=zAGVQLHvwOY', 'zAGVQLHvwOY', true),
('m1000000-0000-0000-0000-000000000007', 'Убийцы цветочной луны — Трейлер', 'https://www.youtube.com/watch?v=EP34Yoxs3FQ', 'EP34Yoxs3FQ', true),
('m1000000-0000-0000-0000-000000000008', 'Тёмный рыцарь — Трейлер', 'https://www.youtube.com/watch?v=EXeTwQWrcwY', 'EXeTwQWrcwY', true),
('m1000000-0000-0000-0000-000000000009', 'Бойцовский клуб — Трейлер', 'https://www.youtube.com/watch?v=SUXWAEX2jlg', 'SUXWAEX2jlg', true),
('m1000000-0000-0000-0000-000000000010', 'Джентльмены — Трейлер', 'https://www.youtube.com/watch?v=Ify9S7hj480', 'Ify9S7hj480', true),
('m1000000-0000-0000-0000-000000000011', 'Барби — Официальный трейлер', 'https://www.youtube.com/watch?v=pBk4NYhWNMM', 'pBk4NYhWNMM', true),
('m1000000-0000-0000-0000-000000000012', 'Форсаж 10 — Трейлер', 'https://www.youtube.com/watch?v=32RAq6JzY-w', '32RAq6JzY-w', true),
('m1000000-0000-0000-0000-000000000013', 'Аватар: Путь воды — Трейлер', 'https://www.youtube.com/watch?v=d9MyW72ELq0', 'd9MyW72ELq0', true),
('m1000000-0000-0000-0000-000000000014', 'Достать ножи — Трейлер', 'https://www.youtube.com/watch?v=qGqiHJTsRkQ', 'qGqiHJTsRkQ', true),
('m1000000-0000-0000-0000-000000000015', 'Паразиты — Трейлер', 'https://www.youtube.com/watch?v=5xH0HfJHsaY', '5xH0HfJHsaY', true);

-- =============================================
-- NEWS (Новости)
-- =============================================

INSERT INTO news (title, slug, excerpt, content, cover_image_url, views_count, is_published, published_at, related_movie_id) VALUES
('Киллиан Мёрфи получил Оскар за роль в Оппенгеймере', 'cillian-murphy-oscar-2024',
 'Ирландский актёр получил свою первую статуэтку Американской киноакадемии.',
 'На 96-й церемонии вручения премии Оскар Киллиан Мёрфи был удостоен награды за лучшую мужскую роль за фильм «Оппенгеймер» Кристофера Нолана. Это первый Оскар в карьере 47-летнего ирландского актёра.',
 'https://image.tmdb.org/t/p/original/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg', 15420, true, '2024-03-11', 'm1000000-0000-0000-0000-000000000001'),

('Дюна: Часть вторая собрала $700 млн', 'dune-2-box-office',
 'Сиквел Дени Вильнёва превзошёл сборы первой части.',
 'Фильм «Дюна: Часть вторая» преодолел отметку в 700 миллионов долларов мировых сборов, значительно превзойдя результат первой части. Критики называют картину одним из лучших научно-фантастических фильмов десятилетия.',
 'https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg', 8930, true, '2024-03-25', 'm1000000-0000-0000-0000-000000000002'),

('Тарантино работает над своим последним фильмом', 'tarantino-final-film',
 'Режиссёр подтвердил, что его десятый фильм станет последним.',
 'Квентин Тарантино подтвердил, что работает над сценарием своего десятого и последнего фильма. Режиссёр ранее заявлял, что уйдёт из кино после десятой картины.',
 'https://image.tmdb.org/t/p/w500/1gjcpAa99FAOWGnrUvHEXXsRs7o.jpg', 12300, true, '2024-02-15', NULL),

('Нолан готовит новый проект после Оппенгеймера', 'nolan-new-project',
 'Кристофер Нолан обсуждает новый фильм с Universal Pictures.',
 'После триумфа «Оппенгеймера» на церемонии Оскар режиссёр Кристофер Нолан начал переговоры с Universal Pictures о своём следующем проекте. Детали сюжета пока держатся в секрете.',
 'https://image.tmdb.org/t/p/w500/xuAIuYSmsUzKlUMBFGVZaWsY3DZ.jpg', 9870, true, '2024-03-20', NULL);

-- =============================================
-- COLLECTION MOVIES (Фильмы в подборках)
-- =============================================

-- ТОП 250
INSERT INTO collection_movies (collection_id, movie_id, position)
SELECT c.id, m.id, row_number() OVER (ORDER BY m.rating_kinoarea DESC)
FROM collections c, movies m
WHERE c.slug = 'top-250'
ORDER BY m.rating_kinoarea DESC;

-- Популярные
INSERT INTO collection_movies (collection_id, movie_id, position)
SELECT c.id, m.id, row_number() OVER (ORDER BY m.votes_count DESC)
FROM collections c, movies m
WHERE c.slug = 'popular'
ORDER BY m.votes_count DESC
LIMIT 10;

-- =============================================
-- AWARDS (Награды)
-- =============================================

INSERT INTO awards (name, year, category, movie_id, person_id, is_winner) VALUES
('Оскар', 2024, 'Лучший фильм', 'm1000000-0000-0000-0000-000000000001', NULL, true),
('Оскар', 2024, 'Лучший режиссёр', 'm1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000101', true),
('Оскар', 2024, 'Лучшая мужская роль', 'm1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000004', true),
('Оскар', 2024, 'Лучшая мужская роль второго плана', 'm1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000007', true),
('Оскар', 2020, 'Лучший фильм', 'm1000000-0000-0000-0000-000000000015', NULL, true),
('Оскар', 2020, 'Лучший иностранный фильм', 'm1000000-0000-0000-0000-000000000015', NULL, true),
('Оскар', 2009, 'Лучшая мужская роль второго плана', 'm1000000-0000-0000-0000-000000000008', NULL, true),
('Золотой глобус', 2024, 'Лучший фильм (драма)', 'm1000000-0000-0000-0000-000000000001', NULL, true),
('Золотой глобус', 2024, 'Лучший фильм (комедия/мюзикл)', 'm1000000-0000-0000-0000-000000000011', NULL, true),
('Золотой глобус', 2020, 'Лучший актёр (драма)', 'm1000000-0000-0000-0000-000000000006', NULL, true);

-- =============================================
-- MOVIE QUOTES (Цитаты)
-- =============================================

INSERT INTO movie_quotes (movie_id, quote_text, character_name) VALUES
('m1000000-0000-0000-0000-000000000001', 'Теперь я стал смертью, разрушителем миров.', 'Дж. Роберт Оппенгеймер'),
('m1000000-0000-0000-0000-000000000004', 'Идея — как вирус. Невероятно живучая.', 'Кобб'),
('m1000000-0000-0000-0000-000000000005', 'Мы не должны уходить во тьму нежно.', 'Профессор Брэнд'),
('m1000000-0000-0000-0000-000000000006', 'Всё, что нужно для того, чтобы сойти с ума — это один плохой день.', 'Артур Флек'),
('m1000000-0000-0000-0000-000000000008', 'Почему так серьёзно?', 'Джокер'),
('m1000000-0000-0000-0000-000000000009', 'Первое правило бойцовского клуба: не упоминать о бойцовском клубе.', 'Тайлер Дёрден'),
('m1000000-0000-0000-0000-000000000009', 'Ты — не твоя работа. Ты — не деньги в твоём кошельке.', 'Тайлер Дёрден');
