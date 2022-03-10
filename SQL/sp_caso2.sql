
-- Procedimientos para registrar a un usuario
-- sp secundario para asignar el tipo de usuario
CREATE PROCEDURE sp_assign_user_type (
	@name_person NVARCHAR(250),
	@last_name_person NVARCHAR(250),
	@user_type_name NVARCHAR(100)
)
AS
BEGIN
	DECLARE @id_person int;
	DECLARE @id_type_user int;

	SELECT @id_type_user = ut.user_type_id 
		FROM USER_TYPE as ut
		WHERE ut.user_type_name = @user_type_name;
	SELECT @id_person = p.person_id
		FROM PERSON as p
		WHERE p.person_name = @name_person
		AND p.lastname = @last_name_person;

	INSERT INTO USER_X_TYPE (person_id, user_type_id) VALUES (@id_person, @id_type_user);
END
;
GO
-- sp secundario para asignar el telefono
CREATE PROCEDURE sp_assign_phone(
	@name_person NVARCHAR(250),
	@last_name_person NVARCHAR(250),
	@phone_person int
)
AS
BEGIN
	DECLARE @id_person int;

	SELECT @id_person = p.person_id
		FROM PERSON as p
		WHERE p.person_name = @name_person
		AND p.lastname = @last_name_person;

	INSERT INTO PHONE(phone, person_id) VALUES (@phone_person, @id_person);
END
;
GO
-- sp secundario para asignar el gmail
CREATE PROCEDURE sp_assign_email(
	@name_person NVARCHAR(250),
	@last_name_person NVARCHAR(250),
	@email_person NVARCHAR(250)
)
AS
BEGIN
	DECLARE @id_person int;

	SELECT @id_person = p.person_id
		FROM PERSON as p
		WHERE p.person_name = @name_person
		AND p.lastname = @last_name_person;

	INSERT INTO EMAIL(email, person_id) VALUES (@email_person, @id_person);
END
;
GO
-- sp para insertar a la persona
-- usara: nombvre, apellido, fecha nacimineto, id
-- los que pueden ser null: canton (aleatorio), tipo, 1 telefono, 1 gmail
CREATE PROCEDURE sp_create_person(
	@name_person NVARCHAR(250),
	@last_name_person NVARCHAR(250),
	@birthdate_person date,
	@id_person int,
	@canton_person NVARCHAR(250),
	@email_person NVARCHAR(250),
	@phone_person int,
	@user_type_name NVARCHAR(100)
)
AS
BEGIN
	-- primero creamos a la persona nueva
	DECLARE @register_date datetime;
	DECLARE @id_canton_person int;
	DECLARE @id_new_person int;
	SET @register_date = CAST(GETDATE() as smalldatetime);

	SELECT @id_canton_person = canton_id
		FROM CANTON as c
		WHERE c.canton_name = @canton_person;

	-- creo a la nueva persona
	INSERT INTO PERSON (person_name, lastname, birthdate, id, creation_date)
		VALUES (@name_person, @last_name_person, @birthdate_person, @id_person,  @register_date);
	
	-- le asigno el canton
	SELECT @id_new_person = p.person_id
		FROM PERSON as p
		WHERE p.person_name = @name_person
		AND p.lastname = @last_name_person;

	INSERT INTO CANTONES_X_USERS (canton_id, person_id) VALUES (@id_canton_person, @id_new_person);

	-- si llego un correo
	IF @email_person IS NOT NULL
		EXEC sp_assign_email @name_person, @last_name_person, @email_person;
	-- si llego un telefono
	IF @phone_person IS NOT NULL
		EXEC sp_assign_phone @name_person, @last_name_person, @phone_person;
	-- si llego un tipo de usuario
	IF @user_type_name IS NOT NULL
		EXEC sp_assign_user_type @name_person, @last_name_person, @user_type_name;
END
;
GO

--SP insert deliverables

CREATE PROCEDURE sp_insert_delivery
	@action_id INT,
	@plan_id INT, 
	@canton_id INT,
	@kpi_value INT,
	@kpi_type INT,
	@post_time DATE,
	@author_id INT,
	@computer VARCHAR(34)
AS
BEGIN
	INSERT INTO DELIVERABLES 
	(action_id, plan_id, canton_id, kpi_value, kpi_type, post_time, author_id, computer, checksum)
	VALUES (@action_id, @plan_id, @canton_id, @kpi_value, @kpi_type, @post_time, @author_id, @computer, HASHBYTES('SHA2_512', CONCAT(@action_id,@kpi_type,'arajo',@action_id,@computer)))
END
GO

CREATE PROCEDURE sp_insert_deliverables_qualifications
	@canton_id INT,
	@delivery_id INT,
	@person_id INT,
	@qualification TINYINT,
	@computer_name varchar(34)
AS
BEGIN
	INSERT INTO DELIVERABLES_QUALIFICATIONS 
	(canton_id, delivery_id, person_id, qualification, checksum, computer)
	VALUES (@canton_id, @delivery_id, @person_id, @qualification, HASHBYTES('SHA2_512', CONCAT(@canton_id,@canton_id,'arajo',@person_id,@qualification)), @computer_name)
END 
GO

-- SERVERPROPERTY('MachineName')

-- sp para asignar al manager de campa�a
CREATE PROCEDURE sp_create_maganer(
	@name_person NVARCHAR(250),
	@last_name_person NVARCHAR(250),
	@the_party_name NVARCHAR(250),
	@new_bio VARCHAR(1000),
	@new_photo_url VARCHAR(150)
)
AS
BEGIN
	DECLARE @check VARBINARY(150);
	DECLARE @id_person int;
	DECLARE @id_party int;

	SET @check = HASHBYTES('SHA2_512', CONCAT(@name_person, @last_name_person, @the_party_name, @new_photo_url));

	SELECT @id_person = p.person_id
		FROM PERSON as p
		WHERE p.person_name = @name_person
		AND p.lastname = @last_name_person;
	SELECT @id_party = pa.party_id
		FROM PARTY as pa
		WHERE pa.party_name = @the_party_name;

	INSERT INTO CAMPAIGN_MANAGERS (person_id, party_id, checksum, user_bio, photo_url)
		VALUES (@id_person, @id_party, @check, @new_bio, @new_photo_url);

	INSERT INTO USER_X_GROUP (person_id, party_id) VALUES (@id_person, @id_party);

	INSERT INTO USER_X_TYPE (person_id, user_type_id) VALUES (@id_person, 1);
END
;
GO

CREATE PROCEDURE sp_update_manager(
	@name_person NVARCHAR(250),
	@last_name_person NVARCHAR(250),
	@new_bio VARCHAR(1000),
	@new_photo_url VARCHAR(150),
	@the_party_name NVARCHAR(250)
)
AS
BEGIN
	DECLARE @check VARBINARY(150);
	DECLARE @id_person int;
	DECLARE @id_party int;

	SET @check = HASHBYTES('SHA2_512', CONCAT(@name_person, @last_name_person, @the_party_name, @new_photo_url));

	SELECT @id_person = p.person_id
		FROM PERSON as p
		WHERE p.person_name = @name_person
		AND p.lastname = @last_name_person;
	SELECT @id_party = pa.party_id
		FROM PARTY as pa
		WHERE pa.party_name = @the_party_name;

	UPDATE CAMPAIGN_MANAGERS
	SET person_id = @id_person, user_bio = @new_bio, photo_url = @new_photo_url, checksum = @check, lastUpdate = GETDATE()
	WHERE party_id = @id_party;

	INSERT INTO USER_X_GROUP (person_id, party_id) VALUES (@id_person, @id_party);
END
;
GO

CREATE PROCEDURE sp_create_party_plan(
	@new_title NVARCHAR(200),
	@name_author NVARCHAR(250),
	@last_name_author NVARCHAR(250)
)
AS
BEGIN
	DECLARE @check VARBINARY(150);
	DECLARE @id_manager int;

	SET @check = HASHBYTES('SHA2_512', CONCAT(@new_title, @name_author, @last_name_author));

	SELECT @id_manager = cm.campain_manager_id
		FROM PERSON as p
		INNER JOIN CAMPAIGN_MANAGERS as cm ON p.person_id = cm.person_id
		WHERE p.person_name = @name_author
		AND p.lastname = @last_name_author;

	INSERT INTO PLAN_PARTY(title, author_id, checksum) VALUES(@new_title, @id_manager, @check);
END
;
GO
CREATE PROCEDURE sp_create_action_plan(
	@title_plan NVARCHAR(200),
	@title_action NVARCHAR(100),
	@action_descr NVARCHAR(720)
)
AS
BEGIN
	DECLARE @check VARBINARY(150);
	DECLARE @id_plan int;

	SET @check = HASHBYTES('SHA2_512', CONCAT(@title_plan, @title_action, @action_descr));

	SELECT @id_plan = pp.plan_id
		FROM PLAN_PARTY as pp
		WHERE pp.title = @title_plan;

	INSERT INTO ACTION_PLAN(plan_id, action_title, action_description, checksum) VALUES(@id_plan, @title_action, @action_descr, @check);
END
;
GO
CREATE PROCEDURE sp_create_deliverable(
	@title_action NVARCHAR(100),
	@name_author NVARCHAR(250),
	@last_name_author NVARCHAR(250),
	@canton_name NVARCHAR(250),
	@new_kpi_value INT,
	@new_kpi_type INT,
	@new_post_time DATE
)
AS
BEGIN
	DECLARE @id_action int;
	DECLARE @id_plan int;
	DECLARE @id_canton_deliv int;
	DECLARE @id_person int;
	DECLARE @check VARBINARY(150);
	DECLARE @computer_name VARCHAR(34);

	SET @check = HASHBYTES('SHA2_512', CONCAT(@title_action,@name_author, @last_name_author, @canton_name, @new_kpi_value));
	SET @computer_name = CONVERT(varchar(34), SERVERPROPERTY('MachineName'));

	SELECT @id_person = cm.campain_manager_id
		FROM PERSON as p
		INNER JOIN CAMPAIGN_MANAGERS as cm ON p.person_id = cm.campain_manager_id
		WHERE p.person_name = @name_author
		AND p.lastname = @last_name_author;

	SELECT @id_action = ap.action_id, @id_plan = ap.plan_id
		FROM ACTION_PLAN as ap
		INNER JOIN PLAN_PARTY as pp ON pp.plan_id = ap.plan_id
		INNER JOIN CAMPAIGN_MANAGERS as cm ON cm.campain_manager_id = pp.author_id
		INNER JOIN PERSON as p ON p.person_id = cm.person_id
		WHERE ap.action_title = @title_action
		AND cm.campain_manager_id = @id_person;

	SELECT @id_canton_deliv = canton_id
		FROM CANTON as c
		WHERE c.canton_name = @canton_name;

	INSERT INTO DELIVERABLES(action_id, plan_id, canton_id, kpi_value, kpi_type, post_time, author_id, computer, checksum)
		VALUES (@id_action, @id_plan, @id_canton_deliv, @new_kpi_value, @new_kpi_type,@new_post_time, @id_person, @computer_name , @check );

END
;
GO
CREATE PROCEDURE sp_qualify_deliverable(
	@name_author NVARCHAR(250),
	@last_name_author NVARCHAR(250),
	@id_delivery int,
	@canton_name NVARCHAR(250),
	@the_qualification TINYINT = 1
)
AS
BEGIN
	DECLARE @id_canton_deliv int;
	DECLARE @id_person int;
	DECLARE @check VARBINARY(150);
	DECLARE @computer_name VARCHAR(34);

	SET @check = HASHBYTES('SHA2_512', CONCAT(@name_author, @last_name_author, @canton_name,@the_qualification, @id_delivery ));

	SET @computer_name = CONVERT(varchar(34), SERVERPROPERTY('MachineName'));

	SELECT @id_canton_deliv = canton_id
		FROM CANTON as c
		WHERE c.canton_name = @canton_name;

	SELECT @id_person = p.person_id
		FROM PERSON as p
		WHERE p.person_name = @name_author
		AND p.lastname = @last_name_author;

	INSERT INTO DELIVERABLES_QUALIFICATIONS(canton_id, delivery_id, person_id, qualification, checksum, computer)
		VALUES(@id_canton_deliv, @id_delivery, @id_person, @the_qualification, @check, @computer_name );
END;
GO