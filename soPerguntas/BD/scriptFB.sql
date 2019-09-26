Só perguntas - quiz

create table assunto (
  assuntoid INTEG_KEY constraint pk_assuntoid primary key,
  descricao VCHAR15
);

create table perguntas (
perguntaid  INTEG_KEY constraint pk_perguntaid primary key,
assuntoid integ,
descricao vchar255
);

create table chave(
chaveid INTEG_KEY constraint pk_chaveid primary key,
nomeEscola vchar255,
senha vchar60
);


alter table perguntas add constraint fk_perguntas_assunto foreign key (assuntoid) references assunto(assuntoid);


insert into assunto (assuntoid, descricao) values (1, 'Tabuada');

insert into assunto (assuntoid, descricao) values (2, 'Matemática');

insert into assunto (assuntoid, descricao) values (3, 'Geografia');

insert into assunto (assuntoid, descricao) values (4, 'Ciências');


****


