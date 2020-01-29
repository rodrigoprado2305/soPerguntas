drop table chave;
drop table assunto;
drop table perguntas;

select length(descricao), descricao, perguntaid, length(resposta), resposta from perguntas order by length(resposta)
select * from perguntas

create table assunto (
  assuntoid integer not null constraint pk_assuntoid primary key AUTOINCREMENT,
  descricao varchar(26)
);

create table perguntas (
perguntaid  integer constraint pk_perguntaid primary key AUTOINCREMENT,
assuntoid integer,
descricao varchar(167),
resposta varchar(57)
,constraint fk_perguntas_assunto FOREIGN KEY (assuntoid) REFERENCES assunto(assuntoid)
);

create table chave(
chaveid integer not null constraint pk_chaveid primary key AUTOINCREMENT,
nomeEscola varchar(255),
senha varchar(100)
);

create table versaobd(
  versaobdid integer constraint pk_versaobdid primary key AUTOINCREMENT,
  descricao char(5)
)
insert into versaobd(descricao) values  ('1.0.5');
select * from versaobd

drop table estatisticas

create table estatisticas(
assuntoid integer not null constraint pk_assuntoidid primary key,
numjogadas integer default 1,
media      REAL (10, 2),
mediageral REAL (10, 2),
constraint fk_media_assunto FOREIGN KEY (assuntoid) REFERENCES assunto(assuntoid)
);


select * from estatisticas;

select * from assunto

select
  a.assuntoid, a.descricao, e.mediageral
from 
  assunto a
  left join estatisticas as e on (e.assuntoid = a.assuntoid)


delete from estatisticas;


update estatisticas set mediageral = (7  + 10), numjogadas = (numjogadas + 1), media = (17/numjogadas) where assuntoid = 9;
update estatisticas set mediageral = (mediageral + 7.25), numjogadas = (numjogadas + 1), media = (mediageral/numjogadas) where assuntoid = 9;
update estatisticas set mediageral = (mediageral + 9), numjogadas = (numjogadas + 1), media = (mediageral/numjogadas) where assuntoid = 9;


--alter table perguntas add constraint fk_perguntas_assunto FOREIGN KEY (assuntoid) REFERENCES assunto(assuntoid);
delete from perguntas;
delete from assunto;

update assunto set descricao = 'Adicionando: 0'+TimeToStr(Time) +' where assuntoid = 1

select * from assunto;
select COUNT(*) from perguntas;

select length(descricao),* from perguntas where perguntaid >= 1000

select chaveid, nomeEscola, senha from chave;

select a.assuntoid, a.descricao, p.perguntaid, p.descricao, p.resposta 
from assunto as a
  inner join perguntas as p on (p.assuntoid = a.assuntoid)


drop table chave
update chave set nomeEscola = 'ESCOLINHA SÃO BERNARDO DO CAMPOxx', senha = '1234x' where chaveid = 1

insert into chave (nomeEscola, senha) values ('ESCOLINHA SÃO BERNARDO DO CAMPO','1234');



select perguntaid, assuntoid, descricao, resposta, min(perguntaid), max(perguntaid) from perguntas

select perguntaid, assuntoid, descricao, resposta, min(perguntaid) as min, max(perguntaid) as max from perguntas where assuntoid = 3 group by 3

