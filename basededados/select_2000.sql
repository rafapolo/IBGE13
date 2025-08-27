-- Censo 2000 — Pessoas (via total de moradores) por condição, tipo e situação do domicílio
SELECT
  2000 AS ano,

  -- Condição de ocupação (v0205)
  d.v0205 AS condicao_cod,
  CASE d.v0205
    WHEN '1' THEN 'Proprio pago'
    WHEN '2' THEN 'Proprio em aquisicao'
    WHEN '3' THEN 'Alugado'
    WHEN '4' THEN 'Cedido por empregador'
    WHEN '5' THEN 'Cedido de outra forma'
    WHEN '6' THEN 'Outra condição'
    ELSE 'NIU/ignorado'
  END AS condicao_txt,

  -- Tipo do domicílio (v0202)
  d.v0202 AS tipo_cod,
  CASE d.v0202
    WHEN '1' THEN 'Casa'
    WHEN '2' THEN 'Apartamento'
    WHEN '3' THEN 'Cômodo'
    ELSE 'Outro/NIU'
  END AS tipo_txt,

  -- Situação do domicílio (urbano/rural)
  d.situacao_domicilio AS situacao_cod,
  CASE d.situacao_domicilio
    WHEN 1 THEN 'Urbano'
    WHEN 2 THEN 'Rural'
    ELSE 'NIU/ignorado'
  END AS situacao_urb_rur,

  -- Total de pessoas no domicílio
  SUM(CAST(d.v7100 AS INT64)) AS total_pessoas

FROM `basedosdados.br_ibge_censo_demografico.microdados_domicilio_2000` d
GROUP BY
  ano, condicao_cod, condicao_txt,
  tipo_cod, tipo_txt,
  situacao_cod, situacao_urb_rur
ORDER BY condicao_cod, tipo_cod, situacao_cod;
