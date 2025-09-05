USE club;

CREATE VIEW vista_socios AS
SELECT 
    id_socio,
    nombre,
    apellido_paterno,
    apellido_materno,
    telefono,
    correo
FROM Socio
ORDER BY apellido_paterno, apellido_materno, nombre;

---Una vista que haga la consulta ocupando por lo menos 3 tablas con join internos (select)--

CREATE VIEW vista_barcos_completa AS
SELECT 
    b.n_matricula AS matricula_barco,
    b.nombre_barco,
    b.mensualidad,
    CONCAT(s.nombre, ' ', s.apellido_paterno, ' ', s.apellido_materno) AS nombre_completo_socio,
    s.telefono AS telefono_socio,
    s.correo AS correo_socio,
    m.nombre_muelle,
    m.amarre AS numero_amarre
FROM Barco b
INNER JOIN Socio s ON b.id_socio = s.id_socio
INNER JOIN Muelle m ON b.id_muelle = m.id_muelle
ORDER BY b.nombre_barco;

---Una vista que haga la consulta ocupando por lo menos 3 tablas con join externos (inner join,left join,rigth join)----

CREATE VIEW viajescompleta AS
SELECT 
    v.n_viaje AS numero_viaje,
    v.fecha_hora_salida,
    v.fecha_hora_entrada,
    v.destino,
    CONCAT(p.nombre, ' ', p.apellido_paterno, ' ', p.apellido_materno) AS nombre_completo_patron,
    p.telefono AS telefono_patron,
    p.correo AS correo_patron,
    b.n_matricula AS matricula_barco,
    b.nombre_barco,
    CONCAT(s.nombre, ' ', s.apellido_paterno, ' ', s.apellido_materno) AS nombre_completo_socio,
    s.telefono AS telefono_socio
FROM Viaje v
INNER JOIN Patron p ON v.id_patron = p.id_patron
LEFT JOIN Viaje_Barco vb ON v.n_viaje = vb.n_viaje
RIGHT JOIN Barco b ON vb.n_matricula = b.n_matricula
LEFT JOIN Socio s ON b.id_socio = s.id_socio
ORDER BY v.fecha_hora_salida DESC;
----vistas de los barcos--------
CREATE VIEW vista_barcos AS
SELECT 
    b.n_matricula AS 'Nº Matricula',
    s.nombre AS 'Socio',
    COALESCE(m.nombre_muelle, 'Sin asignar') AS 'Muelle',
    COALESCE(v.destino, 'Sin viaje') AS 'Viajes',
    b.nombre_barco AS 'Nombre del Barco',
    b.mensualidad AS 'Mensualidad'
FROM 
    club.Barco b
    INNER JOIN club.Socio s ON b.id_socio = s.id_socio
    LEFT JOIN club.Muelle m ON b.id_muelle = m.id_muelle
    LEFT JOIN club.Viaje v ON b.n_viaje = v.n_viaje
ORDER BY 
    b.n_matricula;

-- Procedimiento simple que usa la vista
DELIMITER $$
