-- datos de prueba

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

EXEC sp_create_action_plan 'Gran Plan del futuro 20XX', 'Action Plan 01', 'Esta calle tiene como objetivo general';
EXEC sp_create_action_plan 'Nuevo Plan del mañana 20XX', 'Action Plan 02', 'Esta accion valle ';
EXEC sp_create_action_plan 'Plan por el futuro 20XX', 'Action Plan 03', 'Esta tiene como objetivo general';
EXEC sp_create_action_plan 'La Gran Roforma 20XX', 'Action Plan 04', 'valle accion tiene como objetivo general';


EXEC sp_insert_delivery 1, 1, 20, 472, 7, '5/11/2021', 3, 'Mynah, indian';
EXEC sp_insert_delivery 3, 4, 22, 744, 13, '1/30/2026', 4, 'Macaw, blue and gold';
EXEC sp_insert_delivery 3, 4, 15, 985, 13, '7/6/2021', 3, 'Deer, swamp';
EXEC sp_insert_delivery 1, 1, 27, 664, 8, '10/27/2024', 1, 'Fox, cape';
EXEC sp_insert_delivery 2, 1, 42, 122, 15, '6/7/2025', 4, 'White-browed owl';
EXEC sp_insert_delivery 4, 4, 25, 125, 1, '5/13/2025', 2, 'Egyptian viper';
EXEC sp_insert_delivery 4, 3, 33, 644, 5, '10/1/2023', 3, 'Tortoise, indian star';
EXEC sp_insert_delivery 1, 1, 7, 242, 12, '7/16/2024', 3, 'Tortoise, asian foreset';
EXEC sp_insert_delivery 1, 4, 13, 67, 18, '12/24/2025', 4, 'Dove, ring';
EXEC sp_insert_delivery 1, 4, 14, 526, 14, '3/7/2026', 2, 'Cape clawless otter';
EXEC sp_insert_delivery 3, 1, 9, 64, 11, '5/4/2025', 4, 'Yellow-necked spurfowl';
EXEC sp_insert_delivery 3, 4, 7, 20, 4, '12/27/2021', 2, 'Civet, small-toothed palm';
EXEC sp_insert_delivery 4, 4, 11, 837, 5, '1/22/2024', 1, 'Baboon, gelada';
EXEC sp_insert_delivery 3, 1, 44, 487, 13, '7/19/2025', 2, 'Grey lourie';
EXEC sp_insert_delivery 1, 3, 47, 768, 4, '6/21/2025', 4, 'Coot, red-knobbed';
EXEC sp_insert_delivery 1, 3, 26, 981, 1, '5/27/2025', 2, 'Palm squirrel';
EXEC sp_insert_delivery 1, 1, 37, 346, 10, '6/20/2021', 1, 'Red and blue macaw';
EXEC sp_insert_delivery 3, 4, 5, 165, 14, '8/13/2025', 4, 'Deer, white-tailed';
EXEC sp_insert_delivery 3, 4, 16, 492, 9, '5/22/2022', 4, 'Goose, cereopsis';
EXEC sp_insert_delivery 1, 3, 34, 283, 7, '11/8/2023', 2, 'Crane, sandhill';
EXEC sp_insert_delivery 3, 2, 47, 271, 20, '6/20/2025', 3, 'Bush dog';
EXEC sp_insert_delivery 3, 2, 23, 884, 10, '3/4/2026', 2, 'Butterfly, canadian tiger swallowtail';
EXEC sp_insert_delivery 4, 2, 23, 615, 7, '5/27/2025', 3, 'Colobus, white-mantled';
EXEC sp_insert_delivery 2, 1, 23, 62, 3, '6/2/2025', 2, 'Golden-mantled ground squirrel';
EXEC sp_insert_delivery 3, 2, 29, 789, 10, '4/19/2023', 4, 'Spotted hyena';
EXEC sp_insert_delivery 2, 3, 40, 794, 10, '10/10/2022', 1, 'Coatimundi, ring-tailed';
EXEC sp_insert_delivery 4, 4, 13, 185, 6, '1/24/2023', 3, 'Dragon, komodo';
EXEC sp_insert_delivery 1, 4, 17, 385, 13, '8/16/2021', 2, 'Magpie, black-backed';
EXEC sp_insert_delivery 3, 2, 42, 532, 13, '6/12/2022', 3, 'Black-capped chickadee';
EXEC sp_insert_delivery 4, 2, 28, 219, 6, '4/4/2021', 4, 'Phalarope, grey';
EXEC sp_insert_delivery 3, 4, 30, 914, 18, '8/4/2023', 4, 'Gray langur';
EXEC sp_insert_delivery 1, 1, 44, 283, 3, '1/12/2023', 1, 'Indian tree pie';
EXEC sp_insert_delivery 2, 4, 24, 966, 16, '10/29/2023', 2, 'American Virginia opossum';
EXEC sp_insert_delivery 1, 2, 2, 876, 13, '3/6/2026', 4, 'Aardwolf';
EXEC sp_insert_delivery 4, 1, 16, 719, 19, '5/17/2025', 2, 'Rat, white-faced tree';
EXEC sp_insert_delivery 3, 2, 43, 677, 3, '4/26/2023', 3, 'Ringtail';
EXEC sp_insert_delivery 2, 3, 7, 317, 16, '7/14/2021', 2, 'Hornbill, yellow-billed';
EXEC sp_insert_delivery 2, 3, 41, 516, 6, '1/1/2025', 4, 'Egyptian cobra';
EXEC sp_insert_delivery 4, 4, 9, 798, 6, '8/22/2022', 2, 'Goose, cereopsis';
EXEC sp_insert_delivery 3, 1, 48, 301, 9, '12/18/2024', 2, 'Red lava crab';
EXEC sp_insert_delivery 3, 4, 35, 154, 13, '1/7/2023', 2, 'Fox, blue';
EXEC sp_insert_delivery 3, 2, 43, 708, 18, '4/17/2024', 2, 'Langur, hanuman';
EXEC sp_insert_delivery 3, 3, 12, 199, 16, '5/8/2024', 2, 'Black-tailed prairie dog';
EXEC sp_insert_delivery 4, 4, 50, 544, 17, '7/9/2023', 3, 'Lizard (unidentified)';
EXEC sp_insert_delivery 2, 3, 41, 780, 15, '1/22/2022', 2, 'Tiger cat';
EXEC sp_insert_delivery 1, 1, 39, 68, 4, '9/10/2021', 2, 'Siskin, yellow-rumped';
EXEC sp_insert_delivery 1, 1, 40, 275, 6, '9/14/2024', 2, 'Parakeet, rose-ringed';
EXEC sp_insert_delivery 1, 3, 3, 21, 17, '2/12/2024', 1, 'Common palm civet';
EXEC sp_insert_delivery 1, 1, 30, 523, 12, '10/10/2023', 4, 'Bird (unidentified)';
EXEC sp_insert_delivery 2, 2, 25, 896, 20, '11/1/2023', 3, 'Gull, herring';
EXEC sp_insert_delivery 4, 4, 34, 51, 17, '11/9/2021', 4, 'Macaw, blue and gold';
EXEC sp_insert_delivery 1, 3, 22, 234, 16, '5/12/2021', 2, 'Little brown dove';
EXEC sp_insert_delivery 4, 3, 19, 174, 17, '2/16/2023', 3, 'Rhea, gray';
EXEC sp_insert_delivery 4, 4, 44, 843, 5, '4/23/2022', 1, 'Horned lark';
EXEC sp_insert_delivery 1, 3, 12, 814, 18, '1/23/2025', 4, 'Dove, white-winged';
EXEC sp_insert_delivery 2, 1, 34, 71, 7, '9/18/2022', 1, 'Penguin, magellanic';
EXEC sp_insert_delivery 3, 2, 33, 911, 12, '10/6/2021', 2, 'Kaffir cat';
EXEC sp_insert_delivery 3, 3, 2, 63, 18, '1/25/2022', 1, 'Northern elephant seal';
EXEC sp_insert_delivery 1, 2, 46, 889, 6, '9/29/2023', 4, 'Giant heron';
EXEC sp_insert_delivery 2, 1, 18, 21, 18, '1/31/2022', 3, 'Kangaroo, jungle';
EXEC sp_insert_delivery 1, 1, 7, 604, 5, '4/15/2021', 3, 'Long-tailed spotted cat';
EXEC sp_insert_delivery 4, 3, 27, 479, 14, '7/30/2024', 1, 'Sloth, two-toed tree';
EXEC sp_insert_delivery 1, 3, 21, 578, 16, '9/17/2021', 4, 'Ibis, puna';
EXEC sp_insert_delivery 2, 1, 31, 835, 1, '3/12/2025', 3, 'Ox, musk';
EXEC sp_insert_delivery 2, 2, 41, 45, 20, '3/3/2024', 1, 'White-throated toucan';
EXEC sp_insert_delivery 1, 3, 31, 626, 14, '3/19/2025', 1, 'Arboral spiny rat';
EXEC sp_insert_delivery 4, 2, 37, 733, 4, '1/31/2022', 1, 'Skink, blue-tongued';
EXEC sp_insert_delivery 3, 4, 47, 946, 4, '9/13/2022', 2, 'Hartebeest, red';
EXEC sp_insert_delivery 3, 2, 43, 352, 1, '3/3/2023', 1, 'Kite, black';
EXEC sp_insert_delivery 4, 1, 29, 658, 17, '11/24/2025', 4, 'Crane, stanley';
EXEC sp_insert_delivery 1, 3, 42, 112, 12, '7/20/2025', 3, 'Black-capped chickadee';
EXEC sp_insert_delivery 2, 1, 23, 924, 3, '1/17/2024', 1, 'Red-billed hornbill';
EXEC sp_insert_delivery 4, 2, 18, 749, 17, '3/15/2023', 3, 'Baboon, chacma';
EXEC sp_insert_delivery 3, 1, 4, 44, 7, '5/6/2022', 1, 'Water monitor';
EXEC sp_insert_delivery 3, 4, 8, 5, 11, '3/19/2025', 3, 'Buffalo, american';
EXEC sp_insert_delivery 1, 3, 7, 744, 9, '2/1/2022', 3, 'Stick insect';
EXEC sp_insert_delivery 1, 4, 32, 195, 18, '6/6/2021', 3, 'Horned puffin';
EXEC sp_insert_delivery 1, 2, 30, 966, 7, '7/18/2023', 1, 'Numbat';
EXEC sp_insert_delivery 1, 2, 25, 517, 5, '4/26/2024', 2, 'Gulls (unidentified)';
EXEC sp_insert_delivery 3, 2, 9, 824, 8, '5/1/2023', 3, 'Deer, mule';
EXEC sp_insert_delivery 1, 2, 33, 532, 16, '5/11/2025', 2, 'Gecko, tokay';
EXEC sp_insert_delivery 1, 3, 8, 488, 4, '8/21/2021', 4, 'Toddy cat';
EXEC sp_insert_delivery 1, 1, 6, 23, 13, '4/7/2021', 3, 'Small Indian mongoose';
EXEC sp_insert_delivery 4, 4, 11, 100, 9, '6/16/2025', 3, 'Crested bunting';
EXEC sp_insert_delivery 3, 1, 36, 239, 19, '4/19/2023', 3, 'Catfish, blue';
EXEC sp_insert_delivery 1, 2, 16, 398, 1, '9/13/2025', 4, 'Goanna lizard';
EXEC sp_insert_delivery 4, 1, 4, 238, 10, '4/15/2024', 3, 'Gila monster';
EXEC sp_insert_delivery 4, 2, 38, 236, 13, '11/9/2024', 4, 'Mandras tree shrew';
EXEC sp_insert_delivery 3, 4, 38, 981, 4, '5/22/2023', 2, 'Giant heron';
EXEC sp_insert_delivery 2, 3, 2, 833, 6, '1/20/2026', 1, 'Baboon, chacma';
EXEC sp_insert_delivery 2, 2, 32, 900, 9, '9/8/2022', 1, 'Phalarope, red-necked';
EXEC sp_insert_delivery 3, 4, 46, 159, 18, '11/20/2024', 3, 'European stork';
EXEC sp_insert_delivery 3, 2, 4, 695, 7, '1/19/2025', 1, 'Openbill, asian';
EXEC sp_insert_delivery 1, 3, 21, 979, 10, '12/26/2022', 4, 'Suricate';
EXEC sp_insert_delivery 4, 1, 10, 62, 11, '11/12/2025', 1, 'Yellow-headed caracara';
EXEC sp_insert_delivery 4, 1, 35, 925, 18, '12/5/2023', 2, 'Tinamou, elegant crested';
EXEC sp_insert_delivery 1, 2, 44, 359, 5, '2/23/2024', 2, 'Eastern fox squirrel';
EXEC sp_insert_delivery 1, 2, 30, 632, 6, '7/21/2024', 3, 'Cat, tiger';
EXEC sp_insert_delivery 2, 2, 9, 570, 20, '3/4/2022', 1, 'Anteater, australian spiny';
EXEC sp_insert_delivery 3, 1, 39, 893, 9, '12/6/2022', 3, 'Crab-eating fox';

-- solo las primeros 5 entregables tendrán calificaciones 

EXEC sp_insert_deliverables_qualifications 29, 4, 5, 93, 'Kongoni';
EXEC sp_insert_deliverables_qualifications 28, 3, 4, 74, 'Penguin, magellanic';
EXEC sp_insert_deliverables_qualifications 47, 3, 8, 20, 'American racer';
EXEC sp_insert_deliverables_qualifications 27, 2, 3, 93, 'Civet cat';
EXEC sp_insert_deliverables_qualifications 38, 3, 4, 46, 'Western grey kangaroo';
EXEC sp_insert_deliverables_qualifications 13, 3, 9, 74, 'Macaw, blue and yellow';
EXEC sp_insert_deliverables_qualifications 33, 2, 6, 49, 'Royal tern';
EXEC sp_insert_deliverables_qualifications 49, 3, 12, 88, 'Giant girdled lizard';
EXEC sp_insert_deliverables_qualifications 11, 5, 11, 78, 'American crow';
EXEC sp_insert_deliverables_qualifications 12, 3, 2, 66, 'Brown lemur';
EXEC sp_insert_deliverables_qualifications 23, 3, 9, 57, 'Indian tree pie';
EXEC sp_insert_deliverables_qualifications 30, 4, 4, 89, 'Crane, black-crowned';
EXEC sp_insert_deliverables_qualifications 42, 3, 11, 13, 'Eastern quoll';
EXEC sp_insert_deliverables_qualifications 24, 1, 11, 49, 'Elegant crested tinamou';
EXEC sp_insert_deliverables_qualifications 19, 5, 4, 63, 'Cat, kaffir';
EXEC sp_insert_deliverables_qualifications 49, 3, 16, 90, 'Eastern diamondback rattlesnake';
EXEC sp_insert_deliverables_qualifications 46, 4, 6, 20, 'Anteater, australian spiny';
EXEC sp_insert_deliverables_qualifications 35, 4, 2, 94, 'Vulture, oriental white-backed';
EXEC sp_insert_deliverables_qualifications 23, 1, 13, 13, 'Spectacled caiman';
EXEC sp_insert_deliverables_qualifications 22, 2, 13, 66, 'Palm squirrel';
EXEC sp_insert_deliverables_qualifications 5, 3, 14, 18, 'Hyena, striped';
EXEC sp_insert_deliverables_qualifications 8, 1, 15, 66, 'Giant anteater';
EXEC sp_insert_deliverables_qualifications 37, 3, 1, 13, 'Cape wild cat';
EXEC sp_insert_deliverables_qualifications 44, 5, 13, 40, 'Deer, swamp';
EXEC sp_insert_deliverables_qualifications 35, 5, 13, 46, 'Kiskadee, great';
EXEC sp_insert_deliverables_qualifications 26, 3, 9, 87, 'Crab, sally lightfoot';
EXEC sp_insert_deliverables_qualifications 17, 2, 14, 64, 'Gecko, tokay';
EXEC sp_insert_deliverables_qualifications 29, 3, 5, 92, 'Alligator, american';
EXEC sp_insert_deliverables_qualifications 44, 5, 6, 26, 'Common eland';
EXEC sp_insert_deliverables_qualifications 5, 2, 6, 12, 'Blue shark';
EXEC sp_insert_deliverables_qualifications 11, 2, 2, 29, 'Black-fronted bulbul';
EXEC sp_insert_deliverables_qualifications 42, 1, 7, 6, 'South American sea lion';
EXEC sp_insert_deliverables_qualifications 1, 2, 3, 2, 'Stork, openbill';
EXEC sp_insert_deliverables_qualifications 1, 4, 10, 32, 'Squirrel, eastern fox';
EXEC sp_insert_deliverables_qualifications 3, 5, 3, 78, 'Jaguarundi';
EXEC sp_insert_deliverables_qualifications 2, 4, 4, 3, 'Greater rhea';
EXEC sp_insert_deliverables_qualifications 13, 5, 5, 87, 'Hornbill, southern ground';
EXEC sp_insert_deliverables_qualifications 49, 5, 5, 13, 'Marshbird, brown and yellow';
EXEC sp_insert_deliverables_qualifications 20, 4, 14, 20, 'Gecko, barking';
EXEC sp_insert_deliverables_qualifications 15, 3, 3, 90, 'Hanuman langur';
EXEC sp_insert_deliverables_qualifications 18, 1, 7, 91, 'Great white pelican';
EXEC sp_insert_deliverables_qualifications 30, 5, 9, 11, 'Yellow-brown sungazer';
EXEC sp_insert_deliverables_qualifications 22, 4, 11, 1, 'Ass, asiatic wild';
EXEC sp_insert_deliverables_qualifications 36, 2, 2, 19, 'Yellow baboon';
EXEC sp_insert_deliverables_qualifications 32, 1, 15, 48, 'White-browed sparrow weaver';
EXEC sp_insert_deliverables_qualifications 2, 5, 7, 61, 'Cliffchat, mocking';
EXEC sp_insert_deliverables_qualifications 50, 5, 1, 38, 'Porcupine, indian';
EXEC sp_insert_deliverables_qualifications 15, 3, 15, 68, 'Eastern fox squirrel';
EXEC sp_insert_deliverables_qualifications 23, 2, 11, 87, 'Porcupine, crested';
EXEC sp_insert_deliverables_qualifications 9, 5, 9, 38, 'Tammar wallaby';
