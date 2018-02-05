CREATE TABLE empresas (
  cif       CHAR(9),
  nombre    VARCHAR2(50)
    CONSTRAINT empresas_nn NOT NULL,
  telefono  CHAR(9),
  direccion VARCHAR2(50),
  localidad VARCHAR2(50),
  provincia VARCHAR2(30),
  CONSTRAINT empresas_pk PRIMARY KEY (cif),
  CONSTRAINT empresas_uk UNIQUE (nombre)
);
 SELECT * FROM EMPRESAS

CREATE TABLE pedidos(
  n_pedido NUMBER(4),
  cif CHAR(9)CONSTRAINT pedidos_nn1 NOT NULL,
  fecha DATE CONSTRAINT pedidos_nn2 NOT NULL ,
  CONSTRAINT pedidos_pk PRIMARY KEY (n_pedido),
  CONSTRAINT pedidos_fk FOREIGN KEY (cif) REFERENCES empresas
);
 SELECT * FROM PEDIDOS

CREATE TABLE almacenes(
  n_almacen NUMBER(2),
  descripcion VARCHAR2(1000) CONSTRAINT almacenes_nn NOT NULL,
  direccion VARCHAR2(1000),
  CONSTRAINT almacenes_pk PRIMARY KEY (n_almacen)
);
 SELECT * FROM ALMACENES

CREATE TABLE tipo_pieza (
  tipo        CHAR(2),
  descripcion VARCHAR2(25) CONSTRAINT tipo_pieza_nn NOT NULL,
  CONSTRAINT tipo_pieza_pk PRIMARY KEY (tipo)
);
 SELECT * FROM TIPO_PIEZA
DROP TABLE TIPO_PIEZA

CREATE TABLE piezas (
  tipo CHAR(2),
  modelo NUMBER(2),
  precio_venta  NUMBER(11,4) CONSTRAINT piezas_nn NOT NULL,
  CONSTRAINT piezas_pk PRIMARY KEY (tipo,modelo),
  CONSTRAINT piezas_fk FOREIGN KEY (tipo) REFERENCES tipo_pieza
);




CREATE TABLE suministros (
  tipo  CHAR(2),
  modelo NUMBER(2),
  cif CHAR(9),
  precio_compra NUMBER(11,4) CONSTRAINT suministros_nn NOT NULL,
  CONSTRAINT suministros_pk PRIMARY KEY (tipo, modelo, cif),
  CONSTRAINT suministros_fk1 FOREIGN KEY (tipo, modelo) REFERENCES piezas,
  CONSTRAINT suministros_fk2 FOREIGN KEY (cif) REFERENCES empresas,
  CONSTRAINT suministros_ck CHECK (precio_compra>0)
);

CREATE TABLE existencias (
  tipo CHAR(2),
  modelo NUMBER(2),
  n_almacen NUMBER(2),
  cantidad NUMBER(9) CONSTRAINT existencias_nn NOT NULL CONSTRAINT existencias_ck CHECK (cantidad>0),
  CONSTRAINT existencias_pk PRIMARY KEY (tipo,modelo,n_almacen),
  CONSTRAINT  existencias_fk1 FOREIGN KEY (tipo,modelo) REFERENCES piezas,
  CONSTRAINT  existencias_fk2 FOREIGN KEY (n_almacen) REFERENCES almacenes
);

CREATE TABLE lineas_pedido (
  tipo     CHAR(2)
    CONSTRAINT lineas_pedidios_nn1 NOT NULL,
  modelo   NUMBER(2)
    CONSTRAINT lineas_pedidios_nn2 NOT NULL,
  n_pedido NUMBER(4),
  n_linea  NUMBER(2),
  cantidad NUMBER(5),
  precio   NUMBER(11, 4),
  CONSTRAINT lineas_pedido_pk PRIMARY KEY (n_pedido, n_linea),
  CONSTRAINT lineas_pedido_fk1 FOREIGN KEY (n_pedido) REFERENCES pedidos,
  CONSTRAINT lineas_pedido_fk2 FOREIGN KEY (tipo, modelo) REFERENCES piezas
);

