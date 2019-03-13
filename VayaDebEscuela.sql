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
-- Table `escuelas`.`entidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`entidad` (
  `identidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `abreviatura` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`identidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escuelas`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`localidad` (
  `idlocalidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `abreviatura` VARCHAR(45) NULL,
  PRIMARY KEY (`idlocalidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escuelas`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`municipio` (
  `idmunicipio` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `abreviatura` VARCHAR(45) NULL,
  PRIMARY KEY (`idmunicipio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escuelas`.`sostenimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`sostenimiento` (
  `idsostenimiento` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsostenimiento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escuelas`.`niveleducativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`niveleducativo` (
  `idnivel` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idnivel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escuelas`.`turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`turno` (
  `idturno` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idturno`))
ENGINE = InnoDB;


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
-- Table `escuelas`.`configuracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`configuracion` (
  `idconfiguracion` INT NOT NULL,
  `periodoevaluacion` VARCHAR(45) NOT NULL,
  `intervalopagoalumno` VARCHAR(45) NOT NULL,
  `fechapagoescuela` DATETIME NOT NULL,
  `tiempodecontrato` VARCHAR(50) NOT NULL,
  `idperiodo` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idconfiguracion`, `idperiodo`),
  UNIQUE INDEX `idconfiguracion_UNIQUE` (`idconfiguracion` ASC) VISIBLE,
  INDEX `fk_configuracion_periododecalificacion1_idx` (`idperiodo` ASC) VISIBLE,
  CONSTRAINT `fk_configuracion_periododecalificacion1`
    FOREIGN KEY (`idperiodo`)
    REFERENCES `escuelas`.`periododecalificacion` (`idperiodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escuelas`.`escuelas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`escuelas` (
  `idescuela` VARCHAR(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(45) NULL DEFAULT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  `identidad` INT NOT NULL,
  `idlocalidad` INT NOT NULL,
  `idmunicipio` INT NOT NULL,
  `idsostenimiento` INT NOT NULL,
  `idnivel` INT NOT NULL,
  `idturno` INT NOT NULL,
  `idconfiguracion` INT NOT NULL,
  `fechaactivacion` DATETIME NOT NULL,
  `fechadesactivacion` DATETIME NOT NULL,
  PRIMARY KEY (`idescuela`),
  UNIQUE INDEX `idescuela_UNIQUE` (`idescuela` ASC) VISIBLE,
  INDEX `fk_escuelas_entidad1_idx` (`identidad` ASC) VISIBLE,
  INDEX `fk_escuelas_localidad1_idx` (`idlocalidad` ASC) VISIBLE,
  INDEX `fk_escuelas_municipio1_idx` (`idmunicipio` ASC) VISIBLE,
  INDEX `fk_escuelas_sostenimiento1_idx` (`idsostenimiento` ASC) VISIBLE,
  INDEX `fk_escuelas_niveleducativo1_idx` (`idnivel` ASC) VISIBLE,
  INDEX `fk_escuelas_turno1_idx` (`idturno` ASC) VISIBLE,
  INDEX `fk_escuelas_configuracion1_idx` (`idconfiguracion` ASC) VISIBLE,
  CONSTRAINT `fk_escuelas_entidad1`
    FOREIGN KEY (`identidad`)
    REFERENCES `escuelas`.`entidad` (`identidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escuelas_localidad1`
    FOREIGN KEY (`idlocalidad`)
    REFERENCES `escuelas`.`localidad` (`idlocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escuelas_municipio1`
    FOREIGN KEY (`idmunicipio`)
    REFERENCES `escuelas`.`municipio` (`idmunicipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escuelas_sostenimiento1`
    FOREIGN KEY (`idsostenimiento`)
    REFERENCES `escuelas`.`sostenimiento` (`idsostenimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escuelas_niveleducativo1`
    FOREIGN KEY (`idnivel`)
    REFERENCES `escuelas`.`niveleducativo` (`idnivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escuelas_turno1`
    FOREIGN KEY (`idturno`)
    REFERENCES `escuelas`.`turno` (`idturno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escuelas_configuracion1`
    FOREIGN KEY (`idconfiguracion`)
    REFERENCES `escuelas`.`configuracion` (`idconfiguracion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `idescuela` VARCHAR(11) NULL DEFAULT NULL,
  `sesion` VARCHAR(45) NOT NULL,
  `telcasa` INT(10) NOT NULL,
  `telefono` INT(10) NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `idusuarios_UNIQUE` (`idusuario` ASC) VISIBLE,
  INDEX `fk_usuarios_perfiles1_idx` (`idperfil` ASC) VISIBLE,
  INDEX `fk_usuarios_escuelas1_idx` (`idescuela` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_escuelas1`
    FOREIGN KEY (`idescuela`)
    REFERENCES `escuelas`.`escuelas` (`idescuela`),
  CONSTRAINT `fk_usuarios_perfiles1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `escuelas`.`perfiles` (`idperfil`))
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
  `matricula` VARCHAR(45) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'1',
  `telapp` INT(10) NOT NULL,
  `telapp2` INT(10) NOT NULL,
  `telapp3` INT(10) NOT NULL,
  PRIMARY KEY (`idalumno`),
  UNIQUE INDEX `idalumnos_UNIQUE` (`idalumno` ASC) VISIBLE)
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
-- Table `escuelas`.`asignacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`asignacion` (
  `idasignacion` VARCHAR(45) NOT NULL,
  `idasignatura` VARCHAR(11) NOT NULL,
  `idgrupo` VARCHAR(11) NOT NULL,
  `idprofesor` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idasignacion`),
  INDEX `fk_asignaturas_has_usuarios_asignaturas1_idx` (`idasignatura` ASC) VISIBLE,
  INDEX `fk_asigancionmateria_grupos1_idx` (`idgrupo` ASC) VISIBLE,
  INDEX `fk_asigancion_usuarios1_idx` (`idprofesor` ASC) VISIBLE,
  CONSTRAINT `fk_asigancion_usuarios1`
    FOREIGN KEY (`idprofesor`)
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
-- Table `escuelas`.`asignacionesalumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`asignacionesalumno` (
  `idasignacionalumno` VARCHAR(45) NOT NULL,
  `idasignacion` VARCHAR(45) NOT NULL,
  `idalumno` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idasignacionalumno`),
  INDEX `fk_asigancion_has_alumnos_alumnos1_idx` (`idalumno` ASC) VISIBLE,
  INDEX `fk_asigancion_has_alumnos_asigancion1_idx` (`idasignacion` ASC) VISIBLE,
  CONSTRAINT `fk_asigancion_has_alumnos_alumnos1`
    FOREIGN KEY (`idalumno`)
    REFERENCES `escuelas`.`alumnos` (`idalumno`),
  CONSTRAINT `fk_asigancion_has_alumnos_asigancion1`
    FOREIGN KEY (`idasignacion`)
    REFERENCES `escuelas`.`asignacion` (`idasignacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`calificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`calificaciones` (
  `idasignacionalumno` VARCHAR(45) NOT NULL,
  `calificacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idasignacionalumno`),
  INDEX `fk_calificaciones_asigancionesalumno1_idx` (`idasignacionalumno` ASC) VISIBLE,
  CONSTRAINT `fk_calificaciones_asigancionesalumno1`
    FOREIGN KEY (`idasignacionalumno`)
    REFERENCES `escuelas`.`asignacionesalumno` (`idasignacionalumno`))
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
  `idalumno` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idpago`, `idalumno`),
  UNIQUE INDEX `idpagos_UNIQUE` (`idpago` ASC) VISIBLE,
  INDEX `fk_pagos_alumnos1_idx` (`idalumno` ASC) VISIBLE,
  CONSTRAINT `fk_pagos_alumnos1`
    FOREIGN KEY (`idalumno`)
    REFERENCES `escuelas`.`alumnos` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `escuelas`.`codigoactv`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuelas`.`codigoactv` (
  `codigo` VARCHAR(4) NOT NULL,
  `vencido` BIT NOT NULL DEFAULT 0,
  `idusuario` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`codigo`, `idusuario`),
  INDEX `fk_codigoactv_usuarios1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_codigoactv_usuarios1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `escuelas`.`usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
