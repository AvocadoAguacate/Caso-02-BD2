USE Caso02_DB2_Esteban_David;
GO
-- Endpoint #01
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