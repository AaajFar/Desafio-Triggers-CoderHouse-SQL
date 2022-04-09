-- Creacion de Schema y tablas

DROP SCHEMA IF EXISTS fabrica_guitarras;
CREATE SCHEMA IF NOT EXISTS fabrica_guitarras;
USE fabrica_guitarras;

CREATE TABLE IF NOT EXISTS proveedores
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(60) NOT NULL,
direccion VARCHAR(100) NOT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
);

CREATE TABLE IF NOT EXISTS materiales
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('clavijas', 'microfonos', 'maderas', 'cuerdas') NOT NULL,
marca VARCHAR(60) DEFAULT NULL,
modelo VARCHAR(60) NOT NULL,
descripcion VARCHAR(100),
stock INT NOT NULL,
costo INT NOT NULL
);

CREATE TABLE IF NOT EXISTS proveedores_materiales
(
mat_id INT NOT NULL,
prov_id INT NOT NULL,
PRIMARY KEY(mat_id, prov_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id),
FOREIGN KEY (prov_id) REFERENCES fabrica_guitarras.proveedores(id)
);

CREATE TABLE IF NOT EXISTS guitarras
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('electrica', 'clasica', 'electroacustica', 'clasica nino', 'clasica concierto') NOT NULL,
modelo VARCHAR(60) NOT NULL,
ano YEAR NOT NULL,
stock INT NOT NULL,
precio INT NOT NULL
);

CREATE TABLE IF NOT EXISTS materiales_guitarras
(
mat_id INT NOT NULL,
guit_id INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (mat_id, guit_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id),
FOREIGN KEY (guit_id) REFERENCES fabrica_guitarras.guitarras(id)
);

CREATE TABLE IF NOT EXISTS clientes
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL,
direccion VARCHAR(200) DEFAULT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
);

CREATE TABLE IF NOT EXISTS direcciones_envio
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente INT NOT NULL,
direccion VARCHAR(200) NOT NULL,
localidad VARCHAR(60) NOT NULL,
provincia VARCHAR(30) NOT NULL,
FOREIGN KEY (cliente) REFERENCES fabrica_guitarras.clientes(id)
);

CREATE TABLE IF NOT EXISTS fabrica_guitarras.pedidos
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente INT NOT NULL,
guit INT NOT NULL,
cantidad INT NOT NULL,
precio INT NOT NULL,
fecha DATE NOT NULL,
dir_envio INT NOT NULL,
FOREIGN KEY (cliente) REFERENCES fabrica_guitarras.clientes(id),
FOREIGN KEY (guit) REFERENCES fabrica_guitarras.guitarras(id),
FOREIGN KEY (dir_envio) REFERENCES fabrica_guitarras.direcciones_envio(id)
);

-- Insercion de datos

USE fabrica_guitarras;

INSERT INTO proveedores VALUES
(NULL, 'Music Shop', 'Guatemala 2044, CABA', '48722685', 'musicshop@gmail.com'),
(NULL, 'Fender Accesorios', 'Solis 3052, CABA', '49552828', 'fenderacc@gmail.com'),
(NULL, 'Gibson Music', 'Av Nazca 3155, CABA', '45883371', 'gibsonint@gmail.com'),
(NULL, 'Yamaha Accesorios', 'Callao 1233, CABA', '46418892', 'yamahaarg@gmail.com'),
(NULL, 'Gotoh International', 'Lavalle 4882, CABA', '49123355', 'gotohinternacional@gmail.com'),
(NULL, 'Maderas del sur', 'Hipolito Irigoyen 2255, Lanus GBA', '47229822', 'maderasdelsur@info.com.ar'),
(NULL, 'Gutierrez Maderas', 'Av J B Alberdi 5244, CABA', '43228789', DEFAULT),
(NULL, 'Maderera Tres Hermanos', 'Av Alvarez Jonte 2573, CABA', '45838877', 'treshermanosmaderera@hotmail.com'),
(NULL, 'Maderera El Carpintero', 'Av San Martin 2188, CABA', '49928633', DEFAULT),
(NULL, 'Devoto Maderas', 'Av Francisco Beiro 4122, CABA', '46228899', 'devotomaderas@gmail.com');

INSERT INTO materiales VALUES
(NULL, 'clavijas', 'MXP', 'MX218 A', 'Set x6 para clasica', '300', '1000'),
(NULL, 'clavijas', 'Shimura', '214n', 'Set x6 para clasica', '200','1200'),
(NULL, 'clavijas', 'Shimura', '218A', 'Set x6 para clasica', '170','1300'),
(NULL, 'clavijas', 'Fender', '099-0818-000', 'Set x6 para electrica', '300','2000'),
(NULL, 'clavijas', 'Fender', '0990820100', 'Set x6 para electrica', '285','2500'),
(NULL, 'clavijas', 'Gibson', 'PMMH-025 GOLD', 'Set x6 para electrica', '120','2000'),
(NULL, 'clavijas', 'Gibson', 'PMMH-030 BLACK', 'Set x6 para electrica', '150','2500'),
(NULL, 'clavijas', 'Yamaha', 'TM 30', 'Set x6 para electrica o acustica', '400','1500'),
(NULL, 'clavijas', 'Gotoh', '1503b-z', 'Set x6 para electrica', '235','2000'),
(NULL, 'clavijas', 'Gotoh', '1502c', 'Set x6 para electrica', '345','2500'),
(NULL, 'clavijas', 'Gotoh', '1513c', 'Set x6 para electrica', '120','3000'),
(NULL, 'microfonos', 'DS Pickups', 'DS10-N-M-B', 'Set x3 para electrica', '200','4000'),
(NULL, 'microfonos', 'DS Pickups', 'DS10-N-M-B', 'Set x3 para electrica', '145','4500'),
(NULL, 'microfonos', 'Fender', 'Tex Mex', 'Set x3 para electrica', '280','5000'),
(NULL, 'microfonos', 'Fender', 'Vintage Noiseless', 'Set x3 para electrica', '150','6000'),
(NULL, 'microfonos', 'Dimarzio', 'Rainmaker Dreamcatcher', 'Set x2 para electrica', '320','5500'),
(NULL, 'microfonos', 'Dimarzio', 'DP227 DP228', 'Set x2 para electrica', '252','5500'),
(NULL, 'microfonos', 'Fishman', 'Blend 301', 'Para guitarra acustica', '520','2000'),
(NULL, 'microfonos', 'Cherub', 'GS3', 'Para guitarra acustica', '100','2500'),
(NULL, 'microfonos', 'Dimarzio', 'Dp136', 'Para guitarra acustica', '80','3500'),
(NULL, 'cuerdas', 'D addario', 'ez900', 'Set x6 para acustica .010', '200','1000'),
(NULL, 'cuerdas', 'Ernie Ball', 'Super Slinky', 'Set x6 para electrica .009', '155','1200'),
(NULL, 'cuerdas', 'Fender', '150R', 'Set x6 para electrica .010', '322','1100'),
(NULL, 'cuerdas', 'Fender', '150L', 'Set x6 para electrica .009', '255','1200'),
(NULL, 'cuerdas', 'Gibson', 'sag-mb11', 'Set x6 para acustica .011', '120','1250'),
(NULL, 'cuerdas', 'Gibson', 'seg-700l', 'Set x6 para electrica .010', '522','1350'),
(NULL, 'cuerdas', 'D addario', 'EJ-30', 'Set x6 para clasica', '800','1000'),
(NULL, 'cuerdas', 'Cantata', '630', 'Set x6 para clasica', '677','800'),
(NULL, 'maderas', NULL, 'Alamo', 'Para guitarra electrica', '200','2000'),
(NULL, 'maderas', NULL, 'Ebano', 'Para guitarra electrica', '150','3000'),
(NULL, 'maderas', NULL, 'Pino Abeto', 'Para guitarra clasica', '100','1500'),
(NULL, 'maderas', NULL, 'Cedro Español', 'Para guitarra clasica', '250','4000'),
(NULL, 'maderas', NULL, 'Caoba', 'Para guitarra clasica', '92','5000'),
(NULL, 'maderas', NULL, 'Palorosa', 'Para guitarra electrica', '177','5000'),
(NULL, 'maderas', NULL, 'Arce', 'Para guitarra clasica', '389','4500'),
(NULL, 'maderas', NULL, 'Fresno', 'Para guitarra acustica', '155','3500'),
(NULL, 'maderas', NULL, 'Wengue', 'Para guitarra acustica', '255','5000');

INSERT INTO proveedores_materiales VALUES
('1','1'),
('2','1'),
('3','1'),
('4','2'),
('5','2'),
('6','3'),
('7','3'),
('8','4'),
('9','5'),
('10','5'),
('11','5'),
('12','1'),
('13','1'),
('14','2'),
('15','2'),
('16','1'),
('17','1'),
('18','3'),
('19','2'),
('20','1'),
('21','1'),
('22','1'),
('23','2'),
('24','2'),
('25','3'),
('26','3'),
('27','1'),
('28','5'),
('29','6'),
('30','8'),
('31','7'),
('32','10'),
('33','8'),
('34','9'),
('35','7'),
('36','8'),
('37','10');

INSERT INTO guitarras VALUES
(NULL,'Electrica','Stratocaster','2020','120','45000'),
(NULL,'Electrica','Stratocaster','2021','300', '50000'),
(NULL,'Electrica','Les Paul','2019','155','60000'),
(NULL,'Electrica','335','2020','250','60000'),
(NULL,'Electrica','Stratocaster','2018','88','70000'),
(NULL,'Electrica','Stratocaster','2019','120','80000'),
(NULL,'Electroacustica','345','2020','300','35000'),
(NULL,'Electroacustica','CD80','2019','192','40000'),
(NULL,'Electroacustica','CE400','2021','400','30000'),
(NULL,'Electroacustica','CD90','2021','250','60000'),
(NULL,'Clasica','C40','2020','250','25000'),
(NULL,'Clasica','C50','2020','208','30000'),
(NULL,'Clasica','C60','2021','365','40000'),
(NULL,'Clasica','M5','2020','112','60000'),
(NULL,'Clasica','M6','2019','55','75000'),
(NULL,'Clasica','C60LR','2022','488','45000'),
(NULL,'Clasica Nino','C40M','2020','452','20000'),
(NULL,'Clasica Nino','C50M','2020','266','30000'),
(NULL,'Clasica Concierto','C100','2016','40','100000'),
(NULL,'Clasica Concierto','C102','2018','62','120000');

INSERT INTO materiales_guitarras VALUES
('4','1','1'),
('12','1','1'),
('24','1','1'),
('29','1','1'),
('5','2','1'),
('13','2','1'),
('23','2','1'),
('29','2','1'),
('6','3','1'),
('17','3','1'),
('26','3','1'),
('30','3','1'),
('7','4','1'),
('16','4','1'),
('26','4','1'),
('30','4','1'),
('9','5','1'),
('14','5','1'),
('22','5','1'),
('34','5','1'),
('11','6','1'),
('15','6','1'),
('22','6','1'),
('34','6','1'),
('8','7','1'),
('18','7','1'),
('21','7','1'),
('36','7','1'),
('8','8','1'),
('19','8','1'),
('25','8','1'),
('36','8','1'),
('8','9','1'),
('18','9','1'),
('21','9','1'),
('36','9','1'),
('8','10','1'),
('20','10','1'),
('25','10','1'),
('37','10','1'),
('1','11','1'),
('28','11','1'),
('31','11','1'),
('1','12','1'),
('28','12','1'),
('31','12','1'),
('1','13','1'),
('28','13','1'),
('35','13','1'),
('2','14','1'),
('27','14','1'),
('32','14','1'),
('3','15','1'),
('27','15','1'),
('33','15','1'),
('3','16','1'),
('28','16','1'),
('35','16','1'),
('1','17','1'),
('28','17','1'),
('31','17','1'),
('2','18','1'),
('28','18','1'),
('31','18','1'),
('3','19','1'),
('21','19','1'),
('35','19','1'),
('3','20','1'),
('21','20','1'),
('33','20','1');

INSERT INTO clientes VALUES
(NULL,'Juan','Perez','Boyaca 555, CABA','1152889655','juanperez@gmail.com'),
(NULL,'Jose','Ceballos','Caracas 2155, CABA','1187923355','joseceballos@mail.com'),
(NULL,'Carla','Farias','Av Segurola 2322 1°B, CABA','1155224855','carlafarias@gmail.com'),
(NULL,'Carolina','Gomez','Av Hipolito Yirigoyen 522, Lanus, GBA','1166128799','gomezcarolina33@gmail.com'),
(NULL,'Norberto','Carrizo','Av Mitre 2251 5°A, Avellaneda, GBA','1165442525','carrizonorberto@mail.com'),
(NULL,'Paula','Carrasco','Av Nazca 859, CABA','1144558484','carrascop@gmail.com'),
(NULL,'Jorge','Gonzalez','Serrano 755, CABA','1154883255', DEFAULT),
(NULL,'Jonathan','Garcia','Av Libertador 5233 11°C, CABA','1154552300','garciajonathan11@gmail.com'),
(NULL,'Cinthia','Morales','Av Callao 202, CABA','1189655145', DEFAULT),
(NULL,'Debora','Caruso','Carlos Calvo 3255 4°A, CABA','1144887784','deboracar@gmail.com');

INSERT INTO direcciones_envio VALUES
(NULL,'1','Av Eva Peron 2155','CABA','Buenos Aires'),
(NULL,'1','Av 25 de Mayo 522','San Rafael','Mendoza'),
(NULL,'2','Av Jujuy 5221','Resistencia','Chaco'),
(NULL,'2','Av 9 de Julio 521','Rosario','Santa Fe'),
(NULL,'2','Carlos Casares 422','Villa Maria','Cordoba'),
(NULL,'3','Gral Cesar Diaz 5524','CABA','Buenos Aires'),
(NULL,'4','Ceballos 252','Lujan','Buenos Aires'),
(NULL,'4','Quitana 5050','Moreno','Buenos Aires'),
(NULL,'5','Bufano 722','CABA','Buenos Aires'),
(NULL,'5','Peru 2666','Salta','Salta'),
(NULL,'5','Av del Campo 526','Rosario','Santa Fe'),
(NULL,'6','Lima 888','CABA','Buenos Aires');

INSERT INTO pedidos VALUES
(NULL,'1','2','10','500000','2022/01/22','2'),
(NULL,'5','3','5','300000','2022/01/25','10'),
(NULL,'5','13','20','800000','2022/01/25','10'),
(NULL,'4','5','40','3200000','2022/01/30','8'),
(NULL,'1','17','7','140000','2022/02/05','2'),
(NULL,'3','19','2','200000', '2022/02/15','6'),
(NULL,'4','9','10','300000','2022/02/17','7'),
(NULL,'4','14','5','300000', '2022/02/17','7'),
(NULL,'1','1','8','360000','2022/02/25','1'),
(NULL,'5','4','10','600000','2022/02/26','11'),
(NULL,'5','6','8','640000','2022/02/26','11'),
(NULL,'6','1','20','900000', '2022/03/02','12'),
(NULL,'2','7','15','525000','2022/03/10','4');



-- Creacion de vistas

USE fabrica_guitarras;

# Vista para saber el costo de fabricación de todas las guitarras
CREATE OR REPLACE VIEW costo_guitarras
AS SELECT SUM(mat.costo) costo, guit.id id_guitarra
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id
GROUP BY guit.id;

# Vista para saber el valor total de mis ventas, en que cantidad de pedidos y que cantidad de guitarras
CREATE OR REPLACE VIEW total_ventas
AS SELECT SUM(cantidad) cantidad_guitarras, COUNT(id) cantidad_pedidos, SUM(precio) total
FROM pedidos;

# Vista para obtener los datos solamente de los proveedores del tipo de material "maderas"
CREATE OR REPLACE VIEW proveedores_maderas
AS SELECT prov.nombre, prov.telefono, prov.mail
FROM proveedores prov
INNER JOIN proveedores_materiales pm ON pm.prov_id = prov.id
INNER JOIN materiales mat ON mat.id = pm.mat_id
WHERE mat.tipo = "maderas"
GROUP BY prov.nombre;

# Vista para ver todos los pedidos junto a su valor y direccion de envio
CREATE OR REPLACE VIEW pedidos_clientes
AS SELECT ped.id id_pedido, ped.precio valor, CONCAT (cl.nombre, ' ', cl.apellido) nombre_apellido, dir.direccion direccion_envio, dir.localidad, dir.provincia
FROM pedidos ped
INNER JOIN clientes cl ON ped.cliente = cl.id
INNER JOIN direcciones_envio dir ON ped.dir_envio = dir.id
ORDER BY ped.fecha;

# Vista para saber que materiales necesito para fabricar cada guitarra
CREATE OR REPLACE VIEW material_p_guitarra
AS SELECT guit.id id_guitarra, guit.tipo tipo_guitarra, guit.modelo modelo_guitarra, mat.tipo tipo_material, mat.marca marca_material, mat.modelo modelo_material
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id;

# Vista para saber de que materiales tengo stock bajo junto con los datos del proveedor que lo vende.
CREATE OR REPLACE VIEW stock_bajo_materiales
AS SELECT mat.id id_material, mat.tipo, mat.modelo, mat.stock, prov.nombre, prov.telefono, prov.mail
FROM materiales mat
INNER JOIN proveedores_materiales pm ON mat.id = pm.mat_id
INNER JOIN proveedores prov ON prov.id = pm.prov_id
WHERE mat.stock <= 100;

# Vista para saber de que guitarras tengo stock bajo para fabricar mas
CREATE OR REPLACE VIEW stock_bajo_guitarras
AS SELECT id, tipo, modelo, stock
FROM guitarras
WHERE stock <= 100;

# Vista para saber cual es el promedio de ventas y en que cantidad de pedidos
CREATE OR REPLACE VIEW promedio_ventas
AS SELECT AVG(precio) promedio_venta, COUNT(id) tota_pedidos
FROM pedidos;

-- Creacion de funciones

USE fabrica_guitarras;

# Funcion para calcular el costo de un pedido mediante el id del mismo
DELIMITER $$
CREATE FUNCTION `costo_pedido` (id INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
    SET resultado = (SELECT SUM(mat.costo) * ped.cantidad
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	INNER JOIN pedidos ped ON ped.guit = guit.id
	WHERE ped.id = id);
RETURN resultado;
END
$$
DELIMITER ;


# Funcion para calcular el costo de fabricacion de una guitarra mediante el id de la misma
DELIMITER $$
CREATE FUNCTION `costo_guitarra`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
    SET resultado = (SELECT SUM(mat.costo)
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	WHERE guit.id = id);
RETURN resultado;
END
$$
DELIMITER ;


# Funcion para calcular cuantos pedidos realizo un cliente mediante el id del mismo
DELIMITER $$
CREATE FUNCTION `cantidad_pedidos_clientes`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
	SET resultado = (SELECT COUNT(id)
	FROM pedidos
	WHERE cliente = id);
RETURN resultado;
END
$$
DELIMITER ;


/* Funcion para calcular cuantos dias pasaron desde el ultimo pedido que hizo un cliente
mediante su id */
DELIMITER $$
CREATE FUNCTION `cantidad_dias_ult_pedido`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE fecha1 DATE;
    DECLARE fecha2 DATE;
    DECLARE resultado INT;
	SET fecha1 = (SELECT ped.fecha
	FROM pedidos ped
	WHERE cliente = id
	ORDER BY fecha DESC
	LIMIT 1);
    SET fecha2 = (SELECT CURDATE() FROM DUAL);
    SET resultado = (DATEDIFF(fecha2,fecha1));
RETURN resultado;
END
$$
DELIMITER ;


# Funcion para calcular cantidad de pedidos entre 2 fechas que ingrese el usuario
DELIMITER $$
CREATE FUNCTION `cant_pedidos_por_fecha`(fecha1 DATE, fecha2 DATE) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE resultado INT;
	SET resultado = (SELECT COUNT(id)
	FROM pedidos
	WHERE fecha BETWEEN fecha1 AND fecha2);
RETURN resultado;
END
$$
DELIMITER ;



-- Creacion de Stored Procedure

/* Store Procedure #1: Sirve para ordenar la tabla de guitarras según los parametros que ingresa
el usuario. En total recibe 2 parametros, el primero corresponde a sobre que campo se va a hacer
el orden, el segundo corresponde a la forma en que se va a hacer ese orden (ASC, DESC).
Para poder realizarlo utilicé el condicional CASE para cada caso, de tal forma que cuando se llama
al SP los parametros que espera son de tipo INT, siendo que en el caso del campo son valores
del 1 al 6 y son en el mismo orden que esta la tabla, y en el caso del orden son valores 1 para
ASC y 2 para DESC. Por ejemplo si hicieramos un CALL con parametros 3 y 2 lo ordenaría por 
modelo de forma descendente.
*/

DELIMITER //
CREATE PROCEDURE sp_orden_guitarras (IN campo INT, IN orden INT)
BEGIN
    SELECT * 
    FROM guitarras 
    ORDER BY
    CASE WHEN campo = 1 AND orden = 1 THEN id END,
    CASE WHEN campo = 1 AND orden = 2 THEN id END DESC,
    CASE WHEN campo = 2 AND orden = 1 THEN tipo END,
	CASE WHEN campo = 2 AND orden = 2 THEN tipo END DESC,
	CASE WHEN campo = 3 AND orden = 1 THEN modelo END,
	CASE WHEN campo = 3 AND orden = 2 THEN modelo END DESC,
	CASE WHEN campo = 4 AND orden = 1 THEN ano END,
	CASE WHEN campo = 4 AND orden = 2 THEN ano END DESC,
	CASE WHEN campo = 5 AND orden = 1 THEN stock END,
	CASE WHEN campo = 5 AND orden = 2 THEN stock END DESC,
	CASE WHEN campo = 6 AND orden = 1 THEN precio END,
	CASE WHEN campo = 6 AND orden = 2 THEN precio END DESC;
END
//
DELIMITER ;

-- PRUEBA PARA STORE PROCEDURE #1
/*
CALL sp_orden_guitarras(6,2);
*/




/* Store Procedure #2: Sirve para ingresar nuevos registros a la tabla guitarras
El funcionamiento es muy simple, recibe los mismos parametros que luego usa dentro de la
funcion para hacer el INSERT a la tabla, excepto por el 'id' que en este caso al ser
autoincremental se le pasa el valor NULL
*/

DELIMITER //
CREATE PROCEDURE sp_insertar_guitarra (IN tipo ENUM('electrica', 'clasica', 'electroacustica', 
									'clasica nino', 'clasica concierto'),
									IN modelo VARCHAR(60),
                                    IN ano YEAR,
                                    IN stock INT,
                                    IN precio INT)
BEGIN
	INSERT INTO guitarras VALUES
    (null, tipo, modelo, ano, stock, precio);
END					
//
DELIMITER ; 

-- PRUEBA PARA STORE PROCEDURE #2
/*
CALL sp_insertar_guitarra ('electrica', 'stratocaster', '2022', '500', '60000');
*/



/* Store Procedure #3: Sirve para ingresar nuevos registros a la tabla de relación de 
materiales_guitarras, con un funcionamiento similar al anterior en el cual se le pasa
los mismos parametros para que luego dentro de la funcion se haga el INSERT a la tabla
*/

DELIMITER //
CREATE PROCEDURE sp_insertar_materiales_guitarras (IN materialid INT,
												IN guitarraid INT,
                                                IN cantidad INT)
BEGIN
	INSERT INTO materiales_guitarras VALUES
    (materialid, guitarraid, cantidad);
END					
//
DELIMITER ;

-- PRUEBA PARA STORED PROCEDURE #3
/*
CALL sp_insertar_materiales_guitarras(5, 21, 1);
CALL sp_insertar_materiales_guitarras(15, 21, 1);
CALL sp_insertar_materiales_guitarras(24, 21, 1);
CALL sp_insertar_materiales_guitarras(34, 21, 1);
*/
