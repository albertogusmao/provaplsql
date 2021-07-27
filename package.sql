-- Start of DDL Script for Package SAJ.OM_PKG_TASK
-- Generated 27/07/2021 08:23:03 from SAJ@DRACOPG5DEV.TJ.BA.GOV.BR

CREATE OR REPLACE 
PACKAGE om_pkg_task
  IS
 
    FUNCTION Fn_insere_tarefas (p_nome IN VARCHAR2,
           p_area IN VARCHAR2)
            RETURN NUMBER;
            
      procedure p_insere_tarefas (p_nome IN VARCHAR2, p_area IN VARCHAR2)  ;          

END;
/


CREATE OR REPLACE 
PACKAGE BODY om_pkg_task
as


  FUNCTION Fn_insere_tarefas (p_nome IN VARCHAR2,
           p_area IN VARCHAR2)
            RETURN NUMBER
        IS
          
          V_equipe_responsavel  NUMBER:=0;
          v_cont  NUMBER :=0;
          
        BEGIN
           
        --Verificando se existe equipes para a tarefa inserida
        select count(1)
        into v_cont
        from equipes e  
        where nome_b1||'/'||nome_b2||'/'||nome_b3=p_area;
        
        
   if v_cont >0 then 
        
        select decode(status,1,e.oid,0) --Se status ativo(1) uso o oid da tabela equipe, caso seja 0 coloco 0 
        into V_equipe_responsavel
        from equipes e      
        where nome_b1||'/'||nome_b2||'/'||nome_b3=p_area;
             
        begin 
        insert into tarefa values (oid_SEQ.nextval,p_nome,sysdate,p_area,V_equipe_responsavel);
          EXCEPTION
                WHEN OTHERS
                THEN
                    ROLLBACK;
                    RAISE_APPLICATION_ERROR (-20007,
                        'Erro inserido ao inserir area '
                    || p_area);
         end;           
        dbms_output.put_line('Inserido com Sucesso!');
        
        if V_equipe_responsavel=0 then 
        return -2; --- Caso exista, mas a equipe não está ativa, o sistema preencherá o campo equipe_responsável com 0 e retornará -2
        else 
          return 0; -- Caso exista uma equipe na mesma área dessa tarefa, o sistema preencherá o campo equipe_responsável com o oid dessa equipe e o valor retornado pela função será 0
        end if;
        
    else  --  - Caso não exista, o valor inserido no campo equipe_responsável será 0 e a função retornará o valor -1
    
        begin 
        insert into tarefa values (oid_SEQ.nextval,p_nome,sysdate,p_area,V_equipe_responsavel);
          EXCEPTION
                WHEN OTHERS
                THEN
                    ROLLBACK;
                    RAISE_APPLICATION_ERROR (-20007,
                        'Erro inserido ao inserir area '
                    || p_area);
         end; 
          dbms_output.put_line('Inserido com Sucesso!');
          return -1;
     end if; 
     


     
   end;
   
   procedure p_insere_tarefas (p_nome IN VARCHAR2, p_area IN VARCHAR2) is
   begin 
       insert into log values (oid_SEQ.nextval,sysdate,Fn_insere_tarefas(p_nome,p_area),p_nome);       
   end;  
  END om_pkg_task;
/


-- End of DDL Script for Package SAJ.OM_PKG_TASK
