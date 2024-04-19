-- Criar Banco de dados
CREATE DATABASE SA5_gabrielcoutinho;

-- DDL
-- 1 Criar tabela "Clientes" 
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- 2 Criar tabela "Pedidos"
CREATE TABLE Pedidos (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Total DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);

-- 3 Criar tabela "Produtos"
CREATE TABLE Produtos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao TEXT,
    Preco DECIMAL(10, 2),
    CONSTRAINT positive_price CHECK (Preco > 0)
);

-- 4 Criar tabela "Categorias"
CREATE TABLE Categorias (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

-- 5 Criar tabela "Pedidos_Produtos"
CREATE TABLE Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);

-- 6 Criar tabela de junção "Produtos_Categorias"
CREATE TABLE Produtos_Categorias (
    ID_Produto INT,
    ID_Categoria INT,
    PRIMARY KEY (ID_Produto, ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);


-- 7 Criar tabela "Empregador"
CREATE TABLE Empregados (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Cargo VARCHAR(20),
    CONSTRAINT valid_cargo CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'))
);

-- 8 Criar tabela "Vendas"
CREATE TABLE Vendas (
    ID INT PRIMARY KEY,
    ID_Produto INT,
    ID_Cliente INT,
    Data_Venda DATE,
    Quantidade INT,
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);

-- 9 Adicionar coluna "Telefone" à tabela "Clientes"
ALTER TABLE Clientes
ADD Telefone VARCHAR(20); 

-- 9.2 Modificar coluna "Descrição" da tabela "Produtos" para permitir valores nulos
ALTER TABLE Produtos
ALTER COLUMN Descricao DROP NOT NULL;

-- 9.3 Remover a restrição de chave estrangeira (foreign key) da tabela "Pedidos"
ALTER TABLE Pedidos
DROP CONSTRAINT Pedidos_ID_Cliente_fkey;

-- 9.4 Renomear a tabela "Empregados" para "Funcionários"
ALTER TABLE Empregados
RENAME TO Funcionarios;

SELECT *FROM Funcionarios;

-- DML
-- 1 Inserir cinco novos clientes
INSERT INTO Clientes (ID, Nome, Sobrenome, Email, Telefone) VALUES
(1, 'Marcos', 'Verstappen', 'marcos@verstappen.com', '555'),
(2, 'Charles', 'Leclerc', 'charlinho@leclerc.com', '567'),
(3, 'Chamber', 'Awp', 'chamber@awp.com', '568'),
(4, 'Noel', 'Machado', 'noel@machado.com', '569'),
(5, 'Makelele', 'lele', 'makelele@lele.com', '650');

SELECT *FROM Clientes;
SELECT *FROM Pedidos;
SELECT *FROM Produtos;

-- 2 Inserir dez novos registros de pedidos associados a diferentes clientes
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status) VALUES
(1, 1, '2024-04-01', 100.00, 'Em andamento'),
(2, 1, '2024-04-02', 50.00, 'Finalizado'),
(3, 2, '2024-04-03', 75.00, 'Cancelado'),
(4, 3, '2024-04-04', 200.00, 'Em andamento'),
(5, 2, '2024-04-05', 30.00, 'Cancelado'),
(6, 1, '2024-04-01', 100.00, 'Em andamento'),
(7, 1, '2024-04-02', 50.00, 'Finalizado'),
(8, 2, '2024-04-03', 75.00, 'Cancelado'),
(9, 3, '2024-04-04', 200.00, 'Em andamento'),
(10, 2, '2024-04-05', 30.00, 'Finalizado');

-- 3 Inserir quinze novos produtos
INSERT INTO Produtos (ID, Nome, Descricao, Preco) VALUES
(1, 'Produto 1', 'Descrição do Produto 1', 50.00),
(2, 'Produto 2', 'Descrição do Produto 2', 75.00),
(3, 'Produto 3', 'Descrição do Produto 3', 100.00),
(4, 'Produto 4', 'Descrição do Produto 4', 25.00),
(5, 'Produto 5', 'Descrição do Produto 5', 150.00),
(6, 'Produto 6', 'Descrição do Produto 1', 51.00),
(7, 'Produto 7', 'Descrição do Produto 2', 76.00),
(8, 'Produto 8', 'Descrição do Produto 3', 120.00),
(9, 'Produto 9', 'Descrição do Produto 4', 23.00),
(10, 'Produto 10', 'Descrição do Produto 5', 160.00),
(11, 'Produto 11', 'Descrição do Produto 1', 80.00),
(12, 'Produto 12', 'Descrição do Produto 2', 78.00),
(13, 'Produto 13', 'Descrição do Produto 3', 240.00),
(14, 'Produto 14', 'Descrição do Produto 4', 190.00),
(15, 'Produto 15', 'Descrição do Produto 5', 110.00);

-- 4 Associação 3produtos Pedidos_produtos
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto) VALUES
('1','2'),
('1','3'),
('2','2');

-- 5 Associação 3produtos Produtos_categoria
INSERT INTO Categorias (ID, nome) VALUES
('1', 'Alimentos'),
('2', 'Ferramentas'),
('3', 'Cosmeticos');

-- 6 Inserir cinco registros de funcionario 
INSERT INTO Funcionarios (ID, Nome, Sobrenome, Cargo) VALUES
('1', 'Manoel', 'Ferrari', 'Atendente'),
('2', 'Diogo', 'Suarez', 'Atendente'),
('3', 'Leonildo', 'Mark', 'Atendente'),
('4', 'Leonel', 'Love', 'Atendente'),
('5', 'Maike', 'Zequinha', 'Atendente');

-- 7 Registrar algumas vendas
INSERT INTO Vendas (ID, ID_Produto, ID_Cliente, Data_Venda, Quantidade) VALUES
('1', '10', '3', '2024-04-10', '5'),
('2', '5', '4', '2024-03-30','2'),
('3', '3', '1', '2024-04-5','1'),
('4', '12', '2', '2024-01-30','3'),
('5', '7', '5', '2024-02-29','4');

-- 8 Atualizar preço especifico 
UPDATE Produtos SET Preco = 60.00 WHERE ID = 10;

-- 9 Atualiza cargo de um funcionario
UPDATE Funcionarios SET Cargo = 'Atendente' WHERE ID = 3;

-- 10 Exclua um cliente
DELETE FROM Vendas WHERE ID_Cliente = 3;
DELETE FROM Pedidos WHERE ID_Cliente = 3;
DELETE FROM clientes WHERE ID = 3;

-- 11 Exclua um produto da tabela e seus registros
DELETE FROM Produtos WHERE ID = 4;
DELETE FROM Pedidos_Produtos WHERE ID_Produto = 4;

-- 12 
DELETE FROM Funcionarios WHERE ID = 5;

-- 14
UPDATE Pedidos SET Status = 'Em andamento' WHERE ID = 8;

-- 15
SELECT * FROM Pedidos WHERE Status ='Em andamento';