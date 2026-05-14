-- ============================================================
-- Ficheiro: 01_insert_dim_date.sql
-- Descrição: Inserção de dados na dimensão de datas
-- Projecto: NexCart Data Warehouse
-- ============================================================

INSERT INTO dim_date (date_key, full_date, year, quarter, month, month_name, week_of_year, day_of_month, day_name, is_weekend, is_holiday)
SELECT
    TO_CHAR(d, 'YYYYMMDD')::INTEGER,
    d,
    EXTRACT(YEAR FROM d)::SMALLINT,
    EXTRACT(QUARTER FROM d)::SMALLINT,
    EXTRACT(MONTH FROM d)::SMALLINT,
    TO_CHAR(d, 'Month'),
    EXTRACT(WEEK FROM d)::SMALLINT,
    EXTRACT(DAY FROM d)::SMALLINT,
    TO_CHAR(d, 'Day'),
    EXTRACT(ISODOW FROM d) IN (6, 7),
    FALSE
FROM GENERATE_SERIES('2023-01-01'::DATE, '2024-12-31'::DATE, '1 day') AS d;