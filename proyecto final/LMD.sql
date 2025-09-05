INSERT INTO club.Socio (nombre, apellido_paterno, apellido_materno, telefono, correo) VALUES
('Juan', 'García', 'López', '5551234567', 'juan.garcia@email.com'),
('María', 'Rodríguez', 'Martín', '5552345678', 'maria.rodriguez@email.com'),
('Carlos', 'Hernández', 'Pérez', '5553456789', 'carlos.hernandez@email.com'),
('Ana', 'López', 'Sánchez', '5554567890', 'ana.lopez@email.com'),
('Pedro', 'González', 'Ramírez', '5555678901', 'pedro.gonzalez@email.com'),
('Laura', 'Martínez', 'Torres', '5556789012', 'laura.martinez@email.com'),
('Roberto', 'Sánchez', 'Flores', '5557890123', 'roberto.sanchez@email.com'),
('Carmen', 'Torres', 'Morales', '5558901234', 'carmen.torres@email.com'),
('Miguel', 'Flores', 'Jiménez', '5559012345', 'miguel.flores@email.com'),
('Isabel', 'Morales', 'Ruiz', '5550123456', 'isabel.morales@email.com');


INSERT INTO club.Patron (nombre, apellido_paterno, apellido_materno, telefono, correo) VALUES
('Alejandro', 'Navarro', 'Castillo', '5551111111', 'alejandro.navarro@email.com'),
('Sofía', 'Castro', 'Herrera', '5552222222', 'sofia.castro@email.com'),
('Fernando', 'Herrera', 'Vargas', '5553333333', 'fernando.herrera@email.com'),
('Lucía', 'Vargas', 'Mendoza', '5554444444', 'lucia.vargas@email.com'),
('Ricardo', 'Mendoza', 'Ortega', '5555555555', 'ricardo.mendoza@email.com'),
('Patricia', 'Ortega', 'Silva', '5556666666', 'patricia.ortega@email.com'),
('Andrés', 'Silva', 'Ramos', '5557777777', 'andres.silva@email.com'),
('Beatriz', 'Ramos', 'Guerrero', '5558888888', 'beatriz.ramos@email.com'),
('Diego', 'Guerrero', 'Medina', '5559999999', 'diego.guerrero@email.com'),
('Cristina', 'Medina', 'Peña', '5550000000', 'cristina.medina@email.com');

INSERT INTO club.Muelle (nombre_muelle, amarre) VALUES
('Muelle Norte A', 101),
('Muelle Norte B', 102),
('Muelle Sur A', 201),
('Muelle Sur B', 202),
('Muelle Este A', 301),
('Muelle Este B', 302),
('Muelle Oeste A', 401),
('Muelle Oeste B', 402),
('Muelle Central', 501),
('Muelle Deportivo', 601);

INSERT INTO club.Viaje (id_patron, fecha_hora_salida, fecha_hora_entrada, destino) VALUES
(1, '2024-01-15 08:00:00', '2024-01-15 18:30:00', 'Isla Mujeres'),
(2, '2024-01-16 09:15:00', '2024-01-16 19:45:00', 'Cozumel'),
(3, '2024-01-17 07:30:00', '2024-01-17 17:00:00', 'Playa del Carmen'),
(4, '2024-01-18 10:00:00', '2024-01-18 20:30:00', 'Cancún'),
(5, '2024-01-19 08:45:00', '2024-01-19 16:15:00', 'Puerto Morelos'),
(6, '2024-01-20 11:30:00', '2024-01-20 21:00:00', 'Holbox'),
(7, '2024-01-21 06:00:00', '2024-01-21 15:30:00', 'Contoy'),
(8, '2024-01-22 09:00:00', '2024-01-22 18:00:00', 'Xcaret'),
(9, '2024-01-23 07:15:00', '2024-01-23 16:45:00', 'Xel-Há'),
(10, '2024-01-24 10:30:00', NULL, 'Tulum');

INSERT INTO club.Barco (n_matricula, id_socio, id_muelle, n_viaje, nombre_barco, mensualidad) VALUES
('MX-2024-001', 1, 1, 1, 'Viento Marino', 15000),
('MX-2024-002', 2, 2, 2, 'Ola Azul', 18000),
('MX-2024-003', 3, 3, 3, 'Gaviota Blanca', 12000),
('MX-2024-004', 4, 4, 4, 'Delfín Dorado', 20000),
('MX-2024-005', 5, 5, 5, 'Coral Rojo', 16000),
('MX-2024-006', 6, 6, 6, 'Estrella Marina', 22000),
('MX-2024-007', 7, 7, 7, 'Pez Volador', 14000),
('MX-2024-008', 8, 8, 8, 'Sirena Azul', 19000),
('MX-2024-009', 9, 9, 9, 'Tritón Dorado', 17000),
('MX-2024-010', 10, 10, 10, 'Neptuno Rey', 25000);


INSERT INTO club.Viaje_Barco (n_matricula, n_viaje) VALUES
('MX-2024-001', 1),
('MX-2024-002', 2),
('MX-2024-003', 3),
('MX-2024-004', 4),
('MX-2024-005', 5),
('MX-2024-006', 6),
('MX-2024-007', 7),
('MX-2024-008', 8),
('MX-2024-009', 9),
('MX-2024-010', 10);

INSERT INTO club.Barco_Muelle (n_matricula, id_muelle, fecha_estadia) VALUES
('MX-2024-001', 1, '2024-01-15 06:00:00'),
('MX-2024-002', 2, '2024-01-16 07:00:00'),
('MX-2024-003', 3, '2024-01-17 05:30:00'),
('MX-2024-004', 4, '2024-01-18 08:00:00'),
('MX-2024-005', 5, '2024-01-19 06:45:00'),
('MX-2024-006', 6, '2024-01-20 09:30:00'),
('MX-2024-007', 7, '2024-01-21 04:00:00'),
('MX-2024-008', 8, '2024-01-22 07:00:00'),
('MX-2024-009', 9, '2024-01-23 05:15:00'),
('MX-2024-010', 10, '2024-01-24 08:30:00');
