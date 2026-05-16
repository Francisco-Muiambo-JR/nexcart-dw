# 🛒 NexCart Analytics — E-Commerce Data Warehouse

Dashboard interactivo de analytics para uma plataforma de e-commerce moçambicana, construído com PostgreSQL, Python e Streamlit.

## 🚀 Demo ao Vivo

👉 **[Ver Dashboard](https://nexcart-dw-spvkaflavxbvdfbhj8rb32.streamlit.app/)**

## 📋 Sobre o Projecto

Projecto completo de Data Engineering e Analytics que simula o ambiente de dados de uma empresa de e-commerce. Cobre todo o ciclo — desde a modelagem dimensional até à visualização interactiva em produção.

## 🏗️ Arquitectura
Dados Transaccionais → Star Schema (PostgreSQL) → Views Analíticas → Dashboard (Streamlit)

### Star Schema
- **fact_order_items** — tabela de factos com métricas de vendas
- **dim_date** — dimensão temporal com 731 dias
- **dim_customer** — dimensão de clientes com segmentação RFM
- **dim_product** — dimensão de produtos com SCD Type 2
- **dim_location** — dimensão geográfica com 10 cidades moçambicanas
- **dim_channel** — dimensão de canais de venda

## 📊 KPIs Analisados

- Receita total e margem bruta em Metical (MZN)
- Crescimento mês a mês (MoM)
- Top produtos por categoria com ranking
- Performance geográfica por cidade e região
- Análise por canal de venda (Online, Mobile, Offline)
- Segmentação de clientes (Bronze, Silver, Gold, Platinum)

## 🛠️ Tecnologias

| Camada | Tecnologia |
|---|---|
| Base de dados | PostgreSQL 16 |
| Cloud DB | Neon (PostgreSQL serverless) |
| Modelagem | Star Schema (Kimball) |
| SQL Avançado | Window Functions, CTEs, Views |
| Backend | Python, SQLAlchemy, pandas |
| Dashboard | Streamlit, Plotly |
| Deploy | Streamlit Cloud |
| Versionamento | Git, GitHub |

## 📁 Estrutura do Projecto
nexcart_dw/
├── 01_create_tables/    # DDL das tabelas do Data Warehouse
├── 02_insert_data/      # Scripts de inserção de dados
├── 03_queries/          # Queries analíticas por KPI
├── 04_views/            # Views analíticas
├── dashboard.py         # Dashboard interactivo
└── requirements.txt     # Dependências Python

## 🔍 SQL Avançado Utilizado

- **Window Functions** — RANK(), LAG(), PARTITION BY
- **CTEs** — Common Table Expressions para queries complexas
- **Views** — camada semântica para análise de negócio
- **Colunas GENERATED** — cálculos automáticos de receita e margem
- **Constraints** — CHECK, UNIQUE, FOREIGN KEY para integridade referencial

## 📈 Funcionalidades do Dashboard

- Filtros interactivos por ano, categoria, região e canal
- 5 KPIs em tempo real
- Gráfico de receita mensal
- Top 10 produtos por receita
- Distribuição por categoria
- Mapa de performance por cidade
- Análise por canal de venda
- Segmentação de clientes
- Tabela de detalhe de transacções

## 👤 Autor

**Francisco Salomão Muiambo Jr**  
Analista de Dados  
📍 Maputo, Moçambique  

[![GitHub](https://img.shields.io/badge/GitHub-Francisco--Muiambo--JR-black?logo=github)](https://github.com/Francisco-Muiambo-JR)