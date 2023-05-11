--Gioco: L'impiccato
--Autore: Vicol Andrei Alexandru
--Data: 09/05/2023

--Il giocatore ha 5 possibilità di sbagliare. Alla sesta è Game Over.
--

Declare @comando varchar(1)
Declare @lettera varchar(1)

--Scegliere: 'S' per cominciare il gioco
--			 'T' per teriminare il gioco

set @comando = 'S'

--Scegliere la lettera
set @lettera = 'I'

EXECUTE [dbo].[Hangman] @comando,  @lettera