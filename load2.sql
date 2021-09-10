-- --------------------------------------------
-- Inserção dos dados na Tabela 'Continentes'
-- --------------------------------------------
INSERT INTO Continentes(nome)
SELECT DISTINCT (continent) FROM covid_data;

-- --------------------------------------------
-- Inserção dos dados na Tabela 'Paises'
-- --------------------------------------------
INSERT INTO Paises(codigo_iso, id_continente, localizacao, populacao, densidade_populacional, idade_media, 
				   idosos_65_mais, idosos_70_mais, pib_per_capita, pobreza_extrema, taxa_morte_cardiovascular, 
                   prevalencia_diabetes, fumantes_feminino, fumantes_masculino, lavatorios, leitos_hospital_por_milhar, 
                   expectativa_vida, idh)
SELECT DISTINCT(iso_code), c.id, location, population, population_density, median_age, aged_65_older, aged_70_older,
			    gdp_per_capita, extreme_poverty, cardiovasc_death_rate, diabetes_prevalence, female_smokers, male_smokers,
				handwashing_facilities, hospital_beds_per_thousand, life_expectancy, human_development_index 
FROM covid_data cd LEFT JOIN Continentes c 
ON cd.continent = c.nome;

-- --------------------------------------------
-- Inserção dos dados na Tabela 'Datas'
-- --------------------------------------------
INSERT INTO Datas(`data`)
SELECT DISTINCT(`date`) FROM covid_data;

-- --------------------------------------------
-- Inserção dos dados na Tabela 'Dados_Covid'
-- --------------------------------------------
INSERT INTO Dados_Covid(
	codigo_iso, `data`, total_casos, novos_casos, novos_casos_suavizado, total_mortes, novas_mortes, 
	novas_mortes_suavizado, total_casos_por_milhao, novos_casos_por_milhao, novos_casos_suavizado_por_milhao,
	total_mortes_por_milhao, novas_mortes_por_milhao, novas_mortes_suavizado_por_milhao, taxa_reproducao,
	pacientes_uti, pacientes_uti_por_milhao, pacientes_hosp, pacientes_hosp_por_milhao, admissoes_uti_semanais, 
	admissoes_uti_semanais_por_milhao, admissoes_hosp_semanais, admissoes_hosp_semanais_por_milhao,
	total_testes, novos_testes, total_testes_por_milhar, novos_testes_por_milhar, novos_testes_suavizado, 
	novos_testes_suavizado_por_milhar, taxa_positivo, testes_por_caso, unidades_testes, total_vacinacoes, 
	pessoas_vacinadas, pessoas_completamente_vacinadas, novas_vacinacoes, novas_vacinacoes_suavizado, 
	total_vacinacoes_por_centena, pessoas_vacinadas_por_centena, pessoas_completamente_vacinadas_por_centena, 
	novas_vacinacoes_suavizado_por_milhao, indice_rigor)
SELECT 
	iso_code, `date`, total_cases, new_cases, new_cases_smoothed, total_deaths, new_deaths, new_deaths_smoothed, 
    total_cases_per_million, new_cases_per_million, new_cases_smoothed_per_million, total_deaths_per_million, 
    new_deaths_per_million, new_deaths_smoothed_per_million, reproduction_rate, icu_patients, icu_patients_per_million, 
    hosp_patients, hosp_patients_per_million, weekly_icu_admissions, weekly_icu_admissions_per_million, weekly_hosp_admissions, 
    weekly_hosp_admissions_per_million, total_tests, new_tests, total_tests_per_thousand, new_tests_per_thousand, 
    new_tests_smoothed, new_tests_smoothed_per_thousand, positive_rate, tests_per_case, tests_units, total_vaccinations, 
    people_vaccinated, people_fully_vaccinated, new_vaccinations, new_vaccinations_smoothed, total_vaccinations_per_hundred, 
    people_vaccinated_per_hundred, people_fully_vaccinated_per_hundred, new_vaccinations_smoothed_per_million, stringency_index 
FROM covid_data;

-- --------------------------------------------
-- Remoção da tabela temporária 'covid_data'
-- -------------------------------------------- 
DROP TABLE covid_data;