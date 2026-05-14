# ============================================================
# Ficheiro: dashboard.py
# Descrição: Dashboard interactivo NexCart
# Tecnologias: Streamlit, Plotly, PostgreSQL
# Projecto: NexCart Data Warehouse
# ============================================================

import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from sqlalchemy import create_engine

# ============================================================
# CONFIGURAÇÃO DA PÁGINA
# ============================================================

st.set_page_config(
    page_title="NexCart Analytics",
    page_icon="🛒",
    layout="wide"
)

# ============================================================
# LIGAÇÃO À BASE DE DADOS
# ============================================================

@st.cache_resource
def get_engine():
    return create_engine(
        "postgresql+psycopg2://postgres:Muiambo2002@localhost:5432/nexcart_dw"
    )

engine = get_engine()

# ============================================================
# FUNÇÕES DE CARREGAMENTO DE DADOS
# ============================================================

@st.cache_data
def load_receita_mensal():
    query = """
        SELECT ano, mes_num, mes, total_pedidos,
               total_unidades, receita_liquida,
               margem_bruta, ticket_medio, margem_pct
        FROM vw_receita_mensal
        ORDER BY ano, mes_num
    """
    return pd.read_sql(query, engine)

@st.cache_data
def load_produtos():
    query = """
        SELECT categoria, produto, marca, total_pedidos,
               unidades_vendidas, receita_liquida,
               margem_bruta, desconto_medio, ranking_categoria
        FROM vw_performance_produtos
        ORDER BY categoria, ranking_categoria
    """
    return pd.read_sql(query, engine)

@st.cache_data
def load_geografica():
    query = """
        SELECT regiao, cidade, tipo_canal, canal,
               total_pedidos, unidades_vendidas,
               receita_liquida, margem_bruta, ticket_medio
        FROM vw_performance_geografica
        ORDER BY receita_liquida DESC
    """
    return pd.read_sql(query, engine)

# ============================================================
# CARREGAR DADOS
# ============================================================

df_receita   = load_receita_mensal()
df_produtos  = load_produtos()
df_geo       = load_geografica()

# ============================================================
# CABEÇALHO
# ============================================================

st.title("🛒 NexCart Analytics Dashboard")
st.markdown("**Plataforma de E-Commerce — Moçambique**")
st.divider()

# ============================================================
# KPIs PRINCIPAIS
# ============================================================

receita_total  = df_receita["receita_liquida"].sum()
margem_total   = df_receita["margem_bruta"].sum()
total_pedidos  = df_receita["total_pedidos"].sum()
ticket_medio   = df_receita["ticket_medio"].mean()

col1, col2, col3, col4 = st.columns(4)

col1.metric("💰 Receita Total",    f"MT {receita_total:,.0f}")
col2.metric("📈 Margem Bruta",     f"MT {margem_total:,.0f}")
col3.metric("🛍️ Total Pedidos",    f"{total_pedidos:,.0f}")
col4.metric("🎯 Ticket Médio",     f"MT {ticket_medio:,.0f}")

st.divider()

# ============================================================
# GRÁFICO 1 — RECEITA MENSAL
# ============================================================

st.subheader("📅 Receita Mensal")

df_receita["periodo"] = df_receita["mes"] + " " + df_receita["ano"].astype(str)

fig_receita = px.bar(
    df_receita,
    x="periodo",
    y="receita_liquida",
    color="ano",
    title="Receita Líquida por Mês",
    labels={"receita_liquida": "Receita (MT)", "periodo": "Período"},
    color_discrete_sequence=px.colors.qualitative.Set2
)
fig_receita.update_layout(xaxis_tickangle=-45)
st.plotly_chart(fig_receita, use_container_width=True)

st.divider()

# ============================================================
# GRÁFICO 2 — TOP PRODUTOS
# ============================================================

st.subheader("🏆 Performance de Produtos")

col1, col2 = st.columns(2)

with col1:
    fig_produtos = px.bar(
        df_produtos.sort_values("receita_liquida", ascending=True).tail(10),
        x="receita_liquida",
        y="produto",
        orientation="h",
        color="categoria",
        title="Top 10 Produtos por Receita",
        labels={"receita_liquida": "Receita (MT)", "produto": "Produto"}
    )
    st.plotly_chart(fig_produtos, use_container_width=True)

with col2:
    fig_categoria = px.pie(
        df_produtos.groupby("categoria")["receita_liquida"].sum().reset_index(),
        values="receita_liquida",
        names="categoria",
        title="Receita por Categoria",
        color_discrete_sequence=px.colors.qualitative.Set2
    )
    st.plotly_chart(fig_categoria, use_container_width=True)

st.divider()

# ============================================================
# GRÁFICO 3 — PERFORMANCE GEOGRÁFICA
# ============================================================

st.subheader("🗺️ Performance Geográfica")

df_cidade = df_geo.groupby("cidade")["receita_liquida"].sum().reset_index()

fig_geo = px.bar(
    df_cidade.sort_values("receita_liquida", ascending=True),
    x="receita_liquida",
    y="cidade",
    orientation="h",
    title="Receita por Cidade",
    labels={"receita_liquida": "Receita (MT)", "cidade": "Cidade"},
    color="receita_liquida",
    color_continuous_scale="Blues"
)
st.plotly_chart(fig_geo, use_container_width=True)

st.divider()

# ============================================================
# GRÁFICO 4 — CANAIS DE VENDA
# ============================================================

st.subheader("📡 Canais de Venda")

df_canal = df_geo.groupby("canal")["receita_liquida"].sum().reset_index()

fig_canal = px.pie(
    df_canal,
    values="receita_liquida",
    names="canal",
    title="Receita por Canal de Venda",
    color_discrete_sequence=px.colors.qualitative.Pastel
)
st.plotly_chart(fig_canal, use_container_width=True)