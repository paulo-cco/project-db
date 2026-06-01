CREATE DATABASE empresa;
USE empresa;

-- Tabela departamento
CREATE TABLE departamento (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_departamento VARCHAR(50)
);

INSERT INTO departamento(nome_departamento) VALUES
('TI'),
('RH'),
('Financeiro'); 

-- Tabela funcionario
CREATE TABLE funcionario(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    id_departamento INT,
    FOREIGN KEY(id_departamento)
        REFERENCES departamento(id_departamento)
);

-- Inserir funcionários
INSERT INTO funcionario(nome, cargo, salario) VALUES
('Fernando Henrique', 'DEV', 4500.00),
('Carlos Chagas', 'Analista', 3800.00),
('Paula Fernandes', 'DBA', 5200.00),
('Ludmila Anita', 'DEV', 4700.00);

-- Atualizar departamentos usando CASE
UPDATE funcionario
SET id_departamento = CASE
    WHEN nome IN ('Carlos Chagas', 'Fernando Henrique') THEN 1   -- TI
    WHEN nome = 'Ludmila Anita' THEN 2                            -- RH
    WHEN nome = 'Paula Fernandes' THEN 3                           -- Financeiro
    ELSE id_departamento
END;

-- Atualizar salário
UPDATE funcionario
SET salario = 4000.00
WHERE nome = 'Carlos Chagas';

--  Média e total
SELECT
    AVG(salario) AS media_salario,
    COUNT(*) AS total_funcionarios
FROM funcionario;

-- Deletar salários < 4000
DELETE FROM funcionario
WHERE salario < 4000.00;

-- Mostrar funcionários com nome do departamento
SELECT 
    f.nome,
    d.nome_departamento
FROM funcionario f
JOIN departamento d ON f.id_departamento = d.id_departamento;