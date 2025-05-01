
CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE pessoa_fisica (
    id INTEGER PRIMARY KEY REFERENCES cliente(id) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    nascimento DATE NOT NULL
);

CREATE TABLE pessoa_juridica (
    id INTEGER PRIMARY KEY REFERENCES cliente(id) ON DELETE CASCADE,
    nome_fantasia VARCHAR(100) NOT NULL,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL
);

CREATE TABLE endereco (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES cliente(id) ON DELETE CASCADE,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    tipo VARCHAR(12) NOT NULL CHECK (tipo IN ('Comercial', 'Residencial')) DEFAULT 'Residencial'
);

CREATE TABLE telefone (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES cliente(id) ON DELETE CASCADE,
    ddd VARCHAR(2) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(12) NOT NULL CHECK (tipo IN ('Movel', 'Fixo', 'Recado')) DEFAULT 'Fixo'
);

CREATE TABLE email (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES cliente(id) ON DELETE CASCADE,
    email VARCHAR(200) NOT NULL
);

-- DML

-- Limpa os dados e reinicia os IDs
TRUNCATE TABLE email, telefone, endereco, pessoa_fisica, pessoa_juridica, cliente RESTART IDENTITY CASCADE;

-- Inserção de 20 clientes (10 PF + 10 PJ)
-- Guardar os IDs gerados
-- PF (1 a 10)
INSERT INTO cliente (ativo) VALUES
(TRUE), (TRUE), (FALSE), (TRUE), (TRUE),
(TRUE), (FALSE), (TRUE), (TRUE), (TRUE);

-- PJ (11 a 20)
INSERT INTO cliente (ativo) VALUES
(TRUE), (TRUE), (FALSE), (TRUE), (TRUE),
(TRUE), (FALSE), (TRUE), (TRUE), (TRUE);

-- Pessoa Física
INSERT INTO pessoa_fisica (id, nome, cpf, nascimento) VALUES
(1, 'Ana Paula', '111.111.111-11', '1990-01-10'),
(2, 'Bruno Silva', '222.222.222-22', '1985-07-21'),
(3, 'Carla Mendes', '333.333.333-33', '1993-03-05'),
(4, 'Daniel Costa', '444.444.444-44', '1980-08-09'),
(5, 'Elaine Souza', '555.555.555-55', '1995-12-25'),
(6, 'Felipe Rocha', '666.666.666-66', '1992-11-15'),
(7, 'Gabriela Luz', '777.777.777-77', '1988-02-20'),
(8, 'Henrique Melo', '888.888.888-88', '1983-04-18'),
(9, 'Isabela Torres', '999.999.999-99', '1991-09-30'),
(10, 'João Pedro', '000.000.000-00', '1996-06-12');

-- Pessoa Jurídica
INSERT INTO pessoa_juridica (id, nome_fantasia, razao_social, cnpj) VALUES
(11, 'TechMais', 'TechMais Sistemas Ltda', '11.111.111/0001-11'),
(12, 'AgroVida', 'AgroVida Produtos Naturais Ltda', '22.222.222/0001-22'),
(13, 'Construfácil', 'Construfácil Engenharia e Obras', '33.333.333/0001-33'),
(14, 'MoveLar', 'MoveLar Indústria de Móveis', '44.444.444/0001-44'),
(15, 'PetAmigo', 'PetAmigo Comércio de Produtos Animais', '55.555.555/0001-55'),
(16, 'EcoLimpo', 'EcoLimpo Limpeza Ambiental Ltda', '66.666.666/0001-66'),
(17, 'AutoPeças BR', 'AutoPeças Brasil SA', '77.777.777/0001-77'),
(18, 'SaborCaseiro', 'Sabor Caseiro Alimentos Artesanais', '88.888.888/0001-88'),
(19, 'VidaSegura', 'Vida Segura Corretora de Seguros', '99.999.999/0001-99'),
(20, 'ClickNet', 'ClickNet Provedor de Internet Ltda', '00.000.000/0001-00');

-- Endereços (clientes variados, múltiplos para alguns)
INSERT INTO endereco (cliente_id, logradouro, numero, complemento, bairro, cidade, estado, cep, tipo) VALUES
(1, 'Rua A', '123', NULL, 'Centro', 'São Paulo', 'SP', '01000-000', 'Residencial'),
(2, 'Av. B', '456', 'Bloco 2', 'Jardim', 'Campinas', 'SP', '13000-000', 'Residencial'),
(2, 'Av. B', '999', 'Sala 12', 'Industrial', 'Campinas', 'SP', '13000-010', 'Comercial'),
(11, 'Rua C', '321', NULL, 'Comercial', 'Sorocaba', 'SP', '18000-000', 'Comercial'),
(14, 'Alameda X', '700', NULL, 'Parque', 'Ribeirão Preto', 'SP', '14000-000', 'Comercial'),
(14, 'Alameda X', '701', NULL, 'Parque', 'Ribeirão Preto', 'SP', '14000-001', 'Comercial'),
(20, 'Rua Net', '88', NULL, 'Centro', 'São Paulo', 'SP', '01020-000', 'Comercial');

-- Telefones (alguns com mais de 1)
INSERT INTO telefone (cliente_id, ddd, numero, tipo) VALUES
(1, '11', '912345678', 'Movel'),
(1, '11', '32345678', 'Fixo'),
(2, '19', '99887766', 'Movel'),
(11, '15', '34567890', 'Fixo'),
(14, '16', '912340001', 'Movel'),
(14, '16', '312340001', 'Fixo'),
(14, '16', '99887755', 'Recado'),
(20, '11', '911112222', 'Movel');

-- Emails (alguns clientes com mais de 1, outros sem)
INSERT INTO email (cliente_id, email) VALUES
(1, 'ana.paula@email.com'),
(2, 'bruno.silva@email.com'),
(2, 'b.silva@empresa.com'),
(11, 'contato@techmais.com.br'),
(14, 'sac@movelar.com'),
(14, 'comercial@movelar.com'),
(20, 'suporte@clicknet.com.br');

