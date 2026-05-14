-- ============================================================
-- Ficheiro: 05_crescimento_mensal.sql
-- Descrição: Crescimento de receita mês a mês
-- KPI: variação absoluta e percentual de receita mensal
-- Projecto: NexCart Data Warehouse
-- ============================================================

WITH receita_mensal AS (
    SELECT
        d.year                              AS ano,
        d.month                             AS mes,
        TRIM(d.month_name)                  AS mes_nome,
        ROUND(SUM(f.net_revenue), 2)        AS receita
    FROM fact_order_items f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.month, d.month_name
)
SELECT
    ano,
    mes_nome                                AS mes,
    receita                                 AS receita_actual,
    LAG(receita) OVER (
        ORDER BY ano, mes
    )                                       AS receita_mes_anterior,
    ROUND(receita - LAG(receita) OVER (
        ORDER BY ano, mes
    ), 2)                                   AS variacao,
    ROUND((receita - LAG(receita) OVER (
        ORDER BY ano, mes
    )) * 100.0 / LAG(receita) OVER (
        ORDER BY ano, mes
    ), 2)                                   AS crescimento_pct
FROM receita_mensal
ORDER BY ano, mes;