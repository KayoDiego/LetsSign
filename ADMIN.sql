-- Tabela de Usuários
CREATE TABLE T_USUARIO (
    id_usuario NUMBER PRIMARY KEY,
    nome_usuario VARCHAR2(100) NOT NULL,
    email_usuario VARCHAR2(100) UNIQUE NOT NULL,
    senha_usuario VARCHAR2(255) NOT NULL,
    telefone_usuario VARCHAR2(15),
    dt_cadastro_usuario DATE NOT NULL
);

-- Tabela de Pessoa Física
CREATE TABLE T_PESSOA_FISICA (
    id_usuario NUMBER PRIMARY KEY,
    nr_cpf VARCHAR2(11) UNIQUE NOT NULL,
    CONSTRAINT FK_PessoaFisica_Usuario FOREIGN KEY (id_usuario)
        REFERENCES T_USUARIO (id_usuario)
);

-- Tabela de Pessoa Jurídica
CREATE TABLE T_PESSOA_JURIDICA (
    id_usuario NUMBER PRIMARY KEY,
    nome_fantasia VARCHAR2(100),
    nr_cnpj VARCHAR2(14) UNIQUE NOT NULL,
    ds_ramo_atividade VARCHAR2(100),
    CONSTRAINT FK_PessoaJuridica_Usuario FOREIGN KEY (id_usuario)
        REFERENCES T_USUARIO (id_usuario)
);

-- Tabela de Identidades Digitais
CREATE TABLE T_IDENTIDADE_DIGITAL (
    id_identidade_digital NUMBER PRIMARY KEY,
    id_usuario NUMBER NOT NULL,
    chave_publica CLOB NOT NULL,
    certificado_digital CLOB NOT NULL,
    dt_emissao DATE NOT NULL,
    dt_expiracao DATE,
    CONSTRAINT FK_IdentidadeDigital_Usuario FOREIGN KEY (id_usuario)
        REFERENCES T_USUARIO (id_usuario)
);

-- Tabela de Documentos
CREATE TABLE T_DOCUMENTOS (
    id_documento NUMBER PRIMARY KEY,
    id_usuario NUMBER NOT NULL,
    nome_documento VARCHAR2(100),
    hash_documento CLOB NOT NULL,
    dt_cadastro_documento DATE NOT NULL,
    status_validacao VARCHAR2(20),
    CONSTRAINT FK_Documentos_Usuario FOREIGN KEY (id_usuario)
        REFERENCES T_USUARIO (id_usuario)
);

-- Tabela de Biometria
CREATE TABLE T_BIOMETRIA (
    id_biometria NUMBER PRIMARY KEY,
    id_usuario NUMBER NOT NULL,
    tipo_biometria VARCHAR2(50),
    dados_biometricos CLOB NOT NULL,
    dt_biometria DATE NOT NULL,
    CONSTRAINT FK_Biometria_Usuario FOREIGN KEY (id_usuario)
        REFERENCES T_USUARIO (id_usuario)
);

-- Tabela de Blocos Blockchain
CREATE TABLE T_BLOCOS_BLOCKCHAIN (
    id_bloco NUMBER PRIMARY KEY,
    bloco_hash CLOB NOT NULL,
    dt_inclusao DATE NOT NULL,
    bloco_hash_anterior CLOB
);

-- Tabela de Transações Blockchain
CREATE TABLE T_TRANSACOES_BLOCKCHAIN (
    id NUMBER PRIMARY KEY,
    id_bloco NUMBER NOT NULL,
    id_documento NUMBER NOT NULL,
    hash_transacao CLOB NOT NULL,
    dt_transacao DATE NOT NULL,
    CONSTRAINT FK_Transacoes_Bloco FOREIGN KEY (id_bloco)
        REFERENCES T_BLOCOS_BLOCKCHAIN (id_bloco),
    CONSTRAINT FK_Transacoes_Documento FOREIGN KEY (id_documento)
        REFERENCES T_DOCUMENTOS (id_documento)
);

-- Tabela de Assinaturas
CREATE TABLE T_ASSINATURAS (
    id_assinatura NUMBER PRIMARY KEY,
    id_usuario NUMBER NOT NULL,
    id_documento NUMBER NOT NULL,
    assinatura_digital CLOB NOT NULL,
    dt_assinatura DATE NOT NULL,
    validacao_biometria CHAR(1) CHECK (validacao_biometria IN ('0', '1')),
    validacao_blockchain CHAR(1) CHECK (validacao_blockchain IN ('0', '1')),
    CONSTRAINT FK_Assinaturas_Usuario FOREIGN KEY (id_usuario)
        REFERENCES T_USUARIO (id_usuario),
    CONSTRAINT FK_Assinaturas_Documento FOREIGN KEY (id_documento)
        REFERENCES T_DOCUMENTOS (id_documento)
);