-- Consulta 1: Obtener todos los socios con sus barcos
SELECT s.nombre, s.apellido_paterno, b.nombre_barco, b.n_matricula
FROM Socio s
JOIN Barco b ON s.id_socio = b.propietario_soc
ORDER BY s.apellido_paterno;

-- Consulta 2: Viajes realizados con información del patrón
SELECT v.n_de_viaje, v.destino, v.fecha_hora_salida, 
       p.nombre, p.apellido_paterno, b.nombre_barco
FROM Viaje v
JOIN Patron p ON v.id_patron = p.id_patron
JOIN Barco b ON v.id_barco = b.n_matricula
ORDER BY v.fecha_hora_salida;

-- Consulta 3: Barcos y sus muelles asignados
SELECT b.nombre_barco, m.nombre_muelle, m.amarre
FROM Barco b
JOIN BarcoMuelle bm ON b.n_matricula = bm.id_barco
JOIN Muelle m ON bm.id_muelle = m.id_muelle;

-- Consulta 4: Socios que no han realizado viajes (usando sus barcos)
SELECT s.nombre, s.apellido_paterno, s.correo
FROM Socio s
LEFT JOIN Barco b ON s.id_socio = b.propietario_soc
LEFT JOIN Viaje v ON b.n_matricula = v.id_barco
WHERE v.n_de_viaje IS NULL;

-- Consulta 5: Mensualidad total por socio
SELECT s.nombre, s.apellido_paterno, 
       COUNT(b.n_matricula) as total_barcos,
       SUM(b.mensualidad) as mensualidad_total
FROM Socio s
JOIN Barco b ON s.id_socio = b.propietario_soc
GROUP BY s.id_socio, s.nombre, s.apellido_paterno
ORDER BY mensualidad_total DESC;
