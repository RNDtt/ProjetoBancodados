CREATE DATABASE IF NOT EXISTS DBA;
USE DBA;

-- Tabela dos predios
CREATE TABLE predio (
    id_predio INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(9),
    cidade VARCHAR(30) NOT NULL,
    endereco VARCHAR(150) NOT NULL
);

-- Tabela das salas
CREATE TABLE sala (
    id_sala INT AUTO_INCREMENT PRIMARY KEY,
    id_predio INT NOT NULL,
    andar INT,
    numero_sala INT NOT NULL,
    FOREIGN KEY (id_predio) REFERENCES predio(id_predio)
);

-- Tabela das categorias dos itens
CREATE TABLE categoria_item (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(30) NOT NULL,
    descricao VARCHAR(150)
);

-- Tabela dos itens do inventario
CREATE TABLE item_inventario (
    id_item_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_sala INT NOT NULL,
    nome_item VARCHAR(50) NOT NULL,
    patrimonio_item VARCHAR(50) NOT NULL UNIQUE,
    valor DECIMAL(10,2),
    FOREIGN KEY (id_categoria) REFERENCES categoria_item(id_categoria),
    FOREIGN KEY (id_sala) REFERENCES sala(id_sala)
);

-- Tabela dos colaboradores
CREATE TABLE colaborador (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    matricula_colaborador VARCHAR(25) NOT NULL UNIQUE
);

-- Tabela das tags RFID
CREATE TABLE tag_rfid (
    id_tag INT AUTO_INCREMENT PRIMARY KEY,
    id_item INT NOT NULL UNIQUE,
    codigo_tag VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (id_item) REFERENCES item_inventario(id_item_inventario)
);

-- Tabela dos leitores RFID
CREATE TABLE leitor_rfid (
    id_leitor INT AUTO_INCREMENT PRIMARY KEY,
    id_sala INT NOT NULL,
    codigo_leitor VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (id_sala) REFERENCES sala(id_sala)
);

-- Tabela que guarda as leituras RFID
CREATE TABLE leitura_rfid (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_tag INT NOT NULL,
    id_leitor INT NOT NULL,
    data_hora DATETIME NOT NULL,
    tipo_leitura VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_tag) REFERENCES tag_rfid(id_tag),
    FOREIGN KEY (id_leitor) REFERENCES leitor_rfid(id_leitor)
);

-- Tabela das movimentacoes dos patrimonios
CREATE TABLE movimentacao (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_item INT NOT NULL,
    id_funcionario INT,
    id_sala_origem INT,
    id_sala_destino INT,
    data_hora DATETIME NOT NULL,
    razao_mov VARCHAR(180),
    situacao VARCHAR(30),
    FOREIGN KEY (id_item) REFERENCES item_inventario(id_item_inventario),
    FOREIGN KEY (id_funcionario) REFERENCES colaborador(id_funcionario),
    FOREIGN KEY (id_sala_origem) REFERENCES sala(id_sala),
    FOREIGN KEY (id_sala_destino) REFERENCES sala(id_sala)
);


-- DML: alguns dados para testar o banco


INSERT INTO predio (cep, cidade, endereco)
VALUES ('78000-000', 'Cuiaba', 'Rua da Faculdade, 100');

INSERT INTO sala (id_predio, andar, numero_sala)
VALUES
(1, 1, 101),
(1, 1, 102);

INSERT INTO categoria_item (nome_categoria, descricao)
VALUES
('Informatica', 'Computadores e equipamentos'),
('Eletronicos', 'Projetores e outros equipamentos');

INSERT INTO item_inventario
(id_categoria, id_sala, nome_item, patrimonio_item, valor)
VALUES
(1, 1, 'Computador', 'PAT-001', 3000.00),
(2, 2, 'Projetor', 'PAT-002', 2500.00);

INSERT INTO colaborador (nome_funcionario, matricula_colaborador)
VALUES
('Joao Silva', 'MAT001'),
('Maria Souza', 'MAT002');

INSERT INTO tag_rfid (id_item, codigo_tag)
VALUES
(1, 'TAG001'),
(2, 'TAG002');

INSERT INTO leitor_rfid (id_sala, codigo_leitor)
VALUES
(1, 'LEITOR001'),
(2, 'LEITOR002');

INSERT INTO leitura_rfid (id_tag, id_leitor, data_hora, tipo_leitura)
VALUES
(1, 1, NOW(), 'AUTOMATICA'),
(2, 2, NOW(), 'MANUAL');

INSERT INTO movimentacao
(id_item, id_funcionario, id_sala_origem, id_sala_destino,
 data_hora, razao_mov, situacao)
VALUES
(1, 1, 1, 2, NOW(), 'Mudanca de sala', 'AUTORIZADA'),
(2, NULL, 2, 1, NOW(), 'Movimentacao sem identificacao do colaborador', 'VERIFICAR');


-- SELECTS para conferir os dados

SELECT * FROM predio;
SELECT * FROM sala;
SELECT * FROM categoria_item;
SELECT * FROM item_inventario;
SELECT * FROM colaborador;
SELECT * FROM tag_rfid;
SELECT * FROM leitor_rfid;
SELECT * FROM leitura_rfid;
SELECT * FROM movimentacao;
