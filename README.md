Tipo:: #Proyecto  
Materia:: [[Bases de Datos 2]]
Fecha:: 2022-03-15T22:00

---
# Caso02
## Preguntas

## Todo
- [ ] Actualizar la base con respecto a la clase del 02-03
	- [x] Actualizar las tablas
	- [ ] Actualizar los inserts
		- [ ] SPs 
- [x] Nuevo tipo deusuario
	- [x] Ciudadano 
		- [x] Se le asigna un cantón, por GPS
- [ ] El ciudadano verá en una pantalla todos los entregables para su cantón por partido político
- [x] Calificación de entregables ( 0 a 10)
- [ ]  Endpoints
	- [ ] Listar los cantones que recibirán entregables en los primeros 100 días de gobierno, pero que no recibirán nada en los últimos 100 (David)
		- [ ] Hacer uso según se necesite de except, intersect, set difference, datepart
			- [ ] Cantón, cantidad de beneficios que recibirán en los primeros 100 días
	- [ ] Para una misma acción en un mismo partido, sacar la densidad para todos los cantones que hay en los rangos de satisfacción del primer, segundo y tercer tercio (Esteban)
		- [ ] dense_rank, pivot tables
			- [ ] Partido, acción, tercio1, tercio2, tercio3
	- [ ] Listar por año, los 3 top meses del volumen de entregables por partido que estén relacionados a una lista de palabras proporcionadas
		- [ ] rank, datepart, full text
			- [ ] Partido, año, nombre del mes, % de entregables, position
	- [ ] Ranking por partido con mayores niveles de satisfacción en su plan en forma global pero cuya acción tenga el mismo comportamiento para todos los cantones donde habrá un entregable. Se consideran aceptables al top 30% de las calificaciones de satisfacción.
		- [ ] Rank, except, intersect, pivot tables, rank
			- [ ] Partido, % aceptación, posición, nota máxima obtenida
	- [ ] Reporte de niveles de satisfacción por partido por cantón ordenados por mayor calificación a menor y por partido. Finalmente agregando un sumarizado por partido de los mismos porcentajes.
		- [ ] pivot tables, roll up
			- [ ] Partido, cantón, % insatisfechos, % medianamente satisfechos, % de muy satisfechos, sumarizado
	- [ ] Dada un usuario ciudadano y un plan de un partido, recibir una lista de entregables para su cantón y las respectivas calificaciones de satisfacción para ser guardadas en forma transaccional.
		- [ ] Table value parameters, transactions, read committed, transaction error handling
			- [ ] 200 OK
