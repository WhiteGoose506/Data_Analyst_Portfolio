/*
QUESTION 3: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/;

SELECT 
    jp.job_title_short,
    s.skills,
    SUM(CASE WHEN jp.job_work_from_home = TRUE THEN 1 ELSE 0 END) AS remote_job,
    SUM(CASE WHEN jp.job_work_from_home = FALSE THEN 1 ELSE 0 END) AS non_remote_job
FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    jp.job_title_short,
    s.skills
ORDER BY
    remote_job DESC,
    non_remote_job DESC
limit 5;


/*  - In order to display the job_title_short in association with the skills(basically name of the skill),
        we would have link up the three tables through an INNER JOIN clause
    - Right now, within the WHERE clause, it is only filtering for 'Data Analyst', therefore it returns
        all the type of work (remote or non-remote) available, but what if the applicants have preferences?
    - In order to segregate between remote or non-remote, SUM(CASE WHEN...THEN 1 ELSE 0 END) has to be used.
        COUNT() only sums the non-null value, Boolean Logic like TRUE or FALSE are considered non_null,
        therefore COUNT() will include sum upindiscriminately. Hence I countered with using an numeric values,
        for summation.
*/;