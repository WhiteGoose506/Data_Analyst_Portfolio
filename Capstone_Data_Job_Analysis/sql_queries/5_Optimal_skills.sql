/*
Question 5: What are the most optimal skills to learn (high demand + high paying skill)?
- Identify skills in high demand and associated with high average salaries for "Data Analyst".
- Concentrates on remote positions with specified salaries.
- Why? Target skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis.
*/;

WITH high_demand AS (
    SELECT 
        sj.skill_id,
        s.skills,
        COUNT(sj.job_id) AS demand
    FROM job_postings_fact AS jp
    INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE job_title_short = 'Data Analyst'
      AND jp.salary_year_avg IS NOT NULL
      AND jp.job_work_from_home = TRUE
    GROUP BY sj.skill_id, s.skills
),
high_paying_skill AS (
    SELECT 
        sj.skill_id,
        s.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS jp
    INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE job_title_short = 'Data Analyst'
      AND jp.salary_year_avg IS NOT NULL
      AND jp.job_work_from_home = TRUE
    GROUP BY sj.skill_id, s.skills
)
SELECT
    hd.skills,
    hd.demand,
    hps.avg_salary
FROM high_demand AS hd
INNER JOIN high_paying_skill AS hps 
    ON hd.skill_id = hps.skill_id
ORDER BY 
    hd.demand DESC,
    hps.avg_salary DESC
;

/*
- Combine the CTE from qns 3 and 4 respectivvely since they already covered high demand + high paying skill.
- Basically inner join on the linked columns skills_id to connect the two tables together.
- Just needs to be very careful with Syntax errors.
*/