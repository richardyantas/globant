WITH DepartmentStats AS (
    SELECT
        D.id AS department_id,
        D.department AS department_name,
        COUNT(E.id) AS num_employees
    FROM
        employee E
    JOIN
        department D ON E.department_id = D.id
    WHERE
        strftime('%Y', E.datetime) = '2021'
    GROUP BY
        D.id, D.department
),
AvgStats AS (
    SELECT
        AVG(num_employees) AS avg_employees
    FROM
        DepartmentStats
)
SELECT
    DS.department_id,
    DS.department_name,
    DS.num_employees
FROM
    DepartmentStats DS
JOIN
    AvgStats A ON DS.num_employees > A.avg_employees
ORDER BY
    DS.num_employees DESC;
