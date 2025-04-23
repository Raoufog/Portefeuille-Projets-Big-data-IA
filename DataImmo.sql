--USE [master] ; 
--CREATE DATABASE [DataImmo] COLLATE French_CI_AS 
--GO
--USE [DataImmo] ; 
CREATE TABLE [dbo].[ValeursFoncieres](
	[Identifiant de document] [varchar](50) NULL, [Reference document] [varchar](50) NULL,
	[1 Articles CGI] [varchar](50) NULL, [2 Articles CGI] [varchar](50) NULL,
	[3 Articles CGI] [varchar](50) NULL, [4 Articles CGI] [varchar](50) NULL,
	[5 Articles CGI] [varchar](50) NULL, [No disposition] [varchar](50) NULL,
	[Date mutation] [datetime] NULL, [Nature mutation] [varchar](50) NULL,
	[Valeur fonciere] [varchar](50) NULL, [No voie] [varchar](50) NULL,
	[B T Q] [varchar](50) NULL, [Type de voie] [varchar](50) NULL,
	[Code voie] [varchar](50) NULL, [Voie] [varchar](50) NULL,
	[Code postal] [varchar](50) NULL, [Commune] [varchar](50) NULL,
	[Code departement] [varchar](50) NULL, [Code commune] [varchar](50) NULL,
	[Prefixe de section] [varchar](50) NULL, [Section] [varchar](50) NULL,
	[No plan] [varchar](50) NULL, [No Volume] [varchar](50) NULL,
	[1er lot] [varchar](50) NULL, [Surface Carrez du 1er lot] [varchar](50) NULL,
	[2eme lot] [varchar](50) NULL, [Surface Carrez du 2eme lot] [varchar](50) NULL,
	[3eme lot] [varchar](50) NULL, [Surface Carrez du 3eme lot] [varchar](50) NULL,
	[4eme lot] [varchar](50) NULL, [Surface Carrez du 4eme lot] [varchar](50) NULL,
	[5eme lot] [varchar](50) NULL, [Surface Carrez du 5eme lot] [varchar](50) NULL,
	[Nombre de lots] [int] NULL, [Code type local] [varchar](50) NULL,
	[Type local] [varchar](50) NULL, [Identifiant local] [varchar](50) NULL,
	[Surface reelle bati] [float] NULL, [Nombre pieces principales] [int] NULL,
	[Nature culture] [varchar](50) NULL, [Nature culture speciale] [varchar](50) NULL,
	[Surface terrain] [int] NULL
) 
GO
bulk insert [ValeursFoncieres]
from 'C:\data\ValeursFoncieres-2024.txt'
with(firstrow=2,FIELDTERMINATOR = '|', ROWTERMINATOR='0x0A', codepage = '65001')


--Consultation de notre jeu de données
select TOP 20 * from ValeursFoncieres ;

--Suppression des colonnes vides
ALTER TABLE ValeursFoncieres DROP COLUMN [Identifiant de document];
ALTER TABLE ValeursFoncieres DROP COLUMN [5 Articles CGI];
ALTER TABLE ValeursFoncieres DROP COLUMN [4 Articles CGI];
ALTER TABLE ValeursFoncieres DROP COLUMN [3 Articles CGI];
ALTER TABLE ValeursFoncieres DROP COLUMN [2 Articles CGI];
ALTER TABLE ValeursFoncieres DROP COLUMN [1 Articles CGI];
ALTER TABLE ValeursFoncieres DROP COLUMN [Reference document];
ALTER TABLE ValeursFoncieres DROP COLUMN [Identifiant local];
ALTER TABLE ValeursFoncieres DROP COLUMN [No Volume];
ALTER TABLE ValeursFoncieres DROP COLUMN [1er lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 1er lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [2eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 2eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [3eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 3eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [4eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 4eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [5eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 5eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [B T Q];
ALTER TABLE ValeursFoncieres DROP COLUMN [Prefixe de section];
ALTER TABLE ValeursFoncieres DROP COLUMN [No Volume];
ALTER TABLE ValeursFoncieres DROP COLUMN [1er lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 1er lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [2eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [SUrface Carrez du 2eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [3eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 3eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [4eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 4eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [5eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Surface Carrez du 5eme lot];
ALTER TABLE ValeursFoncieres DROP COLUMN [Nature culture speciale];

--LISTER DES VALEURS NULL PAR COLONNES
 
SELECT
  SUM(CASE WHEN [No disposition] IS NULL THEN 1 ELSE 0 END) AS nulls_No_disposition,
  SUM(CASE WHEN [Date mutation] IS NULL THEN 1 ELSE 0 END) AS nulls_Date_mutation,
  SUM(CASE WHEN [Nature mutation] IS NULL THEN 1 ELSE 0 END) AS nulls_Nature_mutation,
  SUM(CASE WHEN [Valeur fonciere] IS NULL THEN 1 ELSE 0 END) AS nulls_Valeur_fonciere,
  SUM(CASE WHEN [No voie] IS NULL THEN 1 ELSE 0 END) AS nulls_No_voie,
  SUM(CASE WHEN [Type de voie] IS NULL THEN 1 ELSE 0 END) AS nulls_Type_de_voie,
  SUM(CASE WHEN [Code voie] IS NULL THEN 1 ELSE 0 END) AS nulls_Code_voie,
  SUM(CASE WHEN [Voie] IS NULL THEN 1 ELSE 0 END) AS nulls_Voie,
  SUM(CASE WHEN [Code postal] IS NULL THEN 1 ELSE 0 END) AS nulls_Code_postal,
  SUM(CASE WHEN [Commune] IS NULL THEN 1 ELSE 0 END) AS nulls_Commune,
  SUM(CASE WHEN [Code departement] IS NULL THEN 1 ELSE 0 END) AS nulls_Code_departement,
  SUM(CASE WHEN [Code commune] IS NULL THEN 1 ELSE 0 END) AS nulls_Code_commune,
  SUM(CASE WHEN [Section] IS NULL THEN 1 ELSE 0 END) AS nulls_Section,
  SUM(CASE WHEN [No plan] IS NULL THEN 1 ELSE 0 END) AS nulls_No_plan,
  SUM(CASE WHEN [Nombre de lots] IS NULL THEN 1 ELSE 0 END) AS nulls_Nombredelots,
  SUM(CASE WHEN [Code type local] IS NULL THEN 1 ELSE 0 END) AS nulls_Codetypelocal,
  SUM(CASE WHEN [Type local] IS NULL THEN 1 ELSE 0 END) AS nulls_Typelocal,
  SUM(CASE WHEN [Surface reelle bati] IS NULL THEN 1 ELSE 0 END) AS nulls_Surfacereellebati,
  SUM(CASE WHEN [Nombre pieces principales] IS NULL THEN 1 ELSE 0 END) AS nulls_Nombrepiecesprincipales,
  SUM(CASE WHEN [Nature culture] IS NULL THEN 1 ELSE 0 END) AS nulls_Natureculture,
  SUM(CASE WHEN [Surface terrain] IS NULL THEN 1 ELSE 0 END) AS nulls_Surfaceterrain
FROM ValeursFoncieres;

--Changez le type de la colonne date mutation
ALTER TABLE ValeursFoncieres 
ALTER COLUMN [Date mutation] DATE;

--Changeons le type de valeur fonciere en type float
ALTER TABLE ValeursFoncieres 
ALTER COLUMN [Valeur fonciere] FLOAT;


--Consultation de notre jeu de données
SELECT  top 50 [Valeur fonciere]  from ValeursFoncieres;

--Ecriture des requêtes associées aux KPI

--1- Valeur fonciere en fonction du type de local
SELECT [type local], SUM (CAST(REPLACE([Valeur fonciere], ',', '.') AS FLOAT) ) AS [Valeur fonciere]
FROM ValeursFoncieres
WHERE [type local] IS NOT NULL
GROUP BY [type local];


--2- Valeur fonciere en fonction du LIEU de local (Commune)
SELECT [Commune], SUM (CAST(REPLACE([Valeur fonciere], ',', '.') AS FLOAT) ) AS [Valeur fonciere]
FROM ValeursFoncieres
WHERE [Commune] IS NOT NULL
GROUP BY [Commune]
ORDER BY [Valeur fonciere] DESC;


--3- Prix moyen en fonction du nombre de lots
SELECT
[Nombre de lots], 
AVG(CAST(REPLACE([Valeur fonciere], ',', '.') AS FLOAT)) AS [Prix Moyen]
FROM ValeursFoncieres
GROUP BY [Nombre de lots]
ORDER BY [Prix Moyen] DESC;


--4- Repartition des types de locaux par date de mutation
SELECT FORMAT([Date mutation], 'MMMM') AS MOIS, 
	SUM(CASE WHEN [type local] = 'Maison' THEN 1 ELSE 0 END) AS Maison,
	SUM(CASE WHEN [type local] = 'Appartement' THEN 1 ELSE 0 END) AS Appartement,
	SUM(CASE WHEN [type local] = 'Dépendance' THEN 1 ELSE 0 END) AS Dependance,
	SUM(CASE WHEN [type local] = 'Local industriel, commercial ou assimilé' THEN 1 ELSE 0 END) AS [Local industriel, commercial ou assimile]
FROM ValeursFoncieres
GROUP BY FORMAT([Date mutation], 'MMMM')
ORDER BY FORMAT([Date mutation], 'MMMM') DESC;


--5- PRIX MOYEN DES TYPES DE LOCAUX PAR ANNEE
SELECT YEAR([Date mutation]) AS MOYENNE_ANNEES, 
	AVG(CASE WHEN [type local] = 'Maison' THEN (CAST(REPLACE([Valeur fonciere], ',', '.') AS FLOAT)) ELSE 0 END) AS Maison,
	AVG(CASE WHEN [type local] = 'Appartement' THEN (CAST(REPLACE([Valeur fonciere], ',', '.') AS FLOAT)) ELSE 0 END) AS Appartement,
	AVG(CASE WHEN [type local] = 'Dépendance' THEN (CAST(REPLACE([Valeur fonciere], ',', '.') AS FLOAT)) ELSE 0 END) AS Dependance,
	AVG(CASE WHEN [type local] = 'Local industriel, commercial ou assimilé' THEN (CAST(REPLACE([Valeur fonciere], ',', '.') AS FLOAT)) ELSE 0 END) AS [Local industriel, commercial ou assimile]
FROM ValeursFoncieres
GROUP BY YEAR([Date mutation]);





--select DISTINCT ([Nature mutation]) from ValeursFoncieres;
--select top 10 * from ValeursFoncieres;
