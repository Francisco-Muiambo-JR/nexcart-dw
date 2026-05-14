-- ============================================================
-- Ficheiro: 01_views.sql
-- Descrição: Views analíticas do projecto NexCart
-- Projecto: NexCart Data Warehouse
-- ============================================================

-- View 1: Receita mensal
CREATE VIEW vw_receita_mensal AS
SELECT
    d.year                              AS ano,
    d.month                             AS mes_num,
    TRIM(d.month_name)                  AS mes,
    COUNT(DISTINCT f.order_id)          AS total_pedidos,
    SUM(f.quantity)                     AS total_unidades,
    ROUND(SUM(f.net_revenue), 2)        AS receita_liquida,
    ROUND(SUM(f.gross_margin), 2)       AS margem_bruta,
    ROUND(AVG(f.net_revenue), 2)        AS ticket_medio,
    ROUND(SUM(f.gross_margin) * 100.0 /
        SUM(f.net_revenue), 2)          AS margem_pct
FROM fact_order_items f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name;

-- View 2: Performance por produto
CREATE VIEW vw_performance_produtos AS
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
GROUP BY p.category, p.product_name, p.brand;

-- View 3: Performance geográfica
CREATE VIEW vw_performance_geografica AS
SELECT
    l.region                            AS regiao,
    l.city                              AS cidade,
    ch.channel_type                     AS tipo_canal,
    ch.channel_name                     AS canal,
    COUNT(DISTINCT f.order_id)          AS total_pedidos,
    SUM(f.quantity)                     AS unidades_vendidas,
    ROUND(SUM(f.net_revenue), 2)        AS receita_liquida,
    ROUND(SUM(f.gross_margin), 2)       AS margem_bruta,
    ROUND(AVG(f.unit_price), 2)         AS ticket_medio
FROM fact_order_items f
JOIN dim_location l  ON f.location_key = l.location_key
JOIN dim_channel ch  ON f.channel_key  = ch.channel_key
GROUP BY l.region, l.city, ch.channel_type, ch.channel_name;