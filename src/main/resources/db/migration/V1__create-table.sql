CREATE TABLE TB_TIPO_DOMINIO (
    IDENT BIGINT NOT NULL,
    DS_TIPO VARCHAR(150),
    DT_CADASTRO TIMESTAMP NOT NULL,
    COD_TIPO_DOMINIO VARCHAR(70) NOT NULL,
    PRIMARY KEY (IDENT),
    CONSTRAINT UNIQUE_COD_TIPO_DOMINIO UNIQUE(COD_TIPO_DOMINIO)
);

CREATE TABLE TB_DOMINIO (
    IDENT BIGINT NOT NULL,
    COD_DOMINIO VARCHAR(70) NOT NULL,
    DOMINIO VARCHAR(150),
    ID_DOM_SITUACAO INTEGER,
    ID_TIPO INTEGER NOT NULL,
    DT_CADASTRO TIMESTAMP NOT NULL,
    PRIMARY KEY (IDENT),
    CONSTRAINT UNIQUE_COD_DOMINIO UNIQUE(COD_DOMINIO),
    CONSTRAINT FK_DOM_SITUACAO FOREIGN KEY (ID_DOM_SITUACAO) REFERENCES TB_DOMINIO(IDENT),
    CONSTRAINT FK_TIPO_DOMINIO FOREIGN KEY (ID_TIPO) REFERENCES TB_TIPO_DOMINIO(IDENT)
);

CREATE TABLE TB_PESSOA (
    IDENT BIGINT GENERATED BY DEFAULT AS IDENTITY,
    DS_NOME VARCHAR(255),
    DT_ATUALIZACAO TIMESTAMP(6) WITH TIME ZONE,
    ID_DOM_SITUACAO BIGINT,
    DS_TELEFONE VARCHAR(11),
    SG_TIPO_PESSOA VARCHAR(15) NOT NULL CHECK (
        SG_TIPO_PESSOA IN ('PESSOA_JURIDICA', 'PESSOA_FISSICA')
    ),
    PRIMARY KEY (IDENT),
    CONSTRAINT FK_DOM_SITUACAO_PESSOA FOREIGN KEY (ID_DOM_SITUACAO) REFERENCES TB_DOMINIO(IDENT)
);

CREATE TABLE TB_PESSOA_FISICA (
    ID_PESSOA BIGINT NOT NULL,
    ID_DOM_GENERO BIGINT,
    CD_CPF VARCHAR(11),
    PRIMARY KEY (ID_PESSOA),
    CONSTRAINT FK_ID_PF_PESSOA FOREIGN KEY (ID_PESSOA) REFERENCES TB_PESSOA(IDENT),
    CONSTRAINT FK_DOM_GENERO_PF FOREIGN KEY (ID_DOM_GENERO) REFERENCES TB_DOMINIO(IDENT)
);

CREATE TABLE TB_PESSOA_JURIDICA (
    ID_PESSOA BIGINT NOT NULL,
    CD_CNPJ VARCHAR(14),
    PRIMARY KEY (ID_PESSOA),
    CONSTRAINT FK_ID_PJ_PESSOA FOREIGN KEY (ID_PESSOA) REFERENCES TB_PESSOA(IDENT)
);

CREATE TABLE TB_LICENCA (
    IDENT BIGINT GENERATED BY DEFAULT AS IDENTITY,
    DT_ATUALIZACAO TIMESTAMP(6) WITH TIME ZONE,
    DT_EXPIRACAO TIMESTAMP(6) WITH TIME ZONE,
    ID_DOM_SITUACAO BIGINT,
    ID_DOM_TIPO_LICENCA BIGINT,
    ID_PESSOA_JURIDICA BIGINT,
    PRIMARY KEY (IDENT),
    CONSTRAINT FK_DOM_SITUACAO_LICENCA FOREIGN KEY (ID_DOM_SITUACAO) REFERENCES TB_DOMINIO(IDENT),
    CONSTRAINT FK_TIPO_LICENCA FOREIGN KEY (ID_DOM_TIPO_LICENCA) REFERENCES TB_DOMINIO(IDENT),
    CONSTRAINT FK_ID_PJ_LICENCA FOREIGN KEY (ID_PESSOA_JURIDICA) REFERENCES TB_PESSOA_JURIDICA(ID_PESSOA)
);

CREATE TABLE TB_TENANT (
    IDENT BIGINT GENERATED BY DEFAULT AS IDENTITY,
    DT_ATUALIZACAO TIMESTAMP(6) WITH TIME ZONE,
    DT_CADASTRO TIMESTAMP(6) WITH TIME ZONE,
    ID_PESSOA_JURIDICA BIGINT NOT NULL UNIQUE,
    DS_NOME VARCHAR(255),
    PRIMARY KEY (IDENT),
    CONSTRAINT FK_ID_PJ_TENANT FOREIGN KEY (ID_PESSOA_JURIDICA) REFERENCES TB_PESSOA_JURIDICA(ID_PESSOA)
);

CREATE TABLE TB_USUARIO (
    IDENT BIGINT GENERATED BY DEFAULT AS IDENTITY,
    DT_ATUALIZACAO TIMESTAMP(6) WITH TIME ZONE,
    ID_DOM_SITUACAO BIGINT,
    DS_SENHA VARCHAR(255),
    DS_TOKEN VARCHAR(255),
    PRIMARY KEY (IDENT),
    CONSTRAINT FK_DOM_SITUACAO_USUARIO FOREIGN KEY (ID_DOM_SITUACAO) REFERENCES TB_DOMINIO(IDENT)
);

CREATE TABLE TB_USUARIO_TENANT (
    IDENT BIGINT GENERATED BY DEFAULT AS IDENTITY,
    DT_ATUALIZACAO TIMESTAMP(6) WITH TIME ZONE,
    ID_DOM_SITUACAO BIGINT,
    ID_TENANT BIGINT,
    ID_USUARIO BIGINT,
    PRIMARY KEY (IDENT),
    CONSTRAINT FK_DOM_SITUACAO_TENANT_USUARIO FOREIGN KEY (ID_DOM_SITUACAO) REFERENCES TB_DOMINIO(IDENT),
    CONSTRAINT FK_ID_TENANT_USUARIO FOREIGN KEY (ID_TENANT) REFERENCES TB_TENANT(IDENT),
    CONSTRAINT FK_ID_USUARIO_TENANT FOREIGN KEY (ID_USUARIO) REFERENCES TB_USUARIO(IDENT)
);

CREATE TABLE TB_VINCULO_FUNCIONARIO (
    IDENT BIGINT GENERATED BY DEFAULT AS IDENTITY,
    DT_ATUALIZACAO TIMESTAMP(6) WITH TIME ZONE,
    ID_DOM_CARGO BIGINT,
    ID_DOM_SITUACAO BIGINT,
    ID_PESSOA_FISICA BIGINT,
    ID_PESSOA_JURIDICA BIGINT,
    PRIMARY KEY (IDENT),
    CONSTRAINT FK_DOM_SIT_FUNC FOREIGN KEY (ID_DOM_SITUACAO) REFERENCES TB_DOMINIO(IDENT),
    CONSTRAINT FK_DOM_CARGO_FUNC FOREIGN KEY (ID_DOM_CARGO) REFERENCES TB_DOMINIO(IDENT),
    CONSTRAINT FK_ID_PF_FUNC FOREIGN KEY (ID_PESSOA_FISICA) REFERENCES TB_PESSOA_FISICA(ID_PESSOA),
    CONSTRAINT FK_ID_PJ_FUNC FOREIGN KEY (ID_PESSOA_JURIDICA) REFERENCES TB_PESSOA_JURIDICA(ID_PESSOA)
);