Tipo:: #Proyecto  
Materia:: [[Bases de Datos 2]]
Fecha:: 2022-03-15T22:00

---
# Caso02
## Preguntas

## Todo
- [x] Actualizar la base con respecto a la clase del 02-03
	- [x] Actualizar las tablas
	- [x] Actualizar los inserts
		- [x] SPs 
- [x] Nuevo tipo deusuario
	- [x] Ciudadano 
		- [x] Se le asigna un cantón, por GPS
- [x] El ciudadano verá en una pantalla todos los entregables para su cantón por partido político
- [x] Calificación de entregables ( 0 a 10)
- [x]  Endpoints
	- [x] Listar los cantones que recibirán entregables en los primeros 100 días de gobierno, pero que no recibirán nada en los últimos 100 (David)
		- [x] Hacer uso según se necesite de except, intersect, set difference, datepart
			- [x] Cantón, cantidad de beneficios que recibirán en los primeros 100 días
	- [x] Para una misma acción en un mismo partido, sacar la densidad para todos los cantones que hay en los rangos de satisfacción del primer, segundo y tercer tercio (Esteban)
		- [x] dense_rank, pivot tables
			- [x] Partido, acción, tercio1, tercio2, tercio3
	- [x] Listar por año, los 3 top meses del volumen de entregables por partido que estén relacionados a una lista de palabras proporcionadas
		- [x] rank, datepart, full text
			- [x] Partido, año, nombre del mes, % de entregables, position
	- [x] Ranking por partido con mayores niveles de satisfacción en su plan en forma global pero cuya acción tenga el mismo comportamiento para todos los cantones donde habrá un entregable. Se consideran aceptables al top 30% de las calificaciones de satisfacción.
		- [x] Rank, except, intersect, pivot tables, rank
			- [x] Partido, % aceptación, posición, nota máxima obtenida
	- [x] Reporte de niveles de satisfacción por partido por cantón ordenados por mayor calificación a menor y por partido. Finalmente agregando un sumarizado por partido de los mismos porcentajes.
		- [x] pivot tables, roll up
			- [x] Partido, cantón, % insatisfechos, % medianamente satisfechos, % de muy satisfechos, sumarizado
	- [x] Dada un usuario ciudadano y un plan de un partido, recibir una lista de entregables para su cantón y las respectivas calificaciones de satisfacción para ser guardadas en forma transaccional.
		- [x] Table value parameters, transactions, read committed, transaction error handling
			- [x] 200 OK

