/*
Question 4: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/;


SELECT 
    s.skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary,
    SUM(CASE WHEN jp.job_work_from_home = TRUE THEN 1 ELSE 0 END) AS remote_job,
    SUM(CASE WHEN jp.job_work_from_home = FALSE THEN 1 ELSE 0 END) AS non_remote_job
FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE
    (job_title_short = 'Data Analyst' AND
    jp.salary_year_avg IS NOT NULL)
GROUP BY
    s.skills
ORDER BY
    avg_salary DESC
;


/*
- Pretty straight forward
*/;