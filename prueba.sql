PRUEBA

PARTE 2

CREATE DATABASE prueba;
RETURN => CREATE DATABASE

\c prueba;
RETURN => You are now connected to database "prueba" as user "andres".

CREATE TABLE cliente(
        id SERIAL PRIMARY KEY,
        nombre VARCHAR,
        rut VARCHAR(15),
        direccion VARCHAR
        );

SELECT * FROM cliente; =>  id | nombre | rut | direccion 
                          ----+--------+-----+-----------
                          (0 rows)

CREATE TABLE factura(
        id SERIAL PRIMARY KEY,
        numero_factura INT,
        fecha DATE,
        cliente_id INT REFERENCES cliente(id),
        sub_total INT
        );

SELECT * FROM factura; =>   id | numero_factura | fecha | cliente_id | sub_total 
                           ----+----------------+-------+------------+-----------
                           (0 rows)

CREATE TABLE categoria(
        id SERIAL PRIMARY KEY,
        nombre VARCHAR,
        descripcion VARCHAR
        );

SELECT * FROM categoria; =>  id | nombre | descripcion 
                            ----+--------+-------------
                            (0 rows)

CREATE TABLE producto(
        id SERIAL PRIMARY KEY,
        nombre VARCHAR,
        precio_unitario INT,
        descripcion VARCHAR,
        id_categoria INT REFERENCES categoria(id)
        );

SELECT * FROM producto; =>  id | nombre | precio_unitario | descripcion | id_categoria 
                           ----+--------+-----------------+-------------+--------------
                           (0 rows)

CREATE TABLE producto_factura(
        id_producto INT REFERENCES producto(id),
        cantidad INT,
        id_factura INT REFERENCES factura(id)
        );

SELECT * FROM producto_factura; =>  id_producto | cantidad | id_factura 
                                   -------------+----------+------------
                                  (0 rows)


INSERTANDO DATOS

CLIENTES 5
INSERT INTO cliente (nombre,rut,direccion) VALUES ('Juan','17123456','Martin de zamora 4237');
INSERT INTO cliente (nombre,rut,direccion) VALUES ('Maria','16123456','Alcantara 150');
INSERT INTO cliente (nombre,rut,direccion) VALUES ('Pedro','12345678','Malaga 24');
INSERT INTO cliente (nombre,rut,direccion) VALUES ('Andres','174035962','gertrudis echeñique 71');
INSERT INTO cliente (nombre,rut,direccion) VALUES ('Jose','8123456','Portofino 420');

SELECT * FROM cliente; =>  id | nombre |    rut    |       direccion        
                          ----+--------+-----------+------------------------
                          4 | Andres | 174035962 | gertrudis echeñique 71
                          1 | Juan   | 171234567 | Martin de zamora 4237
                          2 | Maria  | 174567897 | Alcantara 150
                          3 | Pedro  | 164567897 | Malaga 24
                          5 | Jose   | 64567897  | Portofino 420
                          (5 rows)

CATEGORIAS 3

INSERT INTO categoria (nombre,descripcion) VALUES ('Respiratorio','Productos para pacientes respiratorios');
INSERT INTO categoria (nombre,descripcion) VALUES ('Musculoesqueletico','Productos para pacientes con alteraciones musculares');
INSERT INTO categoria (nombre,descripcion) VALUES ('Neurologia','Productos para pacientes con alteraciones neurologicas');

SELECT * FROM categoria; => ----+--------------------+--------------------------------------------------------
                              1 | Respiratorio       | Productos para pacientes respiratorios
                              2 | Musculoesqueletico | Productos para pacientes con alteraciones musculares
                              3 | Neurologia         | Productos para pacientes con alteraciones neurologicas
                             (3 rows)

PRODUCTOS 8

INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Canula',15,'Endocanula traqueal para VMNI',1);
INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Bomba Aspiracion',150,'Bomba aspiracion de secreciones',1);
INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Bandas elasticas',5,'Bandas elasticas con resistencia',2);
INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Mancuerna',25,'Mancuerna 2.5KG',2);
INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Cinturon de marcha',18,'Correa cinturon facilitadores de marcha',3);
INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Martillo reflejo',35,'Martillo evaluacion reflejos',3);
INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Sonda aspiracion',4,'Sonda de aspiracion calibre 4',1);
INSERT INTO producto (nombre,precio_unitario,descripcion,id_categoria) VALUES ('Pesa',20,'Pesa 5KG',2);

SELECT * FROM producto; =>  id |       nombre       | precio_unitario |               descripcion               | id_categoria 
                           ----+--------------------+-----------------+-----------------------------------------+--------------
                             1 | Canula             |              15 | Endocanula traqueal para VMNI           |            1
                             2 | Bomba Aspiracion   |             150 | Bomba aspiracion de secreciones         |            1
                             3 | Bandas elasticas   |               5 | Bandas elasticas con resistencia        |            2
                             4 | Mancuerna          |              25 | Mancuerna 2.5KG                         |            2
                             5 | Cinturon de marcha |              18 | Correa cinturon facilitadores de marcha |            3
                             6 | Martillo reflejo   |              35 | Martillo evaluacion reflejos            |            3
                             7 | Sonda aspiracion   |               4 | Sonda de aspiracion calibre 4           |            1
                             8 | Pesa               |              20 | Pesa 5KG                                |            2
                             (8 rows)

FACTURAS 10

CLIENTE 1

2 FACTURAS
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (1,'15/07/2020',1,10);
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (2,'15/07/2020',1,49);

PRODCUTOS FACTURA 1 (2 productos)
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (3,2,1);

PRODCUTOS FACTURA 2 (3 productos)
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (4,1,2);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (8,1,2);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (7,1,2);

SELECT * FROM factura; =>   id | numero_factura |   fecha    | cliente_id | sub_total 
                           ----+----------------+------------+------------+-----------
                             1 |              1 | 2020-07-15 |          1 |        10
                             2 |              2 | 2020-07-15 |          1 |        49
                             (2 rows)

SELECT * FROM producto_factura; =>  id_producto | cantidad | id_factura 
                                   -------------+----------+------------
                                              3 |        2 |          1
                                              4 |        1 |          2
                                              8 |        1 |          2
                                              7 |        1 |          2
                                    (3 rows)

CLIENTE 2

3 FACTURAS 
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (3,'16/06/2020',2,180);
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (4,'16/06/2020',2,165);
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (5,'08/07/2020',2,170);

PRODCUTOS FACTURA 3 (3 productos)
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (1,2,3);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (2,1,3);

PRODCUTOS FACTURA 4 (2 productos)
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (1,1,4);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (2,1,4);

PRODCUTOS FACTURA 5 (3 productos)
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (1,1,5);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (2,1,5);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (3,1,5);

SELECT * FROM factura; =>   id | numero_factura |   fecha    | cliente_id | sub_total 
                           ----+----------------+------------+------------+-----------
                             1 |              1 | 2020-07-15 |          1 |        10
                             2 |              2 | 2020-07-15 |          1 |        49
                             3 |              3 | 2020-06-16 |          2 |       180
                             4 |              4 | 2020-06-16 |          2 |       165
                             5 |              5 | 2020-07-08 |          2 |       170
                            (5 rows)

SELECT * FROM producto_factura; =>  id_producto | cantidad | id_factura 
                                   -------------+----------+------------
                                              3 |        2 |          1
                                              4 |        1 |          2
                                              8 |        1 |          2
                                              1 |        2 |          3
                                              2 |        1 |          3
                                              1 |        1 |          4
                                              2 |        1 |          4
                                              7 |        1 |          2
                                              1 |        1 |          5
                                              2 |        1 |          5
                                              3 |        1 |          5
                                    (11 rows)

CLIENTE 3

1 FACTURA 

INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (6,'27/07/2020',3,150);

PRODUCTO FACTURA 6 (1 producto)

INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (2,1,6);

SELECT * FROM factura; =>  id | numero_factura |   fecha    | cliente_id | sub_total 
                           ----+----------------+------------+------------+-----------
                             1 |              1 | 2020-07-15 |          1 |        10
                             2 |              2 | 2020-07-15 |          1 |        49
                             3 |              3 | 2020-06-16 |          2 |       180
                             4 |              4 | 2020-06-16 |          2 |       165
                             5 |              5 | 2020-07-08 |          2 |       170
                             6 |              6 | 2020-07-27 |          3 |       150
                            (6 rows)

SELECT * FROM producto_factura; =>  id_producto | cantidad | id_factura 
                                   -------------+----------+------------
                                              3 |        2 |          1
                                              4 |        1 |          2
                                              8 |        1 |          2
                                              1 |        2 |          3
                                              2 |        1 |          3
                                              1 |        1 |          4
                                              2 |        1 |          4
                                              7 |        1 |          2
                                              1 |        1 |          5
                                              2 |        1 |          5
                                              3 |        1 |          5
                                              2 |        1 |          6
                                    (12 rows)


CLIENTE 4

4 FACTURAS 

INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (7,'01/06/2020',4,154);
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (8,'15/06/2020',4,23);
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (9,'29/06/2020',4,49);
INSERT INTO factura (numero_factura,fecha,cliente_id,sub_total) VALUES (10,'10/07/2020',4,150);

PRODCUTOS FACTURA 7 (2 productos)

INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (2,1,7);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (7,1,7);

PRODCUTOS FACTURA 8 (3 productos)

INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (7,2,8);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (1,1,8);

PRODCUTOS FACTURA 9 (4 productos)

INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (1,1,9);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (7,1,9);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (3,1,9);
INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (4,1,9);


PRODCUTOS FACTURA 10 (1 producto)

INSERT INTO producto_factura (id_producto,cantidad,id_factura) VALUES (2,1,10);


SELECT * FROM factura; =>   id | numero_factura |   fecha    | cliente_id | sub_total 
                           ----+----------------+------------+------------+-----------
                             1 |              1 | 2020-07-15 |          1 |        10
                             2 |              2 | 2020-07-15 |          1 |        49
                             3 |              3 | 2020-06-16 |          2 |       180
                             4 |              4 | 2020-06-16 |          2 |       165
                             5 |              5 | 2020-07-08 |          2 |       170
                             6 |              6 | 2020-07-27 |          3 |       150
                             7 |              7 | 2020-06-01 |          4 |       154
                             8 |              8 | 2020-06-15 |          4 |        23
                             9 |              9 | 2020-06-29 |          4 |        49
                            10 |             10 | 2020-07-10 |          4 |       150
                            (10 rows)

SELECT * FROM producto_factura; =>  id_producto | cantidad | id_factura 
                           -------------+----------+------------
                                      3 |        2 |          1
                                      4 |        1 |          2
                                      8 |        1 |          2
                                      1 |        2 |          3
                                      2 |        1 |          3
                                      1 |        1 |          4
                                      2 |        1 |          4
                                      7 |        1 |          2
                                      1 |        1 |          5
                                      2 |        1 |          5
                                      3 |        1 |          5
                                      2 |        1 |          6
                                      2 |        1 |          7
                                      7 |        1 |          7
                                      7 |        2 |          8
                                      1 |        1 |          8
                                      1 |        1 |          9
                                      7 |        1 |          9
                                      3 |        1 |          9
                                      4 |        1 |          9
                                      2 |        1 |         10
                            (21 rows)


PARTE 3

CONSULTA 1

SELECT factura.cliente_id, MAX(factura.sub_total) FROM factura GROUP BY factura.cliente_id,factura.sub_total ORDER BY factura.sub_total DESC LIMIT 1;
RETURN =>  cliente_id | max 
          ------------+-----
                    2 | 180
          (1 row)

Consulta 2

SELECT id, cliente_id FROM factura WHERE sub_total > 100;

RETURN =>  id | cliente_id 
          ----+------------
            3 |          2
            4 |          2
            5 |          2
            6 |          3
            7 |          4
           10 |          4
           (6 rows)

Consulta 3

SELECT factura.cliente_id, producto_factura.id_producto FROM factura INNER JOIN producto_factura ON factura.id=producto_factura.id_factura WHERE id_producto=6;

RETURN  cliente_id | id_producto 
       ------------+-------------
       (0 rows)