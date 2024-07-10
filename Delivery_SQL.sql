USE T1_AndreAleff
GO

CREATE SCHEMA Delivery
GO

--------------- CRIANDO AS TABELAS ---------------
CREATE TABLE Delivery.[Cliente]
(
    [Cliente_id] int NOT NULL,
	[NIF] char(9) NOT NULL,
	[Nome] varchar(60) NOT NULL,
	[Telefone] char(9) NOT NULL,
	[Email] varchar (30) NOT NULL,
	[Morada] varchar (100)NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Cliente_id] ASC
)
)

GO

CREATE TABLE Delivery.[Compra]
(
	[Compra_id] int NOT NULL,
	[Fatura] int NULL,
	[Data/Hora] datetime  NOT NULL,
	[Cliente_id] int  NOT NULL,
	[Vendedor_id] int NOT null
PRIMARY KEY CLUSTERED 
(
	[Compra_id] ASC
)
)
GO

CREATE TABLE Delivery.[Vendedor]
(
	[Vendedor_id] int NOT NULL    ,
	[Nome] varchar (30) NOT NULL,
	[Telefone] int  NOT NULL,
	[NIF] char(9) NOT NULL,
	[Email] varchar (30) NOT NULL,
	[Morada] varchar (150) NOT NULL
	PRIMARY KEY CLUSTERED 
(
	[Vendedor_id] ASC
)
)
GO

CREATE TABLE Delivery.[Entregador]
(
	[Entregador_id] int NOT NULL    ,
	[Nome] varchar(60) NOT NULL,
	[Telefone] int NOT NULL,
	[NIF] char(9) NOT NULL,
	[Matricula do ve�culo] char(9) NULL,
	[Email] varchar (30) NOT NULL,
	[Morada] varchar(150) NOT NULL,
	[Regi�o_id] int NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Entregador_id] ASC
)
)
GO


CREATE TABLE Delivery.[Entrega]
(
	[Entrega_id] int NOT NULL    ,
	[Data de entrega] datetime NULL,
	[Situa��o_id] int  NOT NULL,
	[Pacote_id] int NOT NULL,
	[Valor por Entrega] decimal(5,2) NOT NULL,
	[Entregador_id] int NOT NULL
	PRIMARY KEY CLUSTERED 
(
	[Entrega_id] ASC
)
)
GO


CREATE TABLE Delivery.[Pacote]
(
	[Pacote_id] int NOT NULL    ,
	[Status_id] int NOT NULL,
	[Compra_id] INT NOT NULL,
	[Tp_Pacote_id] int  NULL,
	[Coleta_id] int  NULL,
	[Entrega_id] int  NULL,
	[Data Prevista] datetime
	PRIMARY KEY CLUSTERED 
(
	[Pacote_id] ASC
)
) 
GO


CREATE TABLE Delivery.[Tipo_Pacote]
(
	[Tp_Pacote_id] int NOT NULL    ,
	[Designa��o] varchar(60)  NULL,
	[Valor] int  NULL,
	PRIMARY KEY CLUSTERED 
(
	[Tp_Pacote_id] ASC
)
) 
GO


CREATE TABLE Delivery.[Reagendamento]
(
	[Reagendamento_id] int  NOT NULL    ,
	[Nova Data] date NULL,
	[Entrega_id] int  NOT NULL,
	[Numero Tentativa] int  NULL,
	[Data Tentativa] datetime NULL,
	[Motivo Insucesso] VARCHAR(60) NULL,
	PRIMARY KEY CLUSTERED 
(
	[Reagendamento_id] ASC
)
) 
GO


CREATE TABLE Delivery.[Coleta]
(
	[Coleta_id] int  NOT NULL    ,
	[Valor por Coleta] decimal(5,2) NULL,
	[Entregador_id] int  NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Coleta_id] ASC
)
)
GO

CREATE TABLE Delivery.[Regi�o]
(
	[Regi�o_id] int  NOT NULL    ,
	[Designa��o] varchar(60) NOT NULL,
	[Taxa de Sucesso] decimal(3,2) NULL,
	[Gestor_id] int  NOT NULL
	PRIMARY KEY CLUSTERED 
(
	[Regi�o_id] ASC
)
)  
GO

CREATE TABLE Delivery.[Gestor]
(
    [Gestor_id] int  NOT NULL  ,
	[NIF] char(9) NOT NULL,
	[Nome] varchar(60) NOT NULL,
	[Telefone] int NULL,
	[Email] varchar (30) NOT NULL,
	[Morada] varchar (100) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Gestor_id] ASC
)
)  
GO

CREATE TABLE Delivery.[Status]
(
	[Status_id] int NOT NULL    ,
	[Tp_status] varchar(60)  NULL,
	PRIMARY KEY CLUSTERED 
(
	[Status_id] ASC
)
) 
GO



CREATE TABLE Delivery.[Ocorrencia na entrega]
(
	[Situa��o_id] int NOT NULL    ,
	[Tp_ocorrencia] varchar(60)  NULL,
	PRIMARY KEY CLUSTERED 
(
	[Situa��o_id] ASC
)
) 
GO

ALTER TABLE Delivery.[Compra]  WITH CHECK ADD  CONSTRAINT [FK_Compra_Cliente] FOREIGN KEY([Cliente_id])
REFERENCES Delivery.[Cliente] ([Cliente_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Compra]  WITH CHECK ADD  CONSTRAINT [FK_Compra_vendedor] FOREIGN KEY([Vendedor_id])
REFERENCES Delivery.[Vendedor] ([Vendedor_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Pacote]  WITH CHECK ADD  CONSTRAINT [FK_Pacote_Compra] FOREIGN KEY([Compra_id])
REFERENCES Delivery.[Compra] ([Compra_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Pacote]  WITH CHECK ADD  CONSTRAINT [FK_Pacote_tp_pacote] FOREIGN KEY([Tp_Pacote_id])
REFERENCES Delivery.[Tipo_pacote] ([Tp_Pacote_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Pacote]  WITH CHECK ADD  CONSTRAINT [FK_Pacote_Coleta] FOREIGN KEY([Coleta_id])
REFERENCES Delivery.[Coleta] ([Coleta_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Pacote]  WITH CHECK ADD  CONSTRAINT [FK_Pacote_Status] FOREIGN KEY([Status_id])
REFERENCEs Delivery.[Status] ([Status_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Pacote]  WITH CHECK ADD  CONSTRAINT [FK_Pacote_Entrega] FOREIGN KEY([Entrega_id])
REFERENCES Delivery.[Entrega] ([Entrega_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Coleta]  WITH CHECK ADD  CONSTRAINT [FK_Coleta_Entregregador] FOREIGN KEY([Entregador_id])
REFERENCES Delivery.[Entregador] ([Entregador_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Entregador]  WITH CHECK ADD  CONSTRAINT [FK_Entregador_Regi�o] FOREIGN KEY([Regi�o_id])
REFERENCES Delivery.[Regi�o] ([Regi�o_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Regi�o]  WITH CHECK ADD  CONSTRAINT [FK_Regi�o_Gestor] FOREIGN KEY([Gestor_id])
REFERENCES Delivery.[Gestor] ([Gestor_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Entrega]  WITH CHECK ADD  CONSTRAINT [FK_Entrega_Situa��o] FOREIGN KEY([Situa��o_id])
REFERENCES Delivery.[Ocorrencia na entrega] ([Situa��o_id])
ON UPDATE CASCADE
GO
ALTER TABLE Delivery.[Entrega]  WITH CHECK ADD  CONSTRAINT [FK_Entrega_Entregador] FOREIGN KEY([Entregador_id])
REFERENCES Delivery.[Entregador] ([Entregador_id])
GO
ALTER TABLE Delivery.[Reagendamento]  WITH CHECK ADD  CONSTRAINT [FK_Reagendamento_Entrega] FOREIGN KEY([Entrega_id])
REFERENCES Delivery.[Entrega] ([Entrega_id])
ON UPDATE CASCADE
GO

------- INSERINDO DADOS BASE -------
INSERT INTO Delivery.[Regi�o] ([Regi�o_id], [Designa��o], [Taxa de Sucesso], [Gestor_id])
VALUES
(1, 'Lisboa Centro', 0.95, 1),
(2, 'Lisboa Norte', 0.90, 2),
(3, 'Lisboa Sul', 0.85, 3),
(4, 'Lisboa Oeste', 0.92, 4),
(5, 'Lisboa Leste', 0.88, 5);
GO

INSERT INTO Delivery.[Tipo_Pacote] ([Tp_Pacote_id], [Designa��o], [Valor])
VALUES
(1, 'Pequeno', 10),
(2, 'M�dio', 20),
(3, 'Grande', 30),
(4, 'Extra Grande', 50),
(5, 'Cancelado', 0);
GO

INSERT INTO Delivery.[Ocorrencia na entrega] ([Situa��o_id], [Tp_ocorrencia])
VALUES
(1, 'Cliente Ausente'),
(2, 'Endere�o Incorreto'),
(3, 'Entrega Reagendada'),
(4, 'Pacote Danificado'),
(5, 'Entrega Bem Sucedida'),
(6, 'Em Rota');
GO

INSERT INTO Delivery.[Status] ([Status_id], [Tp_status])
VALUES
(1, 'Aguardando Coleta'),
(2, 'Coletado'),
(3, 'Aguardando Despacho'),
(4, 'Em Tr�nsito'),
(5, 'Entregue'),
(6, 'Reagendado'),
(7, 'Cancelado');
GO

INSERT INTO Delivery.[Gestor] ([Gestor_id], [NIF], [Nome], [Telefone], [Email], [Morada])
VALUES
(1, 123456789, 'Ana Silva', '912345678', 'ana.silva@example.com', 'Rua A, Lisboa'),
(2, 987654321, 'Bruno Costa', '932145678', 'bruno.costa@example.com', 'Rua B, Lisboa'),
(3, 192837465, 'Carla Santos', '952367890', 'carla.santos@example.com', 'Rua C, Lisboa'),
(4, 564738291, 'Diogo Ferreira', '912365478', 'diogo.ferreira@example.com', 'Rua D, Lisboa'),
(5, 374829105, 'Eva Martins', '923456789', 'eva.martins@example.com', 'Rua E, Lisboa');
GO

INSERT INTO Delivery.[Cliente] ([Cliente_id], [NIF], [Nome], [Telefone], [Email], [Morada])
VALUES
(1, '123456789', 'Jos� Almeida', '912345678', 'jose.almeida@example.com', 'Avenida A, 10, Lisboa'),
(2, '098765432', 'Maria Ferreira', '913245678', 'maria.ferreira@example.com', 'Rua B, 20, Lisboa'),
(3, '112233445', 'Carlos Silva', '914345678', 'carlos.silva@example.com', 'Travessa C, 30, Lisboa'),
(4, '667788990', 'Ana Sousa', '915445678', 'ana.sousa@example.com', 'Alameda D, 40, Lisboa'),
(5, '554433221', 'Lu�s Costa', '916545678', 'luis.costa@example.com', 'Pra�a E, 50, Lisboa');
GO



INSERT INTO Delivery.[Vendedor] ([Vendedor_id], [Nome], [Telefone], [NIF], [Email], [Morada])
VALUES
(1, 'Pedro Mendes', 917654321, '123456789', 'pedro.mendes@example.com', 'Rua F, 60, Lisboa'),
(2, 'Rita Santos', 918754321, '987654321', 'rita.santos@example.com', 'Rua G, 70, Lisboa'),
(3, 'Jo�o Pereira', 919854321, '192837465', 'joao.pereira@example.com', 'Rua H, 80, Lisboa'),
(4, 'Paula Rocha', 910954321, '564738291', 'paula.rocha@example.com', 'Rua I, 90, Lisboa'),
(5, 'Nuno Gomes', 911054321, '374829105', 'nuno.gomes@example.com', 'Rua J, 100, Lisboa');
GO

INSERT INTO Delivery.[Entregador] ([Entregador_id], [Nome], [Telefone], [NIF], [Matricula do ve�culo], [Email], [Morada], [Regi�o_id])
VALUES
(1, 'F�bio Ribeiro', 920123456, '456789123', '00-AA-01', 'fabio.ribeiro@example.com', 'Rua K, 110, Lisboa', 1),
(2, 'Sofia Martins', 920223456, '654321987', '00-AA-02', 'sofia.martins@example.com', 'Rua L, 120, Lisboa', 2),
(3, 'Tiago Neves', 920323456, '789123654', '00-AA-03', 'tiago.neves@example.com', 'Rua M, 130, Lisboa', 3),
(4, 'Helena Costa', 920423456, '321987654', '00-AA-04', 'helena.costa@example.com', 'Rua N, 140, Lisboa', 4),
(5, 'Ricardo Lima', 920523456, '987321654', '00-AA-05', 'ricardo.lima@example.com', 'Rua O, 150, Lisboa', 5);
GO


--(USP_Update_Data)procedure para atualizar cliente, entregador ou vendedor (considerando apenas nome, telefone, email e morada)
--TESTADA

Create or alter Procedure USP_Update_Data (
	@Tabela varchar(20), -- Esse par�metro identifica a tabela que ser� atualizada
	@Id int,
	@Nome varchar(60),
	@Telefone char(9),
	@Email varchar(30),
	@Morada varchar(100))
as 
	begin
	set nocount on
		if @Tabela = 'Cliente'
			UPDATE Delivery.Cliente
			SET Nome = @Nome, 
				Telefone = @Telefone, 
				Email = @Email, 
				Morada = @Morada
			WHERE Cliente_id = @id;
		else if @tabela = 'Entregador'
			UPDATE Delivery.Entregador
			SET Nome = @Nome, 
				Telefone = @Telefone, 
				Email = @Email, 
				Morada = @Morada
			WHERE Entregador_id = @id;
		else if @tabela = 'Vendedor'
			UPDATE Delivery.Vendedor
			SET Nome = @Nome, 
				Telefone = @Telefone, 
				Email = @Email, 
				Morada = @Morada
			WHERE Vendedor_id = @id;
		else 
			print('A tabela fornecida n�o existe, os par�metros de tabela que podem ser utilizados s�o: Cliente, Entregador ou Vendedor')
	end
go


----//(USP_Validate_Purchase)procedure para criar compra, fazer os checks necess�rios(se o cliente nao existir na base de dados retornar uma mensagem para criar o cliente primeiro)
-- PROCEDURE TESTADA
CREATE or alter PROCEDURE USP_Validate_Purchase 
    @Cliente_id INT,
    @Vendedor_id INT
AS
BEGIN
	SET NOCOUNT ON
	declare @pacoteid int
	SET @pacoteid = (SELECT MAX([Pacote_id]) FROM Delivery.Pacote)
	declare @compraid int
	SET @compraid = (SELECT MAX([Compra_id]) FROM Delivery.Compra)
    IF NOT EXISTS (SELECT 1 FROM Delivery.Cliente WHERE Cliente_id = @Cliente_id) --- se nao existe entao adicionar uma cliente
    BEGIN
        RAISERROR('Cliente n�o existe. Por favor, crie o cliente primeiro.', 16, 1) ---- dizendo que o clienete nao existe
        RETURN
    END

    INSERT INTO Delivery.Compra (Compra_id, Cliente_id, Vendedor_id, [Data/Hora])
    VALUES (@compraid+1,@Cliente_id, @Vendedor_id, getdate());

    IF DATEPART(HOUR, getdate()) < 12
    BEGIN
        INSERT INTO Delivery.Pacote (Pacote_id,Status_id, Compra_id, [Data Prevista])
        VALUES (@pacoteid+1,1, @Compraid+1, DATEADD(HOUR, 24, GETDATE()));
    END
    ELSE
    BEGIN
        INSERT INTO Delivery.Pacote (Pacote_id,Status_id, Compra_id, [Data Prevista])
        VALUES (@pacoteid+1,3, @Compraid+1, DATEADD(HOUR, 48, GETDATE()));
����END
END
go

-- (USP_Collect_Value)procedure para coleta e classifica��o de valor do pacote. (atualizar tabela pacotes sobre o status)
-- PROCEDURE TESTADA
Create or alter procedure USP_Collect_Value(
	@entregador_id int,
	@tipo_pacote_id int,
	@pacote_id int)
as
	begin
		set nocount on
		declare @coleta_id int
		SET @coleta_id = (SELECT MAX([Coleta_id]) FROM Delivery.Coleta)
		insert into Delivery.Coleta(Coleta_id, [Valor por Coleta], Entregador_id)
		values(@coleta_id+1,2.5, @entregador_id)
		UPDATE Delivery.Pacote
			SET Status_id = 2,
				Tp_Pacote_id = @tipo_pacote_id,
				Coleta_id = @coleta_id+1
			WHERE Pacote_id = @pacote_id;
	end
go	

-- (USP_Reschedule_Deliver) procedure para transito, reagendamento ou finaliza��o de entrega (Atualizar tabela pacotes sobre isso)
-- TESTADA
Create or alter procedure USP_RescheduleOrDeliver_Package(
	@entregador_id int, 
	@pacote_id int,
	@ocorrencia_id int)
as 
	begin
		set nocount on
		declare @entrega_id int,
				@reagendamento_id int,
				@num_tentativa int,
				@ocorrencia varchar(60)
		select @entrega_id = Entrega_id
		from Delivery.Pacote
		where Pacote_id = @pacote_id

		if @entrega_id is NULL and @ocorrencia_id = 6  -- se a entrega ainda nao esta atribuida a um pacote criamos a entrega e atribuimos o pacote a "em rota"
			begin
				SET @entrega_id = (SELECT MAX(Entrega_id) FROM Delivery.Entrega)
				insert into Delivery.Entrega(Entrega_id, Entregador_id, Pacote_id,Situa��o_id, [Valor por Entrega])
				values(@entrega_id+1,@entregador_id,@pacote_id,6, 5)
				UPDATE Delivery.Pacote
				SET Status_id = 4,
					Entrega_id = @entrega_id+1
				WHERE Pacote_id = @pacote_id;
				return
			end
		else if  @entrega_id is NULL and @ocorrencia_id <> 6
			begin
				RAISERROR('Objeto n�o est� em rota para ocorrencia solicitada', 16, 1)
				RETURN
			end
		else if @entrega_id is not null and @ocorrencia_id = 5 -- se o pacote ja estiver atribuido a uma entrega e formos finalizar a entrega isso correr�
			begin
					UPDATE Delivery.Entrega
					SET Situa��o_id = @ocorrencia_id,
						[Data de entrega] = getdate()
					WHERE Entrega_id = @entrega_id;

					UPDATE Delivery.Pacote
					SET Status_id = 5
					WHERE Pacote_id = @pacote_id;
			end
		else if @entrega_id is not null and @ocorrencia_id <> 5 --se o pacote ja estiver atribuido a uma entrega e formos realizar uma a��o que reagende o pacote.
			begin
				UPDATE Delivery.Entrega
					SET Situa��o_id = @ocorrencia_id
					WHERE Entrega_id = @entrega_id;

					UPDATE Delivery.Pacote
					SET Status_id = 6
					WHERE Pacote_id = @pacote_id;
					
					set @ocorrencia = (select Tp_ocorrencia from Delivery.[Ocorrencia na entrega] where Situa��o_id = @ocorrencia_id) 
					SET @reagendamento_id = ISNULL((SELECT MAX(Reagendamento_id) FROM Delivery.Reagendamento), 0)
					SET @num_tentativa =  ISNULL((SELECT MAX([Numero Tentativa]) FROM Delivery.Reagendamento where Entrega_id = @entrega_id), 0)
					insert into Delivery.Reagendamento(Reagendamento_id, Entrega_id, [Nova Data],[Numero Tentativa],[Data Tentativa], [Motivo Insucesso])
					values(@reagendamento_id+1, @entrega_id, DATEADD(HOUR, 24, GETDATE()), @num_tentativa+1, getdate(), @ocorrencia)
			end
	end;
go

---testada
CREATE TRIGGER TRG_Reschedule_Limit
ON Delivery.Reagendamento
AFTER INSERT, UPDATE
AS
BEGIN
	set nocount on
    DECLARE @Entrega_id INT;

    SELECT @Entrega_id = Entrega_id
    FROM inserted;

    -- Verifique se o n�mero de tentativas de reagendamento � 3 ou mais
    IF (SELECT MAX([Numero Tentativa]) AS N_TENTATIVA FROM Delivery.Reagendamento WHERE Entrega_id = @Entrega_id) >= 3
    BEGIN
        -- Atualizar tipo de pacote para cancelado, isto vai zerar o valor do pacote
		UPDATE Delivery.Pacote
        SET Tp_Pacote_id = 5
        WHERE Entrega_id = @Entrega_id;
		-- Zerar o valor do pacote
        UPDATE Delivery.Pacote
        SET [Status_id] = 7
        WHERE Entrega_id = @Entrega_id;

        -- Zerar o valor da coleta associada
        UPDATE Delivery.Coleta
        SET [Valor por Coleta] = 0
        WHERE Coleta_id = (SELECT Coleta_id FROM Delivery.Pacote WHERE Entrega_id = @Entrega_id);

		-- Zerar o valor da entrega associada
		UPDATE Delivery.Entrega
        SET [Valor por Entrega] = 0
        WHERE Entrega_id = (SELECT Entrega_id FROM Delivery.Pacote WHERE Entrega_id = @Entrega_id);
����END
END;
GO
---testado
CREATE TRIGGER trg_Update_Indice_Sucesso
ON Delivery.Entrega
AFTER INSERT, UPDATE 
AS
BEGIN
	set nocount on
	DECLARE @EntregasFeitas int,
			@Reagendadas int,
			@Entrega_id int,
			@Regi�o_id int

	set @Entrega_id = (select Entrega_id from Inserted)

	set @Regi�o_id = (select top 1(Rg.Regi�o_id)
		from Delivery.Reagendamento R
			Join Delivery.Entrega E on R.Entrega_id = E.Entrega_id
			join Delivery.Entregador En on E.Entregador_id = En.Entregador_id
			join Delivery.Regi�o Rg on En.Regi�o_id = Rg.Regi�o_id
		where E.Entrega_id = @Entrega_id)
	---- conta quantos reagendamentos tiveram na regi�o
	set @Reagendadas = (select count(isnull(R.[Data Tentativa],0))
			from Delivery.Reagendamento R
			Join Delivery.Entrega E on R.Entrega_id = E.Entrega_id
			join Delivery.Entregador En on E.Entregador_id = En.Entregador_id
			join Delivery.Regi�o Rg on En.Regi�o_id = Rg.Regi�o_id
		where Rg.Regi�o_id = @Regi�o_id)
	--- conta quantas entregas foram completadas na regi�o
	set @EntregasFeitas = (select count(isnull([Data de entrega],0))
		from Delivery.Entrega E 
			join Delivery.Entregador En on E.Entregador_id = En.Entregador_id
			join Delivery.Regi�o Rg on En.Regi�o_id = Rg.Regi�o_id
		where Rg.Regi�o_id = @Regi�o_id)
	
	update Delivery.Regi�o
	set [Taxa de Sucesso] = cast(@EntregasFeitas as float)/(isnull(@EntregasFeitas,0)+isnull(@Reagendadas,0))
	where Regi�o_id = @Regi�o_id
END;
GO

-------------------- PROCEDURES EM ORDEM PARA CRIAR COMPRA/PACOTE, COLETAR, TENTATIVAS DE ENTREGA ----------------------
--exec USP_Validate_Purchase cliente_id, Vendedor_id 
--exec USP_Collect_Value Entregador_id, tipo_pacote_id, pacote_id
--exec USP_RescheduleOrDeliver_Package entregador_id, pacote_id, ocorrencia_id
go

--------------------- NAO APAGAR ----------------------------------------------------------------------------------------
--VIEW PARA SUPERVISOR VERIFICAR QUANTIDADE DE ENTREGAS TOTAIS POR VENDEDOR E CLIENTE
create view Status_of_sales
as
select C.Compra_id,
		V.Nome as NomeVendedor,
		CLT.nome as NomeCliente,
		C.[Data/Hora] as [Data da compra],
		ST.Tp_status as [Status]

from Delivery.Vendedor	V
		join Delivery.Compra C on V.Vendedor_id = C.Vendedor_id
		join Delivery.Pacote P on P.Compra_id = C.Compra_id
		join Delivery.Tipo_Pacote TP on TP.Tp_Pacote_id = P.Tp_Pacote_id
		join Delivery.[Status] ST on P.Status_id = ST.Status_id
		join Delivery.Coleta CL on P.Coleta_id = CL.Coleta_id
		join Delivery.Entrega E on E.Entrega_id = P.Entrega_id
		JOIN delivery.Cliente CLT on CLT.Cliente_id = C.Cliente_id
go

--VIEW PARA VERIFICAR VALOR A RECEBER DOS ENTREGADORES
create view Courier_Payment
as
select EN.Entregador_id as [Entregador ID],
	   EN.Nome as Entregador,
	   SUM(C.[Valor por Coleta]) as [Valor das coletas],
	   SUM(E.[Valor por Entrega]) as [Valor das entregas],
	   SUM(C.[Valor por Coleta])+SUM(E.[Valor por Entrega]) as TOTAL
from Delivery.[Status] ST
		join Delivery.Pacote P on ST.Status_id = P.Status_id
		join Delivery.Coleta C on P.Coleta_id = C.Coleta_id
		join Delivery.Entrega E on P.Entrega_id = E.Entrega_id
		join Delivery.Entregador EN on C.Entregador_id = EN.Entregador_id
where P.Status_id = 5
group by EN.Nome, EN.Entregador_id
go

--VIEW PARA VERIFICAR FINANCEIRO DA EMPRESA
create view Finances
as
select TP.Designa��o As [Tamanho do pacote],
	   TP.Valor as [Valor por pacote],
	   Count(P.[Status_id]) as [Total Pacotes Concluidos],
	   SUM(C.[Valor por Coleta])+SUM(E.[Valor por Entrega]) as [Custo Log�stico],
	   Count(P.[Status_id])*TP.Valor as [Fatura��o Bruta],
	   (Count(P.[Status_id])*TP.Valor)-(SUM(C.[Valor por Coleta])+SUM(E.[Valor por Entrega])) as [Fatura��o l�quida]
from Delivery.[Status] ST
		join Delivery.Pacote P on ST.Status_id = P.Status_id
		join Delivery.Coleta C on P.Coleta_id = C.Coleta_id
		join Delivery.Entrega E on P.Entrega_id = E.Entrega_id
		join Delivery.Entregador EN on C.Entregador_id = EN.Entregador_id
		join Delivery.Tipo_Pacote TP on P.Tp_Pacote_id = TP.Tp_Pacote_id
where P.Status_id = 5
group by TP.Designa��o, TP.Valor
go

--VIEW PARA VERIFICAR ENTREGAS CONCLUDAS, CANCELADAS E REAGENDADAS POR REGI�O
create view Region_sucess
as
select R.Designa��o AS Regi�o,
       SUM(case when s.Tp_status = 'Entregue' then 1 else 0 end) as [Quantidade Entregue],
       SUM(case when s.Tp_status = 'Cancelado' then 1 else 0 end) as [Quantidade Cancelado],
       SUM(case when s.Tp_status = 'Reagendado' then 1 else 0 end) as [Quantidade Reagendado],
	   R.[Taxa de Sucesso] as [Taxa de sucesso da regi�o]
From Delivery.Entrega E
		join Delivery.Entregador EN ON E.Entregador_id = EN.Entregador_id
		join Delivery.Regi�o r ON en.Regi�o_id = r.Regi�o_id
		join Delivery.[Status] s ON e.Situa��o_id = s.Status_id
group by R.Designa��o, R.[Taxa de Sucesso]
go

--VIEW PARA VER A QUANTIDADE/VALOR DE ENTRAGAS FEITAS POR REGI�O
create view Sales_of_Region
as
select
    R.Designa��o AS Regi�o,
    Count(C.Compra_id) AS [Quantidade Vendas Conclu�das],
    SUM(TP.Valor) AS [Valor Total Vendas]
from Delivery.Compra c
		join Delivery.Cliente cli ON c.Cliente_id = cli.Cliente_id
		join Delivery.Pacote p ON c.Compra_id = p.Compra_id
		join Delivery.Tipo_Pacote tp ON p.Tp_Pacote_id = tp.Tp_Pacote_id
		join Delivery.Entrega e ON p.Entrega_id = e.Entrega_id
		join Delivery.Entregador en ON e.Entregador_id = en.Entregador_id
		join Delivery.Regi�o r ON en.Regi�o_id = r.Regi�o_id
where P.status_id = 5
group by R.Designa��o
Go

