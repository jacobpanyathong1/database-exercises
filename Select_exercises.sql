SHOW DATABASES;

USE albums_db;

SELECT *
FROM albums;

-- There are 31 rows in albums_db

SELECT DISTINCT artist
FROM albums;

-- There are 23 distinct rows of artists in albums_db

SHOW DATABASES;

USE albums_db;

SHOW TABLES;

DESCRIBE albums;


-- primary key is id column.

USE albums_db;

SELECT release_date
FROM albums
ORDER BY release_date DESC; 

-- The oldest date of any album released is 1976 and the most recent album is 2011.

-- Below 'Pink Floyd' data

SELECT *
FROM albums
WHERE artist = 'Pink Floyd';

-- Pink Floyd had two albums; The Dark Side of the Moon, The Wall

SELECT *
FROM albums
WHERE name like '%Sgt%';

-- Sgt. Pepper's Lonely Hearts Club Band was released in 1967.

SELECT *
FROM albums
WHERE name like '%Nev%';

-- Genre for Nevermind is Grunge, Alternative rock.

SELECT *
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

/* The albums released between 1990 and 1999 follow:
	The Bodyguard, Jagged Little Pill, Come On Over, Falling into you, Let's Talk About Love, Jagged Little Pill, Falling into You, Dangerous, Come On Over.*/

SELECT *
FROM albums
WHERE sales < 20.0;

/* The albums to follow had sales less than 20M in sales:
	Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hears Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Corn in the U.S.A, Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall.*/

SELECT *
FROM albums
WHERE genre = 'Rock';

SELECT *
FROM albums
WHERE genre = 'Progressive rock';

SELECT *
FROM albums
WHERE genre = 'Hard rock';

-- the string for 'rock' will pull the exact/True value for this search query. It will not pull the rows for 'Hard rock' and 'Progressive rock'
