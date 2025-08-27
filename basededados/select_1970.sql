-- Censo 1970 — Pessoas por condição, espécie, tipo e situação (urbano/rural)
SELECT
  1970 AS ano,

  -- Condição de ocupação (v009)
  d.v009 AS condicao_cod,
  CASE d.v009
    WHEN '1' THEN 'Próprio – já pago'
    WHEN '2' THEN 'Próprio – em aquisição'
    WHEN '3' THEN 'Alugado'
    WHEN '4' THEN 'Cedido'
    WHEN '5' THEN 'Outra condição'
    WHEN '0' THEN 'sem declaracao'
    ELSE 'Não classificado'
  END AS condicao_txt,

  -- Espécie do domicílio (v007)
  d.v007 AS especie_cod,
  CASE d.v007
    WHEN '1' THEN 'Particular permanente'
    WHEN '2' THEN 'Particular ocasional'
    WHEN '3' THEN 'Particular improvisado'
    WHEN '5' THEN 'Coletivo permanente'
    WHEN '7' THEN 'Coletivo improvisado'
    ELSE 'Não classificado'
  END AS especie_txt,

  -- Tipo do domicílio (v008)
  d.v008 AS tipo_cod,
  CASE d.v008
    WHEN '1' THEN 'Durável'
    WHEN '0' THEN 'Rústico'
    WHEN '0' THEN 'Improvisado'
    ELSE 'Outro'
  END AS tipo_txt,

  -- Situação do domicílio (v004)
  d.v004 AS situacao_cod,
  CASE d.v004
    WHEN '0' THEN 'Urbano'
    WHEN '1' THEN 'Suburbano'
    WHEN '2' THEN 'Rural'
    ELSE 'Não classificado'
  END AS situacao_urb_rur,

  -- Pessoas no domicílio (v005)
  SUM(d.v005) AS total_pessoas

FROM `basedosdados.br_ibge_censo_demografico.microdados_domicilio_1970` d
-- (opcional, recomendável para tabulações de “condição de ocupação”)
-- WHERE d.v007 = 1  -- restringe a domicílios particulares permanentes
GROUP BY
  ano, condicao_cod, condicao_txt,
  especie_cod, especie_txt,
  tipo_cod, tipo_txt,
  situacao_cod, situacao_urb_rur
ORDER BY condicao_cod, especie_cod, tipo_cod, situacao_cod;
