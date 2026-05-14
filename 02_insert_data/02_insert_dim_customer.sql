-- ============================================================
-- Ficheiro: 02_insert_dim_customer.sql
-- Descrição: Inserção de dados na dimensão de clientes
-- Projecto: NexCart Data Warehouse
-- ============================================================

INSERT INTO dim_customer 
(customer_id, full_name, email, phone, registration_date, segment, is_active)
VALUES
('C001', 'Ana Silva',        'ana.silva@email.com',      '+258 84 111 0001', '2023-01-15', 'Gold',     TRUE),
('C002', 'Carlos Machava',   'carlos.m@email.com',       '+258 82 222 0002', '2023-02-20', 'Silver',   TRUE),
('C003', 'Fatima Tembe',     'fatima.t@email.com',       '+258 84 333 0003', '2023-03-10', 'Platinum', TRUE),
('C004', 'Joao Mondlane',    'joao.m@email.com',         '+258 82 444 0004', '2023-04-05', 'Bronze',   TRUE),
('C005', 'Lucia Cossa',      'lucia.c@email.com',        '+258 84 555 0005', '2023-05-18', 'Silver',   TRUE),
('C006', 'Manuel Sitoe',     'manuel.s@email.com',       '+258 82 666 0006', '2023-06-22', 'Gold',     TRUE),
('C007', 'Rosa Nhampule',    'rosa.n@email.com',         '+258 84 777 0007', '2023-07-30', 'Bronze',   TRUE),
('C008', 'Pedro Bila',       'pedro.b@email.com',        '+258 82 888 0008', '2023-08-14', 'Silver',   TRUE),
('C009', 'Teresa Guambe',    'teresa.g@email.com',       '+258 84 999 0009', '2023-09-25', 'Platinum', TRUE),
('C010', 'Antonio Mavie',    'antonio.m@email.com',      '+258 82 100 0010', '2023-10-08', 'Gold',     TRUE),
('C011', 'Beatriz Nuvunga',  'beatriz.n@email.com',      '+258 84 110 0011', '2023-11-12', 'Silver',   TRUE),
('C012', 'David Chissano',   'david.c@email.com',        '+258 82 120 0012', '2023-12-01', 'Bronze',   FALSE),
('C013', 'Elena Macuacua',   'elena.m@email.com',        '+258 84 130 0013', '2024-01-09', 'Gold',     TRUE),
('C014', 'Francisco Langa',  'francisco.l@email.com',    '+258 82 140 0014', '2024-02-14', 'Silver',   TRUE),
('C015', 'Gloria Matsimbe',  'gloria.m@email.com',       '+258 84 150 0015', '2024-03-20', 'Platinum', TRUE);