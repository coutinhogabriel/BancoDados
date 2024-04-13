-- DDL (Data Definition Language) Exercícios1:

-- Criar tabela "Clientes"
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- Criar tabela "Pedidos"
CREATE TABLE Pedidos (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Total DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);

-- DML (Data Manipulation Language) Exercícios:

-- Inserir três novos clientes
INSERT INTO Clientes (ID, Nome, Sobrenome, Email) VALUES
(1, 'João', 'Silva', 'joao@example.com'),
(2, 'Maria', 'Santos', 'maria@example.com'),
(3, 'Carlos', 'Ferreira', 'carlos@example.com');

-- Inserir cinco novos registros de pedidos associados a diferentes clientes
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status) VALUES
(1, 1, '2024-04-01', 100.00, 'Em andamento'),
(2, 1, '2024-04-02', 50.00, 'Finalizado'),
(3, 2, '2024-04-03', 75.00, 'Em andamento'),
(4, 3, '2024-04-04', 200.00, 'Em andamento'),
(5, 2, '2024-04-05', 30.00, 'Cancelado');

-- Atualizar o campo "Total" de um pedido específico
UPDATE Pedidos SET Total = 120.00 WHERE ID = 1;

-- Excluir um cliente e seus respectivos pedidos
DELETE FROM Clientes WHERE ID = 3;
DELETE FROM Pedidos WHERE ID_Cliente = 3;

-- Selecionar todos os pedidos com status "Em andamento"
SELECT * FROM Pedidos WHERE Status = 'Em andamento';

-- Listar o nome do cliente, a data do pedido e o total de cada pedido feito nos últimos 30 dias
SELECT c.Nome, p.Data_Pedido, p.Total
FROM Clientes c
JOIN Pedidos p ON c.ID = p.ID_Cliente
WHERE p.Data_Pedido >= CURRENT_DATE -30;