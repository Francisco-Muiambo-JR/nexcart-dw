-- ============================================================
-- Ficheiro: 04_insert_dim_location.sql
-- Descrição: Inserção de dados na dimensão de localização
-- Projecto: NexCart Data Warehouse
-- ============================================================

INSERT INTO dim_location
(city, province, country, region)
VALUES
('Maputo',          'Maputo',           'Mocambique', 'Sul'),
('Matola',          'Maputo',           'Mocambique', 'Sul'),
('Beira',           'Sofala',           'Mocambique', 'Centro'),
('Nampula',         'Nampula',          'Mocambique', 'Norte'),
('Quelimane',       'Zambezia',         'Mocambique', 'Centro'),
('Tete',            'Tete',             'Mocambique', 'Centro'),
('Chimoio',         'Manica',           'Mocambique', 'Centro'),
('Nacala',          'Nampula',          'Mocambique', 'Norte'),
('Lichinga',        'Niassa',           'Mocambique', 'Norte'),
('Xai-Xai',         'Gaza',             'Mocambique', 'Sul');