-- MySQL Script generated by MySQL Workbench
-- Fri Oct  6 15:24:31 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Estados_bien`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estados_bien` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstado`),
  UNIQUE INDEX `estado_UNIQUE` (`estado` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cargos` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `nombreCargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCargo`),
  UNIQUE INDEX `nombreCargo_UNIQUE` (`nombreCargo` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sedes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sedes` (
  `idSede` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idSede`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamentos` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `nombreDepartamento` VARCHAR(45) NOT NULL,
  `Sedes_idSede` INT NOT NULL,
  PRIMARY KEY (`idDepartamento`, `Sedes_idSede`),
  UNIQUE INDEX `nombreDepartamento_UNIQUE` (`nombreDepartamento` ASC) ,
  INDEX `fk_Departamentos_Sedes1_idx` (`Sedes_idSede` ASC) ,
  CONSTRAINT `fk_Departamentos_Sedes1`
    FOREIGN KEY (`Sedes_idSede`)
    REFERENCES `mydb`.`Sedes` (`idSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gerencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gerencias` (
  `idGerencia` INT NOT NULL AUTO_INCREMENT,
  `nombreGerencia` VARCHAR(45) NOT NULL,
  `Departamentos_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idGerencia`, `Departamentos_idDepartamento`),
  UNIQUE INDEX `nombreGerencia_UNIQUE` (`nombreGerencia` ASC) ,
  INDEX `fk_Gerencias_Departamentos1_idx` (`Departamentos_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Gerencias_Departamentos1`
    FOREIGN KEY (`Departamentos_idDepartamento`)
    REFERENCES `mydb`.`Departamentos` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trabajador` (
  `idTrabajador` INT NOT NULL,
  `Cargos_idCargo` INT NOT NULL,
  `Gerencias_idGerencia` INT NOT NULL,
  PRIMARY KEY (`idTrabajador`, `Cargos_idCargo`, `Gerencias_idGerencia`),
  INDEX `fk_Trabajador_Cargos1_idx` (`Cargos_idCargo` ASC) ,
  INDEX `fk_Trabajador_Gerencias1_idx` (`Gerencias_idGerencia` ASC),
  CONSTRAINT `fk_Trabajador_Cargos1`
    FOREIGN KEY (`Cargos_idCargo`)
    REFERENCES `mydb`.`Cargos` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajador_Gerencias1`
    FOREIGN KEY (`Gerencias_idGerencia`)
    REFERENCES `mydb`.`Gerencias` (`idGerencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bienes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bienes` (
  `idBien` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `Estados_bien_idEstado` INT NOT NULL,
  `Trabajador_idTrabajador` INT NOT NULL,
  PRIMARY KEY (`idBien`, `Estados_bien_idEstado`, `Trabajador_idTrabajador`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) ,
  INDEX `fk_Bienes_Estados_bien1_idx` (`Estados_bien_idEstado` ASC),
  INDEX `fk_Bienes_Trabajador1_idx` (`Trabajador_idTrabajador` ASC),
  CONSTRAINT `fk_Bienes_Estados_bien1`
    FOREIGN KEY (`Estados_bien_idEstado`)
    REFERENCES `mydb`.`Estados_bien` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bienes_Trabajador1`
    FOREIGN KEY (`Trabajador_idTrabajador`)
    REFERENCES `mydb`.`Trabajador` (`idTrabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estados_Solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estados_Solicitud` (
  `idEstados_Solicitud` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstados_Solicitud`),
  UNIQUE INDEX `estado_UNIQUE` (`estado` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Solicitud_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Solicitud_tipo` (
  `idSolicitud_tipo` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSolicitud_tipo`),
  UNIQUE INDEX `tipo_UNIQUE` (`tipo` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reparaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reparaciones` (
  `idReparaciones` INT NOT NULL AUTO_INCREMENT,
  `motivo` VARCHAR(250) NOT NULL,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`idReparaciones`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Solicitudes` (
  `idSolicitud` INT NOT NULL AUTO_INCREMENT,
  `codigoSolicitud` VARCHAR(45) NOT NULL,
  `fechaSolicitud` DATE NOT NULL,
  `Estados_Solicitud_idEstados_Solicitud` INT NOT NULL,
  `Trabajador_idTrabajador` INT NOT NULL,
  `Gerencias_idGerencia` INT NOT NULL,
  `Solicitud_tipo_idSolicitud_tipo` INT NOT NULL,
  `Reparaciones_idReparaciones` INT NOT NULL,
  PRIMARY KEY (`idSolicitud`, `Estados_Solicitud_idEstados_Solicitud`, `Trabajador_idTrabajador`, `Gerencias_idGerencia`, `Solicitud_tipo_idSolicitud_tipo`),
  UNIQUE INDEX `codigoSolicitud_UNIQUE` (`codigoSolicitud` ASC),
  INDEX `fk_Solicitudes_Estados_Solicitud1_idx` (`Estados_Solicitud_idEstados_Solicitud` ASC) ,
  INDEX `fk_Solicitudes_Trabajador1_idx` (`Trabajador_idTrabajador` ASC),
  INDEX `fk_Solicitudes_Gerencias1_idx` (`Gerencias_idGerencia` ASC) ,
  INDEX `fk_Solicitudes_Solicitud_tipo1_idx` (`Solicitud_tipo_idSolicitud_tipo` ASC) ,
  INDEX `fk_Solicitudes_Reparaciones1_idx` (`Reparaciones_idReparaciones` ASC),
  CONSTRAINT `fk_Solicitudes_Estados_Solicitud1`
    FOREIGN KEY (`Estados_Solicitud_idEstados_Solicitud`)
    REFERENCES `mydb`.`Estados_Solicitud` (`idEstados_Solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitudes_Trabajador1`
    FOREIGN KEY (`Trabajador_idTrabajador`)
    REFERENCES `mydb`.`Trabajador` (`idTrabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitudes_Gerencias1`
    FOREIGN KEY (`Gerencias_idGerencia`)
    REFERENCES `mydb`.`Gerencias` (`idGerencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitudes_Solicitud_tipo1`
    FOREIGN KEY (`Solicitud_tipo_idSolicitud_tipo`)
    REFERENCES `mydb`.`Solicitud_tipo` (`idSolicitud_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitudes_Reparaciones1`
    FOREIGN KEY (`Reparaciones_idReparaciones`)
    REFERENCES `mydb`.`Reparaciones` (`idReparaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Translados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Translados` (
  `idTranslado` INT NOT NULL,
  `Solicitudes_idSolicitud` INT NOT NULL,
  `Sedes_idSede` INT NOT NULL,
  `comprobante` BLOB NOT NULL,
  PRIMARY KEY (`idTranslado`, `Sedes_idSede`),
  INDEX `fk_Translados_Solicitudes1_idx` (`Solicitudes_idSolicitud` ASC) ,
  INDEX `fk_Translados_Sedes1_idx` (`Sedes_idSede` ASC) ,
  CONSTRAINT `fk_Translados_Solicitudes1`
    FOREIGN KEY (`Solicitudes_idSolicitud`)
    REFERENCES `mydb`.`Solicitudes` (`idSolicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Translados_Sedes1`
    FOREIGN KEY (`Sedes_idSede`)
    REFERENCES `mydb`.`Sedes` (`idSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bienes_has_Solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bienes_has_Solicitudes` (
  `Bienes_idBien` INT NOT NULL,
  `Solicitudes_idSolicitud` INT NOT NULL,
  PRIMARY KEY (`Bienes_idBien`, `Solicitudes_idSolicitud`),
  INDEX `fk_Bienes_has_Solicitudes_Solicitudes1_idx` (`Solicitudes_idSolicitud` ASC) ,
  INDEX `fk_Bienes_has_Solicitudes_Bienes1_idx` (`Bienes_idBien` ASC) ,
  CONSTRAINT `fk_Bienes_has_Solicitudes_Bienes1`
    FOREIGN KEY (`Bienes_idBien`)
    REFERENCES `mydb`.`Bienes` (`idBien`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bienes_has_Solicitudes_Solicitudes1`
    FOREIGN KEY (`Solicitudes_idSolicitud`)
    REFERENCES `mydb`.`Solicitudes` (`idSolicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asignaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Asignaciones` (
  `idAsignacion` INT NOT NULL AUTO_INCREMENT,
  `Trabajador_idTrabajador` INT NOT NULL,
  `Bienes_idBien` INT NOT NULL,
  PRIMARY KEY (`idAsignacion`, `Trabajador_idTrabajador`, `Bienes_idBien`),
  INDEX `fk_Asignaciones_Trabajador1_idx` (`Trabajador_idTrabajador` ASC),
  INDEX `fk_Asignaciones_Bienes1_idx` (`Bienes_idBien` ASC) ,
  CONSTRAINT `fk_Asignaciones_Trabajador1`
    FOREIGN KEY (`Trabajador_idTrabajador`)
    REFERENCES `mydb`.`Trabajador` (`idTrabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asignaciones_Bienes1`
    FOREIGN KEY (`Bienes_idBien`)
    REFERENCES `mydb`.`Bienes` (`idBien`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
