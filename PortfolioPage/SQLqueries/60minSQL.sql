create database record_company;
use record_company;

CREATE TABLE Bands (
ID INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
PRIMARY KEY (ID)
);
CREATE TABLE albums (
ID INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
release_year int,
band_id INT NOT NULL,
PRIMARY KEY (ID), FOREIGN KEY(band_id) REFERENCES Bands(ID)
);


INSERT INTO Bands (name)
VALUES ('Iron Maiden');
INSERT INTO bands (name)
Values ('Deuce'), ('Avenged Sevenfold'), ('Ankor');

SELECT * FROM bands;
SELECT name AS 'Band Name'
FROM Bands;

INSERT INTO albums (name, release_year, band_id)
VALUES ('The Number of the Beast', 1985, 1), ('Power Slave', 1984, 1), ('Nightmare', 2018, 2),
('Nightmare', 2010, 3), ('Test Album', NULL, 3);

SELECT * FROM albums;
SELECT DISTINCT name FROM albums;

UPDATE albums
SET release_year = 1982
WHERE id = 1;

SELECT * From albums
WHERE release_year < 2000;

SELECT * FROM albums
WHERE name LIKE '%er%' or band_id = 2;
SELECT * FROM albums
WHERE release_year = 1984 AND band_id = 1;
SELECT * FROM albums
WHERE release_year BETWEEN 2000 AND 2018;
SELECT * FROM albums
WHERE release_year IS NULL;

DELETE FROM albums WHERE id = 5;

SELECT * FROM bands
JOIN albums ON bands.id = albums.band_id;
SELECT * FROM bands
LEFT JOIN albums ON bands.id = albums.band_id;

SELECT AVG(release_year) FROM albums;
SELECT band_id, COUNT(band_id) FROM albums
GROUP BY band_id;

SELECT b.name AS band_name, COUNT(a.id) as num_albums
FROM bands AS b
LEFT JOIN albums as a ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums = 1;