
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

-- sp para insertar a la persona
-- usara: nombvre, apellido, fecha nacimineto, id
-- los que pueden ser null: canton (aleatorio), tipo, 1 telefono, 1 gmail