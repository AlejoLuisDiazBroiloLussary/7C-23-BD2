1;

select Curso.fecha as Dia, Clase.nombre as Clase_nombre, Mascota.nombre as Mascota_Nombre, Estado_asistencia.estado
from Asistencia 
inner join Curso on Curso.id = Asistencia.curso join Clase on Clase.id = Curso.clase
inner join Mascota on Mascota.id = Asistencia.Mascota
inner join Estado_asistencia on Estado_asistencia.id = Asistencia.estado_asistencia 
where Asistencia.estado_asistencia = 1 and Curso.fecha >= DATE_SUB(NOW(), INTERVAL 1 MONTH);

2;

select Peticion.id as id_peticion, Mascota.nombre as nombre_mascota, Raza.nombre, Persona.nombre as nombre_duenio, Peticion.fecha_creacion, Peticion.fecha_admicion
from Peticion
inner join Mascota on Mascota.id = Peticion.mascota
inner join Raza on Raza.id = Mascota.raza
inner join Adoptante on Adoptante.id = Peticion.adoptante
inner join Persona on Persona.id = Adoptante.persona
WHERE Peticion.validacion = 1 and Peticion.fecha_admicion >= DATE_SUB(NOW(), INTERVAL 2 MONTH);

SELECT COUNT(DISTINCT Mascota.id) AS cantidad_adoptadas, Raza.nombre AS tipo_mascota_mas_adoptado
FROM Peticion
INNER JOIN Mascota ON Mascota.id = Peticion.mascota
INNER JOIN Raza ON Raza.id = Mascota.raza
WHERE Peticion.validacion = 1 and Peticion.fecha_admicion >= DATE_SUB(NOW(), INTERVAL 2 MONTH)
GROUP BY Raza.nombre
ORDER BY COUNT(DISTINCT Mascota.id) DESC
LIMIT 1;

3;

SELECT 
    DATE_FORMAT(P.fecha_creacion, '%Y-%m') AS mes,
    COUNT(DISTINCT CASE WHEN P.validacion = 1 THEN P.id END) AS adopciones_exitosas,
    COUNT(DISTINCT P.id) AS solicitudes,
    ROUND(COUNT(DISTINCT CASE WHEN P.validacion = 1 THEN P.id END) / COUNT(DISTINCT P.id) * 100, 2) AS indice_adopcion
FROM Peticion P
GROUP BY mes;

4;

SELECT Mascota.nombre, Persona.nombre, Preferencia.raza AS Raza_preferida, Raza.nombre, Tamanio.nombre, Preferencia.tamanio AS tamanio_preferido FROM Mascota 
INNER JOIN Peticion on Peticion.mascota = Mascota.id 
INNER JOIN Raza on Mascota.raza = Raza.id 
INNER JOIN Tamanio on Mascota.tamanio = Tamanio.id 
INNER JOIN Preferencia on Preferencia.raza = Raza.id
INNER JOIN Adoptante on Preferencia.adoptante = Adoptante.id 
INNER JOIN Persona on Adoptante.persona = Persona.id
WHERE Mascota.id NOT IN (SELECT mascota FROM Peticion WHERE mascota IS NOT NULL) 
OR Mascota.id IN (SELECT mascota FROM Peticion WHERE validacion = false);
