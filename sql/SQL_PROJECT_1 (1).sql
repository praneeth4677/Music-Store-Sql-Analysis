CREATE DATABASE MUSIC_STORE;
USE MUSIC_STORE;

CREATE TABLE Genre (
	genre_id INT PRIMARY KEY,
	name VARCHAR(120)
);

CREATE TABLE MediaType (
	media_type_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 2. Employee
CREATE TABLE Employee (
	employee_id INT PRIMARY KEY,
	last_name VARCHAR(120),
	first_name VARCHAR(120),
	title VARCHAR(120),
	reports_to INT,
  levels VARCHAR(255),
	birthdate DATE,
	hire_date DATE,
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100)
);

-- 3. Customer
CREATE TABLE Customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(120),
	last_name VARCHAR(120),
	company VARCHAR(120),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100),
	support_rep_id INT,
	FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id)
);

-- 4. Artist
CREATE TABLE Artist (
	artist_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
	album_id INT PRIMARY KEY,
	title VARCHAR(160),
	artist_id INT,
	FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);

-- 6. Track
CREATE TABLE Track (
	track_id INT PRIMARY KEY,
	name VARCHAR(200),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer VARCHAR(220),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL(10,2),
	FOREIGN KEY (album_id) REFERENCES Album(album_id),
	FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id),
	FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

-- 7. Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY,
	customer_id INT,
	invoice_date DATE,
	billing_address VARCHAR(255),
	billing_city VARCHAR(100),
	billing_state VARCHAR(100),
	billing_country VARCHAR(100),
	billing_postal_code VARCHAR(20),
	total DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 8. InvoiceLine
CREATE TABLE InvoiceLine (
	invoice_line_id INT PRIMARY KEY,
	invoice_id INT,
	track_id INT,
	unit_price DECIMAL(10,2),
	quantity INT,
	FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

-- 9. Playlist
CREATE TABLE Playlist (
 	playlist_id INT PRIMARY KEY,
	name VARCHAR(255)
);

-- 10. PlaylistTrack
CREATE TABLE PlaylistTrack (
	playlist_id INT,
	track_id INT,
	PRIMARY KEY (playlist_id, track_id),
	FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

SELECT * FROM GENRE ;
SELECT * FROM MEDIATYPE;
SELECT * FROM EMPLOYEE;
SELECT * FROM CUSTOMER;
SELECT * FROM ARTIST;
SELECT * FROM Album;
SELECT * FROM Track;
SELECT * FROM Invoice;
SELECT * FROM InvoiceLine;
SELECT * FROM Playlist;
SELECT * FROM PlaylistTRACK;

-- Task

-- 1. Who is the senior most employee based on job title? 

	SELECT first_name,
			last_name,
            title,
            levels 
	FROM EMPLOYEE
    ORDER BY LEVELS DESC 
    limit 1;
    
-- 2. 2. Which countries have the most Invoices?

SELECT billing_country,
       COUNT(*) AS total_invoices
FROM Invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;

-- 3. What are the top 3 values of total invoice?
	SELECT INVOICE_ID , TOTAL
    FROM INVOICE 
    ORDER BY TOTAL DESC
    LIMIT 3;
    
-- 4. Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
	
    SELECT BILLING_CITY , SUM(TOTAL) AS TOTAL_REVENUE
    FROM INVOICE 
    GROUP BY BILLING_CITY
    ORDER BY SUM(TOTAL) DESC
    LIMIT 1;
    
-- 5. Who is the best customer? - The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money

    SELECT C.CUSTOMER_ID,CONCAT(C.FIRST_NAME,' ' ,C.LAST_NAME) AS CUS_NAME ,
    SUM(TOTAL) AS TOTALL 
    FROM INVOICE AS I
	INNER JOIN CUSTOMER C
    ON I.CUSTOMER_ID = C.CUSTOMER_ID
    GROUP BY C.CUSTOMER_ID, CONCAT(C.FIRST_NAME,' ' ,C.LAST_NAME)
    ORDER BY TOTALL DESC
    LIMIT 1;
    
-- 6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners.
--  Return your list ordered alphabetically by email starting with A
	
    SELECT DISTINCT C.EMAIL , C.FIRST_NAME, C.LAST_NAME , G.NAME AS GENRE_NAME 
    FROM CUSTOMER AS C
    INNER JOIN INVOICE AS I
	ON C.CUSTOMER_ID = I.CUSTOMER_ID
    INNER JOIN INVOICELINE AS IL
    ON I.INVOICE_ID = IL.INVOICE_ID
    INNER JOIN TRACK AS T
    ON IL.TRACK_ID = T.TRACK_ID
    INNER JOIN GENRE G 
    ON T.GENRE_ID = G.GENRE_ID
    WHERE G.NAME = 'ROCK'
    ORDER BY C.EMAIL ;
    
    
/* 7. Let's invite the artists who have written the most rock music in our dataset.
Write a query that returns the Artist name and total track count of the top 10 rock bands */

SELECT
    A.NAME AS ARTIST_NAME,
    COUNT(*) AS TOTAL_TRACKS
FROM ARTIST A
JOIN ALBUM AB
    ON A.ARTIST_ID = AB.ARTIST_ID
JOIN TRACK T
    ON AB.ALBUM_ID = T.ALBUM_ID
JOIN GENRE G
    ON T.GENRE_ID = G.GENRE_ID
WHERE G.NAME = 'Rock'
GROUP BY A.ARTIST_ID, A.NAME
ORDER BY TOTAL_TRACKS DESC
LIMIT 10;
    
/* '
  8. Return all the track names that have a song length longer than the average song length.
- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first
 */
        SELECT NAME , milliseconds 
        FROM TRACK
        WHERE milliseconds > 
        (
        SELECT AVG(milliseconds) FROM TRACK
        )
        ORDER BY milliseconds DESC;
/*
9. Find how much amount is spent by each customer on artists?
 Write a query to return customer name, artist name and total spent 
*/
-- ORDER OF EXPLRING
	SELECT * FROM CUSTOMER;
    SELECT * FROM INVOICE;
    SELECT * FROM INVOICELINE;
    SELECT * FROM TRACK;
    SELECT * FROM ALBUM;
    SELECT * FROM ARTIST;
        
	SELECT CONCAT(C.FIRST_NAME,' ',C.LAST_NAME) AS Customer_Name , A.NAME AS Artist_Name ,
    SUM(IL.UNIT_PRICE * IL.QUANTITY) AS Total_Spent
    FROM CUSTOMER AS C
    INNER JOIN INVOICE AS I
    ON C.CUSTOMER_ID = I.CUSTOMER_ID
    INNER JOIN INVOICELINE AS IL
    ON I.INVOICE_ID = IL.INVOICE_ID
    INNER JOIN TRACK AS T
    ON IL.TRACK_ID = T.TRACK_ID
    INNER JOIN ALBUM AS ALB
    ON T.ALBUM_ID = ALB.ALBUM_ID
    INNER JOIN ARTIST A
    ON ALB.ARTIST_ID = A.ARTIST_ID
    GROUP BY Customer_Name , Artist_Name
    ORDER BY TOTAL_SPENT DESC;
    
/*
10.  We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. 
Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared, return all Genres 
*/
WITH genre_count AS
(SELECT
        C.COUNTRY,
        G.NAME AS GENRE_NAME,
        COUNT(*) AS PURCHASES,
        DENSE_RANK() OVER(
            PARTITION BY C.COUNTRY
            ORDER BY COUNT(*) DESC) AS RNK
    FROM CUSTOMER C
    JOIN INVOICE I
        ON C.CUSTOMER_ID = I.CUSTOMER_ID
    JOIN INVOICELINE IL
        ON I.INVOICE_ID = IL.INVOICE_ID
    JOIN TRACK T
        ON IL.TRACK_ID = T.TRACK_ID
    JOIN GENRE G
        ON T.GENRE_ID = G.GENRE_ID
    GROUP BY C.COUNTRY, G.GENRE_ID, G.NAME)
SELECT
    COUNTRY , GENRE_NAME AS E, PURCHASES
FROM genre_count
WHERE RNK = 1
ORDER BY COUNTRY;

/*
11. Write a query that determines the customer that has spent the most on music for each country.
 Write a query that returns the country along with the top customer and how much they spent. 
 For countries where the top amount spent is shared, provide all customers who spent this amount
*/

WITH customer_spending AS (
    SELECT
        C.COUNTRY,
        C.CUSTOMER_ID,
        CONCAT(C.FIRST_NAME,' ',C.LAST_NAME) AS CUSTOMER_NAME,
        SUM(I.TOTAL) AS TOTAL_SPENT,
        DENSE_RANK() OVER(
            PARTITION BY C.COUNTRY
            ORDER BY SUM(I.TOTAL) DESC
        ) AS RNK
    FROM CUSTOMER C
    JOIN INVOICE I
        ON C.CUSTOMER_ID = I.CUSTOMER_ID
    GROUP BY
        C.COUNTRY,
        C.CUSTOMER_ID,
        C.FIRST_NAME,
        C.LAST_NAME)
SELECT
    COUNTRY,
    CUSTOMER_NAME,
    TOTAL_SPENT
FROM customer_spending
WHERE RNK = 1
ORDER BY COUNTRY;