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
-- Table `monitro`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NULL,
  `latitude` INT NULL,
  `numero` INT NULL,
  `cidade` VARCHAR(90) NULL,
  `uf` CHAR(2) NULL,
  `longitude` INT NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Empresa` (
  `idEmpresa` INT NOT NULL AUTO_INCREMENT,
  `nomeEmpresa` VARCHAR(45) NULL,
  `CNPJ` CHAR(18) NULL,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Servidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Servidor` (
  `idServidor` INT NOT NULL AUTO_INCREMENT,
  `fkEndereco` INT NOT NULL,
  `sistemaOperacional` VARCHAR(45) NULL,
  `nomeServidor` VARCHAR(100) NULL,
  `fkEmpresa` INT NOT NULL,
  PRIMARY KEY (`idServidor`, `fkEmpresa`),
  INDEX `fk_Servidor_Endereço1_idx` (`fkEndereco` ASC) VISIBLE,
  INDEX `fk_Servidor_Empresa1_idx` (`fkEmpresa` ASC) VISIBLE,
  CONSTRAINT `fk_Servidor_Endereço1`
    FOREIGN KEY (`fkEndereco`)
    REFERENCES `monitro`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servidor_Empresa1`
    FOREIGN KEY (`fkEmpresa`)
    REFERENCES `monitro`.`Empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `nomeCargo` VARCHAR(45) NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Usuario` (
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
    REFERENCES `monitro`.`Empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Cargo1`
    FOREIGN KEY (`fkCargo`)
    REFERENCES `monitro`.`Cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Sessao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Sessao` (
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
    REFERENCES `monitro`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sessao_Endereço1`
    FOREIGN KEY (`fkEndereco`)
    REFERENCES `monitro`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`TipoComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`TipoComponente` (
  `idTipoComponente` INT NOT NULL AUTO_INCREMENT,
  `nomeTipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoComponente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Componente` (
  `idComponente` INT NOT NULL AUTO_INCREMENT,
  `fkTipoComponente` INT NOT NULL,
  `fkServidor` INT NOT NULL,
  PRIMARY KEY (`idComponente`, `fkTipoComponente`),
  INDEX `fk_Componente_TipoComponente1_idx` (`fkTipoComponente` ASC) VISIBLE,
  INDEX `fk_Componente_Servidor1_idx` (`fkServidor` ASC) VISIBLE,
  CONSTRAINT `fk_Componente_TipoComponente1`
    FOREIGN KEY (`fkTipoComponente`)
    REFERENCES `monitro`.`TipoComponente` (`idTipoComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Componente_Servidor1`
    FOREIGN KEY (`fkServidor`)
    REFERENCES `monitro`.`Servidor` (`idServidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`DescricaoComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`DescricaoComponente` (
  `idDescricaoComponente` INT NOT NULL AUTO_INCREMENT,
  `tituloDescricao` VARCHAR(45) NULL,
  `descricao` VARCHAR(150) NULL,
  `fkTipoComponente_Componente` INT NOT NULL,
  `fkComponente` INT NOT NULL,
  PRIMARY KEY (`idDescricaoComponente`, `fkTipoComponente_Componente`, `fkComponente`),
  INDEX `fk_AtributoComponente_Componente1_idx` (`fkTipoComponente_Componente` ASC, `fkComponente` ASC) VISIBLE,
  CONSTRAINT `fk_AtributoComponente_Componente1`
    FOREIGN KEY (`fkTipoComponente_Componente` , `fkComponente`)
    REFERENCES `monitro`.`Componente` (`fkTipoComponente` , `idComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Metrica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Metrica` (
  `idMetrica` INT NOT NULL AUTO_INCREMENT,
  `metrica` VARCHAR(45) NULL,
  PRIMARY KEY (`idMetrica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`RegistroComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`RegistroComponente` (
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
    REFERENCES `monitro`.`Componente` (`fkTipoComponente` , `idComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RegistroComponente_TipoRegistro1`
    FOREIGN KEY (`fkMetrica`)
    REFERENCES `monitro`.`Metrica` (`idMetrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`Processo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`Processo` (
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
    REFERENCES `monitro`.`RegistroComponente` (`idRegistroComponente` , `fkTipoComponente_Componente` , `fkComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitro`.`AlertaComponente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `monitro`.`AlertaComponente` (
  `idAlertaComponente` INT NOT NULL AUTO_INCREMENT,
  `min` INT NULL,
  `max` INT NULL,
  `fkComponente` INT NOT NULL,
  `fkTipoComponente_Componente` INT NOT NULL,
  `fkMetrica` INT NOT NULL,
  PRIMARY KEY (`idAlertaComponente`, `fkComponente`, `fkTipoComponente_Componente`, `fkMetrica`),
  INDEX `fk_AlertaComponente_Componente1_idx` (`fkComponente` ASC, `fkTipoComponente_Componente` ASC) VISIBLE,
  INDEX `fk_AlertaComponente_TipoRegistro1_idx` (`fkMetrica` ASC) VISIBLE,
  CONSTRAINT `fk_AlertaComponente_Componente1`
    FOREIGN KEY (`fkComponente` , `fkTipoComponente_Componente`)
    REFERENCES `monitro`.`Componente` (`idComponente` , `fkTipoComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AlertaComponente_TipoRegistro1`
    FOREIGN KEY (`fkMetrica`)
    REFERENCES `monitro`.`Metrica` (`idMetrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE USER 'monitro-admin' IDENTIFIED BY 'kyvo_io';

GRANT ALL ON `monitro`.* TO 'monitro-admin';
GRANT SELECT ON TABLE `monitro`.* TO 'monitro-admin';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `monitro`.* TO 'monitro-admin';
GRANT SELECT, INSERT, TRIGGER ON TABLE `monitro`.* TO 'monitro-admin';
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- begin attached script 'script'
use monitro;
INSERT INTO tipoComponente (nomeTipo) VALUES ('CPU'), ('Memória RAM'), ('Placa de Rede'), ('Disco');
insert into cargo (nomeCargo) VALUES ('Gerente Noc'), ('Suporte');
INSERT INTO metrica (metrica) VALUES  
	('USO (%)'),
    ('UPLOAD (Mbps)'),
    ('DOWNLOAD (Mbps)'),
    ('USO (GB)'),
	('LIVRE (GB)');
    
INSERT INTO empresa(nomeEmpresa, CNPJ)
VALUES ('Futura Pesquisa','64907604000107')
, ('Mais Pesquisa','98770156000156')
, ('INPA','43376225000150');

INSERT INTO endereco(logradouro, cep, bairro)
VALUES
    ('Rua Manoel Paz de Oliveira', '61946030','Parque São João'),
    ('Rua Miguel Ostrufka','83325615','Alto Tarumã'),
    ('Rua Água Verde','44054128','Parque Ipê');

INSERT INTO usuario (nomeUsuario, email, senha, fkEmpresa, fkCargo)
VALUES
    ('Tite', 'tite@maispesquisa.com', 'adenor', 2, 1),
    ('Gabriel', 'gabriel@maispesquisa.com', 'liberta', 2, 2),
    ('Abel', 'abel@futurapesquisa.com', 'ferreira', 1, 1);

INSERT INTO servidor (nomeServidor,fkEmpresa, fkEndereco, sistemaOperacional)
VALUES
    ('Servidor Core',1, 1, 'Ubuntu Server'),
    ('Servidor Aux',1, 2, 'Ubuntu Server'),
    ('Balancer',1, 3, 'Windows');
    
-- end attached script 'script'
