-- ============================================================
-- Ficheiro: 02_top_produtos.sql
-- Descrição: Performance de produtos por receita e margem
-- KPI: receita líquida, margem bruta, ranking por categoria
-- Projecto: NexCart Data Warehouse
-- ============================================================

SELECT
    p.category                          AS categoria,
    p.product_name                      AS produto,
    p.brand                             AS marca,
    COUNT(DISTINCT f.order_id)          AS total_pedidos,
    SUM(f.quantity)                     AS unidades_vendidas,
    ROUND(SUM(f.net_revenue), 2)        AS receita_liquida,
    ROUND(SUM(f.gross_margin), 2)       AS margem_bruta,
    ROUND(AVG(f.discount_pct), 2)       AS desconto_medio,
    RANK() OVER (
        PARTITION BY p.category
        ORDER BY SUM(f.net_revenue) DESC
    )                                   AS ranking_categoria
FROM fact_order_items f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category, p.product_name, p.brand
ORDER BY p.category, ranking_categoria;