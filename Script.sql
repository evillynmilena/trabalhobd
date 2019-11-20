-
CREATE TABLE IF NOT EXISTS Dieta (
  cod_dieta INTEGER NOT NULL,
  autoria VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (cod_dieta));

CREATE UNIQUE INDEX cod_dieta_UNIQUE ON Dieta (cod_dieta ASC);


-- -----------------------------------------------------
-- Table Administrador
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Administrador (
  CRA INTEGER NOT NULL,
  cod_usuario_adm INTEGER,
  PRIMARY KEY (cod_usuario_adm));


 ALTER TABLE Administrador 
 ADD FOREIGN KEY (cod_usuario_adm)
    REFERENCES Profissional (cod_usuario);


CREATE INDEX fk_Administrador_Profissional2_idx ON Administrador (cod_usuario_adm ASC);


-- -----------------------------------------------------
-- Table Profissional
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Profissional (
  cod_usuario INTEGER NOT NULL,
  nome VARCHAR(100) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  situacao INTEGER NOT NULL,
  fone BIGINT NOT NULL,
  data DATE NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  cod_usuario_adm INTEGER ,
  PRIMARY KEY (cod_usuario));
    
    ALTER TABLE Profissional ADD 
    FOREIGN KEY (cod_usuario_adm)
    REFERENCES Administrador (cod_usuario_adm);

CREATE UNIQUE INDEX cod_usuario_UNIQUE ON Profissional (cod_usuario ASC);

CREATE UNIQUE INDEX email_UNIQUE ON Profissional (email ASC);

CREATE INDEX fk_Profissional_Administrador1_idx ON Profissional (cod_usuario_adm ASC);


-- -----------------------------------------------------
-- Table Nutricionista
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Nutricionista (
  CRN DECIMAL(10,0) NOT NULL,
  cod_usuario_nutri INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_nutri),
  CONSTRAINT fk_Nutricionista_Profissional1
  	
    FOREIGN KEY (cod_usuario_nutri)
    REFERENCES Profissional (cod_usuario));

-- -----------------------------------------------------
-- Table Medico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Medico (
  CRM DECIMAL(10,0) NOT NULL,
  especialidade VARCHAR(45) NOT NULL,
  cod_usuario_med INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_med),
    FOREIGN KEY (cod_usuario_med)
    REFERENCES Profissional (cod_usuario));


-- -----------------------------------------------------
-- Table enfermeiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS enfermeiro (
  COREN DECIMAL(10,0) NOT NULL,
  especialidade VARCHAR(45) NULL,
  cod_usuario_enf INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_enf),
    FOREIGN KEY (cod_usuario_enf)
    REFERENCES Profissional (cod_usuario));


-- -----------------------------------------------------
-- Table Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Paciente (
  CPF VARCHAR(11) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  sexo INTEGER NOT NULL,
  data_nasc DATE NOT NULL,
  rua VARCHAR(100) NULL,
  bairro VARCHAR(50) NULL,
  numero INTEGER NULL,
  CEP DECIMAL(10,0) NULL,
  foto VARCHAR(100) NULL,
  PRIMARY KEY (CPF));



-- -----------------------------------------------------
-- Table Internacao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Internacao (
  seq_intern INTEGER NOT NULL,
  data_saida DATE NULL,
  data_ent DATE NOT NULL,
  procedim TEXT NULL,
  dec_atual TEXT NULL,
  alergia TEXT NULL,
  incapaci TEXT NULL,
  estado TEXT NULL,
  doenca TEXT NOT NULL,
  andar INTEGER NOT NULL,
  leito VARCHAR(45) NOT NULL,
  quarto VARCHAR(45) NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  cod_usuario_med INTEGER NOT NULL,
  PRIMARY KEY (seq_intern, CPF),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF),
    FOREIGN KEY (cod_usuario_med)
    REFERENCES Medico(cod_usuario_med));

CREATE UNIQUE INDEX seq_intern_UNIQUE ON Internacao (seq_intern ASC);

CREATE INDEX fk_Internacao_Paciente1_idx ON Internacao (CPF ASC);

CREATE INDEX fk_Internacao_Medico1_idx ON Internacao (cod_usuario_med ASC);


-- -----------------------------------------------------
-- Table Prescricao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Prescricao (
  data DATE NOT NULL,
  cod_dieta INTEGER NOT NULL,
  seq_intern INTEGER NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  cod_usuario_nutri INTEGER NOT NULL,
  PRIMARY KEY (cod_dieta, seq_intern, CPF),
    FOREIGN KEY (cod_dieta)
    REFERENCES Dieta (cod_dieta),
    FOREIGN KEY (seq_intern , CPF)
    REFERENCES Internacao (seq_intern , CPF),
    FOREIGN KEY (cod_usuario_nutri)
    REFERENCES Nutricionista (cod_usuario_nutri));

CREATE INDEX fk_Prescricao_Dieta1_idx ON Prescricao (cod_dieta ASC);

CREATE INDEX fk_Prescricao_Internacao1_idx ON Prescricao (seq_intern ASC, CPF ASC);

CREATE INDEX fk_Prescricao_Nutricionista1_idx ON Prescricao (cod_usuario_nutri ASC);


-- -----------------------------------------------------
-- Table Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cardapio (
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (cod_card));


-- -----------------------------------------------------
-- Table Alimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Alimento (
  cod_alim INTEGER NOT NULL,
  nome varchar (40) NOT NULL,
  proteina FLOAT NOT NULL,
  gordura FLOAT NOT NULL,
  carboidrato FLOAT NOT  NULL,
  caloria FLOAT NOT NULL,
  PRIMARY KEY (cod_alim));


-- -----------------------------------------------------
-- Table Dieta_Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Dieta_Cardapio (
  cod_dieta INTEGER NOT NULL,
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (cod_dieta, cod_card),
    FOREIGN KEY (cod_dieta)
    REFERENCES Dieta (cod_dieta),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card));

CREATE INDEX fk_Dieta_has_Cardapio_Cardapio1_idx ON Dieta_Cardapio (cod_card ASC);

CREATE INDEX fk_Dieta_has_Cardapio_Dieta_idx ON Dieta_Cardapio (cod_dieta ASC);


-- -----------------------------------------------------
-- Table Cardapio_Alimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cardapio_Alimento (
  cod_card INTEGER NOT NULL,
  cod_alim INTEGER NOT NULL,
  quantidade INTEGER NULL,
  PRIMARY KEY (cod_card, cod_alim),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card),
    FOREIGN KEY (cod_alim)
    REFERENCES Alimento (cod_alim));

CREATE INDEX fk_Cardapio_has_Alimento_Alimento1_idx ON Cardapio_Alimento (cod_alim ASC);

CREATE INDEX fk_Cardapio_has_Alimento_Cardapio1_idx ON Cardapio_Alimento (cod_card ASC);


-- -----------------------------------------------------
-- Table Cozinheiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cozinheiro (
  registro INTEGER NOT NULL,
  cod_usuario_coz INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_coz),
    FOREIGN KEY (cod_usuario_coz)
    REFERENCES Profissional (cod_usuario));


-- -----------------------------------------------------
-- Table Cozinheiro_Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cozinheiro_Cardapio (
  cod_usuario_coz INTEGER NOT NULL,
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario_coz, cod_card),
    FOREIGN KEY (cod_usuario_coz)
    REFERENCES Cozinheiro (cod_usuario_coz),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card));

CREATE INDEX fk_Cozinheiro_has_Cardapio_Cardapio1_idx ON Cozinheiro_Cardapio (cod_card ASC);

CREATE INDEX fk_Cozinheiro_has_Cardapio_Cozinheiro1_idx ON Cozinheiro_Cardapio (cod_usuario_coz ASC);


-- -----------------------------------------------------
-- Table Nutricionista_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Nutricionista_Paciente (
  cod_usuario_nutri integer NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  PRIMARY KEY (cod_usuario_nutri, CPF),
    FOREIGN KEY (cod_usuario_nutri)
    REFERENCES Nutricionista (cod_usuario_nutri),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF));

CREATE INDEX fk_Nutricionista_has_Paciente_Paciente1_idx ON Nutricionista_Paciente (CPF ASC);

CREATE INDEX fk_Nutricionista_has_Paciente_Nutricionista1_idx ON Nutricionista_Paciente (cod_usuario_nutri ASC);


-- -----------------------------------------------------
-- Table Medico_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Medico_Paciente (
  cod_usuario_med INTEGER NOT NULL,
  CPF VARCHAR(11)NOT NULL,
  PRIMARY KEY (cod_usuario_med, CPF),
    FOREIGN KEY (cod_usuario_med)
    REFERENCES Medico (cod_usuario_med),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF));

CREATE INDEX fk_Medico_has_Paciente_Paciente1_idx ON Medico_Paciente (CPF ASC);

CREATE INDEX fk_Medico_has_Paciente_Medico1_idx ON Medico_Paciente (cod_usuario_med ASC);


-- -----------------------------------------------------
-- Table enfermeiro_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS enfermeiro_Paciente (
  cod_usuario_enf INTEGER NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  PRIMARY KEY (cod_usuario_enf, CPF),
    FOREIGN KEY (cod_usuario_enf)
    REFERENCES enfermeiro (cod_usuario_enf),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF));

CREATE INDEX fk_enfermeiro_has_Paciente_Paciente1_idx ON enfermeiro_Paciente (CPF ASC);

CREATE INDEX fk_enfermeiro_has_Paciente_enfermeiro1_idx ON enfermeiro_Paciente (cod_usuario_enf ASC);


-- -----------------------------------------------------
-- Table OBS_Internacao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OBS_Internacao (
  CPF VARCHAR(11) NOT NULL,
  seq_intern INTEGER NOT NULL,
  observacao VARCHAR(45) NULL,
  seq_obs INTEGER NOT NULL,
  PRIMARY KEY (CPF, seq_intern, seq_obs),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF),
    FOREIGN KEY (seq_intern)
    REFERENCES Internacao (seq_intern));

CREATE INDEX fk_Paciente_has_Internacao_Internacao1_idx ON OBS_Internacao (seq_intern ASC);

CREATE INDEX fk_Paciente_has_Internacao_Paciente1_idx ON OBS_Internacao (CPF ASC);

------------------------------------------&&------------------------------S


-- -----------------------------------------------------
-- Table Fone_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fone_Paciente (
  seq_fone INTEGER NOT NULL,
  telefone BIGINT NOT NULL,
  CPF VARCHAR (11) NOT NULL,
  PRIMARY KEY (seq_fone,CPF),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF)); 

CREATE INDEX fk_Fone_Paciente_Paciente1_idx ON Fone_Paciente (CPF ASC);


-- -----------------------------------------------------
-- Table Familia_Paciente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Familia_Paciente (
  seq_familia INTEGER NOT NULL,
  parentesco VARCHAR(40) NOT NULL,
  nome VARCHAR (100),
  CPF VARCHAR(11) NOT NULL,
  PRIMARY KEY (seq_familia, CPF),
    FOREIGN KEY (CPF)
    REFERENCES Paciente (CPF)
    )
;

CREATE INDEX fk_Familia_Paciente_Paciente1_idx ON Familia_Paciente (CPF ASC);


-- -----------------------------------------------------
-- Table Refeicao_Cardapio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Refeicao_Cardapio (
  seq_refeicao INTEGER NOT NULL,
  refeicao VARCHAR(45) NOT NULL,
  cod_card INTEGER NOT NULL,
  PRIMARY KEY (seq_refeicao, cod_card),
    FOREIGN KEY (cod_card)
    REFERENCES Cardapio (cod_card)
    )
;

CREATE INDEX fk_Refeicao_Cardapio_Cardapio1_idx ON Refeicao_Cardapio (cod_card ASC);


-- -----------------------------------------------------
-- Table Vitamina_Alimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Vitamina_Alimento (
  seq_vitamina INTEGER NOT NULL,
  vitamina VARCHAR(45) NULL,
  cod_alim INTEGER NOT NULL,
  PRIMARY KEY (seq_vitamina, cod_alim),
    FOREIGN KEY (cod_alim)
    REFERENCES Alimento (cod_alim)
    )
;

CREATE INDEX fk_Vitamina_Alimento_Alimento1_idx ON Vitamina_Alimento (cod_alim ASC);


-- -----------------------------------------------------
-- Table Internacao_Dieta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Internacao_Dieta (
  seq_intern INTEGER NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  cod_dieta INTEGER NOT NULL,
  PRIMARY KEY (seq_intern, CPF, cod_dieta),
    FOREIGN KEY (seq_intern , CPF)
    REFERENCES Internacao (seq_intern , CPF),
    FOREIGN KEY (cod_dieta)
    REFERENCES Dieta (cod_dieta));

CREATE INDEX fk_Internacao_has_Dieta_Dieta1_idx ON Internacao_Dieta (cod_dieta ASC);

CREATE INDEX fk_Internacao_has_Dieta_Internacao1_idx ON Internacao_Dieta (seq_intern ASC, CPF ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




-------------------------- SEQUENCES--------------------------

CREATE SEQUENCE sequence_profissional;
CREATE SEQUENCE sequence_dieta ;
CREATE SEQUENCE sequence_cardapio;
CREATE SEQUENCE sequence_alimento;


----------------------------------------USUARIO ESPECIAL ADMINISTRADOR-------------------------------------------------------

INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( '123','EVillyn Milena','7656789','evillynmilena@gmail.com','1','16997231009','2019.11.20','administrador', '123');

INSERT INTO administrador (cra,cod_usuario_adm) VALUES ('4213','123');

------------------------------------------INSERT PROFISSIONAL----------------------------------------------------------------
INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Maria josé','78780','maria@gmail.com','1','1698654367','2013.10.22','cozinheira', '123');

INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Marcelo Rosa','97766556','drmarcelo@gmail.com','1','16864904532','2016.10.02','medico', '123');

INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Paula souza','877339202','nutripaula@gmail.com','1','1698783398','2018.12.07','nutricionista', '123');

INSERT INTO profissional (cod_usuario,nome,senha,email,situacao,fone,data,tipo,cod_usuario_adm)VALUES( NEXTVAL('sequence_profissional'),'Ricardo Pereira','78780','ricardo@gmail.com','1','16985643671','2011.02.04','enfermeiro', '123');


---------------------------------------INSERT ALIMENTOS------------------------------------------------------------------

INSERT INTO alimento (cod_alim,nome,proteina,gordura,carboidrato,caloria) VALUES (NEXTVAL('sequence_alimento'),'abobora cozida','1.4','0.7','10.28','48');

------------------------------------INSERT CARDAPIO--------------------------------------------------------------------

INSERT INTO cardapio (cod_card) VALUES (NEXTVAL('sequence_cardapio'));

----------------------------------------INSERT CARDAPIO ALIMENTO --------------------------------------

INSERT INTO cardapio_alimento (cod_card,cod_alim,quantidade) VALUES ('01','01','01');

------------------------------------------INSERT DIETA-------------------------------------------------

INSERT INTO dieta (cod_dieta,nome,autoria) VALUES (NEXTVAL('sequence_dieta'),'natural','Paula souza');
 
 --------------------------------------INSERT DIETA CARDAPIO-------------------------------------------

INSERT INTO dieta_cardapio (cod_dieta,cod_card) VALUES ('1','1');

------------------------------------- INSERT COZINHEIRO---------------------------------------------

INSERT INTO cozinheiro (registro,cod_usuario_coz) VALUES ('87655343','1');

------------------------------------ INSERT COZINHEIRO CARDAPIO -----------------------------------

INSERT INTO cozinheiro_cardapio (cod_card, cod_usuario_coz) VALUES ('1','1');

------------------------------------- INSERT ENFERMEIRO --------------------------------------

INSERT INTO enfermeiro (coren,especialidade,cod_usuario_enf) VALUES ('09987652','intensivista','4');

------------------------------------INSERT PACIENTE------------------------------------------

INSERT INTO paciente (cpf,nome,sexo,data_nasc,rua,bairro,numero,cep) VALUES ('97542156789','José carlos','01','1980.02.11','são sebatião','centro','22','14120000');

---------------------------------INSERT ENFERMEIRO PACIENTE ---------------------------
INSERT INTO enfermeiro_paciente (cod_usuario_enf,cpf) VALUES('04','97542156789');

---------------------------------- INSERT FAMILIA PACIENTE-----------------------------

INSERT INTO familia_paciente (seq_familia,parentesco,nome,cpf) VALUES ('01','Irmã','lourdes de fatima','97542156789');

--------------------------------- INSERT FONE PACIENTE------------------------------

INSERT INTO fone_paciente (seq_fone,telefone,cpf) VALUES('01','16993261653','97542156789');

-----------------------------------INSERT MEDICO------------------------------

INSERT INTO medico (crm, cod_usuario_med, especialidade) VALUES('454527','2','clinico');

----------------------------------------INSERT MEDICO PACIENTE ------------------------------------

INSERT INTO medico_paciente (cod_usuario_med,cpf) VALUES ('2','97542156789');
---------------------------------- INSERT INTERNACAO---------------------------------

INSERT INTO internacao (seq_intern,data_ent,data_saida,procedim,dec_atual,alergia,incapaci,estado,doenca,andar,leito,quarto,cpf,cod_usuario_med) 
VALUES('01','2019.11.09','2019.11.20','entubação','conciente e falando','não','não','bom','diabetes tipo 1','02','502','18','97542156789','2');

----------------------------------INSERT INTERNACAO DIETA--------------------------------------

INSERT INTO internacao_dieta (seq_intern,cpf,cod_dieta) VALUES('01','97542156789','01');

----------------------------------- INSERT NUTRICIONISTA----------------------

INSERT INTO nutricionista (crn,cod_usuario_nutri) VALUES('004887583','03');

--------------------------------INSERT PACIENTE NUTRICIONISTA-------------------

INSERT INTO nutricionista_paciente (cod_usuario_nutri,cpf) VALUES ('03','97542156789');

---------------------------------INSERT OBS_Internacao-------------------------------------

INSERT INTO obs_internacao (cpf,seq_intern,seq_obs,observacao) VALUES ('97542156789','01','não apresentou piora do quadro');

---------------------------------INSERT REFEICAO CARDAPIO----------------------------------
INSERT INTO refeicao_cardapio (seq_refeicao,refeicao,cod_card) VALUES ('02','almoco','01');

---------------------------- INSERT VITAMINA-------------------------------------------------
INSERT INTO vitamina_alimento  (seq_vitamina, vitamina, cod_alim) VALUES ('01','vitamina C','01');

-----------------------------INSERT PRESCRICAO---------------------------------------------------------
INSERT INTO prescricao (data,cod_dieta,seq_intern,cpf,cod_usuario_nutri) VALUES ('2019.11.20','01','01','97542156789','03');

























