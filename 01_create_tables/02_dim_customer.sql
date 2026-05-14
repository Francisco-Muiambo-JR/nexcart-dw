-- ============================================================
-- Ficheiro: 02_dim_customer.sql
-- Descrição: Criação da tabela de dimensão de clientes
-- Projecto: NexCart Data Warehouse
-- ============================================================

CREATE TABLE dim_customer (
    customer_key      SERIAL        PRIMARY KEY,
    customer_id       VARCHAR(50)   NOT NULL UNIQUE,
    full_name         VARCHAR(100),
    email             VARCHAR(150),
    phone             VARCHAR(20),
    registration_date DATE,
    segment           VARCHAR(30)   CHECK (segment IN ('Bronze','Silver','Gold','Platinum')),
    is_active         BOOLEAN       NOT NULL DEFAULT TRUE,
    valid_from        DATE          NOT NULL DEFAULT CURRENT_DATE,
    valid_to          DATE,
    is_current        BOOLEAN       NOT NULL DEFAULT TRUE
);