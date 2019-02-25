-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema escuelas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema escuelas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `escuelas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `escuelas` ;

-- -----------------------------------------------------
-- Table `escuelas`.`periododecalificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`periododecalificacion` (
  `idperiodo` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `evaluaciones` INT(11) NOT NULL,
  PRIMARY KEY (`idperiodo`),
  UNIQUE INDEX `idperiodo_UNIQUE` (`idperiodo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`escuelas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`escuelas` (
  `idescuela` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  `pagado` BIT(1) NOT NULL DEFAULT b'1',
  `idperiodo` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idescuela`),
  UNIQUE INDEX `idescuela_UNIQUE` (`idescuela` ASC) VISIBLE,
  INDEX `fk_escuelas_periododecalificacion1_idx` (`idperiodo` ASC) VISIBLE,
  CONSTRAINT `fk_escuelas_periododecalificacion1`
    FOREIGN KEY (`idperiodo`)
    REFERENCES `escuelas`.`periododecalificacion` (`idperiodo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`perfiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`perfiles` (
  `idperfil` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idperfil`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`usuarios` (
  `idusuario` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidopaterno` VARCHAR(45) NOT NULL,
  `apellidomaterno` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `perfil` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'0',
  `idperfil` VARCHAR(11) NOT NULL,
  `idescuela` VARCHAR(11) NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `idusuarios_UNIQUE` (`idusuario` ASC) VISIBLE,
  INDEX `fk_usuarios_perfiles1_idx` (`idperfil` ASC) VISIBLE,
  INDEX `fk_usuarios_escuelas1_idx` (`idescuela` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_perfiles1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `escuelas`.`perfiles` (`idperfil`),
  CONSTRAINT `fk_usuarios_escuelas1`
    FOREIGN KEY (`idescuela`)
    REFERENCES `escuelas`.`escuelas` (`idescuela`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`chat` (
  `idchat` VARCHAR(11) NOT NULL,
  `mensaje` VARCHAR(45) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `enviado` BIT(1) NOT NULL DEFAULT b'0',
  `visto` BIT(1) NOT NULL DEFAULT b'0',
  `idtutor` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idchat`),
  UNIQUE INDEX `idchat_UNIQUE` (`idchat` ASC) VISIBLE,
  INDEX `fk_chat_usuarios1_idx` (`idtutor` ASC) VISIBLE,
  CONSTRAINT `fk_chat_usuarios1`
    FOREIGN KEY (`idtutor`)
    REFERENCES `escuelas`.`usuarios` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`grupos` (
  `idgrupo` VARCHAR(11) NOT NULL,
  `nombregrupo` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  `idescuela` VARCHAR(11) NOT NULL,
  `chat_idchat` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idgrupo`, `chat_idchat`),
  INDEX `fk_grupos_escuelas_idx` (`idescuela` ASC) VISIBLE,
  INDEX `fk_grupos_chat1_idx` (`chat_idchat` ASC) VISIBLE,
  CONSTRAINT `fk_grupos_chat1`
    FOREIGN KEY (`chat_idchat`)
    REFERENCES `escuelas`.`chat` (`idchat`),
  CONSTRAINT `fk_grupos_escuelas`
    FOREIGN KEY (`idescuela`)
    REFERENCES `escuelas`.`escuelas` (`idescuela`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`alerta` (
  `idalerta` VARCHAR(11) NOT NULL,
  `mensaje` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  `idgrupo` VARCHAR(11) NULL DEFAULT NULL,
  `idescuela` VARCHAR(11) NULL DEFAULT NULL,
  `idusuario` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idalerta`),
  UNIQUE INDEX `idtipochat_UNIQUE` (`idalerta` ASC) VISIBLE,
  INDEX `fk_alerta_grupos1_idx` (`idgrupo` ASC) VISIBLE,
  INDEX `fk_alerta_escuelas1_idx` (`idescuela` ASC) VISIBLE,
  INDEX `fk_alerta_usuarios1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_alerta_escuelas1`
    FOREIGN KEY (`idescuela`)
    REFERENCES `escuelas`.`escuelas` (`idescuela`),
  CONSTRAINT `fk_alerta_grupos1`
    FOREIGN KEY (`idgrupo`)
    REFERENCES `escuelas`.`grupos` (`idgrupo`),
  CONSTRAINT `fk_alerta_usuarios1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `escuelas`.`usuarios` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`alumnos` (
  `idalumno` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `paterno` VARCHAR(45) NOT NULL,
  `materno` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  `idtutor` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idalumno`),
  UNIQUE INDEX `idalumnos_UNIQUE` (`idalumno` ASC) VISIBLE,
  INDEX `fk_alumnos_usuarios1_idx` (`idtutor` ASC) VISIBLE,
  CONSTRAINT `fk_alumnos_usuarios1`
    FOREIGN KEY (`idtutor`)
    REFERENCES `escuelas`.`usuarios` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`asignaturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`asignaturas` (
  `idasignatura` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`idasignatura`),
  UNIQUE INDEX `idasignaturas_UNIQUE` (`idasignatura` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`asigancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`asigancion` (
  `idasigancion` VARCHAR(45) NOT NULL,
  `idasignatura` VARCHAR(11) NOT NULL,
  `idgrupo` VARCHAR(11) NOT NULL,
  `idusuario` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idasigancion`),
  INDEX `fk_asignaturas_has_usuarios_asignaturas1_idx` (`idasignatura` ASC) VISIBLE,
  INDEX `fk_asigancionmateria_grupos1_idx` (`idgrupo` ASC) VISIBLE,
  INDEX `fk_asigancion_usuarios1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_asigancion_usuarios1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `escuelas`.`usuarios` (`idusuario`),
  CONSTRAINT `fk_asigancionmateria_grupos1`
    FOREIGN KEY (`idgrupo`)
    REFERENCES `escuelas`.`grupos` (`idgrupo`),
  CONSTRAINT `fk_asignaturas_has_usuarios_asignaturas1`
    FOREIGN KEY (`idasignatura`)
    REFERENCES `escuelas`.`asignaturas` (`idasignatura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`asigancionesalumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`asigancionesalumno` (
  `idasignacionesalumno` VARCHAR(45) NOT NULL,
  `idasigancion` VARCHAR(45) NOT NULL,
  `idalumno` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idasignacionesalumno`),
  INDEX `fk_asigancion_has_alumnos_alumnos1_idx` (`idalumno` ASC) VISIBLE,
  INDEX `fk_asigancion_has_alumnos_asigancion1_idx` (`idasigancion` ASC) VISIBLE,
  CONSTRAINT `fk_asigancion_has_alumnos_alumnos1`
    FOREIGN KEY (`idalumno`)
    REFERENCES `escuelas`.`alumnos` (`idalumno`),
  CONSTRAINT `fk_asigancion_has_alumnos_asigancion1`
    FOREIGN KEY (`idasigancion`)
    REFERENCES `escuelas`.`asigancion` (`idasigancion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`calificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`calificaciones` (
  `idcalificaciones` INT(11) NOT NULL,
  `idasignacionesalumno` VARCHAR(45) NOT NULL,
  `calificacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcalificaciones`, `idasignacionesalumno`),
  INDEX `fk_calificaciones_asigancionesalumno1_idx` (`idasignacionesalumno` ASC) VISIBLE,
  CONSTRAINT `fk_calificaciones_asigancionesalumno1`
    FOREIGN KEY (`idasignacionesalumno`)
    REFERENCES `escuelas`.`asigancionesalumno` (`idasignacionesalumno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`comunicados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`comunicados` (
  `idcomunicado` VARCHAR(11) NOT NULL,
  `contenido` VARCHAR(45) NOT NULL,
  `fechainicio` DATETIME NOT NULL,
  `fechafin` DATETIME NOT NULL,
  `idgrupo` VARCHAR(11) NULL DEFAULT NULL,
  `idescuela` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idcomunicado`),
  UNIQUE INDEX `idcomunicados_UNIQUE` (`idcomunicado` ASC) VISIBLE,
  INDEX `fk_comunicados_grupos1_idx` (`idgrupo` ASC) VISIBLE,
  INDEX `fk_comunicados_escuelas1_idx` (`idescuela` ASC) VISIBLE,
  CONSTRAINT `fk_comunicados_escuelas1`
    FOREIGN KEY (`idescuela`)
    REFERENCES `escuelas`.`escuelas` (`idescuela`),
  CONSTRAINT `fk_comunicados_grupos1`
    FOREIGN KEY (`idgrupo`)
    REFERENCES `escuelas`.`grupos` (`idgrupo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`opcionesenvio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`opcionesenvio` (
  `idopcionesenvio` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`idopcionesenvio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`pagos` (
  `idpago` VARCHAR(11) NOT NULL,
  `pagado` BIT(1) NOT NULL DEFAULT b'1',
  `idtutor` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idpago`),
  UNIQUE INDEX `idpagos_UNIQUE` (`idpago` ASC) VISIBLE,
  INDEX `fk_pagos_usuarios1_idx` (`idtutor` ASC) VISIBLE,
  CONSTRAINT `fk_pagos_usuarios1`
    FOREIGN KEY (`idtutor`)
    REFERENCES `escuelas`.`usuarios` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
