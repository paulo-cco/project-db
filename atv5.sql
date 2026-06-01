CREATE DATABASE lab;
USE lab;

CREATE TABLE funcionarios(
	funcionario_id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(255) NOT NULL,
    salario DECIMAL(10,2)
);

INSERT INTO funcionarios(nome, cargo, salario) VALUES
('Jon Snow', 'DEV', 4500.00),
('Daenerys Targaryen', 'Analista', 3800.00),
('Arya Stark', 'DEV', 4800.00),
('Tyrion Lannister', 'DBA', 5200.00),
('Euron Greyjoy', 'Suporte', 3100.00);

CREATE TABLE projetos(
	id_projetos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomeProjeto VARCHAR(50),
    responsavel VARCHAR(50)
);

INSERT INTO projetos(nomeProjeto, responsavel) VALUES
('Site institucional', 'Jon Snow'),
('App Mobile', 'Daenerys Targaryen'),
('ERP Interno', 'Arya Stark'),
('Dashboard BI', 'Varys');

SELECT 
	nome
FROM funcionarios

UNION ALL

SELECT
	responsavel
FROM projetos;

SELECT 
	nome
FROM funcionarios

UNION 

SELECT
	responsavel
FROM projetos;

SELECT *
FROM funcionarios
WHERE nome LIKE '%a%';

SELECT *
FROM funcioarios
WHERE salarios BETWEEN 4000.00 and 5000.00;

SELECT
	MIN(salario) AS menor_salario,
	MAX(salario) AS maior_salario
FROM funcionarios; 

SELECT *
FROM funcionarios
ORDER BY salario  DESC
	LIMIT 3;
    
SELECT
	cargo,
    COUNT(*),
    AVG(salario)
FROM funcionarios
GROUP BY cargo
HAVING AVG(salario) > 4000.00;