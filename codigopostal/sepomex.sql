SET NAMES 'latin1';
DROP DATABASE IF EXISTS latin1;
CREATE DATABASE IF NOT EXISTS sepomex DEFAULT CHARACTER SET latin1;
USE sepomex;

CREATE TABLE sepomex.sepomex(    
  d_codigo VARCHAR(45) NULL COMMENT '',
  d_asenta VARCHAR(145) NULL COMMENT '',
  d_tipo_asenta VARCHAR(45) NULL COMMENT '',
  d_mnpio VARCHAR(45) NULL COMMENT '',
  d_estado VARCHAR(45) NULL COMMENT '',
  d_ciudad VARCHAR(45) NULL COMMENT '',
  d_cp VARCHAR(45) NULL COMMENT '',
  c_estado INT(7) NULL COMMENT '',
  c_oficina INT(4) NULL COMMENT '',
  c_cp INT(4) NULL COMMENT '',
  c_tipo_asenta INT(10) NULL COMMENT '',
  c_mnpio INT(4) NULL COMMENT '',
  id_asenta_cpcons INT(5) NULL COMMENT '',
  d_zona VARCHAR(45) NULL COMMENT '',
  c_cve_ciudad INT(3) NULL COMMENT ''
 )DEFAULT CHARACTER SET latin1;

