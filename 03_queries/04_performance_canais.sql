-- ============================================================
-- Ficheiro: 04_performance_canais.sql
-- Descrição: Performance de vendas por canal
-- KPI: receita líquida, total pedidos, ticket médio por canal
-- Projecto: NexCart Data Warehouse
-- ============================================================

SELECT
    ch.channel_type                     AS tipo,
    ch.channel_name                     AS canal,
    COUNT(DISTINCT f.order_id)          AS total_pedidos,
    SUM(f.quantity)                     AS unidades_vendidas,
    ROUND(SUM(f.net_revenue), 2)        AS receita_liquida,
    ROUND(AVG(f.unit_price), 2)         AS ticket_medio
FROM fact_order_items f
JOIN dim_channel ch ON f.channel_key = ch.channel_key
GROUP BY ch.channel_type, ch.channel_name
ORDER BY receita_liquida DESC;