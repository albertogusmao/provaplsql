10.Considere o seguinte código executado em um banco oracle:

insert into tab values (1,1); --1 registro
commit;
insert into tab values (2,2); --2 registros
truncate table tab;  -- 0 registros 
insert into tab values (3,3); --1 registro

rollback; -- 0 registros  
insert into tab values (4,4); -- 1 registro

select count(*) from tab -- 1 registro

Sabendo que o comando select será executado na mesma sessão que o resto do código, qual o resultado? E se executado em outra sessão?



R: O resultado é 1 registro, e se executado em outra sessão 0 registros, pois nao houve um commit apos o ultimo insert.