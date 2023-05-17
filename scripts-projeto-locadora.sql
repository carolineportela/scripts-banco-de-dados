#Exibe todos databases
show databases;

#Cria um database
create database dv_videolocadora_tarde_20231;

 #Deleta um database
 #drop database dv_videolocadora_tarde_2023;
 
 #Permite selecionar o database que será utilizado
 use dv_videolocadora_tarde_20231;
 
 #Exibe todas tabelas existentes
 show tables;
 
 #TABELA : CLASSIFICAÇÃO
 create table tbl_classificacao (
		id int not null auto_increment primary key,
        sigla varchar(2) not null,
        nome varchar(45) not null,
        descricao varchar (100) not null,
        unique index(id)

);

#TABELA: GENERO
create table tbl_genero (
		id int not null auto_increment primary key,
		nome varchar(45) not null,
        unique index(id)
);

#TABELA: SEXO
create table tbl_sexo (
		id int not null auto_increment primary key,
		nome varchar(45) not null,
		sigla varchar(5) not null,
        unique index(id)
);

#TABELA : NACIONALIDADE
create table tbl_nacionalidade(
		id int not null auto_increment primary key,
		nome varchar(45) not null,
		unique index(id)
);

#Esses dois comandos faz a mesma coisa,mostra a estrutura da tabela
desc tbl_nacionalidade;
describe tbl_nacionalidade;

################ COMANDOS PARA ALTERAR UMA TABELA ################

# add column - adiciona uma nova coluna na tabela,estou dicionando descricao na tabela nacionalidade.
alter table tbl_nacionalidade
add column descricao varchar(50) not null;

alter table tbl_nacionalidade
add column teste int,
add column teste2 varchar(10) not null;

# drop column - Exlcui uma coluna da tabela,estou excluindo a coluna teste2
alter table tbl_nacionalidade
drop column teste2;

# modify column - Modifica uma coluna da tabela,estou mudando  o tipo do teste
alter table tbl_nacionalidade
modify column teste varchar(5) not null;

# change - Permite editar o dado de uma coluna,estou mudando o nome do atributo teste para teste_nacionalidade
alter table tbl_nacionalidade
change teste teste_nacionalidade int not null;

# colocando tipo na coluna teste_nacionalidade
alter table tbl_nacionalidade
change  teste_nacionalidade  teste_nacionalidade varchar(10) not null;

# exclui uma tabela do database
drop table tbl_nacionalidade;

################ CRIANDO TABELAS COM FK ################

#TABELA : FILME 
create  table tbl_filme(
id int not null auto_increment primary key,
nome varchar(100) not null,
nome_original varchar(100) not null,
data_lancamento date not null,
data_relancamento date,
duracao time not null,
foto_capa varchar(150) not null,
sinopse text not null,
id_classificacao int not null,

#É atributo ou nome ao processo de criar a FK
constraint FK_Classificacao_Filme

#É o atributo desta tabela que será a FK
foreign key(id_classificacao)

#Especifica de onde irá vir a FK
references tbl_classificacao(id),

unique index(id)
);

desc tbl_filme;

#Tabela intermediaria que recebe os id de filme e genero
create table tbl_filme_genero(
id int not null auto_increment ,
id_filme int not null,
id_genero int not null,

#Relacionamento : filme com Genero Filme_FilmeGenero
constraint FK_Filme_FilmeGenero
foreign key (id_filme)
references tbl_filme (id),

#Relacionamento : genero e filme Genero_FilmeGenero
constraint FK_Genero_FilmeGenero
foreign key (id_genero)
references tbl_genero (id),

primary key(id),
unique index(id)

);

drop table tbl_filme_genero;
desc tbl_filme_genero;

 show tables;
 
#Excluindo 
drop table tbl_filme;
drop table tbl_genero;
 
 #Permite exlcuir uma constraint de uma tabela (somente podemos alterar a estrutura de uma tabela que fornece uma FK,
 #se apagarmos as suas contraints)
alter table tbl_filme_genero
drop foreign key FK_Genero_FilmeGenero;

# Permite criar uma constraint e suas relações em uma tabela já existente - Reconstruindo a relação de filme e genero
alter table tbl_filme_genero
add constraint FK_Genero_FilmeGenero
foreign key (id_genero)
references tbl_genero (id);

#TABELA : INTERMEDIARIA 
create table tbl_filme_avaliacao(
id int not null auto_increment primary key,
nota float not null,
comentario varchar (300),
id_filme int not null,

constraint FK_Filme_Avaliacao
foreign key (id_filme)
references tbl_filme (id)


);

#Adicionando o unique index que eu tinha esquecido
alter table tbl_filme_avaliacao 
add unique index(id);

desc tbl_filme_avaliacao;

create table tbl_diretor(
id int not null auto_increment primary key,
nome varchar (100),
nome_artistico varchar (100),
data_nascimento date,
biografia TEXT,
foto varchar (150),
data_falescimento DATE,
id_sexo int not null,

constraint FK_Sexo_Diretor
foreign key (id_sexo)
references tbl_sexo (id),
unique index(id)
);

show tables;

#TABELA : INTERMEDIARIA DIRETOR E NACIONALIDADE
create table tbm_diretor_nacionalidade (
id int not null auto_increment primary key,
id_diretor int not null,
id_nacionalidade int not null,

# Relacionamento : Diretor_Diretor
constraint FK_DiretorNacionalidade
foreign key (id_diretor)
references tbl_diretor (id),

#Relacionamento Nacionalidade_Diretor
constraint FK_Nacionalidade_Diretor
foreign key (id_nacionalidade)
references tbl_nacionalidade (id),


unique index(id)


);

# TABELA : INTERMEDIARIA FILME_DIRETOR
create table tbl_filme_diretor (
id int not null auto_increment primary key,
id_diretor int not null,
id_filme int not null,

constraint FK_Filme_FilmeDiretor
foreign key (id_filme)
references tbl_filme (id),

constraint FK_Diretor_FilmeDiretor
foreign key (id_diretor)
references tbl_diretor (id),

unique index(id)

);

# TABELA AUTOR
create table tbl_ator(
id int not null auto_increment primary key,
nome varchar (100),
nome_artistico varchar (100),
data_nascimento date,
biografia TEXT,
foto varchar (150),
data_falescimento DATE,
id_sexo int not null,

constraint FK_Sexo_Ator
foreign key (id_sexo)
references tbl_sexo (id),
unique index(id)
);



# TABELA : INTERMEDIARIA AUTOR E NACIONALIDADE
create table tbl_ator_nacionalidade (
id int not null auto_increment primary key,
id_ator int not null,
id_nacionalidade int not null,

#Relacionamento : Nascionalidade_AtorNacionalidade
constraint FK_Ator_AtorNacionalidade
foreign key (id_ator)
references tbl_ator (id),

constraint FK_Nacionalidade_AtorNacionalidade
foreign key (id_nacionalidade)
references tbl_nacionalidade (id),

unique index(id)

);

# TABELA: FILME_ATOR
create table tbl_filme_ator (
	id int not null auto_increment primary key,
    id_filme int not null,
    id_ator int not null,
    
    constraint FK_Filme_FilmeAtor
    foreign key (id_filme)
    references tbl_filme(id),
    
    constraint FK_Ator_FilmeAtor
    foreign key (id_ator)
    references tbl_ator(id),
    
    unique index (id)
);

desc tbl_filme_ator;

### Inserir dados nas tabelas ###

#Tabela GENERO
insert into tbl_genero(nome) values ('policial');
insert into tbl_genero(nome) values ('drama');
insert into tbl_genero(nome) values ('Fantasia');
insert into tbl_genero(nome) values ('Acao');
insert into tbl_genero(nome) values ('Suspense');

##Exemplo : Segunda forma de fazer um insert quando queremos colocar mais de um genero de uma vez
insert into tbl_genero(nome) values ('Comedia'),
									('Romance'),
                                    ('Aventura'),
                                    ('Animação'),
                                    ('Musical');
#SELECT
select * from tbl_genero;

#DELETE
delete from tbl_genero;

#UPDTE
update tbl_genero set  nome = 'Comédia';

# Mudando o nome da primeira coluna
update tbl_genero set  nome = 'Comedia' where id = 1;



insert tbl_classificacao (
						  sigla,
						  nome,
						 descricao
                         ) 
                         values
								('L','Livre', 'Não expõe as crianças a conteúdo potencialmente prejudiciais'),
								('10','Não recomendado para menores de 10 anos', 'Conteúdo violento ou linguagem inapropriada'),
								('12','Não recomendado para menores de 12 anos', 'As cenas podem conter agressão física, e consumo de drogas.'),
								('14','Não recomendado para menores de 14 anos', 'Conteúdo mais violento e linguagem sexual'),
								('16','Não recomendado para menores de 16 anos', 'Cenas de tortura'),
								('18','Não recomendado para menores de 18 anos', 'Conteudos sexuais e violentos ao extremo.');
                                                        
select * from tbl_classificacao;

#INSERT
##TABELA FILME
insert into tbl_filme 		(nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) 
						values 
							('O Poderoso Chefão',
                            'The godfather',
                            '1972-03-24',
                            '2022-02-24',
                            '02:55:00',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/93/20/20120876.jpg',
                            'Don Vito Corleone (Marlon Brando) é o chefe de uma "família" de Nova York que está feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo (Gianni Russo). Porém, durante a festa, Bonasera (Salvatore Corsitto) é visto no escritório de Don Corleone pedindo "justiça", vingança na verdade contra membros de uma quadrilha, que espancaram barbaramente sua filha por ela ter se recusado a fazer sexo para preservar a honra. Vito discute, mas os argumentos de Bonasera o sensibilizam e ele promete que os homens, que maltrataram a filha de Bonasera não serão mortos, pois ela também não foi, mas serão severamente castigados. Vito porém deixa claro que ele pode chamar Bonasera algum dia para devolver o "favor". Do lado de fora, no meio da festa, está o terceiro filho de Vito, Michael (Al Pacino), um capitão da marinha muito decorado que há pouco voltou da 2ª Guerra Mundial. Universitário educado, sensível e perceptivo, ele quase não é notado pela maioria dos presentes, com exceção de uma namorada da faculdade, Kay Adams (Diane Keaton), que não tem descendência italiana mas que ele ama. Em contrapartida há alguém que é bem notado, Johnny Fontane (Al Martino), um cantor de baladas românticas que provoca gritos entre as jovens que beiram a histeria. Don Corleone já o tinha ajudado, quando Johnny ainda estava em começo de carreira e estava preso por um contrato com o líder de uma grande banda, mas a carreira de Johnny deslanchou e ele queria fazer uma carreira solo. Por ser seu padrinho Vito foi procurar o líder da banda e ofereceu 10 mil dólares para deixar Johnny sair, mas teve o pedido recusado. Assim, no dia seguinte Vito voltou acompanhado por Luca Brasi (Lenny Montana), um capanga, e após uma hora ele assinou a liberação por apenas mil dólares, mas havia um detalhe: nas "negociações" Luca colocou uma arma na cabeça do líder da banda. Agora, no meio da alegria da festa, Johnny quer falar algo sério com Vito, pois precisa conseguir o principal papel em um filme para levantar sua carreira, mas o chefe do estúdio, Jack Woltz (John Marley), nem pensa em contratá-lo. Nervoso, Johnny começa a chorar e Vito, irritado, o esbofeteia, mas promete que ele conseguirá o almejado papel. Enquanto a festa continua acontecendo, Don Corleone comunica a Tom Hagen (Robert Duvall), seu filho adotivo que atua como conselheiro, que Carlo terá um emprego mas nada muito importante, e que os "negócios" não devem ser discutidos na sua frente. Os verdadeiros problemas começam para Vito quando Sollozzo (Al Lettieri), um gângster que tem apoio de uma família rival, encabeçada por Phillip Tattaglia (Victor Rendina) e seu filho Bruno (Tony Giorgio). Sollozzo, em uma reunião com Vito, Sonny e outros, conta para a família que ele pretende estabelecer um grande esquema de vendas de narcóticos em Nova York, mas exige permissão e proteção política de Vito para agir. Don Corleone odeia esta idéia, pois está satisfeito em operar com jogo, mulheres e proteção, mas isto será apenas a ponta do iceberg de uma mortal luta entre as famílias.',
                            4);
                            
insert into tbl_filme 		(nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) 
						values 
							('FORREST GUMP - O CONTADOR DE HISTÓRIAS',
                            'Forrest Gump',
                            '1994-12-07',
                            null,
                            '02:20:00',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/30/21/19874092.jpg',
                            'Quarenta anos da história dos Estados Unidos, vistos pelos olhos de Forrest Gump (Tom Hanks), um rapaz com QI abaixo da média e boas intenções. Por obra do acaso, ele consegue participar de momentos cruciais, como a Guerra do Vietnã e Watergate, mas continua pensando no seu amor de infância, Jenny Curran.',
                            4);
                            
insert into tbl_filme 		(nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) 
						values 
							('O REI LEÃO',
                            'The Lion King',
                            '1994-08-08',
                            '2011-08-26',
                            '01:29:00',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/84/28/19962110.jpg',
                            'Clássico da Disney, a animação acompanha Mufasa (voz de James Earl Jones), o Rei Leão, e a rainha Sarabi (voz de Madge Sinclair), apresentando ao reino o herdeiro do trono, Simba (voz de Matthew Broderick). O recém-nascido recebe a bênção do sábio babuíno Rafiki (voz de Robert Guillaume), mas ao crescer é envolvido nas artimanhas de seu tio Scar (voz de Jeremy Irons), o invejoso e maquiavélico irmão de Mufasa, que planeja livrar-se do sobrinho e herdar o trono.',
                            1); 
                            
insert into tbl_filme 		(nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) 
						values 
							('À ESPERA DE UM MILAGRE',
                            'The Green Mile',
                            '2000-10-03',
                            null,
                            '03:09:00',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/91/66/66/20156966.jpg',
                            '1935, no corredor da morte de uma prisão sulista. Paul Edgecomb (Tom Hanks) é o chefe de guarda da prisão, que temJohn Coffey (Michael Clarke Duncan) como um de seus prisioneiros. Aos poucos, desenvolve-se entre eles uma relação incomum, baseada na descoberta de que o prisioneiro possui um dom mágico que é, ao mesmo tempo, misterioso e milagroso.',
                            4);                             


insert into tbl_filme 		(nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) 
						values 
							('BATMAN - O CAVALEIRO DAS TREVAS',
                            'The Dark Knight',
                            '2008-07-18',
                            null,
                            '02:32:00',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/86/98/32/19870786.jpg',
                            'Após dois anos desde o surgimento do Batman (Christian Bale), os criminosos de Gotham City têm muito o que temer. Com a ajuda do tenente James Gordon (Gary Oldman) e do promotor público Harvey Dent (Aaron Eckhart), Batman luta contra o crime organizado. Acuados com o combate, os chefes do crime aceitam a proposta feita pelo Coringa (Heath Ledger) e o contratam para combater o Homem-Morcego.',
                            3);     

insert into tbl_filme 		(nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) 
						values 
							('VINGADORES: ULTIMATO',
                            'Avengers: Endgame',
                            '2019-04-25',
                            '2019-07-11',
                            '03:01:00',
                            'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg',
                            'Em Vingadores: Ultimato, após Thanos eliminar metade das criaturas vivas em Vingadores: Guerra Infinita, os heróis precisam lidar com a dor da perda de amigos e seus entes queridos. Com Tony Stark (Robert Downey Jr.) vagando perdido no espaço sem água nem comida, o Capitão América/Steve Rogers (Chris Evans) e a Viúva Negra/Natasha Romanov (Scarlett Johansson) precisam liderar a resistência contra o titã louco.',
                            3);   
                            
 select * from tbl_classificacao;                           

select * from tbl_filme;

select * from tbl_genero;

#INSERT
# TABELA DE RELACAO ENTRE FILME E GENERO

#O poderoso chefao
insert into tbl_filme_genero (id_filme,id_genero) values (4,13), (4,14);

#Forrest GUMP
insert into tbl_filme_genero (id_filme,id_genero) values (5,9), (5,14),(5,8);

#REI LEAO
insert into tbl_filme_genero (id_filme,id_genero) values (6,11), (6,10), (6,12);

#A espera de um milagre
insert into tbl_filme_genero (id_filme,id_genero) values (7,13), (7,15);

#BATMAN
insert into tbl_filme_genero (id_filme,id_genero) values (8,16), (8,17);

#Vingadores
insert into tbl_filme_genero (id_filme,id_genero) values (9,16), (9,15), (9,10);

#### Tabela Sexo ###

insert into tbl_sexo(nome,sigla) values ('Masculino','M');
insert into tbl_sexo(nome,sigla) values ('Feminino','F');


select * from tbl_sexo;

### Tabela Autor##

insert into tbl_ator (						
					nome ,
					nome_artistico,
					data_nascimento ,
					biografia ,
					foto,
					data_falescimento ,
					id_sexo
						) values
                        ('Alfredo James Pacino',
                        'Al Pacino',
                        '1940-04-25',
                        'É um grande fã de ópera;- É um dos poucos astros de Hollywood que nunca casou;- Foi preso em janeiro de 1961, acusado de carregar consigo uma arma escondida;- Recusou o personagem Han Solo, da trilogia original de "Star Wars";- Foi o primeiro na história do Oscar a ser indicado no mesmo ano nas categorias de melhor ator e melhor ator coadjuvante.',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/19/03/19/18/33/1337912.jpg',
                        null,
                        1
                        );
                        
insert into tbl_ator (						
					nome ,
					nome_artistico,
					data_nascimento ,
					biografia ,
					foto,
					data_falescimento ,
					id_sexo
						) values
                        ('Alfredo James Pacino',
                        'Al Pacino',
                        '1940-04-25',
                        'É um grande fã de ópera;- É um dos poucos astros de Hollywood que nunca casou;- Foi preso em janeiro de 1961, acusado de carregar consigo uma arma escondida;- Recusou o personagem Han Solo, da trilogia original de "Star Wars";- Foi o primeiro na história do Oscar a ser indicado no mesmo ano nas categorias de melhor ator e melhor ator coadjuvante.',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/19/03/19/18/33/1337912.jpg',
                        null,
                        1
                        ); 
                        
insert into tbl_ator (						
					nome ,
					nome_artistico,
					data_nascimento ,
					biografia ,
					foto,
					data_falescimento ,
					id_sexo
						) values
                        ('Thomas Jeffrey Hanks',
                        'Tom Hanks',
                        '1956-07-09',
                        'Tom Hanks iniciou a carreira no cinema aos 24 anos, com um papel no filme de baixo orçamento Trilha de Corpos. Logo migrou para a TV, onde estrelou por dois anos a série Bosom Buddies. Nela passou a trabalhar com comédia, algo com o qual não estava habituado, rendendo convites para pequenas participações nas séries Táxi, Caras & Caretas e Happy Days.
							Em 1984, veio seu primeiro sucesso no cinema: a comédia Splash - Uma Sereia em Minha Vida, na qual era dirigido por Ron Howard e contracenava com Daryl Hannah. Em seguida vieram várias comédias, entre elas A Última Festa de Solteiro (1984), Um Dia a Casa Cai (1986) e Dragnet - Desafiando o Perigo (1987), tornando-o conhecido do grande público.',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/18/08/08/18/47/1167635.jpg',
                        null,
                        1
                        ); 
 #Parei no thomas                       
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Gary Alan Sinise',
                        'Gary Sinise',
                        '1955-03-17',
                        'Sinise é conhecido por vários papéis durante sua carreira, como o de George Milton na adaptação cinematográfica de De Ratos e Homens, o tenente Dan Taylor em Forrest Gump, pelo qual foi nomeado para o Oscar de melhor ator coadjuvante, Harry S. Truman em Truman (filme de 1995), pelo qual ganhou um Globo de Ouro, Ken Mattingly em Apollo 13, o detetive Jimmy Shaker em Ransom, e George C. Wallace no filme de televisão George Wallace, pelo qual foi premiado com um Emmy do Primetime. Em abril de 2017, Gary foi agraciado com uma estrela na calçada da fama de Hollywood. A cerimônia contou as participações do ator Joe Mantegna da série Criminal Minds.

É também integrante da banda Lt. Dan Band, que atua em prol da caridade e de associações sem fins lucrativos, onde toca baixo. O nome Lieutenant Dan ou tenente Dan vem do personagem de Gary no filme Forrest Gump (tenente Dan Taylor), que contracenou com Tom Hanks como o amigo salvo por Forrest durante a Guerra do Vietnam.

Em janeiro de 2015, foi confirmado no spin-off da série Criminal Minds, no papel do chefe da equipe, Jack Garrett, com vinte anos de experiência na Unidade de Análise Comportamental do FBI. Junto de Sinise, outros dois nomes foram confirmados: Tyler James Williams (Todo Mundo Odeia o Chris e The Walking Dead) e Anna Gunn (Breaking Bad).',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/92/45/36/20200745.jpg',
                        null,
                        1
						);
                        
                        
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Manoel Garcia Júnior',
                        'Garcia Júnior',
                        '1967-03-02',
                        'Manoel Garcia Júnior é um ator, dublador, radialista, tradutor e diretor de dublagem brasileiro. Manoel é filho dos também dubladores Garcia Neto e Dolores Machado.',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/14/01/16/13/52/556410.jpg',
                        null,
                        1
						);                        
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'MICHAEL CLARKE DUNCAN',
                        'Michael Duncan',
                        '1957-12-10',
                        'Michael Clarke Duncan é conhecido pela atuação em À Espera de um Milagre, que lhe rendeu indicações ao Oscar e ao Globo de Ouro de Melhor Ator Coadjuvante. Fez sua estreia nos cinemas em 1995, com um papel não creditado em Sexta-Feira em Apuros. O primeiro trabalho de destaque viria três anos depois com Armageddon. Agradou tanto que Bruce Willis recomendou que Frank Darabont contratasse ele para À Espera de um Milagre, em 1999.

Muitas vezes tratado como Big Mike, por causa da altura de 1,96 m, o ator se destacou ainda em Meu Vizinho Mafioso, Planeta dos Macacos, O Escorpião Rei e A Ilha. Participou também de três adaptações dos quadrinhos: O Demolidor, Sin City - A Cidade do Pecado e Lanterna Verde. Robert Rodriguez contava com o retorno dele para Sin City 2: A Dame to Kill For, algo que infelizmente não irá mais acontecer.

Na TV, Clarke Duncan contou com participações em importantes seriados, como Um Maluco no Pedaço, Bones, Chuck e Two and a Half Men. Faleceu em setembro de 2012, aos 54 anos, após passar dois meses hospitalizado em Los Angeles.
PRIMEIRAS APARIÇÕES NAS TELAS',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/14/09/06/19/41/147683.jpg',
                        '2012-12-10',
                        1
						);   
 
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'MATTHEW BRODERICK',
                        'MATTHEW BRODERICK',
                        '1962-04-21',
                        'Matthew Broderick é um ator norte-americano, célebre pela sua atuação como Ferris Bueller em Ferris Buellers Day Off de 1986, e por outros papéis, como David Lightman em WarGames, Jimmy Garrett em Projeto Secreto: Macacos, Nick Tatopoulos, em Godzilla e o personagem título em Inspector Gadget.',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/19/07/02/22/47/0236519.jpg',
                        null,
                        1
						);
 
 insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Christian Charles Philip Bale',
                        'Christian Bale',
                        '1974-01-30',
                        'Caçula de três irmãs mais velhas, filho de um piloto de aviação comercial e de uma dançarina de circo, Bale começou a atuar por influência de uma delas. Pouca gente recorda que este ator inglês é o menino Jim, que tocou corações em Império do Sol (1987), de Steven Spielberg. Para ganhar o papel, derrotou cerca de quatro mil candidatos e sua atuação ainda rendeu prêmios.Mesmo tendo começado cedo (aos 9 anos fez seu primeiro comercial de cereais), foi somente com Psicopata Americano (2000) que ganhou mais notoriedade no papel de Patrick Bateman, que seria, incialmente, de Leonardo DiCaprio.Sua dedicação ao trabalho é reconhecida e sua "entrega" para viver Trevor em O Operário (2004), quando emagreceu cerca de 30 kg, foi considerada chocante demais.Famoso por sua aversão a entrevistas, Bale é capaz de concedê-las com seu bom sotaque americano apenas para não ',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/24/18/43/126776.jpg',
                        null,
                        1
						);
 
 
  insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Heathcliff Andrew Ledger',
                        'HEATH LEDGER',
                        '1979-04-04',
                        'Extremamente tímido, este australiano descendente de irlandeses e escoceses optou por atuar desde cedo. Mesmo com a rápida fama conquistada, em parte por sua beleza, ele procurou interpretar papéis que não explorassem este aspecto e conseguiu atuações marcantes em sua curta carreira. Premiado após sua morte pela atuação como Coringa, Ledger tem seu lugar marcado para sempre na história do cinema mundial. (RC)

',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/18/08/16/19/43/2593099.jpg',
                        '2008-01-22',
                        1
						);
                        
  insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Robert John Downey Jr',
                        'ROBERT DOWNEY JR.',
                        '1965-05-04',
                        'Do céu ao inferno e ao céu novamente. Se alguém pensou no mito do pássaro fênix que renasce das cinzas, até que a comparação poderia se encaixar para definir este brilhante ator que já deu vida para personagens tão distantes em tempo e estilo, como Charles Chaplin (Chaplin - 1992) e Tony Stark (Homem de Ferro - 2008).Na ativa por mais de quatro décadas e dono de uma voz grave, afinada, Downey já dublou desenho animado (God, the Devil and Bob - 2000), se aventurou no mundo da música, em 2004, com o disco The Futurist (Sony) e fez bonito na televisão, onde faturou o Globo de Ouro, além de outros prêmios e indicações por Larry Paul, personagem do seriado Ally McBeal (2000 - 2002). Mas é no cinema que sua estrela parece brilhar mais intensamente. Tendo estreado aos cinco anos de idade, em 1970, dirigido pelo pai em Pound e repetido a experiência outras vezes, como ...',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/18/06/29/00/35/0101925.jpg',
                        null,
                        1
						);                        
 
   insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Christopher Robert Evans',
                        'Christopher Evans.',
                        '1981-06-13',
                        ' Depois de uma infância e estudos ​​em Boston, Chris Evans decidiu ir para Nova York para tentar a sorte na comédia. Ele rapidamente consegue entrar na profissão, principalmente participando em séries de televisão (Boston Public). Sua carreira no cinema começou em 2001, em uma comédia para adolescentes (Não é Mais um Besteirol Americano). Mas sem ficar preso a apenas um gênero de filme, o ator vai para outras produções: trapaceia nas provas com Scarlett Johansson na comédia policial Nota Máxima (2004), interpreta o papel de Kim Basinger no thriller Celular - Um Grito de Socorro (2004) e seduz Jessica Biel em London (2005).O destino de Chris Evans como o conhecemos hoje começou em 2005, quando ele conseguiu seu primeiro papel como super-herói. Em Quarteto Fantástico, um sucesso de bilheteria adaptado dos quadrinhos da Marvel, ele interpreta Johnny Storm, também ...',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/19/59/2129500.jpg',
                        null,
                        1
						);  
                        
     ##### DIRETORES #######   
     
insert into tbl_diretor (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'FRANCIS FORD COPPOLA',
                        ' Francis F. Coppola',
                        '1939-04-07',
                        'Em 1969, fundou juntamente com George Lucas a produtora American Zoetrope, em São Francisco, tendo como primeiro projeto o filme THX 1138 (1970);- É tio do ator Nicolas Cage;- Pai da tambem diretora Sofia Coppola;- Foi assistente de direção de Roger Corman;- Graduado na Universidade da Califórnia (UCLA), a mesma dos diretores, George Lucas e Steven Spielberg.',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/35/21/99/19187501.jpg',
                        null,
                        1
						);     
     
  
insert into tbl_diretor (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Christopher Edward Nolan',
                        'CHRISTOPHER NOLAN',
                        '1970-07-30',
                        'Com apenas sete anos de idade, Christopher Nolan já se arriscava por trás das câmeras. Utilizando-se da câmera Super 8 do pai, ele realizou vários pequenos filmes estrelados por seus brinquedos. A vontade de dirigir não passou e ele acabou se tornando um importante realizador.

						Formou-se em literatura na Universidade de Londres, na mesma época em que começou a realizar filmes em 16mm. Seu curta "Larceny" foi exibido no Festival de Cinema de Cambridge em 1996.

						Nolan estreou na direção com Following (1998), mas foi Amnésia (2000) que chamou a atenção da grande público, abrindo seu caminho para o sucesso em Hollywood. Na sequência, comandou Al Pacino, Robin Williams e Hilary Swank em Insônia (2002).

						Em 2005, dirigiu o filme que mudou para sempre sua história: Batman Begins. Ele investiu em um Homem-Morcego mais sombrio e realista, o que ficou ainda mais claro na continuação, Batman - O Cavaleiro das Trevas. O segundo longa rendeu um Oscar póstumo para Heath Ledger, que brilhou na pele do vilão Coringa. Com O Cavaleiro das Trevas Ressurge, fecha sua trilogia sobre o herói.

						Em um período "entre-Batmans" realizou A Origem e chamou a atenção pela criatividade e pela complexidade narrativa. O filme arrecadou mais de US$ 800 milhões em todo mundo e conquistou estatuetas no Oscar.
',
                        'HTTPS://BR.WEB.IMG3.ACSTA.NET/C_310_420/PICTURES/15/02/26/15/33/118611.JPG',
                        null,
                        1
						);
                        
insert into tbl_diretor (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Eric R. Roth',
                        'ERIC ROTH',
                        '1945-03-22',
                        'Roth ganhou o Oscar de Melhor Roteiro Adaptado por Forrest Gump . Ele é conhecido por escrever seus scripts em um programa DOS sem acesso à Internet, além de distribuir os scripts apenas em formatos de cópia impressa.Ele seguiu sua vitória no Oscar co-escrevendo roteiros para vários filmes indicados ao Oscar, incluindo The Insider , Munich , The Curious Case of Benjamin Button e A Star Is Born . Enquanto escrevia O Curioso Caso de Benjamin Button , ele perdeu os pais e, como resultado, vê o filme como "... meu filme mais pessoal',
                        'https://deadline.com/wp-content/uploads/2019/02/rexfeatures_10080896hi.jpg',
                        null,
                        1
						);
                        
 insert into tbl_diretor (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Roger Allers',
                        'Rogers',
                        '1949-06-29',
                        'Nascido em Rye, Nova York, mas criado em Scottsdale, Arizona, Allers se tornou um fã de animação aos cinco anos de idade, depois de ver Peter Pan da Disney. Decidir o que ele queria buscar uma carreira na Disney e até mesmo trabalhar ao lado de Walt Disney, alguns anos mais tarde, ele foi enviado para a Disneylândia para um  kit de animação. No entanto, Allers, até então um estudante do ensino médio, cresceu desanimado sobre a realização de seu sonho quando ele soube da morte de Walt Disney, em 1966. 
Apesar de não ter a oportunidade de conhecer Walt, Allers ainda conseguiu uma graduação em Artes pela Universidade do Estado do Arizona. Mas quando ele se matriculou em uma aula na Universidade de Harvard, percebeu que seu interesse em animação foi revitalizado. Depois de receber seu diploma em Artes plásticas, ele passou os próximos dois anos viajando e vivendo na Grécia. Enquanto estava lá, ele passou algum tempo vivendo em uma caverna, e, eventualmente, encontrou Leslee, quem mais tarde se casou. Allers aceitou um emprego na Flynn Studios, onde ele trabalhou como animador de projetos como A Rua Sésamo, The Electric Company, Make a Wish, e vários outros comerciais.
',
                        'HTTPS://BR.WEB.IMG3.ACSTA.NET/C_310_420/MEDIAS/NMEDIA/18/91/54/06/20150846.JPG',
                        null,
                        1
						); 
                        
 insert into tbl_diretor (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Frank Darabont',
                        'Frank',
                        '1959-01-28',
                        'Frank Darabont é um cineasta, roteirista e produtor de cinema francês radicado nos Estados Unidos. Fez várias adaptações dos livros de Stephen King.',
                       'HTTPS://BR.WEB.IMG3.ACSTA.NET/C_310_420/MEDIAS/NMEDIA/18/91/54/06/20150846.JPG',
                        null,
                        1
						); 
                        
  insert into tbl_diretor (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Joseph Vincent Russo',
                        'Joseph Russo',
                        '1971-08-08',
                        'Joseph Vincent Russo nasceu na cidade de Cleveland, nos EUA. Começou sua carreira como diretor de videoclipes, sempre ao lado do irmão Anthony Russo. Ambos se graduaram em cinema na Universidade de Iowa. Ao lado de Anthony, estreou como realizador de longas em L.A.X. 2194 (1994), telefilme da NBC.

Começaram a se destacar a partir da série Arrested Development, que comandaram entre 2003 e 2005, pela qual foram premiados com o Emmy. Entretanto, a fama mundial dos irmãos chegou após ingressarem no Universo Cinematográfico da Marvel, em que dirigiram o blockbuster Capitão América 2: O Soldado Invernal (2014).',
                       'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/17/01/231901.jpg',
                        null,
                        1
						);                        
  insert into tbl_diretor (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                       data_falescimento,
                        id_sexo
                        ) values (
                        'Robert Lee Zemeckis',
                        'ROBERT ZEMECKIS',
                        '1952-05-05',
                        ' Especialista em efeitos especiais, Robert Zemeckis é um dos partidários dos filmes do também diretor Steven Spielberg, que já produziu vários de seus filmes; - Trabalhando geralmente com seu parceiro de roteiros Bob Gale, os primeiros filmes de Robert apresentou ao público seu talento para comédias tipo pastelão, como Tudo por uma Esmeralda (1984); 1941 - Uma Guerra Muito Louca (1979) e, acrescentando efeitos muito especiais em Uma Cilada para Roger Rabbit (1988) e De Volta para o Futuro (1985); - Apesar destes filmes terem sidos feitos meramente para o puro entretenimento, com raros desenvolvimentos dos personagens ou mesmo com uma trama cuidadosa, eles são diversão na certa; - Seus filmes posteriores no entanto, se tornaram mais sérios e reflexivos, como o enormemente bem sucedido filme estrelado por Tom Hanks Forrest Gump (1994) e o filme estrelado por Jodie Foster ...',
                       'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/57/81/20030814.jpg',
                        null,
                        1
						);  
                        
 ##### Ligar filme e diretor #######
 
 #O PODEROSO CHEFAO
 insert into tbl_filme_diretor (id_filme , id_diretor) values (4,2);
 
 #FORREST CUMP
 insert into tbl_filme_diretor (id_filme , id_diretor) values (5,7);
 
 # REI LEAO
insert into tbl_filme_diretor (id_filme , id_diretor) values (6,4);
  
# A espera de um milagre
insert into tbl_filme_diretor (id_filme , id_diretor) values (7,5);

#BATMAN
insert into tbl_filme_diretor (id_filme , id_diretor) values (8,1);

#VINGADORES
insert into tbl_filme_diretor (id_filme , id_diretor) values (9,6);

####################################

#### Ligar filme e ator  ###

# O poderoso chefao (atores - Marlon Brando e Alfredo)
insert into tbl_filme_ator (id_filme , id_ator) values (4,1) , (4,2);

#FORREST GUMP
insert into tbl_filme_ator (id_filme , id_ator) values (5,3) , (5,4);

# o REI LEAO
insert into tbl_filme_ator (id_filme , id_ator) values (6,5) , (6,6);

# A espera de um milagre
insert into tbl_filme_ator (id_filme , id_ator) values (7,7) , (7,3);

#Batman
insert into tbl_filme_ator (id_filme , id_ator) values (8,8) , (8,9);

#Vingadores Ver pq esse nao foi ####
insert into tbl_filme_ator (id_filme , id_ator) values (9,11) , (9,12);

select * from tbl_filme;
select * from tbl_ator;

#######################
### Ligar filme e avaliacao ###


insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                4.8,
                                'O que mais ainda se pode falar deste filme? Sério, já é algo até cômico a tentativa de qualquer pessoa de trazer um nuance, um tema sobre esse clássico que ainda não tenha sido exaustivamente discutido. ',
                                4
                                );
                                
                                
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                4.7,
                                'Woooollllll, um drama épico!!! Tom Hanks merecia o OSCAR de todos os tempos.... Forrest Gump é o filme! Mesmo sendo longo é incansável! Tenho orgulho de dizer que sou fã desse ator sensacional e desse filme brilhante! Um clássico cinematográfico! :)',
                                5
                                );                                

insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                '5.0',
                               'top
					meu filho gostou muito. Ele gostou porque é peludo que nem ele
					meu filho meio que parece o sonic... bixo zuado kkkkk',
                                6
                                ); 
                                
 insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                '4.7',
                               'Tom Hanks é O ATOR. Filme brilhante de um livro brilhantemente escrito por Stephen King. Um filme muito forte mas que é capaz de emocionar qualquer um. Um dos melhores filmes da minha vida. ',
                                7
                                );   
                                
                                
 insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                '4.7',
                               'o melhor filme que eu assisti no cinema spoiler: ',
                                8
                                );  
                                
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                '4.0',
                               'Finalmente, uma conclusão é desfecho de tudo que andávamos vendo nos últimos 10 anos de UCM! Esse longa que eh muito mais que filme mostra e da tudo o que você precisava ver. Fantástico.',
                                9
                                ); 
                                
####### Tabela de Nacionalidade #######
insert into tbl_nacionalidade(nome)values ('Americano'),
											('Brasileiro'),
                                            ('Frances'),
                                            ('Britanico'),
                                            ('Australiano');

select * from tbl_nacionalidade;

####### Tabela autor_nacionalidade ######

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (1,1);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (2,1);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (3,1);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (4,1);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (5,2);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (6,1);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (7,1);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (8,4);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (9,5);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (11,1);

insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (12,1);

        #Falta fazer diretor e nacionalidade
#############################################################

## SELECTS AULA 17/05 ##
# select - serve para especificar quais colunas serão exibidas
# from - serve para definir quais tabelas serão utilizadas
#where - serve para definir o criterio de busca

#Retorna todas as colunas de uma tabela e todos os registros
select * from tbl_filme;
select tbl_filme.* from tbl_filme;

#Retorna apenas as colunas escolhidas
select id,nome,nome_original from tbl_filme;
select tbl_filme.id,tbl_filme.nome,tbl_filme.nome_original from tbl_filme;

#Ajuste virtual
#Podemos criar nomenclaturas virtuais para as colunas e tabelas (isso nao altera fisicamente a tabela)
select tbl_filme.id as id_filme,
		tbl_filme.nome as nome_filme,
        tbl_filme.nome_original
        from tbl_filme;
        
select filme.nome as nome_filme,
		ator.nome as nome_ator
from tbl_filme as filme,tbl_ator as ator;
 
 #Permite ordenar de forma crescente e descrescente
select * from tbl_filme order by nome ;
select * from tbl_filme order by nome asc;
select * from tbl_filme order by nome desc;
select * from tbl_filme order by nome,data_lancamento desc,sinopse asc;
 
 #Limitar a quantidade de registros que serão exibidas,trazer só dois filmes.
select * from tbl_filme limit 2;

#Padronizar os dados deixando tudo para maiuscula (o upper tbm funciona)
select ucase(tbl_filme.nome) as nome from tbl_filme;
select upper(tbl_filme.nome) as nome from tbl_filme;

# Padronizar os dados deixando tudo para minusculo (o lower tbl funciona)
select lcase(tbl_filme.nome) as nome from tbl_filme;
select lower(tbl_filme.nome) as nome from tbl_filme;
 
 #Manda a quantidade de caracteres
 select length (tbl_filme.nome) as quantidade_caracteres from tbl_filme;
 
 #Contatenar 
 select concat ('<span>Filme: ', tbl_filme.nome, '</span>') as nome_filme_formatado from tbl_filme;
 
 #Concat e substr kintos
select concat(substr(tbl_filme.sinopse,1,50 ), 'Leia mais ...')as sinopse_reduzida from tbl_filme;

desc tbl_filme;

 #select * from tbl_filme,tbl_ator;       


select * from tbl_filme_avaliacao;
select * from tbl_diretor;
select * from tbl_filme;
select * from tbl_ator;
 
#delete from tbl_ator where id = 10;
#delete from tbl_diretor where id = 3;
select * from tbl_ator;



select * from tbl_ator;
select * from tbl_classificacao;                           
select * from tbl_filme;
select * from tbl_genero;
select * from tbl_filme_genero;










