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

--** Endpoint #04
-- Ranking por partido con mayores niveles de satisfacción en su plan en forma global pero 
-- cuya acción tenga el mismo comportamiento para todos los cantones donde habrá un 
-- entregable. Se consideran aceptables al top 30% de las calificaciones de satisfacción.
-- Salida: Partido, % aceptación, posición, nota máxima obtenida
ALTER PROCEDURE sp_endpoint04(
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

	/* ranking por partido por nivel de satisfaccion*/
	SELECT TOP(30) p.party_name as 'Partido: ',
		COUNT( CASE WHEN dq.qualification > 66 THEN 1 END) * 100 / @total_qualifications as '% Satisfecho: ',
		COUNT( d.kpi_type ) as 'cantidad de tipos de acciones: ',
		/* MAX ( dq.qualification ) / 10 as 'Nota Maxima: ', por ahora no porque las mescla */
		RANK () OVER ( ORDER BY p.party_name DESC ) AS 'Ranking No: '
	FROM DELIVERABLES_QUALIFICATIONS as dq
	INNER JOIN DELIVERABLES as d ON dq.delivery_id = d.delivery_id
	INNER JOIN CANTON as c ON dq.canton_id = c.canton_id
	INNER JOIN CAMPAIGN_MANAGERS as cm ON d.author_id = cm.campain_manager_id
	INNER JOIN PARTY as p ON cm.party_id = p.party_id
	WHERE p.party_id = ISNULL(@party_id, p.party_id)
	AND dq.post_time BETWEEN @first_day AND @last_day
	GROUP BY p.party_name, d.kpi_type 
	INTERSECT
	SELECT TOP(30) p.party_name as 'Partido: ', /* acciones con el mismo comportamiento en todos los cantones donde habran entregables */
		COUNT( CASE WHEN dq.qualification > 66 THEN 1 END) * 100 / @total_qualifications as '% Satisfecho: ',
		COUNT( d.kpi_type ) as 'cantidad de tipos de acciones: ',
		RANK () OVER ( ORDER BY p.party_name DESC ) AS 'Ranking No: '
	FROM DELIVERABLES_QUALIFICATIONS as dq
	INNER JOIN DELIVERABLES as d ON dq.delivery_id = d.delivery_id
	INNER JOIN CANTON as c ON dq.canton_id = c.canton_id
	INNER JOIN CAMPAIGN_MANAGERS as cm ON d.author_id = cm.campain_manager_id
	INNER JOIN PARTY as p ON cm.party_id = p.party_id
	WHERE p.party_id = ISNULL(@party_id, p.party_id)
	AND dq.post_time BETWEEN @first_day AND @last_day
	AND c.canton_id IS NOT NULL
	GROUP BY p.party_name, d.kpi_type 

	/*usar INTERSECT para tener los datos iguales en ambos select*/
END
;
GO
Exec sp_endpoint04 null, '2022-03-12', '2022-03-15';

-- Endpoint #05
-- Reporte de niveles de satisfacción por partido por cantón ordenados por mayor calificación a
-- menor y por partido. Finalmente agregando un sumarizado por partido de los mismos porcentajes. 
-- Salida: Partido, cantón, % insatisfechos, % medianamente satisfechos, % de muy satisfechos, sumarizado

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

-- Endpont #06
-- Dada un usuario ciudadano y un plan de un partido, recibir una lista de entregables para su 
-- cantón y las respectivas calificaciones de satisfacción para ser guardadas en forma transaccional. 
-- Salida: 200 OK
