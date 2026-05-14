-- ============================================================
-- Ficheiro: 01_dim_date.sql
-- Descrição: Criação da tabela de dimensão de datas
-- Projecto: NexCart Data Warehouse
-- ============================================================

CREATE TABLE dim_date (
    date_key        INTEGER     PRIMARY KEY,
    full_date       DATE        NOT NULL UNIQUE,
    year            SMALLINT    NOT NULL,
    quarter         SMALLINT    NOT NULL CHECK (quarter BETWEEN 1 AND 4),
    month           SMALLINT    NOT NULL CHECK (month BETWEEN 1 AND 12),
    month_name      VARCHAR(10) NOT NULL,
    week_of_year    SMALLINT    NOT NULL,
    day_of_month    SMALLINT    NOT NULL,
    day_name        VARCHAR(10) NOT NULL,
    is_weekend      BOOLEAN     NOT NULL DEFAULT FALSE,
    is_holiday      BOOLEAN     NOT NULL DEFAULT FALSE
);