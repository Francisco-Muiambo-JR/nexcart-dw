# NexCart Data Warehouse 🛒

Projecto de Data Engineering e Analytics simulando uma plataforma de e-commerce moçambicana.

## 📋 Descrição

Pipeline completo de dados construído com PostgreSQL, cobrindo modelagem dimensional (Star Schema), queries analíticas avançadas e visualização interactiva.

## 🏗️ Arquitectura

- **Base de dados:** PostgreSQL 16
- **Modelagem:** Star Schema (Kimball)
- **Visualização:** Streamlit + Plotly (em desenvolvimento)

## 📁 Estrutura do Projecto
nexcart_dw/
├── 01_create_tables/    # Criação das tabelas do Data Warehouse
├── 02_insert_data/      # Inserção de dados nas tabelas
├── 03_queries/          # Queries analíticas por KPI
└── 04_views/            # Views analíticas

## 📊 KPIs Analisados

- Receita mensal e crescimento MoM
- Top produtos por categoria
- Performance geográfica por cidade e região
- Análise por canal de venda

## 🛠️ Tecnologias

- PostgreSQL 16
- SQL (Window Functions, CTEs, Views)
- Git & GitHub

## 👤 Autor

Francisco Muiambo — Analista de Dados