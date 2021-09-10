-- --------------------------------------------
-- Consulta 1
-- --------------------------------------------
SELECT COUNT(*) AS 'Quant. de países registrados'
FROM Paises
WHERE codigo_iso LIKE 'OWID_KOS'
OR codigo_iso NOT LIKE 'OWID%';

-- --------------------------------------------
-- Consulta 2
-- --------------------------------------------
SELECT total_casos AS 'Total de casos no mundo em 14/04/2021'
FROM Paises p, Dados_Covid dc
WHERE p.codigo_iso = dc.codigo_iso
AND localizacao = 'World'
AND `data` = '2021-04-14';

-- --------------------------------------------
-- Consulta 3
-- --------------------------------------------
WITH soma_novos_casos AS(
	SELECT localizacao, sum(novos_casos) AS soma
    FROM Paises p, Dados_Covid dc
    WHERE p.codigo_iso = dc.codigo_iso
    AND `data` LIKE '2021-03%'
    AND (p.codigo_iso LIKE 'OWID_KOS'
    OR p.codigo_iso NOT LIKE 'OWID%')
    GROUP BY localizacao
	ORDER BY soma DESC
    LIMIT 0, 10)
SELECT localizacao AS 'Países com mais casos confirmados em Março/2021'
FROM soma_novos_casos;

-- --------------------------------------------
-- Consulta 4
-- --------------------------------------------
WITH paises_maior AS(
	SELECT localizacao, expectativa_vida, 
    ROW_NUMBER() OVER(ORDER BY expectativa_vida DESC) AS coluna
    FROM Paises
    ORDER BY expectativa_vida DESC),
paises_menor AS(
	SELECT localizacao, expectativa_vida, 
    ROW_NUMBER() OVER(ORDER BY expectativa_vida) AS coluna
    FROM Paises
    WHERE expectativa_vida IS NOT NULL
    ORDER BY expectativa_vida ASC)
SELECT pma.localizacao AS 'Países com maior expectativa de vida',
	   pme.localizacao AS 'Países com menor expectativa de vida'
FROM paises_maior pma, paises_menor pme
WHERE pma.coluna = pme.coluna
LIMIT 0, 10;

-- --------------------------------------------
-- Consulta 5
-- --------------------------------------------
SELECT c.nome AS 'Continentes', 
sum(novos_casos) AS 'Total de casos em 2021'
FROM Continentes c, Paises p, Dados_Covid dc
WHERE p.codigo_iso = dc.codigo_iso
AND c.id = p.id_continente
AND `data` LIKE '2021%'
AND (p.codigo_iso LIKE 'OWID_KOS'
OR p.codigo_iso NOT LIKE 'OWID%')
GROUP BY c.nome;

-- --------------------------------------------
-- Consulta 6
-- --------------------------------------------
SELECT localizacao AS 'Países', 
abs(max(pessoas_completamente_vacinadas)) AS 'Total de pessoas totalmente vacinadas em 2021',
round((max(pessoas_completamente_vacinadas)*100/populacao),2) AS `Total de pessoas totalmente vacinadas em 2021 (%)`
FROM Continentes c, Paises p, Dados_Covid dc
WHERE p.codigo_iso = dc.codigo_iso
AND c.id = p.id_continente
AND c.nome = 'South America'
AND `data` LIKE '2021%'
GROUP BY localizacao
ORDER BY `Total de pessoas totalmente vacinadas em 2021 (%)` DESC;

-- --------------------------------------------
-- Consulta 7
-- --------------------------------------------
SELECT localizacao AS 'Países',
round(avg(indice_rigor),2) AS 'Média do índice de rigor em Março/2021',
round(sum(novos_casos_por_milhao),2) AS 'Total de casos por milhão em Março/2021'
FROM Paises p, Dados_Covid dc
WHERE p.codigo_iso = dc.codigo_iso
AND `data` LIKE '2021-03%'
AND (p.codigo_iso LIKE 'OWID_KOS'
OR p.codigo_iso NOT LIKE 'OWID%')
AND indice_rigor IS NOT NULL
GROUP BY localizacao;

-- --------------------------------------------
-- Consulta 8
-- --------------------------------------------
WITH paises_info_uti AS(
	SELECT localizacao, sum(pacientes_uti) AS pacientes
    FROM Paises p, Dados_Covid dc
	WHERE p.codigo_iso = dc.codigo_iso
	AND `data` LIKE '2021-02%'
    AND (p.codigo_iso LIKE 'OWID_KOS'
	OR p.codigo_iso NOT LIKE 'OWID%')
    GROUP BY localizacao)
SELECT localizacao AS 'Países sem informação sobre pacientes nas UTIs em Feveireiro/2021'
FROM paises_info_uti piu
WHERE piu.pacientes IS NULL;

-- --------------------------------------------
-- Consulta 9
-- --------------------------------------------
WITH maior_valor_novos_casos AS(
	SELECT max(novos_casos) AS maior_valor
    FROM Dados_Covid
    WHERE codigo_iso = 'BRA')
SELECT DATE_FORMAT(`data`, '%d/%m/%Y') AS 'Dia com maior número de novos casos de COVID-19 no Brasil'
FROM Dados_Covid dc, maior_valor_novos_casos mvnc
WHERE codigo_iso = 'BRA'
AND dc.novos_casos = mvnc.maior_valor;

-- --------------------------------------------
-- Consulta 10
-- --------------------------------------------
WITH maior_valor_novas_mortes AS(
	SELECT max(novas_mortes) AS maior_valor
    FROM Dados_Covid
    WHERE codigo_iso = 'OWID_WRL')
SELECT DATE_FORMAT(`data`, '%d/%m/%Y') AS 'Dia com maior número de mortes por COVID-19 no mundo'
FROM Dados_Covid dc, maior_valor_novas_mortes mvnm
WHERE codigo_iso = 'OWID_WRL'
AND dc.novas_mortes = mvnm.maior_valor;