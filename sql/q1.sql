SELECT
    D.department,
    J.job,
    COUNT(E.id) AS num_employees,
    CASE
        WHEN MONTH(E.datetime) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(E.datetime) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(E.datetime) BETWEEN 7 AND 9 THEN 'Q3'
        WHEN MONTH(E.datetime) BETWEEN 10 AND 12 THEN 'Q4'
    END AS quarter
FROM
    employee E
JOIN
    department D ON E.department_id = D.id
JOIN
    job J ON E.job_id = J.id
WHERE
    YEAR(E.datetime) = 2021
GROUP BY
    D.department,
    J.job,
    quarter
ORDER BY
    D.department,
    J.job;
