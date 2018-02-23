CREATE TABLE tipos_apli(
  id_tipo NUMBER(2),
  tipo VARCHAR2(25) CONSTRAINT tipos_apli_nn1 NOT NULL ,
  CONSTRAINT tipos_apli_pk PRIMARY KEY (id_tipo),
  CONSTRAINT tipos_apli_uk1 UNIQUE (tipo)
);

CREATE TABLE aplicaciones(
  n_aplicaciones NUMBER(4),
  nombre VARCHAR2(25)CONSTRAINT aplicaciones_nn1 NOT NULL,
  extension VARCHAR2(10),
  id_tipo NUMBER(11,2)CONSTRAINT aplicaciones_nn2 NOT NULL,
  CONSTRAINT aplicaciones_pk PRIMARY KEY (n_aplicaciones),
  CONSTRAINT aplicaciones_uk1 UNIQUE (nombre),
  CONSTRAINT aplicaciones_fk1 FOREIGN KEY (id_tipo) REFERENCES tipos_apli ON DELETE CASCADE
);

CREATE TABLE maquinas (
  n_maquina NUMBER(3),
  ip1 NUMBER(3) CONSTRAINT maquinas_nn1 NOT NULL,
  ip2 NUMBER(3) CONSTRAINT maquinas_nn2 NOT NULL,
  ip3 NUMBER(3) CONSTRAINT maquinas_nn3 NOT NULL,
  ip4 NUMBER(3) CONSTRAINT maquinas_nn4 NOT NULL,
  nombre VARCHAR2(45) CONSTRAINT maquinas_nn5 NOT NULL,
  memoria NUMBER(5,1),
  CONSTRAINT maquinas_pk PRIMARY KEY (n_maquina),
  CONSTRAINT maquinas_uk1 UNIQUE (ip1,ip2,ip3,ip4),
  CONSTRAINT maquinas_uk2 UNIQUE (nombre)
);

CREATE TABLE procesos(
  n_aplicacion NUMBER(4),
  id_proceso NUMBER(3),
  nombre VARCHAR2(25) CONSTRAINT procesos_nn1 NOT NULL,
  mem_minima NUMBER(5,1),
  id_proceso_lanz NUMBER(3),
  n_aplicacion_lanz NUMBER(4),
  CONSTRAINT procesos_pk PRIMARY KEY (n_aplicacion,id_proceso),
  CONSTRAINT procesos_uk UNIQUE (nombre),
  CONSTRAINT procesos_fk1 FOREIGN KEY (n_aplicacion) REFERENCES aplicaciones ON DELETE CASCADE,
  CONSTRAINT procesos_fk2 FOREIGN KEY (id_proceso_lanz,n_aplicacion_lanz) REFERENCES procesos(n_aplicacion,id_proceso) ON DELETE SET NULL ,
  CONSTRAINT procesos_ck CHECK (mem_minima>0)
);

CREATE TABLE procesos_lanzados(
  n_aplicacion NUMBER(4),
  id_proceso NUMBER(4),
  fecha_lanz TIMESTAMP,
  fecha_termino TIMESTAMP,
  bloqueado NUMBER(1),
  n_maquina NUMBER(3) CONSTRAINT procesos_lanzados_nn1 NOT NULL ,
  CONSTRAINT procesos_lanzados_pk PRIMARY KEY (n_aplicacion,id_proceso,fecha_lanz),
  CONSTRAINT procesos_lanzados_fk1 FOREIGN KEY (n_aplicacion,id_proceso) REFERENCES procesos(n_aplicacion,id_proceso)ON DELETE CASCADE ,
  CONSTRAINT procesos_lanzados_fk2 FOREIGN KEY (n_maquina) REFERENCES maquinas(n_maquina)ON DELETE CASCADE,
  CONSTRAINT procesos_lanzados_ck CHECK (bloqueado=1 OR bloqueado=0)
);

ALTER TABLE maquinas ADD hd NUMBER(5,2);
ALTER TABLE maquinas ADD tipo CHAR CONSTRAINT maquinas_ck CHECK (tipo='S' OR tipo='C');


INSERT INTO tipos_apli VALUES (1,'Procesador de texto');



INSERT INTO aplicaciones VALUES (1,'Multiword','multi',1);
INSERT INTO procesos VALUES (1,1,'WRD',250,NULL ,NULL );
INSERT INTO procesos_lanzados VALUES (1,1,to_date('30/5/2016' 'dd/mm/yyyy'),to_date('1/6/2016','dd/mm/yyyy'),0,3);
INSERT INTO procesos_lanzados VALUES (1,1,to_date('30/5/2016' 'dd/mm/yyyy'),to_date('1/6/2016','dd/mm/yyyy'),0,1);
INSERT INTO procesos_lanzados VALUES (1,1,to_date('31/5/2016' 'dd/mm/yyyy'),to_date('2/6/2016','dd/mm/yyyy'),1,1);
INSERT INTO procesos_lanzados VALUES (1,1,to_date('30/5/2016' 'dd/mm/yyyy'),NULL ,0,2);
INSERT INTO procesos VALUES (1,2,'WRHELP',250,1,1);
INSERT INTO procesos_lanzados VALUES (1,2,to_date('30/5/2016','dd/mm/yyyy'),to_date('1/6/2016','dd/mm/yyyy'),0,1);
INSERT INTO procesos_lanzados VALUES (1,2,to_date('31/5/2016','dd/mm/yyyy'),NULL ,1,2);
INSERT INTO maquinas VALUES (1,212,34,56,7,'ELECTRO',512,250,'S');
INSERT INTO maquinas VALUES (2,212,34,56,27,'MAGNUS',256,128,'C');
INSERT INTO maquinas VALUES (3,97,23,45,6,'GREGOR',1024,512,'S');