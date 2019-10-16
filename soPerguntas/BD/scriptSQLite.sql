drop table chave;
drop table perguntas;
drop table assunto;


create table assunto (
  assuntoid integer not null constraint pk_assuntoid primary key AUTOINCREMENT,
  descricao varchar(20)
);

create table perguntas (
perguntaid  integer constraint pk_perguntaid primary key AUTOINCREMENT,
assuntoid integer,
descricao varchar(255),
resposta varchar(255)
,constraint fk_perguntas_assunto FOREIGN KEY (assuntoid) REFERENCES assunto(assuntoid)
);

create table chave(
chaveid integer not null constraint pk_chaveid primary key AUTOINCREMENT,
nomeEscola varchar(255),
senha varchar(100)
);

drop table estatisticas

create table estatisticas(
assuntoid integer not null constraint pk_assuntoidid primary key,
numjogadas integer default 1,
media      REAL (10, 2),
mediageral REAL (10, 2),
constraint fk_media_assunto FOREIGN KEY (assuntoid) REFERENCES assunto(assuntoid)
);


-- 9 - Estados
insert into estatisticas (assuntoid, media, mediageral) values (9,7,7);

update estatisticas set media = (mediageral + 10)/(numjogadas+1), mediageral = mediageral + 10, numjogadas = numjogadas+1 where assuntoid = 1;

update estatisticas set media = (mediageral + 10)/(numjogadas+1), mediageral = mediageral + 7.00, numjogadas = numjogadas+1 where assuntoid = 1;

update estatisticas set media = (mediageral + 10)/(numjogadas+1), mediageral = mediageral + 9.00, numjogadas = numjogadas+1 where assuntoid = 1;


select * from estatisticas;


delete from estatisticas;


update estatisticas set mediageral = (7  + 10), numjogadas = (numjogadas + 1), media = (17/numjogadas) where assuntoid = 9;
update estatisticas set mediageral = (mediageral + 7.25), numjogadas = (numjogadas + 1), media = (mediageral/numjogadas) where assuntoid = 9;
update estatisticas set mediageral = (mediageral + 9), numjogadas = (numjogadas + 1), media = (mediageral/numjogadas) where assuntoid = 9;


--alter table perguntas add constraint fk_perguntas_assunto FOREIGN KEY (assuntoid) REFERENCES assunto(assuntoid);
delete from perguntas;
delete from assunto;

update assunto set descricao = 'Adicionando: 0'+TimeToStr(Time) +' where assuntoid = 1

select * from assunto;
select * from perguntas;
select chaveid, nomeEscola, senha from chave;

select a.assuntoid, a.descricao, p.perguntaid, p.descricao, p.resposta 
from assunto as a
  inner join perguntas as p on (p.assuntoid = a.assuntoid)


drop table chave
update chave set nomeEscola = 'ESCOLINHA SÃO BERNARDO DO CAMPOxx', senha = '1234x' where chaveid = 1

insert into chave (nomeEscola, senha) values ('ESCOLINHA SÃO BERNARDO DO CAMPO','1234');



select perguntaid, assuntoid, descricao, resposta, min(perguntaid), max(perguntaid) from perguntas

select perguntaid, assuntoid, descricao, resposta, min(perguntaid) as min, max(perguntaid) as max from perguntas where assuntoid = 3 group by 3



insert into assunto (descricao) values ('Matemática');
insert into assunto (descricao) values ('Inglês');
insert into assunto (descricao) values ('ALFABETO');
insert into assunto (descricao) values ('NUMEROS');

insert into assunto (descricao) values ('Matemática2');
insert into assunto (descricao) values ('Inglês2');
insert into assunto (descricao) values ('ALFABETO2');
insert into assunto (descricao) values ('NUMEROS2');

insert into assunto (descricao) values ('Matemática3');
insert into assunto (descricao) values ('Inglês3');
insert into assunto (descricao) values ('ALFABETO3');
insert into assunto (descricao) values ('NUMEROS3');



insert into perguntas (assuntoid, descricao, resposta) values (1,'2*2','4');
insert into perguntas (assuntoid, descricao, resposta) values (1,'3*2','6');
insert into perguntas (assuntoid, descricao, resposta) values (1,'3*3','9');
insert into perguntas (assuntoid, descricao, resposta) values (1,'3*4','12');
insert into perguntas (assuntoid, descricao, resposta) values (1,'4*4','16');
insert into perguntas (assuntoid, descricao, resposta) values (1,'3*0','0');
insert into perguntas (assuntoid, descricao, resposta) values (1,'x30*1','30');
insert into perguntas (assuntoid, descricao, resposta) values (1,'x50-20','30');
insert into perguntas (assuntoid, descricao, resposta) values (1,'10-4','6');
insert into perguntas (assuntoid, descricao, resposta) values (1,'7+2','9');
insert into perguntas (assuntoid, descricao, resposta) values (1,'4-4','0');
insert into perguntas (assuntoid, descricao, resposta) values (1,'10+4','14');
insert into perguntas (assuntoid, descricao, resposta) values (1,'10*4','40');
insert into perguntas (assuntoid, descricao, resposta) values (1,'100*2','200');
insert into perguntas (assuntoid, descricao, resposta) values (1,'x29+1','30');
insert into perguntas (assuntoid, descricao, resposta) values (1,'10*1','10');
insert into perguntas (assuntoid, descricao, resposta) values (1,'10*2','20');
insert into perguntas (assuntoid, descricao, resposta) values (1,'x10*3','30');
insert into perguntas (assuntoid, descricao, resposta) values (1,'10*4','40');
insert into perguntas (assuntoid, descricao, resposta) values (1,'10*5','50');


insert into perguntas (assuntoid, descricao, resposta) values (2,'hi','oi');
insert into perguntas (assuntoid, descricao, resposta) values (2,'hello','olá');
insert into perguntas (assuntoid, descricao, resposta) values (2,'car','carro');
insert into perguntas (assuntoid, descricao, resposta) values (2,'bus','onibus');
insert into perguntas (assuntoid, descricao, resposta) values (2,'bike','bicicleta');
insert into perguntas (assuntoid, descricao, resposta) values (2,'orange','laranja');
insert into perguntas (assuntoid, descricao, resposta) values (2,'blue','azul');
insert into perguntas (assuntoid, descricao, resposta) values (2,'pink','rosa');
insert into perguntas (assuntoid, descricao, resposta) values (2,'water','agua');
insert into perguntas (assuntoid, descricao, resposta) values (2,'juice','suco');
insert into perguntas (assuntoid, descricao, resposta) values (2,'to drink','beber');
insert into perguntas (assuntoid, descricao, resposta) values (2,'to go','ir');
insert into perguntas (assuntoid, descricao, resposta) values (2,'to do','fazer');
insert into perguntas (assuntoid, descricao, resposta) values (2,'downtown','centro');
insert into perguntas (assuntoid, descricao, resposta) values (2,'windows','janela');
insert into perguntas (assuntoid, descricao, resposta) values (2,'keyboard','teclado');
insert into perguntas (assuntoid, descricao, resposta) values (2,'phone','telefone');
insert into perguntas (assuntoid, descricao, resposta) values (2,'wallet','carteira');
insert into perguntas (assuntoid, descricao, resposta) values (2,'sister','irmã');
insert into perguntas (assuntoid, descricao, resposta) values (2,'brother','irmão');
insert into perguntas (assuntoid, descricao, resposta) values (2,'Bicicle','Bicicleta');

insert into perguntas (assuntoid, descricao, resposta) values (3,'AAAAAA','A');
insert into perguntas (assuntoid, descricao, resposta) values (3,'BBBBBB','B');
insert into perguntas (assuntoid, descricao, resposta) values (3,'CCCCCC','C');
insert into perguntas (assuntoid, descricao, resposta) values (3,'DDDDDD','D');
insert into perguntas (assuntoid, descricao, resposta) values (3,'EEEEEE','E');
insert into perguntas (assuntoid, descricao, resposta) values (3,'FFFFFF','F');
insert into perguntas (assuntoid, descricao, resposta) values (3,'GGGGGG','G');
insert into perguntas (assuntoid, descricao, resposta) values (3,'HHHHHH','H');
insert into perguntas (assuntoid, descricao, resposta) values (3,'IIIIII','I');
insert into perguntas (assuntoid, descricao, resposta) values (3,'JJJJJJ','J');
insert into perguntas (assuntoid, descricao, resposta) values (3,'KKKKKK','K');
insert into perguntas (assuntoid, descricao, resposta) values (3,'MMMMM','M');
insert into perguntas (assuntoid, descricao, resposta) values (3,'NNNNN','N');
insert into perguntas (assuntoid, descricao, resposta) values (3,'OOOOO','O');
insert into perguntas (assuntoid, descricao, resposta) values (3,'PPPPP','P');
insert into perguntas (assuntoid, descricao, resposta) values (3,'QQQQQ','Q');

insert into perguntas (assuntoid, descricao, resposta) values (4,'111111','1');
insert into perguntas (assuntoid, descricao, resposta) values (4,'2222','2');
insert into perguntas (assuntoid, descricao, resposta) values (4,'3333','3');
insert into perguntas (assuntoid, descricao, resposta) values (4,'44444','4');
insert into perguntas (assuntoid, descricao, resposta) values (4,'55555','5');
insert into perguntas (assuntoid, descricao, resposta) values (4,'66666','6');
insert into perguntas (assuntoid, descricao, resposta) values (4,'7777','7');
insert into perguntas (assuntoid, descricao, resposta) values (4,'8888','8');
insert into perguntas (assuntoid, descricao, resposta) values (4,'9999','9');







