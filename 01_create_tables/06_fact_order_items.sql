-- ============================================================
-- Ficheiro: 06_fact_order_items.sql
-- Descrição: Criação da tabela de factos de vendas
-- Projecto: NexCart Data Warehouse
-- ============================================================

CREATE TABLE fact_order_items (
    order_item_id   BIGSERIAL     PRIMARY KEY,
    date_key        INTEGER       NOT NULL REFERENCES dim_date(date_key),
    customer_key    INTEGER       NOT NULL REFERENCES dim_customer(customer_key),
    product_key     INTEGER       NOT NULL REFERENCES dim_product(product_key),
    location_key    INTEGER       NOT NULL REFERENCES dim_location(location_key),
    channel_key     INTEGER       NOT NULL REFERENCES dim_channel(channel_key),
    order_id        VARCHAR(50)   NOT NULL,
    order_item_seq  SMALLINT      NOT NULL DEFAULT 1,
    quantity        SMALLINT      NOT NULL CHECK (quantity > 0),
    unit_price      NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    discount_pct    NUMERIC(5,2)  NOT NULL DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100),
    cost_of_goods   NUMERIC(12,2),
    gross_revenue   NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    net_revenue     NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price * (1 - discount_pct/100)) STORED,
    gross_margin    NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price * (1 - discount_pct/100) - cost_of_goods) STORED,
    created_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_order_item UNIQUE (order_id, order_item_seq)
);