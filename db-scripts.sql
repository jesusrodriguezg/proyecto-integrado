-- Creamos la base de datos con la codificación de caracteres
CREATE DATABASE VIDEOGELVES DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

-- Seleccionamos la base de datos
USE VIDEOGELVES;

-- Creamos las tablas
CREATE TABLE USUARIO (
    ID_USUARIO  INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    EMAIL       VARCHAR(50) NOT NULL,
    PASSWORD    VARCHAR(25) NOT NULL,
    NOMBRE      VARCHAR(25) NOT NULL,
    APELLIDOS   VARCHAR(50) NOT NULL,
    DIRECCION   VARCHAR(200) NOT NULL,
    ADMIN       CHAR NOT NULL,
    PRIMARY KEY (ID_USUARIO)
);

CREATE TABLE CATEGORIA (
    ID_CATEGORIA           INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    NOMBRE_CATEGORIA       VARCHAR(20) NOT NULL,
    DESCRIPCION_CATEGORIA  VARCHAR(150) NOT NULL,
    PRIMARY KEY (ID_CATEGORIA)
);

CREATE TABLE PRODUCTO (
    ID_PRODUCTO             INTEGER NOT NULL UNIQUE,
    NOMBRE_PRODUCTO         VARCHAR(50) NOT NULL,
    DESCRIPCION             VARCHAR(250) NOT NULL,
    PRECIO                  DECIMAL(4,2) NOT NULL,
    STOCK                   INTEGER NOT NULL,
    IMAGEN                  VARCHAR(100) NOT NULL,
    CATEGORIA_ID_CATEGORIA  INTEGER NOT NULL,
    PRIMARY KEY (ID_PRODUCTO)
);

CREATE TABLE PEDIDO (
    ID_PEDIDO           INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    COMPRADO            CHAR(1) NOT NULL,
    FECHA               VARCHAR(10) NOT NULL,
    USUARIO_ID_USUARIO  INTEGER NOT NULL,
    PRIMARY KEY (ID_PEDIDO)
);

CREATE TABLE DETALLE_PEDIDO (
    PEDIDO_ID_PEDIDO      INTEGER NOT NULL,
    PRODUCTO_ID_PRODUCTO  INTEGER NOT NULL,
    CANTIDAD              INTEGER NOT NULL,
    DEVUELTO              CHAR(1) NOT NULL,
    CONSTRAINT PK_DETALLE_PEDIDO PRIMARY KEY (PEDIDO_ID_PEDIDO,PRODUCTO_ID_PRODUCTO)
);

CREATE TABLE LISTA_DESEOS (
    USUARIO_ID_USUARIO    INTEGER NOT NULL,
    PRODUCTO_ID_PRODUCTO  INTEGER NOT NULL
    CONSTRAINT PK_LISTA_DESEOS PRIMARY KEY (USUARIO_ID_USUARIO,PRODUCTO_ID_PRODUCTO);

);

CREATE TABLE VALORACION (
    COMENTARIO            VARCHAR(300) NOT NULL,
    PUNTUACION            INTEGER NOT NULL,
    USUARIO_ID_USUARIO    INTEGER NOT NULL,
    PRODUCTO_ID_PRODUCTO  INTEGER NOT NULL,
    CONSTRAINT PK_VALORACION PRIMARY KEY (USUARIO_ID_USUARIO,PRODUCTO_ID_PRODUCTO)
);

-- Añadimos las claves foráneas
ALTER TABLE PRODUCTO ADD CONSTRAINT FK_PRODUCTO_CATEGORIA FOREIGN KEY (CATEGORIA_ID_CATEGORIA) REFERENCES CATEGORIA (ID_CATEGORIA);

ALTER TABLE PEDIDO ADD CONSTRAINT FK_PEDIDO_USUARIO FOREIGN KEY (USUARIO_ID_USUARIO) REFERENCES USUARIO (ID_USUARIO);

ALTER TABLE DETALLE_PEDIDO ADD CONSTRAINT FK_DETALLE_PEDIDO_PEDIDO FOREIGN KEY (PEDIDO_ID_PEDIDO) REFERENCES PEDIDO (ID_PEDIDO);

ALTER TABLE DETALLE_PEDIDO ADD CONSTRAINT FK_DETALLE_PEDIDO_PRODUCTO FOREIGN KEY (PRODUCTO_ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO);

ALTER TABLE LISTA_DESEOS ADD CONSTRAINT FK_LISTA_DESEOS_PRODUCTO FOREIGN KEY (PRODUCTO_ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO);

ALTER TABLE LISTA_DESEOS ADD CONSTRAINT FK_LISTA_DESEOS_USUARIO FOREIGN KEY (USUARIO_ID_USUARIO) REFERENCES USUARIO (ID_USUARIO);

ALTER TABLE VALORACION ADD CONSTRAINT FK_VALORACION_PRODUCTO FOREIGN KEY (PRODUCTO_ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO);

ALTER TABLE VALORACION ADD CONSTRAINT FK_VALORACION_USUARIO FOREIGN KEY (USUARIO_ID_USUARIO) REFERENCES USUARIO (ID_USUARIO);

-- Creamos el usuario con su contraseña y le otorgamos todos los permisos sobre la BD
CREATE USER 'VIDEOGELVES'@'localhost' IDENTIFIED BY 'Aabc123.';
GRANT ALL PRIVILEGES ON VIDEOGELVES.* TO 'VIDEOGELVES'@'localhost' WITH GRANT OPTION;;
