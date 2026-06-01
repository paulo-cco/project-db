CREATE DATABASE consultorio;
USE consultorio;

#Criando as tabelas


CREATE TABLE profissao(
id INT AUTO_INCREMENT PRIMARY KEY,
area VARCHAR(255) NOT NULL,
nome_prof VARCHAR(255)
);

CREATE TABLE cidade(
id INT AUTO_INCREMENT PRIMARY KEY,
nome_cid VARCHAR(255) NOT NULL,
uf VARCHAR(255) NOT NULL
);

CREATE TABLE paciente(
id INT AUTO_INCREMENT PRIMARY KEY,
nome_paciente VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
idade INT NOT NULL,
fone VARCHAR(255) NOT NULL,
id_prof INT,
	FOREIGN KEY(id_prof)
    REFERENCES profissao(id),
id_cid INT,
	FOREIGN KEY(id_cid)
    REFERENCES cidade(id)
);

CREATE TABLE medico(
id INT AUTO_INCREMENT PRIMARY KEY,
nome_med VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
crm INT NOT NULL UNIQUE,
cod_cid INT,
	FOREIGN KEY(cod_cid)
    REFERENCES cidade(id)
);

CREATE TABLE especializacao(
id INT AUTO_INCREMENT PRIMARY KEY,
nome_esp VARCHAR(255) NOT NULL,
area VARCHAR(255) NOT NULL
);

CREATE TABLE convenio(
id INT AUTO_INCREMENT PRIMARY KEY,
nome_convenio VARCHAR(255) NOT NULL
);

CREATE TABLE med_esp(
cod_esp INT,
cod_med INT,
PRIMARY KEY (cod_esp, cod_med),
FOREIGN KEY(cod_esp) REFERENCES especializacao(id),
FOREIGN KEY(cod_med) REFERENCES medico(id)
);

CREATE TABLE consulta(
data DATE NOT NULL,
hora TIME NOT NULL,
cod_pac INT,
	FOREIGN KEY(cod_pac)
    REFERENCES paciente(id),
cod_medico INT,
	FOREIGN KEY(cod_medico)
    REFERENCES medico(id),
valor DECIMAL(10,2),
cod_conv INT,
	FOREIGN KEY(cod_conv)
	REFERENCES convenio(id),
PRIMARY KEY(data, hora, cod_pac)
);

CREATE TABLE medicamento(
id INT AUTO_INCREMENT PRIMARY KEY,
descricao VARCHAR(255) NOT NULL
);

CREATE TABLE cons_medicamento(
data DATE,
hora TIME, 
id_pac INT,
id_medicamento INT,
PRIMARY KEY(data, hora, id_pac, id_medicamento),
FOREIGN KEY (data, hora, id_pac)
    REFERENCES consulta(data, hora, cod_pac),
FOREIGN KEY (id_medicamento)
    REFERENCES medicamento(id)
);

#Inserindo dados nas tabelas

INSERT INTO profissao(area, nome_prof) VALUES
('medicina', 'medico'),
('odontologia', 'dentista'),
('psicologia', 'psicolo'),
('enfermagem', 'enfermeiro'),
('fisioterapia', 'fisioterapeuta');

INSERT INTO cidade(nome_cid, uf) VALUES
('Manaus', 'AM'),
('Boa Vista', 'RR'),
('Cruzeiro do Sul', 'AC'),
('Coari', 'AM'),
('Rio Branco', 'AC');

INSERT INTO paciente(nome_paciente, email, idade, fone, id_prof, id_cid) VALUES
('Rickson Gracie', 'ricksongracie@gmail.com', 23, '9999-1111', 1, 1), 
('Cãua Remo', 'cauaremo@gmail.com', 16, '9999-2222', 2, 2),
('Elon Delon', 'elondelon@gmail.com', 30, '9999-3333', 3, 3),
('Daniel San', 'danielsan@gmail.com', 22, '9999-4444', 4, 4),
('Gustavo Lima', 'gustavolima@gmail.com', 20, '9999-5555', 5, 5);

INSERT INTO medico(nome_med, email, crm, cod_cid) VALUES 
('Marcus Palmeira', 'marcus@gmail.com', 23453, 1),
('Andre Socrates', 'andre@gmail.com', 555453, 2),
('Neymar Junior', 'ney@gmail.com', 677755, 3),
('Albert Einsten', 'einsten@gmail.com', 987666, 4),
('Daiane dos Santos', 'daiane@gmail.com', 983456, 5);

INSERT INTO especializacao(nome_esp, area) VALUES 
('Pediatria', 'Saúde Infantil'),
('Urologia', 'Saúde Masculina'),
('Psicologia', 'Saúde Maental'),
('Cardiologia', 'Saúde do Coração');

INSERT INTO convenio(nome_convenio) VALUES
('Unimed'),
('Bradesco Saúde'),
('Amil'),
('Hapvida'),
('SulAmérica');

INSERT INTO med_esp(cod_esp, cod_med) VALUES
(1, 5),
(2, 1),
(3, 1),
(3, 2),
(4, 2),
(4, 4);

INSERT INTO consulta(data, hora, cod_pac, cod_medico, valor, cod_conv) VALUES
('2025-03-20', '09:00', 1, 1, 150.00, 1),
('2025-02-21', '10:00', 2, 2, 180.00, 2),
('2025-02-20', '11:00', 3, 3, 200.00, 1),
('2025-03-21', '09:00', 4, 1, 120.00, 2),
('2025-03-21', '14:00', 5, 5, 250.00, 1);

INSERT INTO medicamento(descricao) VALUES
('Aspirina'),
('Diclofenaco'),
('Engove'),
('Eno'),
('Hipoglos'),
('Moura Brasil'),
('Olina'),
('sonrisal'),
('Tylenol');

INSERT INTO cons_medicamento(data, hora, id_pac, id_medicamento) VALUES
('2025-03-20', '09:00', 1, 1),
('2025-03-20', '10:00', 2, 2),
('2025-03-20', '11:00', 3, 3),
('2025-03-21', '09:00', 4, 4),
('2025-03-21', '14:00', 5, 5);

#QUERY
#Dia com maior faturamento

SELECT
	data
FROM consulta
GROUP BY data 
ORDER BY sum(valor) DESC
LIMIT 1;

#Nome do paciente mais novo

SELECT
	nome_paciente
FROM paciente
ORDER BY idade ASC
LIMIT 1;

#Data e hora da consulta de maior valor
SELECT 
	data,
    hora
FROM consulta
ORDER BY valor DESC
LIMIT 1;

#Trás todas as consultas mesmo aquelas que não usam convênio 
SELECT
	consulta.data,
    consulta.hora,
    convenio.nome_convenio
FROM consulta
LEFT JOIN convenio
	ON consulta.cod_conv = convenio.id;
 
 #Data das consultas e descrição dos medicamentos
SELECT
	c.data,
    m.descricao
FROM consulta c 
LEFT JOIN cons_medicamento cm
	ON c.data = cm.data
    AND c.hora = cm.hora
    AND c.cod_pac = cm.id_pac
LEFT JOIN medicamento m
	ON m.id = cm.id_medicamento
ORDER BY m.descricao ASC;

#Nome dos pacientes e as datas das consultas anteriores a 2026. Os pacientes que não tiveram consulta nesse período tambem devem aparecer no resultado.
SELECT
	p.nome_paciente,
    c.data
FROM paciente p 
LEFT JOIN consulta c
	ON p.id = c.cod_pac
WHERE c.data < '2026-01-01' 
OR c.data IS NULL;

#Dados do paciente e a quantidade de consultas realizadas.
SELECT
	p.nome_paciente AS nome,
    p.email,
    p.idade,
    COUNT(c.cod_id) AS total_consultas
FROM paciente p
LEFT JOIN consulta c
	ON p.id = c.cod_pac
GROUP BY
	p.id, p.nome_paciente, p.email, p.idade
ORDER BY total_consultas;

SELECT 
    p.nome_paciente AS nome,
    p.fone AS tel,
    COALESCE(SUM(c.valor), 0) AS total_gastos
FROM paciente p 
LEFT JOIN consulta c
    ON p.id = c.cod_pac
GROUP BY
    p.id, p.nome_paciente, p.fone
ORDER BY total_gastos;

