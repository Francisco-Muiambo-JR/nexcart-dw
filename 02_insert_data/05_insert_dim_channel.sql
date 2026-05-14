-- ============================================================
-- Ficheiro: 05_insert_dim_channel.sql
-- Descrição: Inserção de dados na dimensão de canais de venda
-- Projecto: NexCart Data Warehouse
-- ============================================================

INSERT INTO dim_channel
(channel_name, channel_type, description)
VALUES
('Website',       'Online',  'Loja online via browser'),
('App Mobile',    'Mobile',  'Aplicacao mobile Android e iOS'),
('Loja Maputo',   'Offline', 'Loja fisica em Maputo'),
('Loja Beira',    'Offline', 'Loja fisica na Beira'),
('Loja Nampula',  'Offline', 'Loja fisica em Nampula');