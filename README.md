# 🎵 Music Store SQL Analysis

## 📌 Project Overview

The **Music Store SQL Analysis** project is a SQL-based data analysis project designed to analyze customer purchasing behavior, music preferences, sales performance, and revenue trends.

The project uses a relational Music Store database and SQL queries to transform raw transactional data into meaningful business insights.

---

## 🎯 Business Problem

A music store generates a large amount of customer, invoice, track, artist, and sales data.

The business needs to understand:

- Who are the most valuable customers?
- Which countries generate the most transactions?
- Which cities generate the highest revenue?
- Which music genres are most popular?
- Which artists have the highest number of tracks?
- How do customers spend money on different artists?
- Which genres are preferred in different countries?

Using SQL analysis, these questions can be answered and converted into actionable business insights.

---

## 🎯 Project Objectives

The main objectives of this project are:

- Analyze the Music Store database using SQL.
- Understand customer purchasing behavior.
- Analyze sales and revenue performance.
- Identify popular music genres and artists.
- Identify high-revenue countries and cities.
- Find the highest-spending customers.
- Use SQL concepts to generate meaningful business insights.

---

## 🗄️ Database Schema

The project contains the following tables:

1. `Employee`
2. `Customer`
3. `Invoice`
4. `InvoiceLine`
5. `Artist`
6. `Album`
7. `Track`
8. `Genre`
9. `MediaType`
10. `Playlist`
11. `PlaylistTrack`

# 🔍 Key Analysis Questions & Insights

### 1. Who is the senior-most employee based on job title?

**Answer:** Andrew Adams is the senior-most employee, holding the position of General Manager (L6).

---

### 2. Which countries have the most invoices?

**Answer:** The USA has the highest number of invoices (131), followed by Canada (76) and Brazil (61).

---

### 3. What are the top 3 invoice values?

**Answer:** The highest invoice value is 23.76, followed by 19.80.

---

### 4. Which city generated the highest revenue?

**Answer:** Prague generated the highest revenue with a total invoice value of 273.24.

---

### 5. Who is the best customer?

**Answer:** František Wichterlová is the highest-spending customer, with a total purchase amount of 144.54.

---

### 6. Who are the Rock Music listeners?

**Answer:** The analysis identifies customers who have purchased Rock music and returns their email, first name, last name, and genre.

---

### 7. Which artists have written the most Rock music?

**Answer:** AC/DC has the highest number of Rock tracks (18), followed by Aerosmith (15).

---

### 8. Which tracks are longer than the average song length?

**Answer:** Several tracks are longer than the average song length. The longest track identified is "How Many More Times" with a duration of 711,836 milliseconds.

---

### 9. How much does each customer spend on different artists?

**Answer:** Steve Murray spent the highest amount (17.82) on AC/DC in the project analysis.

---

### 10. What is the most popular music genre in each country?

**Answer:** Rock is the most purchased genre in the majority of countries. This can help support region-specific marketing strategies.


### Table Relationships

```text
Artist
   │
   └── Album
          │
          └── Track
                 │
                 ├── Genre
                 └── MediaType

Customer
   │
   └── Invoice
          │
          └── InvoiceLine
                 │
                 └── Track

Playlist
   │
   └── PlaylistTrack
          │
          └── Track

Employee
   │
   └── Customer
