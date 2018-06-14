-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema perfumaria_perfurmarte
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `perfumaria_perfurmarte` ;

-- -----------------------------------------------------
-- Schema perfumaria_perfurmarte
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `perfumaria_perfurmarte` DEFAULT CHARACTER SET utf8 ;
USE `perfumaria_perfurmarte` ;

-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria para que todos os funcionarios da perfumaria sejam identificados no negocio por um identificador sequencial do tipo inteiro.',
  `nome` VARCHAR(45) NOT NULL COMMENT 'Corresponde ao nome completo de um funcionario no negocio ate um maximo de 45 caracteres.',
  `telemovel` INT(9) NOT NULL COMMENT 'Contem o contacto telefonico principal e operacional de um funcionario. Pode ser um contacto de telemovel (principal) em que os dois primeiros inteiros correspondem a operadora seguido do restante numero: 914477203; Caso o funcionario nao possua um contacto de telemovel podera associar-se um contacto telefonico. Neste caso os 3 primeiros digitos correspondem ao indicativo da regiao e o restante o numero do contacto.',
  `cidade` VARCHAR(45) NOT NULL COMMENT 'Cidade ou regiao onde reside um funcionario registado no sistema com um idFuncionario.\n',
  `create_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`Cliente` (
  `idCartao` INT NOT NULL COMMENT 'Identificador univoco do cliente no sistema. Trata-se de um valor inteiro atribuido de forma sequencial sempre que se insere um novo cliente no sistema. Este identificador sera o identificador atribuido ao cartao de cliente.',
  `nome` VARCHAR(45) NOT NULL COMMENT 'Nome completo de um cliente registado no sistema. ',
  `telemovel` INT(9) NULL COMMENT 'Contem o contacto telefonico de um cliente. Pode ser um contacto de telemovel (principal) em que os dois primeiros inteiros correspondem a operadora seguido do resto do numero: 914477203; Caso o cliente nao possua um contacto de telemovel podera associar-se um contacto telefonico. Neste caso os 3 primeiros digitos correspondem ao indicativo da regiao e o restante o numero do contacto.',
  `email` VARCHAR(45) NULL COMMENT 'Corresponde ao contacto de correio electronico do cliente. Os valores deste campo deverão ser conter o nome do email seguido de um arroba e o respectivo dominio do email.',
  `profissao` VARCHAR(45) NULL COMMENT 'Profissao do cliente. Podera conter o nome do ramo da atividade, cargo desempenhado, etc.',
  `dataNascimento` DATE NULL COMMENT 'Corresponde a data de nascimento do cliente com dia, mes e ano.',
  `cidade` VARCHAR(45) NULL COMMENT 'Cidade actual onde o cliente reside. Apenas e guardada o nome da cidade.',
  `create_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCartao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`Venda` (
  `idVenda` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador univoco de uma venda realizada por um determinado funcionario no negocio. Trata-se de um identificador sequencial do tipo inteiro.',
  `data` DATETIME NOT NULL COMMENT 'Data de registo de uma determinada venda realizada no negocio. Alem do dia possui tambem a hora do registo da venda.',
  `custoTotal` FLOAT NOT NULL COMMENT 'Custo total de uma venda realizada por um funcionario a um cliente. Este custo total corresponde ao total faturado numa compra feita por um cliente de um ou varios artigos. O valor faturado corresponde ao custo total em euros.',
  `idFuncionario` INT NOT NULL COMMENT 'Identificador do funcionario que registou uma determinada venda realizada a um determinado cliente, no sistema.',
  `idCliente` INT NULL COMMENT 'Identificador (chave) do cliente que realizou uma compra de um ou mais artigos no sistema. ',
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idVenda`),
  INDEX `fk_Venda_Funcionario_idx` (`idFuncionario` ASC),
  INDEX `fk_Venda_Cliente1_idx` (`idCliente` ASC),
  CONSTRAINT `fk_Venda_Funcionario`
    FOREIGN KEY (`idFuncionario`)
    REFERENCES `perfumaria_perfurmarte`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `perfumaria_perfurmarte`.`Cliente` (`idCartao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`FamiliaOlfativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`FamiliaOlfativa` (
  `idFamiliaOlfativa` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da familia olfativa a que um dado conjunto de perfumes se insere. Por exemplo: Oriental, Floral, Amadeirado etc.. O conjunto destas chaves caracterizam o catalogo de tipos de familias olfativas disponiveis no negocio. ',
  `tipo` VARCHAR(45) NOT NULL COMMENT 'Corresponde ao tipo de pessoa a que um perfume se destina. Por exemplo Homem, Crianca, Mulher etc..',
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFamiliaOlfativa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`Perfume`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`Perfume` (
  `idPerfume` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador univoco de um perfume no catalogo de perfumes comercializados pela loja. Cada perfume possui um id que e atribuido sequencialmente pelo sistema sempre que se comercializa novos perfumes.',
  `nome` VARCHAR(45) NOT NULL COMMENT 'String com o nome de um determinado perfume.',
  `stock` INT NOT NULL COMMENT 'Stock (quantidade) disponivel de um determinado perfume na loja.',
  `precoUnitario` FLOAT NOT NULL COMMENT 'Preco unitario de venda de um determinado perfume em euros. O preco unitario corresponde ao valor final a que o artigo sera vendido na perfumaria.',
  `tipo` VARCHAR(15) NULL COMMENT 'Corresponde ao tipo de pessoa a que um perfume se destina. Por exemplo Homem, Crianca, Mulher etc..',
  `idFamiliaOlfativa` INT NOT NULL COMMENT 'Identificador da familia olfativa a que o perfume se insere. Por exemplo: Oriental, Floral, Amadeirado etc..',
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPerfume`),
  INDEX `fk_Perfume_FamiliaOlfativa1_idx` (`idFamiliaOlfativa` ASC),
  CONSTRAINT `fk_Perfume_FamiliaOlfativa1`
    FOREIGN KEY (`idFamiliaOlfativa`)
    REFERENCES `perfumaria_perfurmarte`.`FamiliaOlfativa` (`idFamiliaOlfativa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`VendaPerfume`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`VendaPerfume` (
  `idVenda` INT NOT NULL COMMENT 'Identificador da venda realizada por um cliente.',
  `idPerfume` INT NOT NULL COMMENT 'Identificador de um perfume no sistema',
  `precoVenda` FLOAT NOT NULL COMMENT 'Preco em euros a que um determinado perfume foi vendido a data da realizacao da venda. ',
  `quantidade` INT NOT NULL COMMENT 'Quantidade vendida de um artigo adquirido por um cliente numa venda registada no sistema.',
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_VendaPerfume_Venda1_idx` (`idVenda` ASC),
  INDEX `fk_VendaPerfume_Perfume1_idx` (`idPerfume` ASC),
  PRIMARY KEY (`idVenda`, `idPerfume`),
  CONSTRAINT `fk_VendaPerfume_Venda1`
    FOREIGN KEY (`idVenda`)
    REFERENCES `perfumaria_perfurmarte`.`Venda` (`idVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VendaPerfume_Perfume1`
    FOREIGN KEY (`idPerfume`)
    REFERENCES `perfumaria_perfurmarte`.`Perfume` (`idPerfume`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
