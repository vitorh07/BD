CREATE TABLE cliente(
    id SERIAL PRIMARY KEY,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE pessoa_fisica(
    id int PRIMARY KEY REFERENCES cliente(id) ON DELETE CASCADE,
    nome varchar(100) NOT NULL,
    cpf varchar(14) UNIQUE NOT NULL,
    dataNascimento DATE NOT NULL
);

CREATE TABLE pessoa_juridica(
    id int PRIMARY KEY REFERENCES cliente(id) ON DELETE CASCADE,
    cnpj varchar(18) UNIQUE NOT NULL,
    razao_social varchar(100) NOT NULL,
    nome_fantasia varchar(100) NOT NULL
);

CREATE TABLE endereco(
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES cliente(id) ON DELETE CASCADE,
    logradouro varchar(100),
    numero varchar(10),
    complemento varchar(100),
    bairro varchar(100),
    cidade varchar(100) NOT NULL,
    estado varchar(2) NOT NULL,
    cep varchar(9) NOT NULL,
    tipo varchar(20) NOT NULL CHECK (tipo IN ('Comercial', 'Residencial')) DEFAULT 'Residencial'
);

CREATE TABLE telefone(
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES cliente(id) ON DELETE CASCADE,
    ddd VARCHAR(2) NOT NULL,
    numero varchar(10) NOT NULL,
    tipo VARCHAR(12) NOT NULL CHECK (tipo IN ('Móvel', 'Fixo', 'Recado')) DEFAULT 'Fixo'
);

CREATE TABLE email(
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES cliente(id) ON DELETE CASCADE,
    email varchar(200) NOT NULL
);

CREATE TABLE veiculo(
    id SERIAL PRIMARY KEY,
    modelo_id INTEGER REFERENCES modelo(id) ON DELETE CASCADE,
    ano INTEGER,
    cor varchar(100),
    chassi varchar(100),
    placa varchar(100)
);

CREATE TABLE acessorios(
    id SERIAL PRIMARY KEY,
    nome varchar(100),
    descricao varchar(100)
);

CREATE TABLE equipa(
    veiculo_id INTEGER REFERENCES veiculo(id) ON DELETE CASCADE,
    acessorios_id INTEGER REFERENCES acessorios(id) ON DELETE CASCADE,
    PRIMARY KEY (veiculo_id, acessorios_id)
);

CREATE TABLE modelo(
    id SERIAL PRIMARY KEY,
    modelo VARCHAR(100),
    potencia VARCHAR(15),
    versao VARCHAR(100),
    tipo VARCHAR(100)
);

CREATE TABLE compatível(
    acessorios_id INTEGER REFERENCES acessorios(id) ON DELETE CASCADE,
    modelo_id INTEGER REFERENCES modelo(id) ON DELETE CASCADE,
    PRIMARY KEY (acessorios_id, modelo_id)
);

-- DML

INSERT INTO cliente (ativo) VALUES (TRUE);
INSERT INTO cliente (ativo) VALUES (FALSE);

INSERT INTO pessoa_fisica (id, nome, cpf, nascimento)
VALUES (1, 'João da Silva', '123.456.789-00', '1985-06-15');

INSERT INTO pessoa_juridica (id, nome_fantasia, razao_social, cnpj)
VALUES (2, 'Tech Soluções', 'Tech Soluções Ltda', '11.222.333/0001-44');

INSERT INTO cliente (ativo) VALUES (TRUE);
INSERT INTO pessoa_fisica (id, nome, cpf, nascimento)
VALUES (3, 'Maria Oliveira', '987.654.321-00', '1990-12-01');

INSERT INTO cliente (ativo) VALUES (TRUE); 
INSERT INTO pessoa_juridica (id, nome_fantasia, razao_social, cnpj)
VALUES (4, 'Auto Mec', 'Auto Mecânica Brasil SA', '55.666.777/0001-88');

INSERT INTO endereco (cliente_id, logradouro, numero, complemento, bairro, cidade, estado, cep, tipo)
VALUES
(1, 'Rua das Flores', '123', 'Apto 101', 'Centro', 'São Paulo', 'SP', '01001-000', 'Residencial'),
(2, 'Av. Industrial', '456', NULL, 'Distrito', 'Campinas', 'SP', '13001-200', 'Comercial');

INSERT INTO telefone (cliente_id, ddd, numero, tipo)
VALUES
(1, '11', '912345678', 'Movel'),
(2, '19', '32345678', 'Fixo');

INSERT INTO email (cliente_id, email)
VALUES
(1, 'joao.silva@email.com'),
(2, 'contato@techsolucoes.com.br');