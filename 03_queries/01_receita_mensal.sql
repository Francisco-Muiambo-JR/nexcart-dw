-- ============================================================
-- Ficheiro: 01_receita_mensal.sql
-- Descrição: Receita total por mês e ano
-- KPI: GMV mensal, ticket médio, total de pedidos
-- Projecto: NexCart Data Warehouse
-- ============================================================

SELECT
    d.year                          AS ano,
    d.month                         AS mes_num,
    TRIM(d.month_name)              AS mes,
    COUNT(DISTINCT f.order_id)      AS total_pedidos,
    SUM(f.quantity)                 AS total_unidades,
    ROUND(SUM(f.net_revenue), 2)    AS receita_liquida,
    ROUND(AVG(f.net_revenue), 2)    AS ticket_medio
FROM fact_order_items f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;