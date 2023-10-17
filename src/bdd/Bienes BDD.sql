-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.37-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
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
CREATE DATABASE IF NOT EXISTS `bienes_system` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bienes_system`;

-- Volcando estructura para tabla bienes_system.asignaciones
CREATE TABLE IF NOT EXISTS `asignaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trabajadores_id` int(11) NOT NULL,
  `bienes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_Asignaciones_Trabajador1_idx` (`trabajadores_id`) USING BTREE,
  KEY `fk_Asignaciones_Bienes1_idx` (`bienes_id`) USING BTREE,
  CONSTRAINT `fk_Asignaciones_Bienes1` FOREIGN KEY (`bienes_id`) REFERENCES `bienes` (`id`),
  CONSTRAINT `fk_Asignaciones_Trabajador1` FOREIGN KEY (`trabajadores_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.bienes_has_solicitudes
CREATE TABLE IF NOT EXISTS `bienes_has_solicitudes` (
  `bienes_id` int(11) NOT NULL,
  `solicitudes_id` int(11) NOT NULL,
  PRIMARY KEY (`bienes_id`,`solicitudes_id`) USING BTREE,
  KEY `fk_Bienes_has_Solicitudes_Solicitudes1_idx` (`solicitudes_id`) USING BTREE,
  KEY `fk_Bienes_has_Solicitudes_Bienes1_idx` (`bienes_id`) USING BTREE,
  CONSTRAINT `fk_Bienes_has_Solicitudes_Bienes1` FOREIGN KEY (`bienes_id`) REFERENCES `bienes` (`id`),
  CONSTRAINT `fk_Bienes_has_Solicitudes_Solicitudes1` FOREIGN KEY (`solicitudes_id`) REFERENCES `solicitudes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.cargos
CREATE TABLE IF NOT EXISTS `cargos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `nombreCargo_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.departamentos
CREATE TABLE IF NOT EXISTS `departamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `sedes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`sedes_id`) USING BTREE,
  UNIQUE KEY `nombreDepartamento_UNIQUE` (`nombre`) USING BTREE,
  KEY `fk_Departamentos_Sedes1_idx` (`sedes_id`) USING BTREE,
  CONSTRAINT `fk_Departamentos_Sedes1` FOREIGN KEY (`sedes_id`) REFERENCES `sedes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.estados_bien
CREATE TABLE IF NOT EXISTS `estados_bien` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `estado_UNIQUE` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.estados_solicitud
CREATE TABLE IF NOT EXISTS `estados_solicitud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `estado_UNIQUE` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.gerencias
CREATE TABLE IF NOT EXISTS `gerencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `departamentos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `nombreGerencia_UNIQUE` (`nombre`) USING BTREE,
  KEY `fk_Gerencias_Departamentos1_idx` (`departamentos_id`) USING BTREE,
  CONSTRAINT `fk_Gerencias_Departamentos1` FOREIGN KEY (`departamentos_id`) REFERENCES `departamentos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.reparaciones
CREATE TABLE IF NOT EXISTS `reparaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motivo` text NOT NULL,
  `estado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.sedes
CREATE TABLE IF NOT EXISTS `sedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.solicitudes
CREATE TABLE IF NOT EXISTS `solicitudes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_solicitud` varchar(45) NOT NULL,
  `fecha_solicitud` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.solicitud_tipo
CREATE TABLE IF NOT EXISTS `solicitud_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `tipo_UNIQUE` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.translados
CREATE TABLE IF NOT EXISTS `translados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `solicitudes_id` int(11) NOT NULL,
  `sedes_id` int(11) NOT NULL,
  `comprobante` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`sedes_id`) USING BTREE,
  KEY `fk_Translados_Solicitudes1_idx` (`solicitudes_id`) USING BTREE,
  KEY `fk_Translados_Sedes1_idx` (`sedes_id`) USING BTREE,
  CONSTRAINT `fk_Translados_Sedes1` FOREIGN KEY (`sedes_id`) REFERENCES `sedes` (`id`),
  CONSTRAINT `fk_Translados_Solicitudes1` FOREIGN KEY (`solicitudes_id`) REFERENCES `solicitudes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla bienes_system.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `trabajadores_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nickname` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
