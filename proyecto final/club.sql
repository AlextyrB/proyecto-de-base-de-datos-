USE club;

CREATE TABLE club.Socio(
    id_socio 			INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre 				VARCHAR(15) NOT NULL,
    apellido_paterno	VARCHAR(20) NOT NULL,
    apellido_materno 	VARCHAR(20) NOT NULL,
    telefono 			VARCHAR(10),
    correo 				VARCHAR(100),
    UNIQUE (telefono, correo)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_general_ci;

CREATE TABLE club.Patron (
    id_patron 			INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre 				VARCHAR(15) NOT NULL,
    apellido_paterno 	VARCHAR(20) NOT NULL,
    apellido_materno 	VARCHAR(20) NOT NULL,
    telefono 			VARCHAR(10),
    correo 				VARCHAR(100),
    UNIQUE (telefono, correo)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_general_ci;


CREATE TABLE club.Barco(
    n_matricula 		VARCHAR(15) PRIMARY KEY,
    id_socio 			INT(10) NOT NULL,
    id_muelle 			INT(15),
    n_viaje 			INT(10),
    nombre_barco 		VARCHAR(20) NOT NULL,
    mensualidad 		INT(20) NOT NULL,
    CONSTRAINT fk_barco_socio FOREIGN KEY (id_socio) REFERENCES Socio(id_socio),
    CONSTRAINT fk_barco_muelle FOREIGN KEY (id_muelle) REFERENCES Muelle(id_muelle),
    CONSTRAINT fk_barco_viaje FOREIGN KEY (n_viaje) REFERENCES Viaje(n_viaje)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_general_ci;


CREATE TABLE club.Viaje (
    n_viaje 			INT(10) PRIMARY KEY AUTO_INCREMENT,
    id_patron 			INT(10) NOT NULL,
    fecha_hora_salida	DATETIME NOT NULL,
    fecha_hora_entrada 	DATETIME,
    destino 			VARCHAR(50) NOT NULL,
    CONSTRAINT fk_viaje_patron FOREIGN KEY (id_patron) REFERENCES Patron(id_patron)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_general_ci;

CREATE TABLE club.Muelle (
    id_muelle 			INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre_muelle 		VARCHAR(100),
    amarre 				INT
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_general_ci;

CREATE TABLE club.Viaje_Barco (
    n_matricula 		VARCHAR(15),
    n_viaje 			INT(10),
    PRIMARY KEY (n_matricula, n_viaje),
    CONSTRAINT fk_viaje_barco_matricula FOREIGN KEY (n_matricula) REFERENCES Barco(n_matricula),
    CONSTRAINT fk_viaje_barco_viaje FOREIGN KEY (n_viaje) REFERENCES Viaje(n_viaje)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_general_ci;

CREATE TABLE club.Barco_Muelle (
    n_matricula 		VARCHAR(15),
    id_muelle 			INT(15),
    fecha_estadia 		DATETIME NOT NULL,
    PRIMARY KEY (n_matricula, id_muelle, fecha_estadia),
    CONSTRAINT fk_barco_muelle_matricula FOREIGN KEY (n_matricula) REFERENCES Barco(n_matricula),
    CONSTRAINT fk_barco_muelle_muelle FOREIGN KEY (id_muelle) REFERENCES Muelle(id_muelle)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_general_ci;



CREATE INDEX idx_socio_nombre ON Socio(nombre, apellido_paterno, apellido_materno);
CREATE INDEX idx_patron_nombre ON Patron(nombre, apellido_paterno, apellido_materno);
CREATE INDEX idx_barco_socio ON Barco(id_socio);
CREATE INDEX idx_barco_muelle ON Barco(id_muelle);
CREATE INDEX idx_barco_viaje ON Barco(n_viaje);
CREATE INDEX idx_barco_nombre ON Barco(nombre_barco);
CREATE INDEX idx_viaje_patron ON Viaje(id_patron);
CREATE INDEX idx_viaje_fecha ON Viaje(fecha_hora_salida);
CREATE INDEX idx_viaje_barco_matricula ON Viaje_Barco(n_matricula);
CREATE INDEX idx_viaje_barco_viaje ON Viaje_Barco(n_viaje);
CREATE INDEX idx_barco_muelle_matricula ON Barco_Muelle(n_matricula);
CREATE INDEX idx_barco_muelle_muelle ON Barco_Muelle(id_muelle);
CREATE INDEX idx_barco_muelle_fecha ON Barco_Muelle(fecha_estadia);
CREATE INDEX idx_muelle_amarre ON Muelle(amarre);
