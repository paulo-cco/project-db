CREATE DATABASE vendas;
USE vendas;

CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
	cidade VARCHAR(50)
    
);

INSERT INTO cliente(nome, cidade) VALUES
("Anakin Skywalker", "Tatooine"),
("Leia Ortega", "Alderaan"),
("Yoda", "Dagobah"),
("Han Solo", "Corellia");

CREATE TABLE pedido(
id_pedido INT PRIMARY KEY AUTO_INCREMENT,
id_cliente INT, 
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
valor_total DECIMAL(10,2),
data_pedido DATE,
CONSTRAINT chk_valor_total
CHECK (valor_total >= 0)
);

INSERT INTO pedido(id_cliente, valor_total, data_pedido) VALUES
(1, 500.00, '2025-01-15'),
(1, 750.00, '2025-02-20'),
(2, 1200.00, '2025-03-10'),
(2, 300.00, '2025-04-05'),
(4, 1500.00, '2025-05-12'),
(4, 200.00, '2025-06-18'),
(4, 800.00, '2025-07-22');

SELECT *
FROM cliente; 

SELECT * 
FROM pedido;

SELECT 
	c.id_cliente,
    c.nome,
    p.id_pedido,
    p.valor_total

FROM cliente c
RIGHT JOIN pedido p ON c.id_cliente = p.id_cliente;

SELECT 
	c.id_cliente,
    c.nome,
    p.id_pedido,
    p.valor_total

FROM cliente c
LEFT JOIN pedido p 
	ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

SELECT 
	c.id_cliente,
    c.nome,
    sum(p.valor_total) as total_gasto

FROM cliente c
LEFT JOIN pedido p 
	ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING SUM(p.valor_total) > 1000
ORDER BY total_gasto DESC;

/*INSERT INTO pedido (valor_total) values (-100.00);
ERROR: constraint chk_valor_total violated*/

SELECT 

	c.cidade,
	AVG(p.valor_total)  AS media_gasto
    
FROM cliente c
JOIN pedido p 
	ON c.id_cliente = p.id_cliente

GROUP BY c.cidade
HAVING AVG(p.valor_total) > 300.00;
    