CREATE TABLE puestos (
  cod_puestos NUMBER(2),
  titulo_puesto VARCHAR2(25) CONSTRAINT puestos_nn1 NOT NULL ,
  salario_min NUMBER(11,2),
  salario_max NUMBER(11,2),
  CONSTRAINT puestos_pk PRIMARY KEY (cod_puestos),
  CONSTRAINT puestos_uk UNIQUE (titulo_puesto)
);

CREATE TABLE localidades(
  cod_localizacion NUMBER(3),
  localidad VARCHAR2(50) CONSTRAINT localidades_nn1 NOT NULL ,
  direccion VARCHAR2(50),
  cp CHAR(5),
  provincia VARCHAR2(25),
  CONSTRAINT localidades_pk PRIMARY KEY (cod_localizacion)
);

CREATE TABLE empleados(
  cod_emp NUMBER(4),
  nombre VARCHAR2(50) CONSTRAINT empleados_nn1 NOT NULL,
  apellido1 VARCHAR2(50) CONSTRAINT empleados_nn2 NOT NULL,
  apellido2 VARCHAR2(50) CONSTRAINT empleados_nn3 NOT NULL,
  telefono CHAR(9),
  direccion VARCHAR2(50),
  email VARCHAR2(50),
  cod_jefe NUMBER(4),
  cod_dep NUMBER(3),
  CONSTRAINT empleados_pk PRIMARY KEY (cod_emp),
  CONSTRAINT empleados_uk UNIQUE (email)
);

CREATE TABLE historial (
  cod_puesto NUMBER(2),
  cod_emp NUMBER(4),
  fecha_inicio DATE CONSTRAINT historial_nn1 NOT NULL ,
  fecha_fin DATE,
  cod_dep NUMBER(3),
  salario NUMBER(11,2),
  CONSTRAINT historial_pk PRIMARY KEY (cod_puesto,cod_emp)
);

CREATE TABLE departamentos(
  cod_dep NUMBER(2),
  nombre_dep VARCHAR2(25) CONSTRAINT departamentos_nn1 NOT NULL ,
  cod_resp NUMBER(4),
  cod_loc NUMBER(3),
  CONSTRAINT departamentos_pk PRIMARY KEY (cod_dep),
  CONSTRAINT departamentos_uk UNIQUE (nombre_dep)
);
DROP TABLE DEPARTAMENTOS

ALTER TABLE departamentos ADD CONSTRAINT departamentos_fk1 FOREIGN KEY (cod_resp) REFERENCES empleados;
ALTER TABLE departamentos ADD CONSTRAINT departamentos_fk2 FOREIGN KEY (cod_loc) REFERENCES localidades;
ALTER TABLE historial ADD CONSTRAINT historial_fk1 FOREIGN KEY (cod_puesto) REFERENCES puestos;
ALTER TABLE historial ADD CONSTRAINT historial_fk2 FOREIGN KEY (cod_emp) REFERENCES empleados;
ALTER TABLE historial ADD CONSTRAINT historial_fk3 FOREIGN KEY (cod_dep) REFERENCES departamentos;
ALTER TABLE empleados ADD CONSTRAINT empleados_fk1 FOREIGN KEY (cod_jefe) REFERENCES empleados(cod_emp);
ALTER TABLE empleados ADD CONSTRAINT empleados_fk2 FOREIGN KEY (cod_dep) REFERENCES departamentos;