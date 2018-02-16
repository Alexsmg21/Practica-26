CREATE TABLE equipos(
  id_equipo NUMBER(3),
  nombre VARCHAR2(50) CONSTRAINT equipos_nn1 NOT NULL ,
  estadio VARCHAR2(50),
  aforo NUMBER(6),
  ano_fundacion NUMBER(4),
  ciudad VARCHAR2(50) CONSTRAINT equipos_nn2 NOT NULL ,
  CONSTRAINT equipos_pk PRIMARY KEY (id_equipo),
  CONSTRAINT equipos_uk1 UNIQUE (nombre),
  CONSTRAINT equipos_uk2 UNIQUE (estadio)
 );

CREATE TABLE partidos(
  id_equipo_casa NUMBER(2),
  id_equipo_fuera NUMBER(2),
  fecha TIMESTAMP,
  goles_casa NUMBER(2),
  goles_fuera NUMBER(2),
  observaciones VARCHAR2(1000),
  CONSTRAINT partidos_pk PRIMARY KEY (id_equipo_casa,id_equipo_fuera),
  CONSTRAINT partidos_fk1 FOREIGN KEY (id_equipo_casa) REFERENCES equipos ON DELETE CASCADE ,
  CONSTRAINT partidos_fk2 FOREIGN KEY (id_equipo_fuera) REFERENCES equipos  ON DELETE CASCADE,
  CONSTRAINT partidos_ck CHECK (id_equipo_casa!=id_equipo_fuera)
);


CREATE TABLE jugadores(
  id_jugador NUMBER(3),
  nombre VARCHAR2(50) CONSTRAINT jugadores_nn NOT NULL,
  fecha_nac DATE,
  id_equipo NUMBER(2),
  CONSTRAINT jugadores_pk PRIMARY KEY (id_jugador),
  CONSTRAINT jugadores_fk FOREIGN KEY (id_equipo) REFERENCES equipos  ON DELETE SET NULL
);

CREATE TABLE goles(
  id_equipo_casa NUMBER(2),
  id_equipo_fuera NUMBER(2),
  minuto INTERVAL DAY TO SECOND,
  descripcion VARCHAR2(2000),
  id_jugador NUMBER(3),
  CONSTRAINT goles_pk PRIMARY KEY (id_equipo_casa,id_equipo_fuera,minuto),
  CONSTRAINT goles_fk1 FOREIGN KEY (id_equipo_casa,id_equipo_fuera) REFERENCES partidos  ON DELETE CASCADE,
  CONSTRAINT goles_fk2 FOREIGN KEY (id_jugador) REFERENCES jugadores  ON DELETE CASCADE,
  CONSTRAINT goles_ck CHECK (id_equipo_casa=id_equipo_fuera)
);

ALTER TABLE equipos MODIFY aforo CONSTRAINT equipos_nn3 NOT NULL;
ALTER TABLE equipos MODIFY estadio CONSTRAINT equipos_nn4 NOT NULL;



ALTER TABLE equipos MODIFY (ano_fundacion DATE);

ALTER TABLE jugadores DROP CONSTRAINT jugadores_nn;

