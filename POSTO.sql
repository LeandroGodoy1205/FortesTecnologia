/******************************************************************************/
/****                              Generators                              ****/
/******************************************************************************/

CREATE GENERATOR GEN_BOMBAS_ID;
SET GENERATOR GEN_BOMBAS_ID TO 3;

CREATE GENERATOR GEN_COMBUSTIVEL_ID;
SET GENERATOR GEN_COMBUSTIVEL_ID TO 0;

CREATE GENERATOR GEN_TANQUE_ID;
SET GENERATOR GEN_TANQUE_ID TO 3;

CREATE GENERATOR GEN_VENDAS_ID;
SET GENERATOR GEN_VENDAS_ID TO 20;



SET TERM ^ ; 



/******************************************************************************/
/****                          Stored Procedures                           ****/
/******************************************************************************/

CREATE PROCEDURE PRELATORIO_ABASTECIMENTOS (
    PDATA_INICIAL DATE,
    PDATA_FINAL DATE)
RETURNS (
    ID_VENDA INTEGER,
    ID_BOMBA INTEGER,
    QTD_VENDA DECIMAL(9,2),
    VLR_VENDA DECIMAL(18,2),
    DATA_VENDA DATE,
    DESCRICAO_BOMBA VARCHAR(40),
    DESCRICAO_TANQUE VARCHAR(40),
    DESCRICAO_COMBUSTIVEL VARCHAR(40),
    VLR_COMIMPOSTO DECIMAL(5,2))
AS
BEGIN
  SUSPEND;
END^



SET TERM ; ^



/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/



CREATE TABLE BOMBAS (
    ID_BOMBAS        INTEGER NOT NULL,
    ID_TANQUE        INTEGER,
    DESCRICAO_BOMBA  VARCHAR(40)
);

CREATE TABLE COMBUSTIVEL (
    ID_COMBUSTIVEL         INTEGER NOT NULL,
    DESCRICAO_COMBUSTIVEL  VARCHAR(40),
    VALOR_COMBUSTIVEL      DECIMAL(5,2),
    IMPOSTO_COMBUSTIVEL    DECIMAL(5,2)
);

CREATE TABLE TANQUE (
    ID_TANQUE          INTEGER NOT NULL,
    ID_COMBUSTIVEL     INTEGER,
    DESCRICAO_TANQUE   VARCHAR(40),
    CAPACIDADE_TANQUE  DECIMAL(15,2)
);

CREATE TABLE VENDAS (
    ID_VENDA        INTEGER NOT NULL,
    ID_BOMBA        INTEGER,
    QTD_VENDA       DECIMAL(5,2),
    VLR_VENDA       DECIMAL(15,2),
    DATA_VENDA      DATE,
    VLR_COMIMPOSTO  NUMERIC(5,2)
);



/******************************************************************************/
/****                             Primary Keys                             ****/
/******************************************************************************/

ALTER TABLE BOMBAS ADD CONSTRAINT PK_BOMBAS PRIMARY KEY (ID_BOMBAS);
ALTER TABLE COMBUSTIVEL ADD CONSTRAINT PK_COMBUSTIVEL PRIMARY KEY (ID_COMBUSTIVEL);
ALTER TABLE TANQUE ADD CONSTRAINT PK_TANQUE PRIMARY KEY (ID_TANQUE);
ALTER TABLE VENDAS ADD CONSTRAINT PK_VENDAS PRIMARY KEY (ID_VENDA);


/******************************************************************************/
/****                             Foreign Keys                             ****/
/******************************************************************************/

ALTER TABLE BOMBAS ADD CONSTRAINT FK_BOMBAS_1 FOREIGN KEY (ID_TANQUE) REFERENCES TANQUE (ID_TANQUE);
ALTER TABLE TANQUE ADD CONSTRAINT FK_TANQUE_1 FOREIGN KEY (ID_COMBUSTIVEL) REFERENCES COMBUSTIVEL (ID_COMBUSTIVEL);
ALTER TABLE VENDAS ADD CONSTRAINT FK_VENDAS_1 FOREIGN KEY (ID_BOMBA) REFERENCES BOMBAS (ID_BOMBAS);


/******************************************************************************/
/****                               Triggers                               ****/
/******************************************************************************/


SET TERM ^ ;



/******************************************************************************/
/****                         Triggers for tables                          ****/
/******************************************************************************/



/* Trigger: BOMBAS_BI */
CREATE TRIGGER BOMBAS_BI FOR BOMBAS
ACTIVE BEFORE INSERT POSITION 0
as
begin
    new.id_bombas = gen_id(gen_bombas_id,1);
end
^

/* Trigger: COMBUSTIVEL_BI0 */
CREATE TRIGGER COMBUSTIVEL_BI0 FOR COMBUSTIVEL
ACTIVE BEFORE INSERT POSITION 0
AS
begin
  /* Trigger text */
  NEW.id_combustivel = gen_id(gen_combustivel_id,1);
end
^

/* Trigger: TANQUE_BI */
CREATE TRIGGER TANQUE_BI FOR TANQUE
ACTIVE BEFORE INSERT POSITION 0
as
begin
    new.id_tanque = gen_id(gen_tanque_id,1);
end
^

/* Trigger: VENDAS_BI */
CREATE TRIGGER VENDAS_BI FOR VENDAS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  new.id_venda = gen_id(gen_vendas_id,1);
end
^

SET TERM ; ^



/******************************************************************************/
/****                          Stored Procedures                           ****/
/******************************************************************************/


SET TERM ^ ;

ALTER PROCEDURE PRELATORIO_ABASTECIMENTOS (
    PDATA_INICIAL DATE,
    PDATA_FINAL DATE)
RETURNS (
    ID_VENDA INTEGER,
    ID_BOMBA INTEGER,
    QTD_VENDA DECIMAL(9,2),
    VLR_VENDA DECIMAL(18,2),
    DATA_VENDA DATE,
    DESCRICAO_BOMBA VARCHAR(40),
    DESCRICAO_TANQUE VARCHAR(40),
    DESCRICAO_COMBUSTIVEL VARCHAR(40),
    VLR_COMIMPOSTO DECIMAL(5,2))
AS
BEGIN
  FOR
    SELECT  V.ID_VENDA,
            V.ID_BOMBA,
            V.QTD_VENDA,
            CAST(V.VLR_VENDA AS DECIMAL(5,2)),
            V.DATA_VENDA,
            B.DESCRICAO_BOMBA,
            T.DESCRICAO_TANQUE,
            C.DESCRICAO_COMBUSTIVEL,
            V.VLR_COMIMPOSTO
    FROM VENDAS V
    INNER JOIN BOMBAS B ON B.ID_BOMBAS = V.ID_BOMBA
    INNER JOIN TANQUE T ON T.ID_TANQUE = B.ID_TANQUE
    INNER JOIN COMBUSTIVEL C ON C.ID_COMBUSTIVEL = T.ID_COMBUSTIVEL
    WHERE V.DATA_VENDA BETWEEN :PDATA_INICIAL AND :PDATA_FINAL
    ORDER BY V.DATA_VENDA, T.DESCRICAO_TANQUE, B.DESCRICAO_BOMBA
    INTO :ID_VENDA,
         :ID_BOMBA,
         :QTD_VENDA,
         :VLR_VENDA,
         :DATA_VENDA,
         :DESCRICAO_BOMBA,
         :DESCRICAO_TANQUE,
         :DESCRICAO_COMBUSTIVEL,
         :VLR_COMIMPOSTO
  DO
  BEGIN
    SUSPEND;
  END
END^



SET TERM ; ^


/* Fields descriptions */

DESCRIBE FIELD VALOR_COMBUSTIVEL TABLE COMBUSTIVEL
'LITROS';

DESCRIBE FIELD IMPOSTO_COMBUSTIVEL TABLE COMBUSTIVEL
'%';

