SELECT
  1991 AS ano,

  d.v0208 AS condicao_cod,
  CASE d.v0208
    WHEN '1' THEN 'Próprio – já pago'
    WHEN '2' THEN 'Próprio – em aquisição'
    WHEN '3' THEN 'Alugado'
    WHEN '4' THEN 'Cedido por empregador'
    WHEN '5' THEN 'Cedido de outra forma'
    WHEN '6' THEN 'Outra condição'
    WHEN '0' THEN 'NIU / não se aplica'
    WHEN '9' THEN 'Ignorado / sem declaração'
    ELSE 'Não classificado'
  END AS condicao_txt,

d.v0202 AS tipo_cod,
CASE d.v0202
  WHEN '1' THEN 'Casa'
  WHEN '2' THEN 'Apartamento'
  WHEN '3' THEN 'Cômodo (cortiço, cabeça-de-porco, etc.)'
  WHEN '4' THEN 'Oca / maloca (habitação indígena)'
  WHEN '5' THEN 'Unidade em prédio não residencial (loja, galpão, etc.)'
  WHEN '6' THEN 'Unidade improvisada (barraco, tenda, etc.)'
  WHEN '7' THEN 'Outro tipo de domicílio'
  WHEN '0' THEN 'NIU / não declarado'
  ELSE 'Não classificado'
END AS tipo_txt,

d.v1061 AS situacao_cod,
CASE d.v1061
  WHEN '1' THEN 'Cidade ou Vila'
  WHEN '2' THEN 'Área urbana isolada'
  WHEN '3' THEN 'Aglomerado rural de extensão urbana'
  WHEN '4' THEN 'Aglomerado rural isolado'
  WHEN '5' THEN 'Núcleo colonial'
  WHEN '6' THEN 'Povoado'
  WHEN '7' THEN 'Zona rural exclusiva'
  ELSE 'NIU/ignorado'
END AS situacao_urb_rur,

  COUNT(*) AS total_pessoas

FROM `basedosdados.br_ibge_censo_demografico.microdados_pessoa_1991` p
JOIN `basedosdados.br_ibge_censo_demografico.microdados_domicilio_1991` d
  ON p.id_questionario = d.id_questionario
GROUP BY
  ano, condicao_cod, condicao_txt,
  tipo_cod, tipo_txt,
  situacao_cod, situacao_urb_rur
ORDER BY condicao_cod, situacao_cod;
