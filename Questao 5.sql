  select  case 
        when nota < 8 then 'NULL'
          else nome end Nome,
         Nota, 
         Valor from (        
select  a.nome, 
       (select nota from notas where a.valor BETWEEN  Valor_Min and Valor_Max) Nota,
       valor
       from alunos a )
order by nota DESC,nome desc,
CASE WHEN nota<=7 THEN valor END asc

-- Essa consulta imprime exatamente o exemplo de Saida. 
--Obs: Eu achei um pouco incoerente o que estava escrito no enunciado e o que veio no Exemplo de saída
-- Exatamente nesse ponto "Se houver mais de um aluno com a mesma nota (8-10) atribuído a eles, ordene esses alunos 
--em particular por seus nomes em ordem alfabética." logo se julia e marcela tiveram a nota 9, julia teria que aparecer antes 
-- segue abaixo consulta para essa outra situacao 

  select  case 
        when nota < 8 then 'NULL'
          else nome end Nome,
         Nota, 
         Valor from (        
select  a.nome, 
       (select nota from notas where a.valor BETWEEN  Valor_Min and Valor_Max) Nota,
       valor
       from alunos a )
order by nota DESC, nome, -- Esse ponto 
CASE WHEN nota<=7 THEN valor END asc
