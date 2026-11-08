USE cleaning_mini;
CREATE VIEW v_detail AS
SELECT
    j.job_id,
    j.scheduled_at,
    j.job_status,
    c.customer_id,
    c.customer_name,
    w.worker_id,
    w.full_name AS worker_name,
    t.team_id,
    t.team_name,
    r.cost
FROM jobs j
JOIN customers c ON c.customer_id = j.customer_id
JOIN workers   w ON w.worker_id   = j.worker_id
JOIN teams     t ON t.team_id     = w.team_id
LEFT JOIN acceptance_records r ON r.job_id = j.job_id;

CREATE VIEW v_group_summary AS
SELECT
    t.team_id,
    t.team_name,
    COUNT(j.job_id)                                                  AS total_jobs,
    COALESCE(SUM(CASE WHEN j.job_status = 'Completed' THEN 1 END), 0) AS completed_jobs,
    COALESCE(SUM(CASE WHEN j.job_status = 'Cancelled' THEN 1 END), 0) AS cancelled_jobs,
    COALESCE(SUM(r.cost), 0)                                         AS total_cost
FROM teams t
LEFT JOIN workers w            ON w.team_id = t.team_id
LEFT JOIN jobs j               ON j.worker_id = w.worker_id
LEFT JOIN acceptance_records r ON r.job_id = j.job_id
GROUP BY t.team_id, t.team_name;

CREATE VIEW v_debt AS
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(cc.total_cost, 0) AS total_cost,
    COALESCE(pp.total_paid, 0) AS total_paid,
    COALESCE(cc.total_cost, 0) - COALESCE(pp.total_paid, 0) AS debt
FROM customers c
LEFT JOIN (
    SELECT j.customer_id, SUM(r.cost) AS total_cost
    FROM jobs j
    JOIN acceptance_records r ON r.job_id = j.job_id
    GROUP BY j.customer_id
) cc ON cc.customer_id = c.customer_id
LEFT JOIN (
    SELECT j.customer_id, SUM(p.amount) AS total_paid
    FROM jobs j
    JOIN payments p ON p.job_id = j.job_id
    GROUP BY j.customer_id
) pp ON pp.customer_id = c.customer_id;
SELECT * FROM v_detail;
SELECT * FROM v_group_summary;
SELECT * FROM v_debt;