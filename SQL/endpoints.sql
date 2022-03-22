USE Caso02_DB2_Esteban_David;
GO
-- Endpoint #01
-- Para listar los cantones que recibiran entregables los primero 100 dias de gobierno,
-- pero no recibiran nada los ultimos 100 dias
-- salida: Partido x Canton x cantidad de beneficios
CREATE PROCEDURE sp_endpoint01(
	@party_id INT,
	@canton_id INT,
	@first_day date,
	@last_day date
)
AS
BEGIN
	-- todo lo de la izquierda que no este en la derecha
	SELECT TOP(100) p.party_name as 'Partido', c.canton_name as 'Canton' ,COUNT(d.delivery_id) as 'Cantidad de Beneficios'
	FROM DELIVERABLES as d
	INNER JOIN CANTON as c ON d.canton_id = c.canton_id
	INNER JOIN CAMPAIGN_MANAGERS as cm ON d.action_id = cm.campain_manager_id
	INNER JOIN PARTY as p ON cm.party_id = p.party_id
	WHERE d.post_time BETWEEN @first_day AND DATEADD(day, 100, @first_day)
	AND p.party_id = ISNULL(@party_id, p.party_id)
	AND c.canton_id = ISNULL(@canton_id, c.canton_id)
	GROUP BY p.party_name, c.canton_name
	EXCEPT
	SELECT TOP(100) p.party_name as 'Partido', c.canton_name as 'Canton' ,COUNT(d.delivery_id) as 'Cantidad de Beneficios'
	FROM DELIVERABLES as d
	INNER JOIN CANTON as c ON d.canton_id = c.canton_id
	INNER JOIN CAMPAIGN_MANAGERS as cm ON d.action_id = cm.campain_manager_id
	INNER JOIN PARTY as p ON cm.party_id = p.party_id
	WHERE d.post_time BETWEEN DATEADD(day, -100, @last_day) AND @first_day
	AND p.party_id = ISNULL(@party_id, p.party_id)
	AND c.canton_id = ISNULL(@canton_id, c.canton_id)
	GROUP BY p.party_name, c.canton_name;
END
;
GO 
-- Endpoint #02
--Para una misma acción en un mismo partido, 
--sacar la densidad para todos los cantones que
--hay en los rangos de satisfacción del primer, segundo y tercer tercio
CREATE PROCEDURE sp_endpoint02
  @action_id INT,
  @party_id INT,
  @kpi_type INT
AS
  BEGIN
    SELECT party_id ,action_id, delivery_id, [0], [1],[2]
    FROM 
    (
      SELECT	CAMPAIGN_MANAGERS.party_id, DELIVERABLES.action_id, DELIVERABLES.delivery_id, qualification/34  AS Tercio, delivery_qualification_id
      FROM [Caso02_DB2_Esteban_David].[dbo].[DELIVERABLES_QUALIFICATIONS]
      INNER JOIN DELIVERABLES
      ON DELIVERABLES.delivery_id = DELIVERABLES_QUALIFICATIONS.delivery_id
      INNER JOIN ACTION_PLAN
      ON DELIVERABLES.action_id = ACTION_PLAN.action_id
      INNER JOIN PLAN_PARTY
      ON PLAN_PARTY.plan_id = DELIVERABLES.plan_id
      INNER JOIN CAMPAIGN_MANAGERS
      ON PLAN_PARTY.author_id = CAMPAIGN_MANAGERS.campain_manager_id
      WHERE DELIVERABLES.action_id = ISNULL(@action_id, DELIVERABLES.action_id)
      AND CAMPAIGN_MANAGERS.party_id = ISNULL(@party_id, CAMPAIGN_MANAGERS.party_id)
      AND DELIVERABLES.kpi_type = ISNULL(@kpi_type, DELIVERABLES.kpi_type)
    ) AS SOURCE_TABLE
    PIVOT
    (
      COUNT(delivery_qualification_id)
      FOR Tercio  IN ([0],[1],[2])
    ) AS PIVOT_TABLE;
  END 
GO
-- Endpoint #03
-- Listar por año, los 3 top meses del volumen de entregables por 
-- partido que estén relacionados a una lista de palabras proporcionadas
--- Salida: Partido, año, nombre del mes, % de entregables, position

-- full text config
CREATE FULLTEXT CATALOG AdvWksDocFTCat; 
GO
CREATE UNIQUE INDEX ui_ukDoc ON ACTION_PLAN(action_description); 
GO
DROP FULLTEXT INDEX ON ACTION_PLAN
GO
CREATE FULLTEXT INDEX ON ACTION_PLAN  
(  
    action_description                         --Full-text index column name  
)  
KEY INDEX ui_ukDoc ON AdvWksDocFTCat --Unique index  
WITH CHANGE_TRACKING AUTO 
GO

--
CREATE PROCEDURE sp_endpoint03
	@text NVARCHAR,
	@first_day DATE,
	@last_day DATE
AS
BEGIN
	with textFilter AS (
	SELECT DELIVERABLES.delivery_id,
		DELIVERABLES.post_time,
		CAMPAIGN_MANAGERS.party_id,
		ACTION_PLAN.action_description
	FROM DELIVERABLES
	INNER JOIN ACTION_PLAN
	ON ACTION_PLAN.action_id = DELIVERABLES.action_id
	INNER JOIN CAMPAIGN_MANAGERS
	ON CAMPAIGN_MANAGERS.campain_manager_id = DELIVERABLES.author_id
	WHERE CONTAINS(action_description, @text)
	AND	DELIVERABLES.post_time BETWEEN @first_day AND @last_day
	)
	SELECT party_id As Party, Total , Año, Mes, Ranking
	FROM (
	SELECT 
		party_id,
		COUNT(delivery_id)  AS Total,
		YEAR(post_time) AS Año,
		DATENAME(MONTH, post_time) AS Mes,
		DENSE_RANK() OVER (PARTITION BY party_id ORDER BY COUNT(delivery_id) DESC) AS Ranking
	FROM textFilter
	GROUP BY party_id, YEAR(post_time), DATENAME(MONTH, post_time)
	) AS CountTable
	WHERE Ranking < 4
END
GO

--** Endpoint #04
-- Ranking por partido con mayores niveles de satisfacción en su plan en forma global pero 
-- cuya acción tenga el mismo comportamiento para todos los cantones donde habrá un 
-- entregable. Se consideran aceptables al top 30% de las calificaciones de satisfacción.
-- Salida: Partido, % aceptación, posición, nota máxima obtenida
/*
SELECT p.party_id AS 'Partido: ', c.canton_id as 'Canton: ', 
		COUNT( dq.qualification ) * 100 / @total_qualifications_satis as '% Satisfaccion:',
		MAX( dq.qualification ) as 'Nota Maxima:',
		DENSE_RANK () OVER (PARTITION BY p.party_id 
			ORDER BY COUNT( p.party_id ) DESC ) as 'Ranking: '
	FROM DELIVERABLES_QUALIFICATIONS as dq
	INNER JOIN DELIVERABLES as d ON dq.delivery_id = d.delivery_id
	INNER JOIN CANTON as c ON dq.canton_id = c.canton_id
	INNER JOIN CAMPAIGN_MANAGERS as cm ON d.author_id = cm.campain_manager_id
	INNER JOIN PARTY as p ON cm.party_id = p.party_id
	WHERE dq.qualification >= 60
	AND dq.post_time BETWEEN @first_day AND @last_day
	GROUP BY p.party_id, c.canton_id
	ORDER BY p.party_id, c.canton_id
*/
ALTER PROCEDURE sp_endpoint04(
	@first_day date,
	@last_day date
)
AS
BEGIN
	DECLARE @total_qualifications_satis INT;

	SELECT @total_qualifications_satis = COUNT( dq.qualification )
	FROM DELIVERABLES_QUALIFICATIONS as dq
	WHERE dq.post_time BETWEEN @first_day AND @last_day;

	SELECT tab.id_party AS 'Partido: ', SUM(tab.satisfacion) as '% Satisfaccion:',
		MAX(tab.notamax) * 0.1 as 'Nota maxima:', RANK() OVER (ORDER BY tab.id_party DESC) AS 'Ranking :'
	FROM (
		SELECT p.party_id AS id_party, c.canton_id as id_canton, 
			COUNT( dq.qualification ) * 100 / @total_qualifications_satis as satisfacion,
			MAX( dq.qualification ) as notamax
		FROM DELIVERABLES_QUALIFICATIONS as dq
		INNER JOIN DELIVERABLES as d ON dq.delivery_id = d.delivery_id
		INNER JOIN CANTON as c ON dq.canton_id = c.canton_id
		INNER JOIN CAMPAIGN_MANAGERS as cm ON d.author_id = cm.campain_manager_id
		INNER JOIN PARTY as p ON cm.party_id = p.party_id
		WHERE dq.qualification >= 60
		AND dq.post_time BETWEEN @first_day AND @last_day
		GROUP BY p.party_id, c.canton_id
		EXCEPT
		SELECT p.party_id AS id_party, c.canton_id as id_canton, 
			COUNT( dq.qualification ) * 100 / @total_qualifications_satis as satisfacion,
			MAX( dq.qualification ) as notamax
		FROM DELIVERABLES_QUALIFICATIONS as dq
		INNER JOIN DELIVERABLES as d ON dq.delivery_id = d.delivery_id
		INNER JOIN CANTON as c ON dq.canton_id = c.canton_id
		INNER JOIN CAMPAIGN_MANAGERS as cm ON d.author_id = cm.campain_manager_id
		INNER JOIN PARTY as p ON cm.party_id = p.party_id
		WHERE dq.qualification < 60
		AND dq.post_time BETWEEN @first_day AND @last_day
		GROUP BY p.party_id, c.canton_id
		/*calificaciones x canton >= 60 que no tenga evaluaciones menores a 60 en el mismo canton*/
	) as tab
	GROUP BY tab.id_party
	ORDER BY '% Satisfaccion:' DESC;
END
;
GO
Exec sp_endpoint04 '2022-03-12', '2022-03-15';

-- Endpoint #05
-- Reporte de niveles de satisfacción por partido por cantón ordenados por mayor calificación a
-- menor y por partido. Finalmente agregando un sumarizado por partisdo de los mismos porcentajes. 
-- Salida: Partido, cantón, % insatisfechos, % medianamente satisfechos, % de muy satisfechos, sumarizado
GO
CREATE PROCEDURE sp_endpoint05(
	@party_id INT,
	@first_day date,
	@last_day date
)
AS
BEGIN
	DECLARE @total_qualifications INT;

	SELECT @total_qualifications = COUNT( dq.qualification )
	FROM DELIVERABLES_QUALIFICATIONS as dq
	WHERE dq.post_time BETWEEN @first_day AND @last_day;

	SELECT ISNULL(p.party_name, '> SUM ---') as 'Partido: ', ISNULL(c.canton_name, '> SUM ---') as 'Canton: ',
		COUNT( CASE WHEN dq.qualification <= 33 THEN 1 END) * 100 / @total_qualifications as '% Insatisfecho: ',
		COUNT( CASE WHEN dq.qualification >= 34 AND dq.qualification <= 66 THEN 1 END) * 100 / @total_qualifications  as '% Medianamente Satisfecho: ',
		COUNT( CASE WHEN dq.qualification >= 67 THEN 1 END) * 100 / @total_qualifications as '% Satisfecho: '
	FROM DELIVERABLES_QUALIFICATIONS as dq
	INNER JOIN DELIVERABLES as d ON dq.delivery_id = d.delivery_id
	INNER JOIN CANTON as c ON dq.canton_id = c.canton_id
	INNER JOIN CAMPAIGN_MANAGERS as cm ON d.author_id = cm.campain_manager_id
	INNER JOIN PARTY as p ON cm.party_id = p.party_id
	WHERE p.party_id = ISNULL(@party_id, p.party_id)
	AND dq.post_time BETWEEN @first_day AND @last_day
	GROUP BY ROLLUP(p.party_name, c.canton_name)
END
;
GO

Exec sp_endpoint05 null, '2022-03-12', '2022-03-15';
GO
-- Endpont #06
-- Dada un usuario ciudadano y un plan de un partido, recibir una lista de entregables para su 
-- cantón y las respectivas calificaciones de satisfacción para ser guardadas en forma transaccional. 
-- Salida: 200 OK

-- Crea un User Defined Table Type
CREATE TYPE DELIVERABLES_TVP AS TABLE(delivery_id INT,  qualification TINYINT)
GO

CREATE TABLE PERSON_X_DELIVERABLES(
	person_id INT NOT NULL,
	delivery_id INT NOT NULL,
	qualification TINYINT NOT NULL CHECK(qualification <= 100),
	post_time DATETIME DEFAULT GETDATE()
)
GO

CREATE PROCEDURE sp_save_trans 
	@person_id int , 
	@action_id int, 
	@TVP DELIVERABLES_TVP READONLY
AS
  SET NOCOUNT ON SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRY

		BEGIN TRANSACTION SAVE_QUALIFICATIONS
			INSERT INTO PERSON_X_DELIVERABLES(person_id, delivery_id, qualification)
      SELECT @person_id, T.delivery_id,T.qualification
      FROM @TVP AS T
			INNER JOIN DELIVERABLES
			ON T.delivery_id = DELIVERABLES.delivery_id 
			AND DELIVERABLES.action_id = @action_id
    COMMIT TRANSACTION SAVE_QUALIFICATIONS

    SELECT '200 OK';

  END TRY
  BEGIN CATCH

    SELECT
    ERROR_NUMBER()    AS  NumeroError,
    ERROR_STATE()     AS  EstadoError,
    ERROR_SEVERITY()  AS  SeveridadError,
    ERROR_PROCEDURE() AS  ErrorDeProcedimiento,
    ERROR_LINE()      AS  LineaError,
    ERROR_MESSAGE()   AS  MensajeError
    -- Non committable transaction.
    IF (XACT_STATE()) = -1
      ROLLBACK TRANSACTION SAVE_QUALIFICATIONS
    -- Committable transaction.
    IF (XACT_STATE()) = 1
    	COMMIT TRANSACTION SAVE_QUALIFICATIONS
		
  END CATCH
GO

CREATE PROCEDURE sp_endpoint06
	@canton_id INT,
	@person_id INT,
	@action_id INT,
	@qualification TINYINT
AS
BEGIN
	-- declaro una variable con el tipo de tabla entregable
	DECLARE @deliverablesTVP AS DELIVERABLES_TVP;
	-- relleno la tabla
	INSERT INTO @deliverablesTVP (delivery_id, qualification) 
		SELECT D.delivery_id, @qualification
		FROM DELIVERABLES AS D
		WHERE D.canton_id = @canton_id
	-- guardo de manera transaccional 
	EXEC sp_save_trans @person_id, @action_id, @deliverablesTVP
END
GO

DECLARE @deliverablesTVP AS DELIVERABLES_TVP;
	-- relleno la tabla
	INSERT INTO @deliverablesTVP (delivery_id, qualification) 
		SELECT D.delivery_id, 50
		FROM DELIVERABLES AS D
		WHERE D.canton_id = 1
select * from @deliverablesTVP