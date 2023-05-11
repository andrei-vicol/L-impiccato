--INSTALLAZIONE
--Eseguire i seguenti script:
--1.
--Creazione tabella che contiene la parola
CREATE TABLE [dbo].[Impiccato](
	[PAROLA] [varchar](50) NULL
)
--Creazione tabella che scompone la parola
CREATE TABLE [dbo].[Impiccato_scomposizione](
	[Posizione] [int] NULL,
	[Lettera] [varchar](1) NULL
)

--Creazione tabella "Memory Card"
CREATE TABLE [dbo].[Impiccato_tentativi](
	[TENTATIVO] [int] IDENTITY(1,1) NOT NULL,
	[LETTERA] [varchar](max) NULL
)

--Creazione tabella "Stato del gioco"
--Gli stati del gioco possono essere: 1. "In Corso"; 2. "Fine"
	CREATE TABLE [dbo].[Impiccato_status](
		[STATUS] [varchar](max) NULL
	)
	
-------------------------------------------------------------------------------------------------
--2.
CREATE PROCEDURE [dbo].[Hangman] 

(	
	@comando varchar(1),
	@lettera varchar(1)
)

AS 

BEGIN
SET NOCOUNT ON;
DECLARE @i INT,
		@j INT,
		@tentativi INT

		SET @tentativi =   (SELECT COUNT(impiccato_tentativi.lettera) 
							FROM Impiccato_tentativi
							LEFT JOIN Impiccato_scomposizione 
							ON Impiccato_tentativi.LETTERA = Impiccato_scomposizione.Lettera
							WHERE Impiccato_tentativi.LETTERA NOT IN
								(SELECT LETTERA FROM Impiccato_scomposizione))  
		set @i = 1
		SET @j = 1

	DELETE FROM Impiccato_scomposizione --svuoto la tabella così mi accerto che non ci siano dati sporchi
	WHILE @i <= (SELECT LEN(parola) FROM Impiccato) --comincio a scomporre la parola in lettere e le inserisco nella tabella
	BEGIN
	INSERT INTO [dbo].[Impiccato_scomposizione]
			   ([Posizione]
			   ,[Lettera])
		 VALUES
			   (@i
			   ,(SELECT SUBSTRING(parola,@i,@j) FROM Impiccato))
	SET @i = @i + 1
	END

IF	@comando = 'S' --START
	AND @tentativi = 0
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	AND @lettera IN (SELECT lettera FROM Impiccato_scomposizione) --Verifico che la lettera fa parte della parola
	BEGIN
	DECLARE @Impiccato VARCHAR(MAX)
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |     
     |     
     |       
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 0
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |     
     |       
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 1
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	AND @lettera IN (SELECT lettera FROM Impiccato_scomposizione) --Verifico che la lettera fa parte della parola
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |       
     |       
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 1
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |       |
     |       |
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 2
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	AND @lettera IN (SELECT lettera FROM Impiccato_scomposizione) --Verifico che la lettera fa parte della parola
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |       |
     |       |
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 2
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |      \|
     |       |
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 3
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	AND @lettera IN (SELECT lettera FROM Impiccato_scomposizione) --Verifico che la lettera fa parte della parola
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |      \|
     |       |
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 3
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 4
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	AND @lettera IN (SELECT lettera FROM Impiccato_scomposizione) --Verifico che la lettera fa parte della parola
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 4
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      /
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 5
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	AND @lettera IN (SELECT lettera FROM Impiccato_scomposizione) --Verifico che la lettera fa parte della parola
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      /
	 | 
    _|__________ 

	
	' + @Impiccato
	END
ELSE
IF	@comando = 'S' --START
	AND @tentativi = 5
	AND @lettera NOT IN (SELECT lettera FROM Impiccato_tentativi) --Verifico se ho già tentato questa lettera
	BEGIN
		INSERT INTO [dbo].[Impiccato_tentativi]
				   ([LETTERA])
			 VALUES
				   (@lettera)
	SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
	FROM Impiccato_scomposizione
	LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
	PRINT 'Tentativo inserito: ' + @lettera + ' 
	  _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      / \ 
	 | 
    _|__________ 

G A M E   O V E R !

	' + @Impiccato
	END
ELSE
	BEGIN
		SET @Impiccato = (SELECT STRING_AGG( ISNULL(Impiccato_tentativi.LETTERA,'_'), ' ') As Parola 
		FROM Impiccato_scomposizione
		LEFT JOIN Impiccato_tentativi ON Impiccato_scomposizione.Lettera = Impiccato_tentativi.LETTERA)
		PRINT 'Lettera già inserita in precedenza!
		
  PAROLA:   ' + @Impiccato;
	END
END