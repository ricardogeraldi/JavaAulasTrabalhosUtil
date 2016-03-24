# Cria o banco de dados denominado como aula_prog_sistemas
Create Database aula_prog_sistemas;

##### MANIPULANDO TABELAS COM SQL #####
# Cria a tabela Departamento
Create Table Departamento (
	Cod	Integer Not Null,
	Nome Varchar(20) Not Null,
	Constraint pkdepart Primary Key (Cod)
);

# Retorna todos os registros da tabela Departamento
Select * From Departamento;

# Cria a tabela Empregados
Create Table Empregados (
	Cod Integer Not Null,
	Nome Varchar(20) Not Null,
	Endereco Varchar (30),
	Funcao Varchar (30) Not Null,
	Coddepart Int Not Null,
	Salario	Decimal(10,2) Not Null,
	Constraint pkempregado Primary Key (Cod),
	
	Constraint fkdepart Foreign Key (Coddepart) References departamento(Cod) 
);

# Retorna todos os registros da tabela Empregados
Select * From Empregados;

# Alter Table faz alterações nos campos da tabela
Alter Table Empregados Add Column DTNasc Datetime Not Null;
Alter Table Empregados Add Column Cidade Varchar(100) Not Null;
Alter Table Empregados Modify Column Endereco Varchar(40);
Alter Table Empregados Drop Endereco Cascade;
Alter Table Empregados Drop Column DTNasc Cascade;
Alter Table Empregados Drop Endereco Restrict;
Alter Table Empregados Drop Column Endereco;

# O Comando Truncate apaga os registros da tabela Empregados.
Truncate Table Empregados;


##### Inserindo, Alterando e Excluindo Registro das tabelas do banco de dados #####
### INSERT (INSERIR) ###
#Insert Into tabela (atributo1, atributo2, ..., atributon) 
#Values (valor1, valor2, ..., valorn)

# Consulta os registros existentes na tabela Departamento
Select * From Departamento;
Insert Into Departamento(Cod,Nome) Values (1,'Marketing');
Insert Into Departamento(Cod,Nome) Values (1,'Consultoria');

# Consulta os registros existentes na tabela Empregados
Select * From Empregados;
Insert Into Empregados(Cod,Nome,Funcao,Coddepart,Salario,Cidade)
      Values (1,'Nelson','Estagiário',1,600,'Maringa');
Insert Into Empregados(Cod,Nome,Funcao,Coddepart,Salario,Cidade)
      Values(2,'Etevaldo','Estagiário',1,777,'Maringa');
Insert Into Empregados(Cod,Nome,Funcao,Coddepart,Salario,Cidade)
      Values(3,'João','Analista',1,1000,'Maringa');
Insert Into Empregados(Cod,Nome,Funcao,Coddepart,Salario,Cidade)
      Values(4,'Pedro','Analista',1,1500,'Maringa');

### UPDATE (ATUALIZAR) ###
# Update tabela Set <atribuições> Where <Condição>
Update Empregados Set Funcao = 'Analista' 
	Where Funcao = 'Estagiário';
Update Empregados Set Funcao = 'Estagiário', Salario = Salario + 500
	Where Funcao = 'Analista';
Select * from Empregados;

# Delete From tabela Where <Condição>
Delete From Empregados Where Funcao = 'Estagiário';
Select * from Empregados;


##### ESTRUTURAS DE CONSULTAS SQL #####
# SELECT <lista de atributos e funções>
# FROM <lista de tabelas>
# WHERE <condições>
# GROUP BY <atributos de agrupamento> 
# HAVING <condição de agrupamento>
# ORDER BY <list de atributos>; - A clausula Order By pode ser utilizada para uma ordenação crescente (ASC) ou decrescente(DESC).

Select * From Empregados Where salario > 1000;
Select * From Empregados Where salario = 720;
Select * From Empregados Where salario <> 720; 

Select * From Empregados Where salario Between 600 and 720;
Select * From Empregados Where salario Not Between 600 and 720;

Select * From Empregados Where nome Like '%E%';
Select * From Empregados Where nome Like 'E%';
Select * From Empregados Where nome Like '%E';

Select * From Empregados Where salario In (600,650,720);
Select * From Empregados Where salario Not In (600,650,720);

Select * From Empregados Where salario IS Null;
Select * From Empregados Where salario IS NOT Null;

Select * From Empregados Where salario IS Null and funcao = 'Trainee';
Select * From Empregados Where salario IS Null and (funcao = 'Trainee' or funcao = 'Estagiário');


##### FUNÇÕES DE AGREGAMENTO #####
# COUNT
Select count(*) From Empregados;
Select count(salario) From Empregados;

# MAX, MIN
Select max(salario) From Empregados;
Select min(salario) From Empregados;

# SUM, AVG
Select sum(Salario) From Empregados;
Select avg(Salario) From Empregados;

# Essa função tem a finalidade de agrupar os dados a serem retornados 
# em uma consulta SQL, como demonstrado abaixo:
Select Distinct Funcao,Sum(Salario) From Empregados 
	Where Cidade = 'Maringa' 
		Group By Funcao 
			Having SUM(Salario) > 600;

##### Junções #####
# INNER JOIN
Select Empregados.nome, Empregados.funcao 
	From (Empregados Inner Join departamento On Empregados.coddepart = departamento.cod) 
		Where departamento.nome = 'Consultoria';
#Equivalente a :
Select Empregados.nome, Empregados.funcao From Empregados,departamento 
	Where Empregados.coddepart = departamento.cod And departamento.nome = 'Consultoria';

# SubConsultas
Select Nome From Empregados Where Salario = (Select max(salario) From Empregados);

