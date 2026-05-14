-- ============================================================
-- Ficheiro: 03_performance_geografica.sql
-- Descrição: Performance de vendas por cidade e região
-- KPI: receita líquida, margem bruta, ticket médio por cidade
-- Projecto: NexCart Data Warehouse
-- ============================================================

SELECT
    l.region                            AS regiao,
    l.city                              AS cidade,
    COUNT(DISTINCT f.order_id)          AS total_pedidos,
    SUM(f.quantity)                     AS unidades_vendidas,
    ROUND(SUM(f.net_revenue), 2)        AS receita_liquida,
    ROUND(SUM(f.gross_margin), 2)       AS margem_bruta,
    ROUND(AVG(f.unit_price), 2)         AS ticket_medio
FROM fact_order_items f
JOIN dim_location l ON f.location_key = l.location_key
GROUP BY l.region, l.city
ORDER BY receita_liquida DESC;