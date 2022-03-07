
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

--SP insert deliverates 

CREATE PROCEDURE sp_insert_deliverable
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
END
;
GO