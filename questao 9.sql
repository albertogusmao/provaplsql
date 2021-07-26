 -- Criando a trigger 
 --------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------
 
 create or replace trigger tg_tcall
  after insert  
  on tcall
  for each row
declare
begin

  proc_om_record(:new.TIPO,:new.subtipo);
  
end tg_log;
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
-- criando a sequence 
create sequence oid_SEQ
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
nocache
cycle;

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- criando a procedure 

CREATE OR REPLACE
PROCEDURE proc_om_record(P_TIPO NUMBER,P_SUBTIPO NUMBER)
    is
   V_NATUREZA NUMBER(20):=0; 
   V_CONT NUMBER(20):=0; 
    
begin

 
  SELECT COUNT(1)
   INTO V_CONT
   FROM OM_RECORD_NATUREZA
  WHERE tipo =P_TIPO
    AND subtipo=P_SUBTIPO;
      

  IF V_CONT<>0 THEN 
  
  -- ESTOU LEVANDO EM CONSIDERACAO QUE CASO EXISTA REGISTRO EM OM_RECORD_NATUREZA RETORNE APENAS 1 REGISTRO, CASO TENHA MAIS DE 1 TERIA QUE 
 -- TRATAR ESSA POSSIBILIDADE E O SELECT ABAIXO DARIA ERRO.
  
  SELECT NATUREZA
   INTO V_NATUREZA
   FROM OM_RECORD_NATUREZA
  WHERE tipo =P_TIPO
    AND subtipo=P_SUBTIPO;
    
  END IF;  
  
  INSERT INTO om_record (oid,tipo,subtipo,natureza,data_criacao)
     VALUES (oid_SEQ.nextval,P_TIPO,P_SUBTIPO,V_NATUREZA,SYSDATE); 
	 commit;


 END;