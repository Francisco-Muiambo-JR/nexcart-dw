import streamlit as st
import pandas as pd
import plotly.express as px
from sqlalchemy import create_engine

st.set_page_config(page_title="NexCart Analytics", page_icon="🛒", layout="wide")

@st.cache_resource
def get_engine():
    db = st.secrets["database"]
    url = f"postgresql+psycopg2://{db['user']}:{db['password']}@{db['host']}:{db['port']}/{db['database']}?sslmode=require"
    return create_engine(url)

@st.cache_data
def load_dados(_engine):
    query = """
        SELECT
            f.order_id,
            d.full_date,
            d.year AS ano, d.month AS mes_num,
            TRIM(d.month_name) AS mes,
            c.full_name AS cliente, c.segment AS segmento,
            p.product_name AS produto, p.category AS categoria, p.brand AS marca,
            l.city AS cidade, l.region AS regiao,
            ch.channel_name AS canal, ch.channel_type AS tipo_canal,
            f.quantity AS quantidade, f.unit_price AS preco,
            f.discount_pct AS desconto, f.net_revenue AS receita_liquida,
            f.gross_margin AS margem_bruta
        FROM fact_order_items f
        JOIN dim_date     d  ON f.date_key     = d.date_key
        JOIN dim_customer c  ON f.customer_key = c.customer_key
        JOIN dim_product  p  ON f.product_key  = p.product_key
        JOIN dim_location l  ON f.location_key = l.location_key
        JOIN dim_channel  ch ON f.channel_key  = ch.channel_key
    """
    return pd.read_sql(query, _engine)

engine = get_engine()
df = load_dados(engine)

st.title("🛒 NexCart Analytics Dashboard")
st.markdown("**Plataforma de E-Commerce — Moçambique**")
st.divider()

st.sidebar.header("🔍 Filtros")
anos = ["Todos"] + sorted(df["ano"].unique().tolist())
ano_sel = st.sidebar.selectbox("Ano", anos)
categorias = ["Todas"] + sorted(df["categoria"].unique().tolist())
cat_sel = st.sidebar.selectbox("Categoria", categorias)
regioes = ["Todas"] + sorted(df["regiao"].unique().tolist())
reg_sel = st.sidebar.selectbox("Região", regioes)
canais = ["Todos"] + sorted(df["canal"].unique().tolist())
canal_sel = st.sidebar.selectbox("Canal", canais)

df_filtrado = df.copy()
if ano_sel != "Todos":
    df_filtrado = df_filtrado[df_filtrado["ano"] == ano_sel]
if cat_sel != "Todas":
    df_filtrado = df_filtrado[df_filtrado["categoria"] == cat_sel]
if reg_sel != "Todas":
    df_filtrado = df_filtrado[df_filtrado["regiao"] == reg_sel]
if canal_sel != "Todos":
    df_filtrado = df_filtrado[df_filtrado["canal"] == canal_sel]

receita_total = df_filtrado["receita_liquida"].sum()
margem_total  = df_filtrado["margem_bruta"].sum()
total_pedidos = df_filtrado["order_id"].nunique()
ticket_medio  = df_filtrado.groupby("order_id")["receita_liquida"].sum().mean()
margem_pct    = (margem_total / receita_total * 100) if receita_total > 0 else 0

col1, col2, col3, col4, col5 = st.columns(5)
col1.metric("💰 Receita Total",  f"MT {receita_total:,.0f}")
col2.metric("📈 Margem Bruta",   f"MT {margem_total:,.0f}")
col3.metric("📊 Margem %",       f"{margem_pct:.1f}%")
col4.metric("🛍️ Total Pedidos",  f"{total_pedidos:,.0f}")
col5.metric("🎯 Ticket Médio",   f"MT {ticket_medio:,.0f}" if pd.notna(ticket_medio) else "MT 0")

st.divider()
st.subheader("📅 Receita por Mês")
df_mensal = df_filtrado.groupby(["ano", "mes_num", "mes"])["receita_liquida"].sum().reset_index()
df_mensal["periodo"] = df_mensal["mes"].str.strip() + " " + df_mensal["ano"].astype(str)
df_mensal = df_mensal.sort_values(["ano", "mes_num"])
fig1 = px.bar(df_mensal, x="periodo", y="receita_liquida", color="ano",
    title="Receita Líquida Mensal",
    labels={"receita_liquida": "Receita (MT)", "periodo": "Período"},
    color_discrete_sequence=px.colors.qualitative.Set2)
fig1.update_layout(xaxis_tickangle=-45)
st.plotly_chart(fig1, use_container_width=True)

st.divider()
st.subheader("🏆 Performance de Produtos")
col1, col2 = st.columns(2)
with col1:
    df_prod = df_filtrado.groupby("produto")["receita_liquida"].sum().reset_index()
    df_prod = df_prod.sort_values("receita_liquida", ascending=True).tail(10)
    fig2 = px.bar(df_prod, x="receita_liquida", y="produto", orientation="h",
        title="Top 10 Produtos por Receita",
        labels={"receita_liquida": "Receita (MT)", "produto": "Produto"},
        color="receita_liquida", color_continuous_scale="Blues")
    st.plotly_chart(fig2, use_container_width=True)
with col2:
    df_cat = df_filtrado.groupby("categoria")["receita_liquida"].sum().reset_index()
    fig3 = px.pie(df_cat, values="receita_liquida", names="categoria",
        title="Receita por Categoria",
        color_discrete_sequence=px.colors.qualitative.Set2)
    st.plotly_chart(fig3, use_container_width=True)

st.divider()
st.subheader("🗺️ Performance Geográfica e Canais")
col1, col2 = st.columns(2)
with col1:
    df_cidade = df_filtrado.groupby("cidade")["receita_liquida"].sum().reset_index()
    df_cidade = df_cidade.sort_values("receita_liquida", ascending=True)
    fig4 = px.bar(df_cidade, x="receita_liquida", y="cidade", orientation="h",
        title="Receita por Cidade",
        labels={"receita_liquida": "Receita (MT)", "cidade": "Cidade"},
        color="receita_liquida", color_continuous_scale="Greens")
    st.plotly_chart(fig4, use_container_width=True)
with col2:
    df_canal = df_filtrado.groupby("canal")["receita_liquida"].sum().reset_index()
    fig5 = px.pie(df_canal, values="receita_liquida", names="canal",
        title="Receita por Canal de Venda",
        color_discrete_sequence=px.colors.qualitative.Pastel)
    st.plotly_chart(fig5, use_container_width=True)

st.divider()
st.subheader("👥 Segmentos de Clientes")
df_seg = df_filtrado.groupby("segmento")["receita_liquida"].sum().reset_index()
fig6 = px.bar(df_seg.sort_values("receita_liquida", ascending=False),
    x="segmento", y="receita_liquida",
    title="Receita por Segmento de Cliente",
    labels={"receita_liquida": "Receita (MT)", "segmento": "Segmento"},
    color="segmento", color_discrete_sequence=px.colors.qualitative.Set1)
st.plotly_chart(fig6, use_container_width=True)

st.divider()
st.subheader("📋 Detalhe de Transacções")
df_tabela = df_filtrado[["order_id", "full_date", "cliente", "produto",
    "categoria", "cidade", "canal", "quantidade",
    "preco", "desconto", "receita_liquida"]].sort_values("full_date", ascending=False)
st.dataframe(df_tabela, use_container_width=True)