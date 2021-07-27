create table equipes(
                oid number primary key,
                nome  varchar(50),
                nome_b1 varchar(50),
                nome_b2 varchar(50),
                nome_b3 varchar(50),
                status  number
);

create table tarefa(
                oid number primary key,
                nome  varchar(50),
                data_criacao date,
                area varchar(50),
                equipe_responsavel  NUMBER
);

create table log(
                oid number primary key,
                 data date,
                codigo number,
                descricao  varchar(50)
);

insert into equipes values (oid_SEQ.nextval,'ALPHA1','MT_07019','13TRF','E08796',0);
insert into equipes values (oid_SEQ.nextval,'BETA2','MT_11606','13TRF','E08115',1);
insert into equipes values (oid_SEQ.nextval,'BETA1','MT_07901','13TRF','E09516,'1);



