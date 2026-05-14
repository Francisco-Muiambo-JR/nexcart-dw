-- ============================================================
-- Ficheiro: 03_dim_product.sql
-- Descrição: Criação da tabela de dimensão de produtos
-- Projecto: NexCart Data Warehouse
-- ============================================================

CREATE TABLE dim_product (
    product_key     SERIAL        PRIMARY KEY,
    product_id      VARCHAR(50)   NOT NULL,
    product_name    VARCHAR(200)  NOT NULL,
    category        VARCHAR(100)  NOT NULL,
    subcategory     VARCHAR(100),
    brand           VARCHAR(100),
    unit_cost       NUMERIC(10,2) NOT NULL CHECK (unit_cost >= 0),
    is_active       BOOLEAN       NOT NULL DEFAULT TRUE,
    valid_from      DATE          NOT NULL DEFAULT CURRENT_DATE,
    valid_to        DATE,
    is_current      BOOLEAN       NOT NULL DEFAULT TRUE
);