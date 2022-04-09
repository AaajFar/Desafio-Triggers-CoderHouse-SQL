USE fabrica_guitarras;

-- Creación de tabla para guardar los movimientos de la tabla pedidos

CREATE TABLE IF NOT EXISTS movimientos_pedidos
(id_mov INT PRIMARY KEY AUTO_INCREMENT,
fecha_mov DATE NOT NULL,
hora_mov TIME NOT NULL,
usuario_mov VARCHAR(50) NOT NULL,
id_ped INT NOT NULL,
cliente_precio VARCHAR(65) NOT NULL
);

/* Trigger #1: Guarda información de fecha y usuario que realizo el movimiento 
y el id, cliente y precio del pedido sobre el cual se realizo 
cuando hacemos un INSERT en la tabla pedidos*/

CREATE TRIGGER `ingreso_nuevo_pedido`
AFTER INSERT ON `pedidos`
FOR EACH ROW
INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente_precio)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, 
		CONCAT('Se ingreso un nuevo pedido del cliente ', NEW.cliente, 
        ' con el precio de ', NEW.precio));

-- PRUEBA PARA TRIGGER #1

/*
INSERT INTO pedidos VALUES
(NULL,'4','5','10','700000', CURDATE(),'8');
*/


/* Trigger #2: Guarda información de fecha y usuario que realizo el movimiento 
y el id, cliente y precio del pedido sobre el cual se realizo 
cuando hacemos un DELETE en la tabla pedidos*/

CREATE TRIGGER `borrar_pedido`
BEFORE DELETE ON `pedidos`
FOR EACH ROW
INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente_precio)
VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, 
		CONCAT('Se borro un pedido del cliente ', OLD.cliente, 
        ' con el precio de ', OLD.precio));


-- PRUEBA PARA TRIGGER #2

/*
DELETE FROM pedidos WHERE id = 10;
*/


-- Creacion de tabla para guardar los movimientos de la tabla materiales

CREATE TABLE IF NOT EXISTS movimientos_materiales
(id_mov INT PRIMARY KEY AUTO_INCREMENT,
fecha_mov DATETIME NOT NULL,
hora_mov TIME NOT NULL,
usuario_mov VARCHAR(50) NOT NULL,
id_mat INT NOT NULL,
tipo_mat ENUM('maderas', 'microfonos', 'clavijas', 'cuerdas') NOT NULL,
costo_mat INT NOT NULL,
costo_viejo INT,
costo_dif VARCHAR(10),
detalle VARCHAR(30)
);


/* Trigger #3: Guarda información de fecha y usuario que realizo el movimiento 
y el id, tipo, costo viejo, costo nuevo y diferencia de costo en % 
del material sobre el cual se realizo cuando hacemos un UPDATE en la tabla materiales*/

CREATE TRIGGER `actualizar_costo_material`
BEFORE UPDATE ON `materiales`
FOR EACH ROW
INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, OLD.tipo, NEW.costo, OLD.costo, 
		CONCAT(ROUND((((NEW.costo - OLD.costo) * 100) / OLD.costo),2), ' %'), 
        'Actualizacion de precio');

-- PRUEBA PARA TRIGGER #3

/*
UPDATE materiales
SET costo = 3000
WHERE id = 4;
*/


/* Trigger #4: Guarda información de fecha y usuario que realizo el movimiento 
y el id, tipo y costo del material sobre el cual se realizo cuando hacemos 
un INSERT en la tabla materiales*/

CREATE TRIGGER `ingresar_material`
AFTER INSERT ON `materiales`
FOR EACH ROW
INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, NEW.tipo, NEW.costo, NULL, NULL, 
		'Ingreso nuevo material');

-- PRUEBA PARA TRIGGER #4

/*
INSERT INTO materiales VALUES
(NULL, 'microfonos', 'Fender', 'Texas Special', 'Set x3 para electrica', '250', '8000');
*/
