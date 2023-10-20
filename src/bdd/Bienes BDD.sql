-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.28-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para bienes_system
CREATE DATABASE IF NOT EXISTS `bienes_system` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `bienes_system`;

-- Volcando estructura para tabla bienes_system.asignaciones
CREATE TABLE IF NOT EXISTS `asignaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trabajadores_id` int(11) NOT NULL,
  `solicitud_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_Asignaciones_Trabajador1_idx` (`trabajadores_id`) USING BTREE,
  KEY `fk_Asignaciones_Bienes1_idx` (`solicitud_id`) USING BTREE,
  CONSTRAINT `fk_Asignaciones_Solicitudes` FOREIGN KEY (`solicitud_id`) REFERENCES `solicitudes` (`id`),
  CONSTRAINT `fk_Asignaciones_Trabajador1` FOREIGN KEY (`trabajadores_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.asignaciones: ~1 rows (aproximadamente)
INSERT IGNORE INTO `asignaciones` (`id`, `trabajadores_id`, `solicitud_id`) VALUES
	(1, 3, 21);

-- Volcando estructura para tabla bienes_system.bienes
CREATE TABLE IF NOT EXISTS `bienes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `estados_bien_id` int(11) NOT NULL,
  `trabajadores_id` int(11) DEFAULT NULL,
  `categorias_id` int(11) DEFAULT NULL,
  `sedes_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `fk_Bienes_Estados_bien1_idx` (`estados_bien_id`) USING BTREE,
  KEY `fk_Bienes_Trabajador1_idx` (`trabajadores_id`) USING BTREE,
  KEY `FK_bienes_categorias` (`categorias_id`),
  KEY `FK_bienes_sedes` (`sedes_id`),
  CONSTRAINT `FK_bienes_categorias` FOREIGN KEY (`categorias_id`) REFERENCES `categorias` (`id`),
  CONSTRAINT `FK_bienes_sedes` FOREIGN KEY (`sedes_id`) REFERENCES `sedes` (`id`),
  CONSTRAINT `fk_Bienes_Estados_bien1` FOREIGN KEY (`estados_bien_id`) REFERENCES `estados_bien` (`id`),
  CONSTRAINT `fk_Bienes_Trabajador1` FOREIGN KEY (`trabajadores_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.bienes: ~4 rows (aproximadamente)
INSERT IGNORE INTO `bienes` (`id`, `codigo`, `nombre`, `fecha_ingreso`, `estados_bien_id`, `trabajadores_id`, `categorias_id`, `sedes_id`) VALUES
	(5, 'C2-PC GAMER-1697592375490', 'PC GAMER', '2023-10-01', 1, NULL, 2, 2),
	(6, 'C2-LAPTOP HP-1697592400249', 'Laptop HP', '2023-07-06', 1, NULL, 2, 1),
	(7, 'C1-AIRE ACONDICIONADO HUAWEI-1697726377426', 'Aire acondicionado Huawei', '2021-06-11', 1, 2, 1, 1),
	(8, 'C3-ESCRITORIO-1697730116134', 'Escritorio', '2023-10-10', 1, 3, 3, 2);

-- Volcando estructura para tabla bienes_system.bienes_has_solicitudes
CREATE TABLE IF NOT EXISTS `bienes_has_solicitudes` (
  `bienes_id` int(11) NOT NULL,
  `solicitudes_id` int(11) NOT NULL,
  PRIMARY KEY (`bienes_id`,`solicitudes_id`) USING BTREE,
  KEY `fk_Bienes_has_Solicitudes_Solicitudes1_idx` (`solicitudes_id`) USING BTREE,
  KEY `fk_Bienes_has_Solicitudes_Bienes1_idx` (`bienes_id`) USING BTREE,
  CONSTRAINT `fk_Bienes_has_Solicitudes_Bienes1` FOREIGN KEY (`bienes_id`) REFERENCES `bienes` (`id`),
  CONSTRAINT `fk_Bienes_has_Solicitudes_Solicitudes1` FOREIGN KEY (`solicitudes_id`) REFERENCES `solicitudes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.bienes_has_solicitudes: ~15 rows (aproximadamente)
INSERT IGNORE INTO `bienes_has_solicitudes` (`bienes_id`, `solicitudes_id`) VALUES
	(5, 8),
	(5, 9),
	(5, 11),
	(5, 12),
	(5, 13),
	(5, 14),
	(5, 15),
	(5, 17),
	(5, 18),
	(5, 19),
	(5, 21),
	(6, 8),
	(6, 9),
	(6, 12),
	(6, 16),
	(6, 20);

-- Volcando estructura para tabla bienes_system.cargos
CREATE TABLE IF NOT EXISTS `cargos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `nombreCargo_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.cargos: ~5 rows (aproximadamente)
INSERT IGNORE INTO `cargos` (`id`, `nombre`) VALUES
	(1, 'Asegurador'),
	(5, 'Director'),
	(2, 'Gerente'),
	(3, 'Jurista'),
	(4, 'Publicista');

-- Volcando estructura para tabla bienes_system.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.categorias: ~4 rows (aproximadamente)
INSERT IGNORE INTO `categorias` (`id`, `nombre`) VALUES
	(1, 'Electrónica'),
	(2, 'Informática'),
	(3, 'Inmueble');

-- Volcando estructura para tabla bienes_system.departamentos
CREATE TABLE IF NOT EXISTS `departamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `sedes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`sedes_id`) USING BTREE,
  UNIQUE KEY `nombreDepartamento_UNIQUE` (`nombre`) USING BTREE,
  KEY `fk_Departamentos_Sedes1_idx` (`sedes_id`) USING BTREE,
  CONSTRAINT `fk_Departamentos_Sedes1` FOREIGN KEY (`sedes_id`) REFERENCES `sedes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.departamentos: ~2 rows (aproximadamente)
INSERT IGNORE INTO `departamentos` (`id`, `nombre`, `sedes_id`) VALUES
	(1, 'Cobranzas', 1),
	(2, 'Compras', 2);

-- Volcando estructura para tabla bienes_system.estados_bien
CREATE TABLE IF NOT EXISTS `estados_bien` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `estado_UNIQUE` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.estados_bien: ~4 rows (aproximadamente)
INSERT IGNORE INTO `estados_bien` (`id`, `estado`) VALUES
	(1, 'Activo'),
	(2, 'En Reparación'),
	(4, 'Inactivo'),
	(3, 'Solicitado');

-- Volcando estructura para tabla bienes_system.estados_solicitud
CREATE TABLE IF NOT EXISTS `estados_solicitud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `estado_UNIQUE` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.estados_solicitud: ~3 rows (aproximadamente)
INSERT IGNORE INTO `estados_solicitud` (`id`, `estado`) VALUES
	(3, 'Aceptado'),
	(1, 'En espera'),
	(2, 'Rechazado');

-- Volcando estructura para tabla bienes_system.gerencias
CREATE TABLE IF NOT EXISTS `gerencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `departamentos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `nombreGerencia_UNIQUE` (`nombre`) USING BTREE,
  KEY `fk_Gerencias_Departamentos1_idx` (`departamentos_id`) USING BTREE,
  CONSTRAINT `fk_Gerencias_Departamentos1` FOREIGN KEY (`departamentos_id`) REFERENCES `departamentos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.gerencias: ~4 rows (aproximadamente)
INSERT IGNORE INTO `gerencias` (`id`, `nombre`, `departamentos_id`) VALUES
	(1, 'Abastecimiento', 2),
	(2, 'Logística', 2),
	(3, 'Fraude', 1),
	(4, 'Recuperación', 1);

-- Volcando estructura para tabla bienes_system.reparaciones
CREATE TABLE IF NOT EXISTS `reparaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motivo` text NOT NULL,
  `estado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.reparaciones: ~2 rows (aproximadamente)
INSERT IGNORE INTO `reparaciones` (`id`, `motivo`, `estado`) VALUES
	(1, 'Desgate normal', 0),
	(2, 'Daños o averías', 0),
	(3, 'Desgate normal', 0);

-- Volcando estructura para tabla bienes_system.sedes
CREATE TABLE IF NOT EXISTS `sedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.sedes: ~2 rows (aproximadamente)
INSERT IGNORE INTO `sedes` (`id`, `nombre`, `direccion`) VALUES
	(1, 'El Paraiso', 'Edf. La Mata, El paraiso'),
	(2, 'Capitolio', 'Edf. El Naranjal, Capitolio');

-- Volcando estructura para tabla bienes_system.solicitudes
CREATE TABLE IF NOT EXISTS `solicitudes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_solicitud` varchar(45) NOT NULL,
  `fecha_solicitud` datetime NOT NULL DEFAULT current_timestamp(),
  `estados_solicitud_id` int(11) NOT NULL,
  `trabajadores_id` int(11) NOT NULL,
  `gerencias_id` int(11) NOT NULL,
  `solicitudes_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `codigoSolicitud_UNIQUE` (`codigo_solicitud`) USING BTREE,
  KEY `fk_Solicitudes_Estados_Solicitud1_idx` (`estados_solicitud_id`) USING BTREE,
  KEY `fk_Solicitudes_Gerencias1_idx` (`gerencias_id`) USING BTREE,
  KEY `fk_Solicitudes_Solicitud_tipo1_idx` (`solicitudes_tipo`) USING BTREE,
  KEY `fk_Solicitudes_Trabajador1_idx` (`trabajadores_id`) USING BTREE,
  CONSTRAINT `fk_Solicitudes_Estados_Solicitud1` FOREIGN KEY (`estados_solicitud_id`) REFERENCES `estados_solicitud` (`id`),
  CONSTRAINT `fk_Solicitudes_Gerencias1` FOREIGN KEY (`gerencias_id`) REFERENCES `gerencias` (`id`),
  CONSTRAINT `fk_Solicitudes_Solicitud_tipo1` FOREIGN KEY (`solicitudes_tipo`) REFERENCES `solicitud_tipo` (`id`),
  CONSTRAINT `fk_Solicitudes_Trabajador1` FOREIGN KEY (`trabajadores_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.solicitudes: ~13 rows (aproximadamente)
INSERT IGNORE INTO `solicitudes` (`id`, `codigo_solicitud`, `fecha_solicitud`, `estados_solicitud_id`, `trabajadores_id`, `gerencias_id`, `solicitudes_tipo`) VALUES
	(8, '32e7252e-f643-4d8f-854c-adfb66a8c114', '2023-10-17 21:47:53', 1, 1, 2, 2),
	(9, 'cc1763d8-ee4b-4cbf-8ceb-a416924b5a40', '2023-10-17 21:48:52', 1, 1, 2, 2),
	(10, '89181385-0971-48d8-b7d7-5172a6f21878', '2023-10-17 21:56:53', 1, 1, 2, 2),
	(11, '2b5a9a28-6931-4ba8-abc5-9831b6a1f8d3', '2023-10-17 22:02:29', 1, 1, 2, 2),
	(12, '9ff335c7-5356-4b21-8d7e-56962524c1c1', '2023-10-18 10:58:15', 1, 1, 2, 2),
	(13, 'ed41d9b9-9254-4363-b94a-92500002a382', '2023-10-18 12:54:54', 1, 1, 2, 3),
	(14, '10e6b80e-8c83-4279-ad8a-0553c302cadc', '2023-10-18 12:57:35', 1, 1, 2, 3),
	(15, '4c9c98ba-75a2-426e-ad16-3e924425cccf', '2023-10-18 12:59:54', 1, 1, 2, 3),
	(16, 'dc5d7771-ae4e-41a5-bbc4-522603391282', '2023-10-18 13:01:44', 1, 1, 2, 3),
	(17, '7dffbc41-268e-4d40-8c3d-76ebe9088860', '2023-10-18 13:03:00', 1, 1, 2, 3),
	(18, '7a5fee0b-e93e-4483-9fad-b17b8c354779', '2023-10-19 10:38:35', 1, 4, 3, 3),
	(19, '6a8374f4-7553-4694-a6da-3d981be92a47', '2023-10-19 11:25:13', 1, 4, 3, 1),
	(20, '23517f32-b6a2-4f5f-843c-54f5fde3e715', '2023-10-19 11:25:55', 1, 4, 3, 1),
	(21, '23c56c88-a77d-4c41-b0ff-c3c04c6c64da', '2023-10-19 11:27:07', 1, 4, 3, 1);

-- Volcando estructura para tabla bienes_system.solicitud_tipo
CREATE TABLE IF NOT EXISTS `solicitud_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `tipo_UNIQUE` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.solicitud_tipo: ~3 rows (aproximadamente)
INSERT IGNORE INTO `solicitud_tipo` (`id`, `tipo`) VALUES
	(1, 'Asignacion'),
	(3, 'Reparacion'),
	(2, 'Traslado');

-- Volcando estructura para tabla bienes_system.trabajadores
CREATE TABLE IF NOT EXISTS `trabajadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `cargos_id` int(11) NOT NULL,
  `gerencias_id` int(11) NOT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`,`cargos_id`,`gerencias_id`) USING BTREE,
  KEY `fk_Trabajador_Cargos1_idx` (`cargos_id`) USING BTREE,
  KEY `fk_Trabajador_Gerencias1_idx` (`gerencias_id`) USING BTREE,
  CONSTRAINT `fk_Trabajador_Cargos1` FOREIGN KEY (`cargos_id`) REFERENCES `cargos` (`id`),
  CONSTRAINT `fk_Trabajador_Gerencias1` FOREIGN KEY (`gerencias_id`) REFERENCES `gerencias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.trabajadores: ~5 rows (aproximadamente)
INSERT IGNORE INTO `trabajadores` (`id`, `nombre`, `cargos_id`, `gerencias_id`, `apellido`) VALUES
	(1, 'Jesus', 1, 2, 'Zapata'),
	(2, 'José', 2, 1, 'Peñate'),
	(3, 'Lara', 5, 1, 'Molaños'),
	(4, 'Pepe', 3, 3, 'Grillo'),
	(5, 'Lara', 2, 4, 'Croft');

-- Volcando estructura para tabla bienes_system.traslados
CREATE TABLE IF NOT EXISTS `traslados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `solicitudes_id` int(11) NOT NULL,
  `sedes_id` int(11) NOT NULL,
  `comprobante` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`sedes_id`) USING BTREE,
  KEY `fk_Traslados_Solicitudes1_idx` (`solicitudes_id`) USING BTREE,
  KEY `fk_Traslados_Sedes1_idx` (`sedes_id`) USING BTREE,
  CONSTRAINT `fk_Traslados_Sedes1` FOREIGN KEY (`sedes_id`) REFERENCES `sedes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Traslados_Solicitudes1` FOREIGN KEY (`solicitudes_id`) REFERENCES `solicitudes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.traslados: ~2 rows (aproximadamente)
INSERT IGNORE INTO `traslados` (`id`, `solicitudes_id`, `sedes_id`, `comprobante`) VALUES
	(1, 9, 1, ''),
	(2, 11, 1, ''),
	(3, 12, 2, '');

-- Volcando estructura para tabla bienes_system.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `trabajadores_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nickname` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Volcando datos para la tabla bienes_system.usuarios: ~2 rows (aproximadamente)
INSERT IGNORE INTO `usuarios` (`id`, `email`, `password`, `trabajadores_id`) VALUES
	(6, 'asd@gmail.com', '$2b$10$Qqw0PtGrbUNz7N32vInsO.E5MgVz9DGhjn6NCiUfjjOG8Px/zyCPO', 1),
	(8, 'abcd@gmail.com', '$2b$10$LstoFJipoIniWxRAWL4M5eIF9FZNB6QzqNuLF5HGLpCnVuv9kl4su', 4);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
