CREATE DATABASE heranca;
USE heranca;

CREATE TABLE pessoa(
	id_pessoa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
	cpf VARCHAR(255),
	rg VARCHAR(255)
);

CREATE TABLE funcionario(
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
	matricula VARCHAR(255),
	salario DECIMAL(10,2),
    id_pessoa INT,
		CONSTRAINT fk_funcionario_pessoa
			FOREIGN KEY(id_pessoa)
             REFERENCES pessoa(id_pessoa)
);

CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    saldo_devedor DECIMAL(10,2),
    id_pessoa INT, 
		CONSTRAINT fk_pessoa
			FOREIGN KEY(id_pessoa)
            REFERENCES pessoa(id_pessoa)
);

INSERT INTO pessoa(nome, cpf, rg) VALUES
('Frodo Bolseiro', '111', 'RG1'),
('Aragorn', '222', 'RG2'),
('Legonas', '333', 'RG3'),
('Gimli', '444', 'RG4'),
('Gandalf', '555', 'RG5'),
('Samwise Gamgee', '666', 'RG6');

INSERT INTO cliente(saldo_devedor, id_pessoa) VALUES
(150.00, 1),
(0.00, 2),
(50.00, 3),
(500.00, 4),
(10.00, 6);
 
INSERT INTO funcionario(matricula, salario, id_pessoa) VALUES
('MAG01', 9000.00, 5),
('REI01', 8500.00, 2),
('ELF01', 7000.00, 3),
('ANAO01', 7000.00, 4),
('JAR01', 3000.00, 6);

  SELECT
	p.nome,
    c.saldo_devedor,
    f.salario

FROM pessoa p
INNER JOIN cliente c 
	ON p.id_pessoa = c.id_pessoa
INNER JOIN funcionario f 
	ON p.id_pessoa = f.id_pessoa;

SELECT 
	salario,
	AVG(salario) AS media_salario
FROM funcionario
GROUP BY salario
HAVING AVG(salario) > 5000.00; 

SELECT *
FROM funcionario f
JOIN pessoa p
	ON f.id_pessoa = p.id_pessoa
WHERE p.nome LIKE 'G%';








