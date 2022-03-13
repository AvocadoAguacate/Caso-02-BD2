USE Caso02_DB2_Esteban_David;
GO
-- Endpoint #01
-- Para listar los cantones que recibiran entregables los primero 100 dias de gobierno,
-- pero no recibiran nada los ultimos 100 dias
-- salida: Partido x Canton x cantidad de beneficios
CREATE PROCEDURE sp_endpoint01(
	@party_id INT,
	@canton_id INT
)
AS
BEGIN
	DECLARE @first_day date;
	DECLARE @last_day date;

	SELECT @first_day = MIN(post_time) FROM DELIVERABLES;
	SELECT @last_day = MAX(post_time) FROM DELIVERABLES;

	-- todo lo de la izquierda que no este en la derecha
	SELECT p.party_name as 'Partido', c.canton_name as 'Canton' ,COUNT(d.delivery_id) as 'Cantidad de Beneficios'
	FROM DELIVERABLES as d
	INNER JOIN CANTON as c ON d.canton_id = c.canton_id
	INNER JOIN CAMPAIGN_MANAGERS as cm ON d.action_id = cm.campain_manager_id
	INNER JOIN PARTY as p ON cm.party_id = p.party_id
	WHERE d.post_time BETWEEN @first_day AND DATEADD(day, 100, @first_day)
	AND p.party_id = ISNULL(@party_id, p.party_id)
	AND c.canton_id = ISNULL(@canton_id, c.canton_id)
	GROUP BY p.party_name, c.canton_name
	EXCEPT
	SELECT p.party_name as 'Partido', c.canton_name as 'Canton' ,COUNT(d.delivery_id) as 'Cantidad de Beneficios'
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