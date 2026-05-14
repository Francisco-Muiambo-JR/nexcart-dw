-- ============================================================
-- Ficheiro: 05_dim_channel.sql
-- Descrição: Criação da tabela de dimensão de canais de venda
-- Projecto: NexCart Data Warehouse
-- ============================================================

CREATE TABLE dim_channel (
    channel_key     SERIAL        PRIMARY KEY,
    channel_name    VARCHAR(50)   NOT NULL UNIQUE,
    channel_type    VARCHAR(30)   NOT NULL CHECK (channel_type IN ('Online','Offline','Mobile')),
    description     VARCHAR(200)
);