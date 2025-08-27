-- Censo 2010 — Domicílios por condição de ocupação, tipo (detalhado) e situação (urbano/rural)
SELECT
  2010 AS ano,

  -- Condição de ocupação (v0201)
  d.v0201 AS condicao_cod,
  CASE CAST(d.v0201 AS STRING)
    WHEN '1' THEN 'Proprio quitado'
    WHEN '2' THEN 'Proprio em aquisicao'
    WHEN '3' THEN 'Alugado'
    WHEN '4' THEN 'Cedido por empregador'
    WHEN '5' THEN 'Cedido de outra forma'
    WHEN '6' THEN 'Outra condicao'
    ELSE 'NIU/ignorado'
  END AS condicao_txt,

  -- Tipo do domicílio (v4002) — categorias detalhadas documentadas para 2010
  d.v4002 AS tipo_cod,
  CASE CAST(d.v4002 AS STRING)
    WHEN '11' THEN 'Casa'
    WHEN '12' THEN 'Casa de vila ou condominio'
    WHEN '13' THEN 'Apartamento'
    WHEN '14' THEN 'Habitacao em comodo ou cortico'
    WHEN '15' THEN 'Oca / maloca (indigena)'
    WHEN '51' THEN 'Tenda ou barraca'
    WHEN '52' THEN 'Dentro de estabelecimento nao residencial'
    WHEN '53' THEN 'Outro (vagão, trailer, gruta, etc.)'
    WHEN '61' THEN 'Asilo, orfanato ou similar'
    WHEN '62' THEN 'Hotel, pensao ou similar'
    WHEN '63' THEN 'Alojamento de trabalhadores'
    WHEN '64' THEN 'Penitenciaria, presidio ou casa de detencao'
    WHEN '65' THEN 'Outro coletivo'
    ELSE 'NIU/ignorado'
  END AS tipo_txt,

  -- Situação do domicílio (urbano/rural)
  d.situacao_domicilio AS situacao_cod,
  CASE CAST(d.situacao_domicilio AS STRING)
    WHEN '1' THEN 'Urbano'
    WHEN '2' THEN 'Rural'
    ELSE 'NIU/ignorado'
  END AS situacao_urb_rur,

  -- Total de domicílios na célula
  COUNT(*) AS total_domicilios

FROM `basedosdados.br_ibge_censo_demografico.microdados_domicilio_2010` d
-- (opcional) focar em domicílios particulares permanentes:
-- WHERE d.v4001 = '1'  -- 1 = particular permanente (ver schema 2010)
GROUP BY
  ano,
  condicao_cod, condicao_txt,
  tipo_cod, tipo_txt,
  situacao_cod, situacao_urb_rur
ORDER BY condicao_cod, tipo_cod, situacao_cod;
