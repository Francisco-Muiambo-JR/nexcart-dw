-- ============================================================
-- Ficheiro: 04_dim_location.sql
-- Descrição: Criação da tabela de dimensão de localização
-- Projecto: NexCart Data Warehouse
-- ============================================================

CREATE TABLE dim_location (
    location_key    SERIAL        PRIMARY KEY,
    city            VARCHAR(100),
    province        VARCHAR(100),
    country         VARCHAR(100)  NOT NULL,
    region          VARCHAR(50),
    postal_code     VARCHAR(20)
);