-- --------------------------------------------
-- Criação do Banco de Dados
-- ---------------------------------------------
DROP DATABASE IF EXISTS Banco_Dados_Covid;
CREATE DATABASE IF NOT EXISTS Banco_Dados_Covid;
USE Banco_Dados_Covid;

-- --------------------------------------------
-- Criação da Tabela 'Continentes'
-- ---------------------------------------------
DROP TABLE IF EXISTS Continentes;
CREATE TABLE IF NOT EXISTS Continentes(
	id TINYINT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(31) UNIQUE DEFAULT NULL);

-- --------------------------------------------
-- Criação da Tabela 'Paises'
-- ---------------------------------------------
DROP TABLE IF EXISTS Paises;
CREATE TABLE IF NOT EXISTS Paises(
	codigo_iso CHAR(11) PRIMARY KEY,
    id_continente TINYINT DEFAULT NULL,
    localizacao VARCHAR(51) UNIQUE DEFAULT NULL,
    populacao FLOAT DEFAULT NULL,
    densidade_populacional FLOAT DEFAULT NULL,
    idade_media FLOAT DEFAULT NULL,
    idosos_65_mais FLOAT DEFAULT NULL,
    idosos_70_mais FLOAT DEFAULT NULL,
    pib_per_capita FLOAT DEFAULT NULL,
    pobreza_extrema FLOAT DEFAULT NULL,
    taxa_morte_cardiovascular FLOAT DEFAULT NULL,
    prevalencia_diabetes FLOAT DEFAULT NULL,
    fumantes_feminino FLOAT DEFAULT NULL,
    fumantes_masculino FLOAT DEFAULT NULL,
    lavatorios FLOAT DEFAULT NULL,
    leitos_hospital_por_milhar FLOAT DEFAULT NULL,
    expectativa_vida FLOAT DEFAULT NULL,
    idh FLOAT DEFAULT NULL);

-- --------------------------------------------
-- Criação da Tabela 'Datas'
-- ---------------------------------------------
DROP TABLE IF EXISTS Datas;
CREATE TABLE IF NOT EXISTS Datas(
	`data` DATE PRIMARY KEY);
    
-- --------------------------------------------
-- Criação da Tabela 'Dados_Covid'
-- ---------------------------------------------
DROP TABLE IF EXISTS Dados_Covid;
CREATE TABLE IF NOT EXISTS Dados_Covid(
	codigo_iso CHAR(11) NOT NULL,
    `data` DATE NOT NULL,
	total_casos FLOAT DEFAULT NULL,
    novos_casos FLOAT DEFAULT NULL,
    novos_casos_suavizado FLOAT DEFAULT NULL,
    total_mortes FLOAT DEFAULT NULL,
    novas_mortes FLOAT DEFAULT NULL,
    novas_mortes_suavizado FLOAT DEFAULT NULL,
    total_casos_por_milhao FLOAT DEFAULT NULL,
    novos_casos_por_milhao FLOAT DEFAULT NULL,
    novos_casos_suavizado_por_milhao FLOAT DEFAULT NULL,
    total_mortes_por_milhao FLOAT DEFAULT NULL,
    novas_mortes_por_milhao FLOAT DEFAULT NULL,
    novas_mortes_suavizado_por_milhao FLOAT DEFAULT NULL,
    taxa_reproducao FLOAT DEFAULT NULL,
    pacientes_uti FLOAT DEFAULT NULL,
    pacientes_uti_por_milhao FLOAT DEFAULT NULL,
    pacientes_hosp FLOAT DEFAULT NULL,
    pacientes_hosp_por_milhao FLOAT DEFAULT NULL,
    admissoes_uti_semanais FLOAT DEFAULT NULL,
    admissoes_uti_semanais_por_milhao FLOAT DEFAULT NULL,
    admissoes_hosp_semanais FLOAT DEFAULT NULL,
    admissoes_hosp_semanais_por_milhao FLOAT DEFAULT NULL,
    total_testes FLOAT DEFAULT NULL,
    novos_testes FLOAT DEFAULT NULL,
    total_testes_por_milhar FLOAT DEFAULT NULL,
    novos_testes_por_milhar FLOAT DEFAULT NULL,
    novos_testes_suavizado FLOAT DEFAULT NULL,
    novos_testes_suavizado_por_milhar FLOAT DEFAULT NULL,
    taxa_positivo FLOAT DEFAULT NULL,
    testes_por_caso FLOAT DEFAULT NULL,
    unidades_testes TEXT DEFAULT NULL,
    total_vacinacoes FLOAT DEFAULT NULL,
    pessoas_vacinadas FLOAT DEFAULT NULL,
    pessoas_completamente_vacinadas FLOAT DEFAULT NULL,
    novas_vacinacoes FLOAT DEFAULT NULL,
    novas_vacinacoes_suavizado FLOAT DEFAULT NULL,
    total_vacinacoes_por_centena FLOAT DEFAULT NULL,
    pessoas_vacinadas_por_centena FLOAT DEFAULT NULL,
    pessoas_completamente_vacinadas_por_centena FLOAT DEFAULT NULL,
    novas_vacinacoes_suavizado_por_milhao FLOAT DEFAULT NULL,
    indice_rigor FLOAT DEFAULT NULL);
    
-- --------------------------------------------
-- Definição das chaves estrangeiras
-- ---------------------------------------------
ALTER TABLE Paises
	ADD FOREIGN KEY (id_continente) REFERENCES Continentes (id);

ALTER TABLE Dados_Covid
	ADD FOREIGN KEY (codigo_iso) REFERENCES Paises (codigo_iso),
    ADD FOREIGN KEY (`data`) REFERENCES Datas (`data`);