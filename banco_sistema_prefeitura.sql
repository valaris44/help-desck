-- Reset do banco de dados
DROP DATABASE IF EXISTS sistema_prefeitura;
CREATE DATABASE sistema_prefeitura DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sistema_prefeitura;

-- Tabela de setores
CREATE TABLE setores (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    nome_setor VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela de usuários
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    matricula VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('servidor', 'admin', 'tecnico') NOT NULL DEFAULT 'servidor',
    telefone VARCHAR(20),
    area_atuacao VARCHAR(100),
    id_setor INT,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATETIME NULL,
    FOREIGN KEY (id_setor) REFERENCES setores(id_setor)
);

-- Tabela de status dos chamados
CREATE TABLE status_chamado (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela de chamados
CREATE TABLE chamados (
    id_problema INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    nome_problema VARCHAR(255) NOT NULL,
    descricao TEXT,
    prioridade ENUM('baixa','média','alta') DEFAULT 'média',
    id_status INT NOT NULL DEFAULT 1,
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_fechamento DATETIME NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_status) REFERENCES status_chamado(id_status)
);

-- Tabela de anexos dos chamados
CREATE TABLE anexos_chamado (
    id_anexo INT AUTO_INCREMENT PRIMARY KEY,
    id_problema INT NOT NULL,
    nome_arquivo VARCHAR(255) NOT NULL,
    caminho_arquivo VARCHAR(255) NOT NULL,
    data_upload DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_problema) REFERENCES chamados(id_problema)
);

-- Tabela de histórico de alterações dos chamados
CREATE TABLE historico_chamado (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_problema INT NOT NULL,
    id_usuario INT NOT NULL,
    acao VARCHAR(255) NOT NULL,
    detalhes TEXT,
    data_acao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_problema) REFERENCES chamados(id_problema),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabela de logs do sistema (opcional para auditoria)
CREATE TABLE logs_sistema (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    acao VARCHAR(255) NOT NULL,
    detalhes TEXT,
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Dados iniciais mínimos
INSERT INTO setores (nome_setor) VALUES
('Administração'), ('TI'), ('Saúde'), ('Educação')
ON DUPLICATE KEY UPDATE nome_setor=VALUES(nome_setor);

INSERT INTO status_chamado (nome_status) VALUES
('Aberto'), ('Em andamento'), ('Finalizado'), ('Cancelado')
ON DUPLICATE KEY UPDATE nome_status=VALUES(nome_status);

-- Visualização para facilitar consultas dos chamados
CREATE OR REPLACE VIEW vw_chamados_completo AS
SELECT
    c.id_problema,
    u.nome AS nome_usuario,
    u.matricula,
    u.email,
    u.telefone,
    u.area_atuacao,
    s2.nome_setor,
    c.titulo,
    c.nome_problema,
    c.descricao,
    c.prioridade,
    s.nome_status AS status,
    c.data_envio,
    c.data_fechamento
FROM chamados c
JOIN usuarios u ON c.id_usuario = u.id_usuario
LEFT JOIN setores s2 ON u.id_setor = s2.id_setor
JOIN status_chamado s ON c.id_status = s.id_status;
