CREATE DATABASE lab5;
USE lab5;

-- criação das tabelas

CREATE TABLE unidade(
id_uni INT(11) AUTO_INCREMENT NOT NULL,
nome_uni VARCHAR(50),
PRIMARY KEY(id_uni)
); 


CREATE TABLE pessoa(
id_pessoa INT(11) AUTO_INCREMENT NOT NULL,
nome VARCHAR(100),
cpf VARCHAR(14),
telefone VARCHAR(20),
PRIMARY KEY(id_pessoa)
);

CREATE TABLE profissional(
id_profissional INT(11) AUTO_INCREMENT NOT NULL,
cmr_coren VARCHAR(20),
salario DECIMAL(10,2),
id_pessoa INT,
	CONSTRAINT fk_pro_pessoa
		FOREIGN KEY(id_pessoa)
        REFERENCES pessoa(id_pessoa),
id_uni INT,
	CONSTRAINT fk_uni
		FOREIGN KEY(id_uni)
        REFERENCES unidade(id_uni),
PRIMARY KEY(id_profissional)
);

CREATE TABLE paciente(
id_paciente INT AUTO_INCREMENT NOT NULL,
debito_exames DECIMAL(10,2),
id_pessoa INT,
	CONSTRAINT fk_pessoa
		FOREIGN KEY(id_pessoa)
		REFERENCES pessoa(id_pessoa),
PRIMARY KEY(id_paciente)
);

-- inserção de dados

INSERT INTO unidade(nome_uni) VALUES 
('Cardiologia'),
('Pronto Antendimento'),
('Oncologia');

INSERT INTO pessoa(nome, cpf, telefone) VALUES
('Dr. Goku', '111', '9999-0001'),
('Enf. Buma', '222', '9999-0002'),
('Vegeta', '333', '9999-0003'),
('Piccolo', '444', '9999-0004'),
('Dra. Videl', '555', '9999-0005'),
('Dr. Gohan', '666', '9999-0006'),
('Trunks', '777', '9999-0007'),
('Majin Boo', '888', '9999-0008'),
('Broly', '999', '9999-0009');


INSERT INTO profissional(crm_coren, salario, id_pessoa, id_uni) VALUES
('MD123', 15000.00, 1, 1),
('ENF456', 6000.00, 2, 2),
('TEC789', 4500.00, 3, 2),
('MD555', 12000.00, 5, 1),
('MD666' , 20000.00, 6, 3),
('MD888', 18000.00, 8, 3);

 
 INSERT INTO paciente(debito_exames, id_pessoa) VALUES
 (250.00, 3),
 (1200.00, 4),
 (3500.00, 7),
 (50.00, 9);

-- alteração numa tabela

 ALTER TABLE profissional ADD status_plantao VARCHAR(255) NOT NULL DEFAULT 'indisponivel';

-- atualizei um registro 
 
 UPDATE profissional set status_plantao = 'disponivel' where salario > 10000.00;
 
 /*
 Consulta que agrupamento completo, exibe o nome da unidade, quantidade de funcionarios,
 soma os salários e a média salarial*/
 SELECT 
	uni.nome_uni,
    COUNT(prof.id_profissional) AS qnt_profissionais,
     SUM(prof.salario) AS 'soma dos salario',
    AVG(prof.salario) AS media_salario
FROM unidade uni
JOIN profissional prof 
	ON uni.id_uni = prof.id_uni
GROUP BY uni.nome_uni
HAVING AVG(prof.salario) > 8000.00;

/*Consulta que exibe o nome, seu registro profissional e se possui algum débito. */
SELECT
	pe.nome,
    pr.crm_coren,
    pa.debito_exames
FROM  pessoa pe
INNER JOIN profissional pr
	ON pr.id_pessoa = pe.id_pessoa
INNER JOIN paciente pa
	ON pa.id_pessoa = pe.id_pessoa;

/*Consulta que exibe as informações do profissional se o seu nome começar com a letra G,
também ordena o salário do mario para o menor */
SELECT 
	pe.nome,
    pr.salario,
    pr.status_plantao
FROM pessoa pe
JOIN profissional pr
	ON pr.id_pessoa = pe._id_pessoa
 WHERE nome LIKE 'G%'
 ORDER BY pr.salario DESC;
 
 /* Soma os valores que a unidade tem a receber. */
 SELECT
	SUM(debitos_exames) AS 'Valor total' 
FROM paciente