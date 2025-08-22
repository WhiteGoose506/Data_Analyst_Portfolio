/*
QUESTION 2: What skills are required for the top ten paying data analyst job(remote) ?
- Use the previous question query(non-CTE) and built upon it
- Add the specific skills required for the roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop that align with top salaries
*/;


-- Use CTE since it dervies from previous result and query --

WITH highest_paying_job AS
(
SELECT
    c.name AS company_name,
    job_id,
    job_title,
    salary_year_avg
FROM
    job_postings_fact AS jp
INNER JOIN company_dim AS c ON jp.company_id = c.company_id
WHERE
    (job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL)
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT
    hp.company_name,
    hp.job_title,
    STRING_AGG(DISTINCT s.skills, ', ') AS skills_required,
    hp.salary_year_avg
FROM
    highest_paying_job AS hp
INNER JOIN skills_job_dim AS sj ON hp.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
GROUP BY 
    hp.company_name,
    hp.job_title,
    hp.salary_year_avg
ORDER BY 
    salary_year_avg DESC,
    company_name DESC
;

/*
- In the outer query, the SELECT clause, I could simply use hp.* which highlights the whole SELECT within the CTE, 
    although I choose not to use * since I only want to display necessary information
    (for example, why display job_id if they are all the same for individual company?)
- The outer query initially was written: 
        SELECT
            hp.company_name AS company_name,
            hp.job_title,
            s.skills AS skill_required,
            hp.salary_year_avg
        FROM
            highest_paying_job AS hp
        INNER JOIN skills_job_dim AS sj ON hp.job_id = sj.job_id
        INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
        ORDER BY 
            salary_year_avg DESC,
            company_name DESC
        ;
    While it does show individual skills related to most paid jobs by the company,
    visually, repetitve rows are very messy and hard to find a pattern.
- Therefore grouping was the only way I could think off to lump the skills required by highly paid company.
- LEFT JOIN was initially used, sent back all the top 10 paying company, however,
     2 companies returned NULL in skill_required, making the data useless.
*/;