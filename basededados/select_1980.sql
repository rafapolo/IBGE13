SELECT
  1980 AS ano,

  d.v209 AS condicao_cod,
  CASE d.v209
    WHEN '1' THEN 'Próprio já pago'
    WHEN '3' THEN 'Próprio em aquisição'
    WHEN '5' THEN 'Alugado'
    WHEN '6' THEN 'Cedido por empregador'
    WHEN '7' THEN 'Cedido por particular'
    WHEN '0' THEN 'Outra condição'
    WHEN '9' THEN 'NIU / ignorado'
    ELSE 'Não classificado'
  END AS condicao_txt,

  d.v201 AS especie_cod,
  CASE d.v201
    WHEN '1' THEN 'Particular permanente'
    WHEN '2' THEN 'Particular ocasional'
    WHEN '3' THEN 'Particular improvisado'
    WHEN '5' THEN 'Coletivo permanente'
    WHEN '7' THEN 'Coletivo improvisado'
    ELSE 'Não classificado'
  END AS especie_txt,

d.v202 AS tipo_cod,
CASE d.v202
  WHEN '1' THEN 'Casa'
  WHEN '3' THEN 'Apartamento'
  ELSE 'ignorado'
END AS tipo_txt,

  d.v198 AS situacao_cod,
  CASE d.v198
    WHEN 1 THEN 'Cidade ou Vila'
    WHEN 3 THEN 'Área urbana isolada'
    WHEN 5 THEN 'Aglomerado rural'
    WHEN 7 THEN 'Zona rural'
    ELSE 'ignorado'
end as situacao_urb_rur,

  COUNT(*) AS total_domicilios
FROM `basedosdados.br_ibge_censo_demografico.microdados_domicilio_1980` d
GROUP BY
  ano, condicao_cod, condicao_txt,
  especie_cod, especie_txt,
  tipo_cod, tipo_txt,
  situacao_cod, situacao_urb_rur
ORDER BY condicao_cod, especie_cod, tipo_cod, situacao_cod;
