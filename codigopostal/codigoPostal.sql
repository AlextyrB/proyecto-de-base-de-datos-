
USE codigopostal;

CREATE TABLE Estados (
    c_estado 				INT NOT NULL PRIMARY KEY,
    d_estado 				VARCHAR(100) NOT NULL 
)DEFAULT CHARACTER SET latin1;

CREATE TABLE Municipios (
    c_mnpio					INT NOT NULL,
    c_estado 				INT NOT NULL,
    d_mnpio 				VARCHAR(100) NOT NULL,
    PRIMARY KEY (c_mnpio,c_estado),
    FOREIGN KEY (c_estado) REFERENCES Estados(c_estado)
)DEFAULT CHARACTER SET latin1;

CREATE TABLE Ciudades(
    c_cve_ciudad 			INT NOT NULL,
    d_ciudad 				VARCHAR(100) NOT NULL,
    c_estado 				INT NOT NULL,
    PRIMARY KEY (c_eve_ciudad),
    CONSTRAINT fk_ciudad_estado FOREIGN KEY (c_estado) REFERENCES estados(c_estado),
    CONSTRAINT uk_ciudad_estado UNIQUE (d_ciudad, c_estado)
)DEFAULT CHARACTER SET latin1;

CREATE TABLE TiposAsentamiento (
    c_tipo_asenta 			INT  PRIMARY KEY,
    d_tipo_asenta 			VARCHAR(50)  UNIQUE
)DEFAULT CHARACTER SET latin1;

CREATE TABLE Asentamientos (
    id_asenta_cpcons 		INT NOT NULL PRIMARY KEY,
    d_asenta 				VARCHAR(100) NOT NULL,
    d_codigo 				VARCHAR(5) NOT NULL,
    d_zona 					VARCHAR(10) NOT NULL CHECK (d_zona IN ('Urbano', 'Rural')),
    c_tipo_asenta 			INT NOT NULL,
    c_mnpio 				INT NOT NULL,
    FOREIGN KEY (c_tipo_asenta) REFERENCES TiposAsentamiento(c_tipo_asenta),
    FOREIGN KEY (c_mnpio) REFERENCES Municipios(c_mnpio),
    UNIQUE (d_codigo, c_mnpio)
)DEFAULT CHARACTER SET latin1;

CREATE TABLE OficinasPostales (
    c_oficina 				INT NOT NULL PRIMARY KEY,
    d_CP 					VARCHAR(5) NOT NULL,
    c_cve_ciudad 				INT NOT NULL,
    FOREIGN KEY (c_cve_ciudad) REFERENCES Ciudades(c_eve_ciudad),
    UNIQUE (d_CP, c_ciudad)
)DEFAULT CHARACTER SET latin1;

CREATE TABLE AsentamientoOficina (
    id_asenta_cpcons 		INT NOT NULL,
    c_oficina 				INT NOT NULL,
    PRIMARY KEY (id_asenta_epcons, c_oficina),
    FOREIGN KEY (id_asenta_epcons) REFERENCES Asentamientos(id_asenta_epcons),
    FOREIGN KEY (c_oficina) REFERENCES OficinasPostales(c_oficina)
)DEFAULT CHARACTER SET latin1;

CREATE INDEX idx_asentamientos_codigo ON Asentamientos(d_codigo);
CREATE INDEX idx_asentamientos_municipio ON Asentamientos(c_mnpio);
CREATE INDEX idx_oficinas_cp ON OficinasPostales(d_CP);
CREATE INDEX idx_ciudades_nombre ON Ciudades(d_ciudad);
	

