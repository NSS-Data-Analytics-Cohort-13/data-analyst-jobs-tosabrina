SELECT title, MAX(review_count) AS top_review_count
FROM data_analyst_jobs
GROUP BY title
ORDER BY top_review_count DESC;