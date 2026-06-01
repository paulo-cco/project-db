CREATE DATABASE aula4;

CREATE TABLE colaboradores(
	colaborador_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

INSERT INTO colaboradores(nome, cargo, salario) VALUES
('Peter Parker', 'Desenvolvedor', 4600.00),
('Tony Stark', 'Arquiteto de Soft', 7200.00),
('Natasha Romanoff', 'Analista', 3900.00),
('Brucer Banner', 'DBA', 5100.00),
('Steve Rogers', 'Suporte', 3200.00);

CREATE TABLE projetosTI(
	projeto_id INT PRIMARY KEY AUTO_INCREMENT,
    nomeProjeto VARCHAR(100),
    responsavel VARCHAR(50)
);

INSERT INTO projetosTI(nomeProjeto, responsavel) VALUES
('Sistemas de Vendas', 'Peter Parker'),
('Aplicativo Corporativo', 'Tony Stark'),
('BI Analytics', 'Natasha Romanoff'),
('Segurança interna', 'Clint Barton');

SELECT
	nome
FROM colaboradores 

UNION ALL

SELECT
	responsavel
FROM projetosTI;


SELECT DISTINCT
	nome
FROM colaboradores

UNION

SELECT DISTINCT 
	responsavel
FROM projetosTI;

SELECT *
FROM colaboradores
WHERE nome LIKE '%e%'; 

SELECT * 
FROM colaboradores
WHERE salario BETWEEN 4000.00 AND 6000.00;

SELECT
	MIN(salario),
    MAX(salario)
FROM colaboradores;

SELECT 
	salario
FROM colaboradores
ORDER BY salario DESC
LIMIT 3;

SELECT
	cargo,
    COUNT(*) AS Colaboradores,
    AVG(salario) AS media_salario
FROM colaboradores
GROUP BY cargo	
HAVING AVG(salario) > 4500.00;




