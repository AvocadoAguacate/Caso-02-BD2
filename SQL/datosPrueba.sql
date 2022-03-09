﻿-- datos de prueba

INSERT INTO PROVINCE (province_name) VALUES ('Cartago'),('Heredia'),('San Jose'),('Limon'),('Alajuela'),('Puntarenas'),('Guanacaste')
INSERT INTO CANTON (canton_name, province_id) VALUES ('Marjayoûn', 7),('Jingkou', 3),('Fāqūs', 1),('Shiliting', 4),('La Unión', 2),('Rumilly', 7),('Auki', 4),('Vimmerby', 1),('Chernyanka', 4),('Yedogon', 6),('Nejo', 4),('Almirante', 5),('Mulanje', 6),('Liulin', 4),('Asopía', 4),('Armenia', 5),('Xidoupu', 5),('Novoye Devyatkino', 6),('Ha', 5),('Biguaçu', 5),('Scholkine', 7),('Sel’tso', 7),('Kishi', 6),('Lisala', 4),('São Pedro da Aldeia', 5),('Lamía', 6),('Cerenti', 1),('El Galpón', 4),('Shizikeng', 4),('Surin', 1),('Navais', 2),('Delgado', 4),('Gus’-Zheleznyy', 1),('Marondera', 5),('Saguday', 2),('Melun', 1),('Baiqi', 6),('Marmande', 3),('Pumai', 3),('Bayang', 2),('Cojutepeque', 2),('Xiejiatan', 1),('Guane', 2),('Lingqiao', 4),('Jabinyānah', 1),('Nakhchivan', 4),('Viçosa do Ceará', 2),('Emmaboda', 1),('Rizómata', 5),('San Diego', 7),('Barnaul', 2),('Īlām', 5),('Safonovo', 6),('Pokrovka', 5),('Osoyoos', 5),('Buçimas', 2),('Vanves', 5),('Padamulya', 4),('Qinghua', 4),('Quimbaya', 7),('Daxing', 7),('Kortesjärvi', 7),('Rizokárpaso', 4),('Dundee', 6),('Hema', 1),('Atuntaqui', 7),('Milltown', 4),('Nishinomiya-hama', 6),('Strömsund', 5),('Rtishchevo', 3),('Selorejo', 3),('Monastir', 6),('Nanjing', 2),('Yarmolyntsi', 6),('Chulakivka', 3),('Kopparberg', 4),('Vitarte', 7),('Zürich', 2),('Drawsko', 1),('Jiuxian', 7),('Shanghu', 6),('Baiqi', 7),('Venustiano Carranza', 5),('Yelwa', 5),('Bāgh-e Maīdān', 7),('Wangzha', 3),('Dawangzhuang', 3),('Passo Fundo', 4),('Tianzhu', 7),('San Jose', 4),('Shymkent', 5),('San Andres', 1),('Jeffersonville', 2),('Aldeia de Juzo', 4),('Angers', 1),('Embarcación', 1),('Energeticheskiy', 6),('Paris La Défense', 6),('Novi Vinodolski', 6),('Sumberejo', 5)
INSERT INTO USER_TYPE (user_type_name) VALUES ('Admin de Campaña'), ('Ciudadano')
INSERT INTO KPI_TYPE (kpi_name) VALUES ('eu'), ('nulla'), ('odio'), ('rhoncus'), ('cras'), ('eget'), ('eutsata'), ('purus'), ('nunc'), ('luctus'), ('ipsum'), ('suspendisse'), ('molestie'), ('nulltsartara'), ('pede'), ('tellus'), ('vestibulum'), ('habitasse'), ('mi'), ('orci')
INSERT INTO PARTY (party_name, flag, creation_date, foundation) VALUES ('Russel, Rippin and Schmidt', 'http://dummyimage.com/178x100.png/cc0000/ffffff', '10/13/1995', '7/7/2019'), ('Mitchell, Heller and Kirlin', 'http://dummyimage.com/195x100.png/cc0000/ffffff', '6/30/2014', '12/7/2002'), ('Stoltenberg-Crooks', 'http://dummyimage.com/249x100.png/cc0000/ffffff', '6/2/2013', '6/20/1998'), ('Huel-Leannon', 'http://dummyimage.com/153x100.png/ff4444/ffffff', '9/15/2010', '2/22/2017'), ('Kulas-Sanford', 'http://dummyimage.com/204x100.png/cc0000/ffffff', '6/21/2001', '5/16/2006')

EXEC sp_create_person 'Daniel', 'Soto Valverde', '1/16/2014', 123456790, 'Fāqūs', 'danielsoto@gmail.com', 25500001, 'Ciudadano';
EXEC sp_create_person 'Jill', 'Webb', '1/17/2014', 123456791, 'Fāqūs', 'jill@gmail.com', 25500002, 'Ciudadano';
EXEC sp_create_person 'Jessica', 'Armstrong', '1/18/2014', 123456792, 'Fāqūs', 'jessica@gmail.com', 25500003, 'Ciudadano';
EXEC sp_create_person 'Henry', 'Villa', '1/19/2015', 123456793, 'Fāqūs', 'henry@gmail.com', 25500004, 'Ciudadano';
EXEC sp_create_person 'Jeffrey', 'Campbell', '1/20/2004', 123456794, 'Fāqūs', 'jeffrey@gmail.com', 25500005, 'Ciudadano';
EXEC sp_create_person 'Stephanie', 'Lewis', '2/1/2004', 123456795, 'Fāqūs', 'stephanie@gmail.com', 25500006, 'Ciudadano';
EXEC sp_create_person 'Teresa', 'Ray', '2/2/2014', 123456796, 'Fāqūs', 'teresa@gmail.com', 25500007, 'Ciudadano';
EXEC sp_create_person 'Shannon', 'Bean', '2/3/2014', 123456797, 'Fāqūs', 'shannon@gmail.com', 25500008, 'Ciudadano';
EXEC sp_create_person 'Rachel', 'Yates', '2/4/2004', 123456798, 'Fāqūs', 'rachel@gmail.com', 25500009, 'Ciudadano';
EXEC sp_create_person 'Kevin', 'Lewis', '2/5/2014', 123456799, 'Fāqūs', 'kevin@gmail.com', 25500010, 'Ciudadano';
EXEC sp_create_person 'Kenneth', 'Chandler', '1/16/2010', 123456801, 'Fāqūs', 'kenneth@gmail.com', 25500011, 'Ciudadano';
EXEC sp_create_person 'Bryan', 'Moreno', '1/17/2014', 123456802, 'Fāqūs', 'bryan@gmail.com', 25500012, 'Ciudadano';
EXEC sp_create_person 'Kelly', 'Zhang', '1/18/2003', 123456800, 'Fāqūs', 'kelly@gmail.com', 25500013, 'Ciudadano';
EXEC sp_create_person 'Shane', 'Gardner', '1/19/2015', 123456803, 'Fāqūs', 'shane@gmail.com', 25500014, 'Ciudadano';
EXEC sp_create_person 'Matthew', 'Harris', '1/20/2014', 123456804, 'Fāqūs', 'matthew@gmail.com', 25500016, 'Ciudadano';
EXEC sp_create_person 'Janice', 'Moore', '1/16/2010', 123456805, 'Fāqūs', 'janice@gmail.com', 25500017, 'Ciudadano';
 
EXEC sp_create_maganer 'Jessica', 'Armstrong', 'Russel, Rippin and Schmidt','bioExample***','http://dummyimage.com/178x100.png/cc0000/ffffff';
EXEC sp_create_maganer 'Rachel', 'Yates', 'Kulas-Sanford','bioExample***','http://dummyimage.com/178x100.png/cc0000/ffffff';
EXEC sp_create_maganer 'Kelly', 'Zhang', 'Stoltenberg-Crooks','bioExample***','http://dummyimage.com/178x100.png/cc0000/ffffff';
EXEC sp_create_maganer 'Teresa', 'Ray', 'Mitchell, Heller and Kirlin','bioExample***','http://dummyimage.com/178x100.png/cc0000/ffffff';

EXEC sp_create_party_plan 'Gran Plan del futuro 20XX', 'Jessica', 'Armstrong';
EXEC sp_create_party_plan 'Nuevo Plan del mañana 20XX', 'Rachel', 'Yates';
EXEC sp_create_party_plan 'Plan por el futuro 20XX', 'Kelly', 'Zhang';
EXEC sp_create_party_plan 'La Gran Roforma 20XX', 'Teresa', 'Ray';

