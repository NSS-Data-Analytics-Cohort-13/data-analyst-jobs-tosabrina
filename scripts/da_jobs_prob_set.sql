SELECT *
FROM data_analyst_jobs

--1.How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;

--ANS: 1793

--2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

--ANS: ExxobMobil

--3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(location) 
FROM data_analyst_jobs
WHERE location = 'TN';

--ANS:21

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location IN ('KY','TN');

--ANS: 27

--4.How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE 
	location = 'TN'
	AND star_rating >4;
	
--ANS: 3

--5.How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE 
	review_count BETWEEN 500 AND 1000;
	
--ANS: 151

--6.Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT 
	location
	, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_star_rating DESC;

--ANS: NE (Nebraska) and 4.19

--7.Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT title) AS unique_title
FROM data_analyst_jobs;

--ANS: 881

--8.How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title) AS unique_jobs
FROM data_analyst_jobs
WHERE location = 'CA';

--ANS: 230

--9.Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT 
	company
	, ROUND(AVG(star_rating, 2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
	AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating ASC;

--ANS: 40

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT 
	company
	, ROUND(AVG(star_rating, 2) AS avg_star
	, review_count
	, location
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company, review_count, location
ORDER BY avg_star DESC;
--ANS: General Motors (4.20)

--11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
SELECT COUNT(title) AS title_count
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';
-- ANS: 1636

--12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT title 
FROM data_analyst_jobs
WHERE title NOT LIKE '%Analyst%'
	AND title NOT LIKE '%Analytics%';
-- ANS: 39. Not case-sensitive 


--**BONUS:** You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--Disregard any postings where the domain is NULL. 
--Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
 -- Which three industries are in the top 3 on this list? How many jobs have been listed for more than 3 weeks for each of the top 3?
 SELECT title, days_since_posting, domain, skill
 FROM data_analyst_jobs
 WHERE days_since_posting >21
 	AND domain IS NOT NULL
	AND skill = 'SQL'
 ORDER BY days_since_posting DESC;
 
 -- ANS: Consulting and Business Services, Computers and Electronics, Real Estate. All 3