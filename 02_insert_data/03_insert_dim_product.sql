-- ============================================================
-- Ficheiro: 03_insert_dim_product.sql
-- Descrição: Inserção de dados na dimensão de produtos
-- Projecto: NexCart Data Warehouse
-- ============================================================

INSERT INTO dim_product
(product_id, product_name, category, subcategory, brand, unit_cost)
VALUES
('P001', 'iPhone 14 128GB',          'Electronica',  'Smartphones',    'Apple',      38400.00),
('P002', 'Samsung Galaxy A54',        'Electronica',  'Smartphones',    'Samsung',    14100.00),
('P003', 'Laptop Dell Inspiron 15',   'Electronica',  'Computadores',   'Dell',       30700.00),
('P004', 'Auriculares Sony WH-1000',  'Electronica',  'Audio',          'Sony',        5400.00),
('P005', 'Tablet Samsung Tab A8',     'Electronica',  'Tablets',        'Samsung',    11500.00),
('P006', 'Camisola Nike Dri-FIT',     'Vestuario',    'Desporto',       'Nike',        1150.00),
('P007', 'Calcas Levis 501',          'Vestuario',    'Casual',         'Levis',       2050.00),
('P008', 'Tenis Adidas Ultraboost',   'Vestuario',    'Calcado',        'Adidas',      4800.00),
('P009', 'Vestido Zara Floral',       'Vestuario',    'Feminino',       'Zara',        1400.00),
('P010', 'Mochila Samsonite 30L',     'Vestuario',    'Acessorios',     'Samsonite',   2880.00),
('P011', 'Frigorifico LG 350L',       'Casa',         'Electrodomest.', 'LG',         20480.00),
('P012', 'Microondas Samsung 23L',    'Casa',         'Electrodomest.', 'Samsung',     4160.00),
('P013', 'Aspirador Dyson V11',       'Casa',         'Limpeza',        'Dyson',      17920.00),
('P014', 'Cadeira de Escritorio',     'Casa',         'Mobiliario',     'Generic',     6080.00),
('P015', 'Conjunto Roupa de Cama',    'Casa',         'Texteis',        'Generic',     1600.00);