
SELECT *
FROM data_analyst_jobs;

--1.How many rows are in the data_analyst_jobs table?

--INITIAL ATTEMPT:
SELECT COUNT(*)
FROM data_analyst_jobs;
--ANS: 1793

--ALT ANS:
SELECT *
FROM data_analyst_jobs;

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

--ALT SOLUTION:
SELECT *
FROM data_analyst_jobs
WHERE 
	location = 'TN'
	AND star_rating >4;
	
--5.How many postings in the dataset have a review count between 500 and 1000?

--INITIAL ATTEMPT:
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE 
	review_count BETWEEN 500 AND 1000;
--ANS: 151
	
--ALT SOLUTION:
SELECT *
FROM data_analyst_jobs
WHERE 
	review_count BETWEEN 500 AND 1000;

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

--INTIAL ATTEMPT:
SELECT 
	company
	, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
	AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating ASC; 
--ANS: 40

--CORRECT QUERY:
SELECT 
	company
	, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
	HAVING MIN(review_count) > 5000;
--ANS: 40


-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

--INITIAL ATTEMPT:
SELECT 
	company
	, AVG(star_rating) AS avg_star
	, review_count
	, location
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company, review_count, location
ORDER BY avg_star DESC;
--ANS: General Motors (4.20)

--CORRECT QUERY:
SELECT 
	company
	, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
	HAVING MIN(review_count) > 5000
ORDER BY avg_star_rating DESC;
--CORRECT ANS: top 6 tied ("Nike","Unilever","General Motors" "Kaiser Permanente", Microsoft, American Express). 4.19 avg_star_rating

--11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?

-- SELECT COUNT(title) AS title_count
-- FROM data_analyst_jobs
-- WHERE title LIKE '%Analyst%';
-- --ANS Pt. 1: 1636

-- SELECT COUNT(DISTINCT title) AS title_count
-- FROM data_analyst_jobs
-- WHERE title LIKE '%Analyst%';
-- --ANS Pt. 2: 754

--CORRECT QUERY PT 1:
SELECT COUNT(title) AS title_count
FROM data_analyst_jobs
WHERE title iLIKE '%analyst%';
--CORRECT ANS: 1669

--CORRECT QUERY PT 2:
SELECT COUNT(DISTINCT title) AS title_count
FROM data_analyst_jobs
WHERE title iLIKE '%analyst%';
--CORRECT ANS: 774

--12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

--INTIAL ATTEMPT:
-- SELECT title 
-- FROM data_analyst_jobs
-- WHERE title NOT LIKE '%Analyst%'
-- 	AND title NOT LIKE '%Analytics%';
-- -- ANS: 39. Not case-sensitive 

-- CORRECT QUERY:
SELECT DISTINCT title 
FROM data_analyst_jobs
WHERE title NOT iLIKE '%analyst%'
	AND title NOT iLIKE '%analytics%';
--CORRECT ANS: 4. Tableau

--**BONUS:** You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--Disregard any postings where the domain is NULL. 
--Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
 -- Which three industries are in the top 3 on this list? How many jobs have been listed for more than 3 weeks for each of the top 3?

--SECOND ATTEMPT:
 SELECT 
	DISTINCT domain AS industry
	, COUNT(skill) AS sql_skill
 FROM data_analyst_jobs
 WHERE days_since_posting >21
 	AND domain IS NOT NULL
	AND skill iLIKE '%sql%'
GROUP BY industry
ORDER BY sql_skill DESC, industry;
 --ANS: Internet and Software (62), Banks and Financial Services (61), Consulting and Business Services (57).
 --Query Time: 0.268 ms**

-- --Doublechecking Answer:
-- SELECT title, domain, skill, days_since_posting
-- FROM data_analyst_jobs
-- WHERE domain ='Internet and Software'
-- 	AND skill iLIKE '%sql%'
-- 	AND days_since_posting>21
-- ORDER BY domain, days_since_posting;

--ALT ANSWER:
SELECT COUNT(d.title), d.domain
FROM data_analyst_jobs AS d
WHERE d.days_since_posting >21 
	AND d.title IS NOT NULL 
	AND d.domain IS NOT NULL
	AND skill ILIKE '%SQL%'
GROUP BY d.domain
ORDER BY COUNT(d.title) DESC;
--Query Time = 0.159 ms**
 