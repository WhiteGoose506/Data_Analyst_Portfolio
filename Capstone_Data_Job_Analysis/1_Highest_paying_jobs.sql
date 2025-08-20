/*
QUESTION 1: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

--With CTE (For practice purpose only)
;

WITH top_ten_highest_pay AS
(
    SELECT
        company_id,
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date
    FROM
        Job_postings_fact
    WHERE 
        (job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL)
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    c.name AS company_name,
    tt.job_title AS Job_title,
    tt.salary_year_avg AS ten_highest_paid_salary,
    tt.job_posted_date
FROM 
    company_dim AS c
INNER JOIN top_ten_highest_pay AS tt ON c.company_id = tt.company_id
ORDER BY
salary_year_avg DESC,
company_name ASC;

/*  - CTE are commonly used in real world with multiple query within same file.
    - Within the CTE Select statement, I could have omited out other columns and focus on the specifics
        to be used in final SELECT statement, but I simply would like to check if my WHERE filter clause 
        is working properly to ensure my CTE runs as I have intended.
    - Used RIGHT JOIN initially, since I only wanted specific details only from top_ten_highest_pay table, 
        but swapped to INNER JOIN since it disregards the unnecessary rows either way.
    - In the outer query, I selected only the necessary column to display since my CTE WHERE is working as intended.
*/;



--Without CTE
;

SELECT
    c.name AS company_name,
    jp.company_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact AS jp
INNER JOIN company_dim AS c ON jp.company_id = c.company_id
WHERE
    (job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL)
ORDER BY
    salary_year_avg DESC
LIMIT 10;


/* me:  Above query is a straight-forward and direct approach.
        Useful for simple queries, assuming if not being referenced to a lot.
*/
;