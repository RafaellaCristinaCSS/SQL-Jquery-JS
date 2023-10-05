CREATE DATABASE db_curso_web; /* Para criar um novo Banco de Dados e dar a ele um nome, no caso foi db_curso_web */
DROP DATABASE db_curso_web; /* Para deletar um novo Banco de Dados informando o seu nome, no caso foi db_curso_web */
DROP DATABASE IF EXISTS db_curso_web; /* verifica se aquele banco de dados existe e se existir deleta */
DROP TABLE IF EXISTS td_cursos; /* verifica se aquela tabela existe e se existir deleta */

CREATE TABLE td_cursos( /* Para criar uma tabela e ja inserir as suas colunas */
    id_curso int not null AUTO_INCREMENT PRIMARY KEY, /* Inserimos uma coluna com o nome, o tipo da coluna, se ela sera nula(ou seja, pode preencher ou nao), nao nula(é necessario ser preenchido) ou pre definida (default), ou seja, ja passaremos um valor a ela, caso nao seja preenchida, podemos declara se ela é uma chave primaria ou nao, caso ela seja, podemos determinar que ela sera incrementada automaticamente (AUTO_INCREMENT). */
    id_materia int not null,
    imagem_curso Varchar(100) not null,
    nome_curso char(50) not null,
    resumo text null,
    data_cadastro Datetime not null,
    ativo boolean default true,
    investimento float(5,2) default 0 /* O primeiro valor (5) corresponde a quantidade de digitos que podera ser inserido, por exemplo 10.000, e o segundo numero (2) corresponde a quantidades de numeros que podera ter apos a virgula, por exempo 0,55, nesse exemplo ficaria 10.000,55  */
);
DROP TABLE teste; /* Para deletar uma tabela do Banco de Dados informando o seu nome, no caso foi teste */

RENAME TABLE td_cursos_web TO tb_cursos; /* Renomear tabela de um Banco de dados, a primeira informação seria o nome atual (nesse caso td_cursos_web) e a segunda seria o nome que voce queira dar a tabela (nesse caso tb_cursos) */
ALTER TABLE tb_cursos ADD COLUMN carga_horaria VARCHAR(5) NOT NULL; /* Adicionando uma coluna a tabela, informar o nome da tabela, o nome da proxima coluna, e qual tipo de conteudo ela ira receber */
ALTER TABLE tb_cursos CHANGE carga_horaria /* daqui para frente adicionaremos oque estamos querendo mudar */ carga_horaria INT(5) NULL; /* Alterar o conteudo de uma tabela */
ALTER TABLE tb_cursos DROP carga_horaria; /* Apagando uma coluna da tabela */
/* FOREIGN KEY */
ALTER TABLE tb_cursos  /* Para criar uma FOREIGN KEY (uma chave estrangeira, que faz referencia a uma outra tabela ), precisamos de: */
    ADD CONSTRAINT id_materia FOREIGN KEY (id_materia)  /* inserir qual sera a coluna que contera essa referencia (ou seja, onde iremos armazenar o id da outra tabela ) */
    REFERENCES t_materia(id_materia); /* e passar qual é a coluna da tabela que iremos fazer essa referencia, ou seja, o id da outra tabela (obr.: uma FOREIGN KEY sempre sera a chave primaria da tabela que estamos querendo fazer referencia ) */
    
/* Inserindo  */
INSERT INTO tb_cursos(ativo, carga_horaria, data_cadastro, id_curso, imagem_curso, investimento, nome_curso, resumo)VALUES(1, 38,'2000-01-31 12:35:01', 2, 'curso_angular.jpg', 429.50, 'WEB Completo - Aprendendo MySql', 'Aqui escreveremos um texto aleatorio sobre o curso'); /* Inserindo valores as colunas da tabela, no primeiro (nos escrevemos o nome das colunas), e no segundo (o conteudo das colunas respectivamente)  */

/* Selecionando */
SELECT carga_horaria, data_cadastro FROM tb_cursos; /* Selecionar algumas colunas da tabela, primeiro passar o nome das colunas, e depois a tabela que esta armazenada aquelas colunas */
SELECT * FROM tb_cursos; /* Selecionar todas as colunas da tabela */
SELECT * FROM tb_alunos WHERE interesse = 'Jogos' ;/* Filtrando os dados ultilizando o Where */
SELECT * FROM tb_alunos WHERE interesse='Jogos' AND idade < 45; /* Ultilizando operadores logicos AND ou OR */
SELECT * FROM tb_alunos WHERE idade BETWEEN 18 AND 25; /* O BETWEEN significa "Estar entre" */
    /* Duas maneiras de buscar com o OR */
        /* 1º */ SELECT * FROM tb_alunos WHERE interesse = 'Jogos' OR 'Esporte' OR 'Informática'; 
        /* 2º */ SELECT * FROM tb_alunos WHERE interesse IN('Jogos','Esporte','Informática');  
        /* Tambem podemos pedir os que nao sao iguais aos dessas colunas */ SELECT * FROM tb_alunos WHERE interesse NOT IN('Jogos','Esporte','Informática');
SELECT * FROM tb_alunos WHERE nome LIKE "%ne"; /* O (%) Essa busca permitira que retorne todos os dados daquela coluna que terminem com determinado(s) caractere(s) */
SELECT * FROM tb_alunos WHERE nome LIKE "_____o"; /* O (_)  Uma busca mais especifica, onde voce tem que passar o valor exato de caracteres que estao antes ou depois da(s) letra(s) desejadas */
SELECT * FROM tb_alunos WHERE nome LIKE "%y_"; /* Ultilizando os dois aperadores do LIKE */
SELECT * FROM tb_alunos WHERE idade BETWEEN 18 AND 25 ORDER BY nome ASC; /* O ORDER BY serve para ordenar, nos dizemos apartir de qual tabela ele ira ordenar e se sera ASC(crescente) ou DESC (decrescente)*/
SELECT * FROM tb_alunos WHERE idade BETWEEN 18 AND 25 ORDER BY nome ASC LIMIT 4; /* O  LIMIT serve para determinar o limite maximo que nos iremos buscar*/
SELECT * FROM tb_alunos LIMIT 4 OFFSET 0; /* O  OFFSET depende do operador LIMIT, e ele serve para dizer a partir de qual coluta começara a busca, nesse caso eu coloquei que seria a partir da 0, que seria o "primeiro" armazenamento*/
SELECT MIN(investimento) FROM tb_cursos; /* Função que retorna o menor valor */
SELECT MAX(investimento) FROM tb_cursos; /* Função que retorna o maior valor */
SELECT AVG(investimento) FROM tb_cursos; /* Função que retorna a media dos valores */
SELECT SUM(investimento) FROM tb_cursos; /* Funcao para Soma - Nesse caso a soma dos cursos */
SELECT COUNT(*) FROM tb_cursos; /* Funcao para contar - Nesse caso todos da tabela cursos */
SELECT SUM(investimento) FROM tb_cursos WHERE ativo = true; /* Atribuir um filtro juntamente com a funcao*/
SELECT * FROM tb_alunos GROUP BY interesse; /* Agrupar o retorno - Nesse caso pela coluna interesse*/
SELECT *, COUNT(*) FROM tb_alunos GROUP BY interesse; /* Agrupar o retorno e contar quantos estao em cada grupo - Nesse caso pela coluna interesse*/
SELECT estado, COUNT(*) AS total_de_registro_por_estado FROM tb_alunos GROUP BY estado HAVING total_de_registro_por_estado > 5; /* A funcao HAVING aumenta o filtro do agrupamento feito pelo GROUP BY (ou seja, ele depende do GROUP BY para existir) */
SELECT estado, COUNT(*) AS total_de_registro_por_estado FROM tb_alunos GROUP BY estado HAVING estado('CE', 'SC') AND total_de_registro_por_estado > 4; /* Aumentando a complexidade do filtro */

/* Atualização de registros */
UPDATE tb_alunos SET nome = 'João', idade = 18 WHERE id_aluno = 13; /* Iremos atualizar toda a tabela tb_alunos, por isso é bom especificar o WHERE para evitar erros */

/* Deletando registros */
DELETE FROM tb_alunos WHERE id_aluno = 5; /* O registro sera deletado */

/* Junção de informações */
SELECT * FROM tb_alunos LEFT JOIN tb_cursos ON (tb_alunos.id_cliente  = tb_cursos.id_cliente); /* Dizemos que queremos todas as colunas das tabelas tb_alunos(como é um LEFT JOIN - a tabela da esquerda tem prioridade) que possui uma relação com a tabela tb_cursos, e essa relação se da pela coluna id_cliente */
SELECT * FROM tb_alunos RIGHT JOIN tb_cursos ON (tb_alunos.id_cliente  = tb_cursos.id_cliente); /* RIGHT JOIN - a tabela da direita tem prioridade na busca pelas informações */
/* INNER JOIN - trara apenas os registros que tiverem relações entre si, sem prioridade entre as tabelas */



/* Tipos de Dados que podemos armazenar */

/* Campos de Texto */
/* Text - Tamanho varivel que armazena uma grande quantidade de caracteres */
/* Varchar -  Tamanho varivel que armazena de 0 a 255 */
/* Char - Tamanho fixo que armazena de 0 ate 255 caracteres */

/* Campo Numérico */
/* Int - Valores numericos Inteiros */
/* Floot - Valores numericos fracionados */

/* Campos de data e hora */
/* Date - data do formato YYYY/mm/dd */
/* Time - Hora */
/* Datetime - combinação de data e hora em um mesmo campo */
