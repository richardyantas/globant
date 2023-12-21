SELECT
    D.id AS department_id,
    D.department AS department_name,
    J.id AS job_id,
    J.job AS job_name,
    COUNT(E.id) AS num_employees,
    CASE
        WHEN strftime('%m', E.datetime) BETWEEN '01' AND '03' THEN 'Q1'
        WHEN strftime('%m', E.datetime) BETWEEN '04' AND '06' THEN 'Q2'
        WHEN strftime('%m', E.datetime) BETWEEN '07' AND '09' THEN 'Q3'
        WHEN strftime('%m', E.datetime) BETWEEN '10' AND '12' THEN 'Q4'
    END AS quarter
FROM
    employee E
JOIN
    department D ON E.department_id = D.id
JOIN
    job J ON E.job_id = J.id
WHERE
    strftime('%Y', E.datetime) = '2021'
GROUP BY
    D.id, D.department, J.id, J.job, quarter
ORDER BY
    department_name, job_name, quarter;
