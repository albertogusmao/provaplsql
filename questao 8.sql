select name from dogs
union 
select name from cats 


-- O comando union ja faz o distinct, diferentemente do union all que traria todos os nomes de ambas tabelas.