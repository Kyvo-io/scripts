-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema monitro
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `monitro` ;

-- -----------------------------------------------------
-- Schema monitro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `monitro` DEFAULT CHARACTER SET utf8 ;
USE `monitro` ;

-- -----------------------------------------------------
-- Table `monitro`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NULL,
  `latitude` DOUBLE NULL,
  `numero` DOUBLE NULL,
  `cidade` VARCHAR(90) NULL,
  `uf` CHAR(2) NULL,
  `longitude` DOUBLE NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`empresa` (
  `idEmpresa` INT NOT NULL AUTO_INCREMENT,
  `nomeEmpresa` VARCHAR(45) NULL,
  `CNPJ` CHAR(18) NULL,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`servidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`servidor` (
  `idServidor` INT NOT NULL AUTO_INCREMENT,
  `fkEndereco` INT NOT NULL,
  `sistemaOperacional` VARCHAR(45) NULL,
  `nomeServidor` VARCHAR(100) NULL,
  `tempoAtividade` VARCHAR(45) NULL,
  `tipoServidor` VARCHAR(45) NULL,
  `fkEmpresa` INT NOT NULL,
  PRIMARY KEY (`idServidor`, `fkEmpresa`),
  INDEX `fk_Servidor_Endereço1_idx` (`fkEndereco` ASC) VISIBLE,
  INDEX `fk_Servidor_Empresa1_idx` (`fkEmpresa` ASC) VISIBLE,
  CONSTRAINT `fk_Servidor_Endereço1`
    FOREIGN KEY (`fkEndereco`)
    REFERENCES `monitro`.`endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servidor_Empresa1`
    FOREIGN KEY (`fkEmpresa`)
    REFERENCES `monitro`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `nomeCargo` VARCHAR(45) NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nomeUsuario` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `senha` VARCHAR(45) NULL,
  `fkEmpresa` INT NOT NULL,
  `fkCargo` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `fkEmpresa`),
  INDEX `fk_Usuario_Empresa1_idx` (`fkEmpresa` ASC) VISIBLE,
  INDEX `fk_Usuario_Cargo1_idx` (`fkCargo` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Empresa1`
    FOREIGN KEY (`fkEmpresa`)
    REFERENCES `monitro`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Cargo1`
    FOREIGN KEY (`fkCargo`)
    REFERENCES `monitro`.`cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`sessao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`sessao` (
  `idSessao` INT NOT NULL AUTO_INCREMENT,
  `dataInicio` DATETIME NULL,
  `dataTermino` DATETIME NULL,
  `autenticacaoDuasEtapas` TINYINT NULL,
  `fkUsuario` INT NOT NULL,
  `fkEndereco` INT NOT NULL,
  PRIMARY KEY (`idSessao`, `fkUsuario`),
  INDEX `fk_Sessao_Usuario1_idx` (`fkUsuario` ASC) VISIBLE,
  INDEX `fk_Sessao_Endereço1_idx` (`fkEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Sessao_Usuario1`
    FOREIGN KEY (`fkUsuario`)
    REFERENCES `monitro`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sessao_Endereço1`
    FOREIGN KEY (`fkEndereco`)
    REFERENCES `monitro`.`endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`tipoComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`tipoComponente` (
  `idTipoComponente` INT NOT NULL AUTO_INCREMENT,
  `nomeTipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoComponente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`componente` (
  `idComponente` INT NOT NULL AUTO_INCREMENT,
  `fkTipoComponente` INT NOT NULL,
  `fkServidor` INT NOT NULL,
  PRIMARY KEY (`idComponente`, `fkTipoComponente`),
  INDEX `fk_Componente_TipoComponente1_idx` (`fkTipoComponente` ASC) VISIBLE,
  INDEX `fk_Componente_Servidor1_idx` (`fkServidor` ASC) VISIBLE,
  CONSTRAINT `fk_Componente_TipoComponente1`
    FOREIGN KEY (`fkTipoComponente`)
    REFERENCES `monitro`.`tipoComponente` (`idTipoComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Componente_Servidor1`
    FOREIGN KEY (`fkServidor`)
    REFERENCES `monitro`.`servidor` (`idServidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`descricaoComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`descricaoComponente` (
  `idDescricaoComponente` INT NOT NULL AUTO_INCREMENT,
  `tituloDescricao` VARCHAR(45) NULL,
  `descricao` VARCHAR(150) NULL,
  `fkTipoComponente_Componente` INT NOT NULL,
  `fkComponente` INT NOT NULL,
  PRIMARY KEY (`idDescricaoComponente`, `fkTipoComponente_Componente`, `fkComponente`),
  INDEX `fk_AtributoComponente_Componente1_idx` (`fkTipoComponente_Componente` ASC, `fkComponente` ASC) VISIBLE,
  CONSTRAINT `fk_AtributoComponente_Componente1`
    FOREIGN KEY (`fkTipoComponente_Componente` , `fkComponente`)
    REFERENCES `monitro`.`componente` (`fkTipoComponente` , `idComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`metrica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`metrica` (
  `idMetrica` INT NOT NULL AUTO_INCREMENT,
  `metrica` VARCHAR(45) NULL,
  PRIMARY KEY (`idMetrica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`registroComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`registroComponente` (
  `idRegistroComponente` INT NOT NULL AUTO_INCREMENT,
  `fkTipoComponente_Componente` INT NOT NULL,
  `fkComponente` INT NOT NULL,
  `fkMetrica` INT NOT NULL,
  `tituloDado` VARCHAR(45) NULL,
  `dado` DOUBLE NULL,
  `dataRegistro` DATETIME NULL,
  PRIMARY KEY (`idRegistroComponente`, `fkTipoComponente_Componente`, `fkComponente`, `fkMetrica`),
  INDEX `fk_Componente_has_Servidor_Componente1_idx` (`fkTipoComponente_Componente` ASC, `fkComponente` ASC) VISIBLE,
  INDEX `fk_RegistroComponente_TipoRegistro1_idx` (`fkMetrica` ASC) VISIBLE,
  CONSTRAINT `fk_Componente_has_Servidor_Componente1`
    FOREIGN KEY (`fkTipoComponente_Componente` , `fkComponente`)
    REFERENCES `monitro`.`componente` (`fkTipoComponente` , `idComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RegistroComponente_TipoRegistro1`
    FOREIGN KEY (`fkMetrica`)
    REFERENCES `monitro`.`metrica` (`idMetrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`processo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`processo` (
  `idProcesso` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `usoRAM` DOUBLE NULL,
  `alocacaoMemoria` FLOAT NULL,
  `usoCpu` VARCHAR(45) NULL,
  `fkRegistroComponente` INT NOT NULL,
  `fkTipoComponente_Componente` INT NOT NULL,
  `fkComponente_RegistroComponente` INT NOT NULL,
  PRIMARY KEY (`idProcesso`, `fkRegistroComponente`, `fkTipoComponente_Componente`, `fkComponente_RegistroComponente`),
  INDEX `fk_Processo_RegistroComponente1_idx` (`fkRegistroComponente` ASC, `fkTipoComponente_Componente` ASC, `fkComponente_RegistroComponente` ASC) VISIBLE,
  CONSTRAINT `fk_Processo_RegistroComponente1`
    FOREIGN KEY (`fkRegistroComponente` , `fkTipoComponente_Componente` , `fkComponente_RegistroComponente`)
    REFERENCES `monitro`.`registroComponente` (`idRegistroComponente` , `fkTipoComponente_Componente` , `fkComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`alerta` (
  `idAlerta` INT NOT NULL AUTO_INCREMENT,
  `min` INT NULL,
  `max` INT NULL,
  `fkMetrica` INT NOT NULL,
  `fkTipoComponente` INT NOT NULL,
  `fkServidor` INT NOT NULL,
  `fkEmpresa` INT NOT NULL,
  PRIMARY KEY (`idAlerta`, `fkMetrica`, `fkTipoComponente`, `fkServidor`, `fkEmpresa`),
  INDEX `fk_AlertaComponente_TipoRegistro1_idx` (`fkMetrica` ASC) VISIBLE,
  INDEX `fk_alertaComponente_tipoComponente1_idx` (`fkTipoComponente` ASC) VISIBLE,
  INDEX `fk_alertaComponente_servidor1_idx` (`fkServidor` ASC, `fkEmpresa` ASC) VISIBLE,
  CONSTRAINT `fk_AlertaComponente_TipoRegistro1`
    FOREIGN KEY (`fkMetrica`)
    REFERENCES `monitro`.`metrica` (`idMetrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alertaComponente_tipoComponente1`
    FOREIGN KEY (`fkTipoComponente`)
    REFERENCES `monitro`.`tipoComponente` (`idTipoComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alertaComponente_servidor1`
    FOREIGN KEY (`fkServidor` , `fkEmpresa`)
    REFERENCES `monitro`.`servidor` (`idServidor` , `fkEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`historicoAlerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`historicoAlerta` (
  `idhistoricoAlerta` INT NOT NULL AUTO_INCREMENT,
  `nivelAlerta` VARCHAR(45) NULL,
  `dataAlerta` DATETIME NULL,
  `fkServidor` INT NOT NULL,
  `fkEmpresa` INT NOT NULL,
  PRIMARY KEY (`idhistoricoAlerta`, `fkServidor`, `fkEmpresa`),
  INDEX `fk_historicoAlerta_servidor1_idx` (`fkServidor` ASC, `fkEmpresa` ASC) VISIBLE,
  CONSTRAINT `fk_historicoAlerta_servidor1`
    FOREIGN KEY (`fkServidor` , `fkEmpresa`)
    REFERENCES `monitro`.`servidor` (`idServidor` , `fkEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- begin attached script 'script'
DROP USER IF exists 'monitro-admin'@'%';
CREATE USER 'monitro-admin' IDENTIFIED BY 'kyvo_io';
GRANT SELECT ON TABLE `monitro`.* TO 'monitro-admin';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `monitro`.* TO 'monitro-admin';
GRANT SELECT, INSERT, TRIGGER ON TABLE `monitro`.* TO 'monitro-admin';

use monitro;
INSERT INTO tipoComponente (nomeTipo) VALUES ('CPU'), ('Memória RAM'), ('Placa de Rede'), ('Disco');
insert into cargo (nomeCargo) VALUES ('Gerente Noc'), ('Suporte');
INSERT INTO metrica (metrica) VALUES  
	('USO CPU (%)'),
    ('UPLOAD (MB)'),
    ('DOWNLOAD (MB)'),
    ('USO RAM (GB)'),
    ('USO ARMAZENAMENTO (GB)');
    
INSERT INTO empresa(nomeEmpresa, CNPJ)
VALUES ('Futura Pesquisa','64907604000107')
, ('Mais Pesquisa','98770156000156')
, ('INPA','43376225000150');

INSERT INTO endereco(logradouro, cep, bairro, latitude, longitude)
VALUES
    ('Rua Manoel Paz de Oliveira', '61946030','Parque São João', -22.799904, -43.3370793),
    ('Rua Miguel Ostrufka','83325615','Alto Tarumã',-25.4132027, -49.1749135),
    ('Rua Água Verde','44054128','Parque Ipê', -26.910837,  -49.1253785);

INSERT INTO usuario (nomeUsuario, email, senha, fkEmpresa, fkCargo)
VALUES
    ('Tite', 'tite@maispesquisa.com', 'adenor', 2, 1),
    ('Gabriel', 'gabriel@maispesquisa.com', 'liberta', 2, 2),
    ('Abel', 'abel@futurapesquisa.com', 'ferreira', 1, 1);

INSERT INTO servidor (nomeServidor,fkEmpresa, fkEndereco, sistemaOperacional, tipoServidor)
VALUES
    ('Servidor Core',1, 1, 'Ubuntu Server', 'On-promisse'),
    ('Servidor Aux',1, 2, 'Ubuntu Server', 'Cloud Azure'),
    ('Balancer',1, 3, 'Windows', 'Cloud AWS');
    
INSERT INTO componente 
VALUES (default,1,3),
(default,1,2),
(default,1,3);
    
-- end attached script 'script'
