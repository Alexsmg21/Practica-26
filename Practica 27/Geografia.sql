CREATE TABLE comunidades(
  id_comunidad NUMBER(2),
  nombre VARCHAR2(25)CONSTRAINT comunidades_nn1 NOT NULL ,
  id_capital NUMBER(5) CONSTRAINT comunidades_nn2 NOT NULL ,
  max_provincias NUMBER(1),
  CONSTRAINT comunidades_pk PRIMARY KEY (id_comunidad),
  CONSTRAINT comunidades_uk1 UNIQUE (nombre),
  CONSTRAINT comunidades_uk2 UNIQUE (id_capital)
);




CREATE TABLE localidades(
  id_localidad NUMBER(5),
  nombre VARCHAR2(50) CONSTRAINT localidades_nn1 NOT NULL ,
  poblacion NUMBER(8),
  n_provincias NUMBER(2) CONSTRAINT localidades_nn2 NOT NULL ,
  CONSTRAINT localidades_pk PRIMARY KEY (id_localidad)
);



CREATE TABLE provincias(
  n_provincia NUMBER(2),
  nombre VARCHAR2(25) CONSTRAINT provincias_nn1 NOT NULL ,
  superficie NUMBER(5),
  id_capital NUMBER(5) CONSTRAINT provincias_nn2 NOT NULL,
  id_comunidad NUMBER(2) CONSTRAINT provincias_nn3 NOT NULL,
  CONSTRAINT provincias_pk PRIMARY KEY (n_provincia),
  CONSTRAINT provincias_uk1 UNIQUE (nombre),
  CONSTRAINT provincias_uk2 UNIQUE (id_capital),
  CONSTRAINT provincias_uk3 UNIQUE (id_comunidad)
);


ALTER TABLE localidades ADD CONSTRAINT localidades_fk FOREIGN KEY (n_provincias) REFERENCES provincias;
ALTER TABLE comunidades ADD CONSTRAINT comunidades_fk FOREIGN KEY (id_capital) REFERENCES localidades;
ALTER TABLE provincias ADD CONSTRAINT provincias_fk1 FOREIGN KEY (id_capital) REFERENCES localidades;
ALTER TABLE provincias ADD CONSTRAINT provincias_fk2 FOREIGN KEY (id_comunidad) REFERENCES comunidades;

SELECT * FROM PROVINCIAS