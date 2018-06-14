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









USE `perfumaria_perfurmarte`;

--
-- Data for table Cliente
--
INSERT INTO Cliente VALUES
(1, 'Avelino F Pereira Rodrigues', 220978420, 'avelinofpereirarodrigues@gmail.com', 'Ciências Biológicas', '1991-06-03', 'Famalicão', '2015-11-09 11:10:23', '2015-11-09 11:10:23'),
(2, 'Custódio Pereira Jorge', 259148419, 'custodiopereirajorge@gmail.com', 'História', '1968-01-19', 'Braga', '2015-11-12 11:10:23', '2015-11-12 11:10:23'),
(3, 'Silva Mário A V Santos', 207101636, 'silvamarioavsantos@gmail.com', 'Materiais', '1971-12-04', 'Famalicão', '2015-11-19 11:10:23', '2015-11-19 11:10:23'),
(4, 'Elaine Rodrigues Silva', 928051373, 'elainerodriguessilva@gmail.com', 'Serviço Social', '1981-06-16', 'Vizela', '2015-11-21 11:10:23', '2015-11-21 11:10:23'),
(5, 'Helena C Moreira Silva', 966401648, 'helenacmoreirasilva@gmail.com', 'Gestão Comercial', '1967-08-03', 'Braga', '2015-11-22 11:10:23', '2015-11-22 11:10:23'),
(6, 'Mário A V Santos Silva ', 244042707, 'marioavsantossilva@gmail.com', 'Rádio e TV', '1955-10-14', 'Famalicão', '2015-11-25 11:10:23', '2015-11-25 11:10:23'),
(7, 'José M Araújo Soares', 274670206, 'josemaraujosoares@gmail.com', 'Fabricação Mecânica', '1953-06-11', 'Famalicão', '2015-12-19 11:10:23', '2015-12-19 11:10:23'),
(8, 'Gisela M Almeida Benjamim', 274253030, 'giselamalmeidabenjamim@gmail.com', 'Logística', '1983-07-03', 'Esposende', '2015-12-28 11:10:23', '2015-12-28 11:10:23'),
(9, 'Alves Pereira & Martins Lda', 202268788, 'alvespereira&martinslda@gmail.com', 'Materiais', '1964-02-21', 'Famalicão', '2016-01-08 11:10:23', '2016-01-08 11:10:23'),
(10, 'Hermínio Antunes Vicente', 938282747, 'herminioantunesvicente@gmail.com', 'Estética e Cosmética', '1974-05-16', 'Barcelos', '2016-01-15 11:10:23', '2016-01-15 11:10:23');

--
-- Data for table FamiliaOlfativa
--
INSERT INTO FamiliaOlfativa VALUES
(1, 'Amadeirado', '2015-01-01 21:50:01'),
(2, 'Chipre', '2015-01-01 21:50:01'),
(3, 'Cítrico', '2015-01-01 21:50:01'),
(4, 'Floral', '2015-01-01 21:50:02'),
(5, 'Floriental', '2015-01-01 21:50:02'),
(6, 'Fougère', '2015-01-01 21:50:02'),
(7, 'Oriental', '2015-01-01 21:50:03');

--
-- Data for table Funcionario
--
INSERT INTO Funcionario VALUES
(1, 'Ana Filipa Oliveira e Sousa', 281933441, 'Famalicão', '2015-01-01 20:57:47', '2015-01-01 20:57:47'),
(2, 'Carlos Diogo da Silva Sa', 259718770, 'Barcelos', '2015-01-01 20:57:47', '2015-01-01 20:57:47'),
(3, 'Janine Marlene Duarte da Silva Freitas', 964379535, 'Famalicão', '2015-01-01 20:57:47', '2015-01-01 20:57:47'),
(4, 'Joao Miguel Ferreira Lopes', 210892889, 'Braga', '2016-01-01 21:00:01', '2016-01-01 21:00:01');

--
-- Data for table Perfume
--
INSERT INTO Perfume VALUES
(1, 'Zen Sun', 75, '59.68', 'Mulher', 3, '2015-01-01 21:50:01'),
(2, 'La Vie est belle', 6, '47.00', 'Mulher', 5, '2015-01-01 21:50:01'),
(3, 'Yellow Diamond', 10, '38.12', 'Mulher', 1, '2015-01-01 21:50:02'),
(4, 'Misteriosa', 21, '41.97', 'Mulher', 7, '2015-01-01 21:50:02'),
(5, 'Essential', 55, '46.47', 'Homem', 3, '2015-06-29 20:50:01'),
(6, 'Sauvage', 74, '54.67', 'Homem', 6, '2015-07-01 21:50:01'),
(7, 'Vip Club', 17, '42.54', 'Homem', 2, '2015-07-01 21:50:01'),
(8, 'The Dreamer', 12, '55.44', 'Homem', 7, '2016-01-03 21:00:53'),
(9, 'Toute petite', 44, '24.64', 'Menina', 3, '2016-01-03 21:00:53'),
(10, 'Jeune homme', 66, '24.64', 'Menino', 3, '2016-01-03 21:00:54');

--
-- Data for table Venda
--
INSERT INTO Venda VALUES
(1, '2015-01-15 10:38:30', '243.32', 2, 5, '2015-01-15 10:38:30'),
(2, '2015-01-15 10:38:30', '73.92', 3, 9, '2015-01-15 10:38:30'),
(3, '2015-03-01 11:15:13', '65.30', 1, 8, '2015-03-01 11:15:13'),
(4, '2015-05-11 14:24:11', '42.54', 4, 2, '2015-05-11 14:24:11'),
(5, '2015-05-28 21:54:33', '166.32', 2, 6, '2015-05-28 21:54:33'),
(6, '2015-05-28 21:54:33', '166.32', 2, 2, '2015-05-28 21:54:33'),
(7, '2016-03-09 10:02:31', '38.31', 2, 4, '2016-03-09 10:02:31'),
(8, '2016-06-09 22:12:38', '127.62', 2, 3, '2016-06-09 22:12:38'),
(9, '2016-08-26 11:38:19', '47.55', 1, 1, '2016-08-26 11:38:19'),
(10, '2016-11-12 12:22:21', '166.32', 3, 7, '2016-11-12 12:22:21');

--
-- Data for table VendaPerfume
--
INSERT INTO VendaPerfume VALUES
(1, 6, '60.83', 4, '2015-01-15 10:38:30'),
(2, 4, '59.68', 2, '2015-01-15 10:38:30'),
(3, 7, '32.65', 2, '2015-03-01 11:15:13'),
(4, 8, '32.65', 3, '2015-05-11 14:24:11'),
(5, 2, '41.97', 1, '2015-05-28 21:54:33'),
(6, 10, '55.44', 1, '2015-05-28 21:54:33'),
(7, 9, '38.12', 2, '2016-03-09 10:02:31'),
(8, 1, '46.47', 3, '2016-06-09 22:12:38'),
(9, 3, '24.64', 1, '2016-08-26 11:38:19'),
(10, 5, '32.65', 3, '2016-11-12 12:22:21');








USE `perfumaria_perfurmarte` ;

-- -----------------------------------------------------
-- procedure d_audTables
-- -----------------------------------------------------
DELIMITER $$
USE `perfumaria_perfurmarte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `d_audTables`()
BEGIN
delete from audcliente;
delete from audfuncionario;
delete from audperfume;
delete from audvenda;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure pr_IaudCliente
-- -----------------------------------------------------

DELIMITER $$
USE `perfumaria_perfurmarte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_IaudCliente`()
BEGIN
INSERT INTO `perfumaria_perfurmarte`.`audcliente` 
(
`idCliente`, 
`nome`,
`cidade`, 
`tipo_operacao`, 
`data_operacao`
)
SELECT idCartao as idCliente, nome,
cidade, "I", now() FROM cliente;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure pr_IaudFuncionario
-- -----------------------------------------------------

DELIMITER $$
USE `perfumaria_perfurmarte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_IaudFuncionario`()
BEGIN
INSERT INTO `perfumaria_perfurmarte`.`audfuncionario` 
(
`idFuncionario`, 
`nome`,
`cidade`, 
`tipo_operacao`, 
`data_operacao`
)
SELECT idFuncionario, nome,
cidade, "I", now() FROM Funcionario;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure pr_IaudPerfume
-- -----------------------------------------------------

DELIMITER $$
USE `perfumaria_perfurmarte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_IaudPerfume`()
BEGIN
INSERT INTO `perfumaria_perfurmarte`.`audperfume` 
(
`idPerfume`, 
`tipo`,
`categoria`, 
`tipo_operacao`, 
`data_operacao`
)
SELECT idPerfume, tipo,
(SELECT tipo as categoria FROM FamiliaOlfativa where perfume.idFamiliaOlfativa = familiaOlfativa.idFamiliaOLfativa),
 "I", now() FROM Perfume;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure pr_IaudVenda
-- -----------------------------------------------------

DELIMITER $$
USE `perfumaria_perfurmarte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_IaudVenda`()
BEGIN
INSERT INTO `perfumaria_perfurmarte`.`audvenda` 
(
`idVenda`,
`idPerfume`,
`idFuncionario`,
`idCliente`,
`data`,
`precoUnit`,
`quantidade`,
`custoTotal`, 
`tipo_operacao`, 
`data_operacao`
)
SELECT idVenda,
(SELECT idPerfume as idPerfume FROM VendaPerfume where Venda.idVenda = vendaPerfume.idVenda),
idFuncionario, idCliente, data, 
(SELECT precoVenda as precoUnit FROM VendaPerfume where Venda.idVenda = vendaPerfume.idVenda),
(SELECT quantidade FROM VendaPerfume where Venda.idVenda = vendaPerfume.idVenda),
 custoTotal, "I", now() FROM Venda;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure pr_teste
-- -----------------------------------------------------

DELIMITER $$
USE `perfumaria_perfurmarte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_teste`(IN id INT , IN nomeC varchar(45), IN morada varchar(45), IN sourceI INT(1))
BEGIN
INSERT INTO 
`perfumaria_perfurmarte`.`teste`
(
`SKCliente`, 
`nome`,
`cidade`,
`source`
)
VALUES(id, nomeC, morada, sourceI);
END$$

DELIMITER ;








USE `perfumaria_perfurmarte`;

-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`audCliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `perfumaria_perfurmarte`.`audCliente`;
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`audCliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `telemovel` INT(9) NULL,
  `email` VARCHAR(45) NULL,
  `profissao` VARCHAR(45) NULL,
  `dataNascimento` DATE NULL,
  `cidade` VARCHAR(45) NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  `dataOperacao` TIMESTAMP NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`audFuncionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `perfumaria_perfurmarte`.`audFuncionario`;
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`audFuncionario` (
  `idFuncionario` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `telemovel` INT(9) NULL,
  `cidade` VARCHAR(45) NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  `dataOperacao` TIMESTAMP NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`audPerfume`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `perfumaria_perfurmarte`.`audPerfume`;
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`audPerfume` (
  `idPerfume` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `stock` INT(11) NULL,
  `precoUnitario` FLOAT NULL,
  `tipo` VARCHAR(15) NULL,
  `categoria` VARCHAR(45) NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  `dataOperacao` TIMESTAMP NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `perfumaria_perfurmarte`.`audVenda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `perfumaria_perfurmarte`.`audVenda`;
CREATE TABLE IF NOT EXISTS `perfumaria_perfurmarte`.`audVenda` (
  `idVenda` INT NOT NULL,
  `idPerfume` INT NOT NULL,
  `idFuncionario` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `data` TIMESTAMP NULL DEFAULT NULL,
  `precoUnit` FLOAT DEFAULT NULL,
  `quantidade` INT(11) DEFAULT NULL,
  `custoTotal` FLOAT DEFAULT NULL,
  `tipoOperacao` VARCHAR(1) DEFAULT NULL,
  `dataOperacao` TIMESTAMP NULL DEFAULT NULL)
ENGINE = InnoDB;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_insercaoCliente
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_insercaoCliente;
delimiter &&
CREATE TRIGGER tg_insercaoCliente 
  AFTER INSERT ON Cliente
  FOR EACH ROW
  BEGIN
    INSERT INTO audCliente 
    VALUES (
        NEW.idCartao, NEW.nome, NEW.telemovel, NEW.email,
        NEW.profissao, NEW.dataNascimento, NEW.cidade, 'I', NOW()
                );
  END;
&& delimiter ;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_updateCliente
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_updateCliente;
delimiter &&
CREATE TRIGGER tg_updateCliente 
  AFTER UPDATE ON Cliente
  FOR EACH ROW
  BEGIN
    INSERT INTO audCliente 
    VALUES (
        NEW.idCartao, NEW.nome, NEW.telemovel, NEW.email,
        NEW.profissao, NEW.dataNascimento, NEW.cidade, 'U', NOW()
                );
  END;
&& delimiter ;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_insercaoFuncionario
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_insercaoFuncionario;
delimiter &&
CREATE TRIGGER tg_insercaoFuncionario 
  AFTER INSERT ON Funcionario
  FOR EACH ROW
  BEGIN
    INSERT INTO audFuncionario 
    VALUES (
        NEW.idFuncionario, NEW.nome, NEW.telemovel,
                NEW.cidade, 'I', NOW()
                );
  END;
&& delimiter ;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_updateFuncionario
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_updateFuncionario;
delimiter &&
CREATE TRIGGER tg_updateFuncionario
  AFTER UPDATE ON Funcionario
  FOR EACH ROW
  BEGIN
    INSERT INTO audFuncionario 
    VALUES (
        NEW.idFuncionario, NEW.nome, NEW.telemovel,
                NEW.cidade, 'U', NOW()
                );
  END;
&& delimiter ;

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_insercaoPerfume
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_insercaoPerfume;
delimiter &&
CREATE TRIGGER tg_insercaoPerfume
  AFTER INSERT ON Perfume
  FOR EACH ROW
  BEGIN
    INSERT INTO audPerfume
    VALUES (
        NEW.idPerfume, NEW.nome, NEW.stock,
                NEW.precoUnitario, NEW.tipo, NEW.idFamiliaOlfativa,
                'I', NOW()
                );
  END;
&& delimiter ;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_updatePerfume
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_updatePerfume;
delimiter &&
CREATE TRIGGER tg_updatePerfume
  AFTER UPDATE ON Perfume
  FOR EACH ROW
  BEGIN
    INSERT INTO audPerfume
    VALUES (
        NEW.idPerfume, NEW.nome, NEW.stock,
                NEW.precoUnitario, NEW.tipo, NEW.idFamiliaOlfativa,
                'U', NOW()
                );
  END;
&& delimiter ;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_insercaoVenda
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_insercaoVendaPerfume;
delimiter &&
CREATE TRIGGER tg_insercaoVendaPerfume
  AFTER INSERT ON vendaperfume
    FOR EACH ROW
    BEGIN
    DECLARE idF int;
        DECLARE idC int;
        DECLARE d datetime;
        DECLARE ct float;
        SELECT idFuncionario FROM venda WHERE venda.idVenda = NEW.idVenda INTO idF;
        SELECT idCliente FROM venda WHERE venda.idVenda = NEW.idVenda INTO idC;
        SELECT data FROM venda WHERE venda.idVenda = NEW.idVenda INTO d;
        SELECT custoTotal FROM venda WHERE venda.idVenda = NEW.idVenda INTO ct;
    INSERT INTO audVenda
    VALUES (
        NEW.idVenda, NEW.idPerfume, idF, 
                idC, d, NEW.precoVenda, NEW.quantidade, 
                ct, 'I', NOW()
    );
    END
&& delimiter ;
-- DROP TRIGGER IF EXISTS tg_insercaoVenda;
-- delimiter &&
-- CREATE TRIGGER tg_insercaoVenda
  -- AFTER INSERT ON Venda
  -- FOR EACH ROW
  -- BEGIN
    -- INSERT INTO audVenda
    -- VALUES (
        -- NEW.idVenda, NEW.data, NEW.custoTotal,
                -- NEW.idFuncionario, NEW.idCliente, 'I', NOW()
                -- );
  -- END;
--&& delimiter ;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_updateVenda
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- DROP TRIGGER IF EXISTS tg_updateVenda;
-- delimiter &&
-- CREATE TRIGGER tg_updateVenda
  -- AFTER UPDATE ON Venda
  -- FOR EACH ROW
  -- BEGIN
    -- INSERT INTO audVenda
    -- VALUES (
        -- NEW.idVenda, NEW.data, NEW.custoTotal,
                -- NEW.idFuncionario, NEW.idCliente, 'U', NOW()
                -- );
  -- END;
-- && delimiter ;













DROP SCHEMA IF EXISTS `ar_perfurmar` ;
CREATE SCHEMA IF NOT EXISTS `ar_perfurmar` DEFAULT CHARACTER SET utf8 ;
USE `ar_perfurmar` ;



--
-- Table structure for table `audit_dim_cliente_fonte1`
--
DROP TABLE IF EXISTS `audit_dim_cliente_fonte1`;
CREATE TABLE `audit_dim_cliente_fonte1` (
  `idCliente` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` int(9) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `profissao` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `audit_dim_cliente_fonte2`
--
DROP TABLE IF EXISTS `audit_dim_cliente_fonte2`;
CREATE TABLE `audit_dim_cliente_fonte2` (
  `idCliente` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` int(9) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `profissao` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `audit_dim_funcionario_fonte1`
--
DROP TABLE IF EXISTS `audit_dim_funcionario_fonte1`;
CREATE TABLE `audit_dim_funcionario_fonte1` (
  `idFuncionario` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` int(11) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `audit_dim_funcionario_fonte2`
--
DROP TABLE IF EXISTS `audit_dim_funcionario_fonte2`;
CREATE TABLE `audit_dim_funcionario_fonte2` (
  `idFuncionario` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` int(11) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `audit_dim_perfume_fonte1`
--
DROP TABLE IF EXISTS `audit_dim_perfume_fonte1`;
CREATE TABLE `audit_dim_perfume_fonte1` (
  `idPerfume` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precoUnitario` float DEFAULT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `audit_dim_perfume_fonte2`
--
DROP TABLE IF EXISTS `audit_dim_perfume_fonte2`;
CREATE TABLE `audit_dim_perfume_fonte2` (
  `idPerfume` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precoUnitario` float DEFAULT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



--
-- Table structure for table `audit_dim_venda_fonte1`
--
DROP TABLE IF EXISTS `audit_dim_venda_fonte1`;
CREATE TABLE `audit_dim_venda_fonte1` (
  `idVenda` int(11) DEFAULT NULL,
  `idPerfume` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `data` timestamp NULL DEFAULT NULL,
  `precoUnit` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `custoTotal` float DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `audit_dim_venda_fonte2`
--
DROP TABLE IF EXISTS `audit_dim_venda_fonte2`;
CREATE TABLE `audit_dim_venda_fonte2` (
  `idVenda` int(11) DEFAULT NULL,
  `idPerfume` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `data` timestamp NULL DEFAULT NULL,
  `precoUnit` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `custoTotal` float DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `lookuptable_cliente`
--
DROP TABLE IF EXISTS `lookuptable_cliente`;
CREATE TABLE `lookuptable_cliente` (
  `SKCliente` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente_fonte1` varchar(45) DEFAULT NULL,
  `idCliente_fonte2` varchar(45) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `idade` int(11) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`SKCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;


--
-- Table structure for table `lookuptable_data`
--
DROP TABLE IF EXISTS `lookuptable_data`;
CREATE TABLE `lookuptable_data` (
  `SKData` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `dia` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `trimestre` int(11) NOT NULL,
  `semestre` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  PRIMARY KEY (`SKData`)
) ENGINE=InnoDB AUTO_INCREMENT=4744 DEFAULT CHARSET=utf8;


--
-- Table structure for table `lookuptable_funcionario`
--
DROP TABLE IF EXISTS `lookuptable_funcionario`;
CREATE TABLE `lookuptable_funcionario` (
  `SKFuncionario` int(11) NOT NULL AUTO_INCREMENT,
  `idFuncionario_fonte1` int(11) DEFAULT NULL,
  `idFuncionario_fonte2` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `telemovel` int(9) DEFAULT NULL,
  PRIMARY KEY (`SKFuncionario`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;


--
-- Table structure for table `lookuptable_perfume`
--
DROP TABLE IF EXISTS `lookuptable_perfume`;
CREATE TABLE `lookuptable_perfume` (
  `SKPerfume` int(11) NOT NULL AUTO_INCREMENT,
  `idPerfume_fonte1` int(11) DEFAULT NULL,
  `idPerfume_fonte2` int(11) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`SKPerfume`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;


--
-- Table structure for table `lookuptable_vendas`
--
DROP TABLE IF EXISTS `lookuptable_vendas`;
CREATE TABLE `lookuptable_vendas` (
  `SKVenda` int(11) NOT NULL AUTO_INCREMENT,
  `idVenda` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `custoTotal` float DEFAULT NULL,
  `idFuncionario` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `fonte` int(11) DEFAULT NULL,
  PRIMARY KEY (`SKVenda`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_dim_cliente`
--
DROP TABLE IF EXISTS `mei_dim_cliente`;
CREATE TABLE `mei_dim_cliente` (
  `idmei_dim_cliente` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `idade` varchar(45) DEFAULT NULL,
  `fonte` int(11) NOT NULL,
  PRIMARY KEY (`idmei_dim_cliente`,`fonte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_dim_clientea`
--
DROP TABLE IF EXISTS `mei_dim_clientea`;
CREATE TABLE `mei_dim_clientea` (
  `idCliente` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `idade` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_dim_clienteb`
--
DROP TABLE IF EXISTS `mei_dim_clienteb`;
CREATE TABLE `mei_dim_clienteb` (
  `idCliente` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `idade` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_dim_funcionarioa`
--
DROP TABLE IF EXISTS `mei_dim_funcionarioa`;
CREATE TABLE `mei_dim_funcionarioa` (
  `idFuncionario` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_dim_funcionariob`
--
DROP TABLE IF EXISTS `mei_dim_funcionariob`;
CREATE TABLE `mei_dim_funcionariob` (
  `idFuncionario` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_dim_perfumea`
--
DROP TABLE IF EXISTS `mei_dim_perfumea`;
CREATE TABLE `mei_dim_perfumea` (
  `idPerfume` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precoUnitario` float DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_dim_perfumeb`
--
DROP TABLE IF EXISTS `mei_dim_perfumeb`;
CREATE TABLE `mei_dim_perfumeb` (
  `idPerfume` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precoUnitario` float DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_tfvendaa`
--
DROP TABLE IF EXISTS `mei_tfvendaa`;
CREATE TABLE `mei_tfvendaa` (
  `idVenda` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `custoTotal` float DEFAULT NULL,
  `idFuncionario` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_tfvendab`
--
DROP TABLE IF EXISTS `mei_tfvendab`;
CREATE TABLE `mei_tfvendab` (
  `idVenda` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `custoTotal` float DEFAULT NULL,
  `idFuncionario` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_tfvendapa`
--
DROP TABLE IF EXISTS `mei_tfvendapa`;
CREATE TABLE `mei_tfvendapa` (
  `idVenda` int(11) NOT NULL,
  `idPerfume` int(11) NOT NULL,
  `precoVenda` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_tfvendapb`
--
DROP TABLE IF EXISTS `mei_tfvendapb`;
CREATE TABLE `mei_tfvendapb` (
  `idVenda` int(11) NOT NULL,
  `idPerfume` int(11) NOT NULL,
  `precoVenda` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `mei_tfvendas`
--
DROP TABLE IF EXISTS `mei_tfvendas`;
CREATE TABLE `mei_tfvendas` (
  `idVenda` int(11) NOT NULL,
  `idPerfume` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `idFuncionario` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `precoVenda` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `custoTotal` float DEFAULT NULL,
  `fonte` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVenda`,`idPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_dim_cliente`
--
DROP TABLE IF EXISTS `pos_dim_cliente`;
CREATE TABLE `pos_dim_cliente` (
  `idCliente` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `idade` int(11) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telemovel` int(9) NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_dim_clientehistoria`
--
DROP TABLE IF EXISTS `pos_dim_clientehistoria`;
CREATE TABLE `pos_dim_clientehistoria` (
  `id_modificacao` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telemovel` int(11) NOT NULL,
  `data_modificacao` datetime NOT NULL,
  PRIMARY KEY (`id_modificacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `ar_perfurmar`.`pos_dim_clienteu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pos_dim_clienteu`;
CREATE TABLE `pos_dim_clienteu` (
  `idCliente` INT(11) NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `cidade` VARCHAR(45) NULL DEFAULT NULL,
  `idade` INT(11) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `telemovel` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_dim_data`
--
DROP TABLE IF EXISTS `pos_dim_data`;
CREATE TABLE `pos_dim_data` (
  `SKData` int(11) NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  PRIMARY KEY (`SKData`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_dim_funcionario`
--
DROP TABLE IF EXISTS `pos_dim_funcionario`;
CREATE TABLE `pos_dim_funcionario` (
  `idFuncionario` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `telemovel` int(9) NOT NULL,
  PRIMARY KEY (`idFuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_dim_funcionariohistoria`
--
DROP TABLE IF EXISTS `pos_dim_funcionariohistoria`;
CREATE TABLE `pos_dim_funcionariohistoria` (
  `id_modificacao` int(11) NOT NULL,
  `idFuncionario` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telemovel` int(9) NOT NULL,
  `data_modificacao` datetime NOT NULL,
  PRIMARY KEY (`id_modificacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_dim_perfume`
--
DROP TABLE IF EXISTS `pos_dim_perfume`;
CREATE TABLE `pos_dim_perfume` (
  `idPerfume` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `tipo` varchar(15) NOT NULL,
  `categoria` varchar(45) NOT NULL,
  PRIMARY KEY (`idPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_dim_perfumehistoria`
--
DROP TABLE IF EXISTS `pos_dim_perfumehistoria`;
CREATE TABLE `pos_dim_perfumehistoria` (
  `id_modificacao` int(11) NOT NULL,
  `idPerfume` int(11) NOT NULL,
  `precoUnitario` float NOT NULL,
  `data_modificacao` date NOT NULL,
  PRIMARY KEY (`id_modificacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pos_tf_venda`
--
DROP TABLE IF EXISTS `pos_tf_venda`;
CREATE TABLE `pos_tf_venda` (
  `SKPerfume` int(11) NOT NULL,
  `SKCliente` int(11) NOT NULL,
  `SKFuncionario` int(11) NOT NULL,
  `SKData` int(11) NOT NULL,
  `custoTotal` float NOT NULL,
  `precoUnitario` float NOT NULL,
  `quantidade` int(11) NOT NULL,
  PRIMARY KEY (`SKPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_dim_clientea`
--
DROP TABLE IF EXISTS `pre_dim_clientea`;
CREATE TABLE `pre_dim_clientea` (
  `idCliente` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `profissao` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_dim_clienteb`
--
DROP TABLE IF EXISTS `pre_dim_clienteb`;
CREATE TABLE `pre_dim_clienteb` (
  `idCliente` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `profissao` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_dim_data`
--
DROP TABLE IF EXISTS `pre_dim_data`;
CREATE TABLE `pre_dim_data` (
  `data` datetime NOT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  PRIMARY KEY (`data`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_dim_funcionarioa`
--
DROP TABLE IF EXISTS `pre_dim_funcionarioa`;
CREATE TABLE `pre_dim_funcionarioa` (
  `idFuncionario` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `telemovel` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_dim_funcionariob`
--
DROP TABLE IF EXISTS `pre_dim_funcionariob`;
CREATE TABLE `pre_dim_funcionariob` (
  `idFuncionario` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_dim_perfumea`
--
DROP TABLE IF EXISTS `pre_dim_perfumea`;
CREATE TABLE `pre_dim_perfumea` (
  `idPerfume` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `stock` int(11) NOT NULL,
  `precoUnitario` float NOT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_dim_perfumeb`
--
DROP TABLE IF EXISTS `pre_dim_perfumeb`;
CREATE TABLE `pre_dim_perfumeb` (
  `idPerfume` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precoUnitario` float DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_tfvendaa`
--
DROP TABLE IF EXISTS `pre_tfvendaa`;
CREATE TABLE `pre_tfvendaa` (
  `idVenda` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `custoTotal` varchar(45) DEFAULT NULL,
  `idFuncionario` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` date DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_tfvendab`
--
DROP TABLE IF EXISTS `pre_tfvendab`;
CREATE TABLE `pre_tfvendab` (
  `idVenda` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `custoTotal` varchar(45) DEFAULT NULL,
  `idFuncionario` int(11) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` date DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_tfvendapa`
--
DROP TABLE IF EXISTS `pre_tfvendapa`;
CREATE TABLE `pre_tfvendapa` (
  `idVenda` int(11) NOT NULL,
  `idPerfume` int(11) DEFAULT NULL,
  `precoVenda` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` date DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `pre_tfvendapb`
--
DROP TABLE IF EXISTS `pre_tfvendapb`;
CREATE TABLE `pre_tfvendapb` (
  `idVenda` int(11) NOT NULL,
  `idPerfume` int(11) DEFAULT NULL,
  `precoVenda` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` date DEFAULT NULL,
  PRIMARY KEY (`idVenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;









USE `ar_perfurmar` ;

--
-- Dumping data for table `lookuptable_data`
--
LOCK TABLES `lookuptable_data` WRITE;
INSERT INTO `lookuptable_data` VALUES (3163,'2015-01-01 00:00:00',1,1,1,1,2015),(3164,'2015-01-02 00:00:00',2,1,1,1,2015),(3165,'2015-01-03 00:00:00',3,1,1,1,2015),(3166,'2015-01-04 00:00:00',4,1,1,1,2015),(3167,'2015-01-05 00:00:00',5,1,1,1,2015),(3168,'2015-01-06 00:00:00',6,1,1,1,2015),(3169,'2015-01-07 00:00:00',7,1,1,1,2015),(3170,'2015-01-08 00:00:00',8,1,1,1,2015),(3171,'2015-01-09 00:00:00',9,1,1,1,2015),(3172,'2015-01-10 00:00:00',10,1,1,1,2015),(3173,'2015-01-11 00:00:00',11,1,1,1,2015),(3174,'2015-01-12 00:00:00',12,1,1,1,2015),(3175,'2015-01-13 00:00:00',13,1,1,1,2015),(3176,'2015-01-14 00:00:00',14,1,1,1,2015),(3177,'2015-01-15 00:00:00',15,1,1,1,2015),(3178,'2015-01-16 00:00:00',16,1,1,1,2015),(3179,'2015-01-17 00:00:00',17,1,1,1,2015),(3180,'2015-01-18 00:00:00',18,1,1,1,2015),(3181,'2015-01-19 00:00:00',19,1,1,1,2015),(3182,'2015-01-20 00:00:00',20,1,1,1,2015),(3183,'2015-01-21 00:00:00',21,1,1,1,2015),(3184,'2015-01-22 00:00:00',22,1,1,1,2015),(3185,'2015-01-23 00:00:00',23,1,1,1,2015),(3186,'2015-01-24 00:00:00',24,1,1,1,2015),(3187,'2015-01-25 00:00:00',25,1,1,1,2015),(3188,'2015-01-26 00:00:00',26,1,1,1,2015),(3189,'2015-01-27 00:00:00',27,1,1,1,2015),(3190,'2015-01-28 00:00:00',28,1,1,1,2015),(3191,'2015-01-29 00:00:00',29,1,1,1,2015),(3192,'2015-01-30 00:00:00',30,1,1,1,2015),(3193,'2015-01-31 00:00:00',31,1,1,1,2015),(3194,'2015-02-01 00:00:00',1,2,1,1,2015),(3195,'2015-02-02 00:00:00',2,2,1,1,2015),(3196,'2015-02-03 00:00:00',3,2,1,1,2015),(3197,'2015-02-04 00:00:00',4,2,1,1,2015),(3198,'2015-02-05 00:00:00',5,2,1,1,2015),(3199,'2015-02-06 00:00:00',6,2,1,1,2015),(3200,'2015-02-07 00:00:00',7,2,1,1,2015),(3201,'2015-02-08 00:00:00',8,2,1,1,2015),(3202,'2015-02-09 00:00:00',9,2,1,1,2015),(3203,'2015-02-10 00:00:00',10,2,1,1,2015),(3204,'2015-02-11 00:00:00',11,2,1,1,2015),(3205,'2015-02-12 00:00:00',12,2,1,1,2015),(3206,'2015-02-13 00:00:00',13,2,1,1,2015),(3207,'2015-02-14 00:00:00',14,2,1,1,2015),(3208,'2015-02-15 00:00:00',15,2,1,1,2015),(3209,'2015-02-16 00:00:00',16,2,1,1,2015),(3210,'2015-02-17 00:00:00',17,2,1,1,2015),(3211,'2015-02-18 00:00:00',18,2,1,1,2015),(3212,'2015-02-19 00:00:00',19,2,1,1,2015),(3213,'2015-02-20 00:00:00',20,2,1,1,2015),(3214,'2015-02-21 00:00:00',21,2,1,1,2015),(3215,'2015-02-22 00:00:00',22,2,1,1,2015),(3216,'2015-02-23 00:00:00',23,2,1,1,2015),(3217,'2015-02-24 00:00:00',24,2,1,1,2015),(3218,'2015-02-25 00:00:00',25,2,1,1,2015),(3219,'2015-02-26 00:00:00',26,2,1,1,2015),(3220,'2015-02-27 00:00:00',27,2,1,1,2015),(3221,'2015-02-28 00:00:00',28,2,1,1,2015),(3222,'2015-03-01 00:00:00',1,2,1,1,2015),(3223,'2015-03-02 00:00:00',2,3,1,1,2015),(3224,'2015-03-03 00:00:00',3,3,1,1,2015),(3225,'2015-03-04 00:00:00',4,3,1,1,2015),(3226,'2015-03-05 00:00:00',5,3,1,1,2015),(3227,'2015-03-06 00:00:00',6,3,1,1,2015),(3228,'2015-03-07 00:00:00',7,3,1,1,2015),(3229,'2015-03-08 00:00:00',8,3,1,1,2015),(3230,'2015-03-09 00:00:00',9,3,1,1,2015),(3231,'2015-03-10 00:00:00',10,3,1,1,2015),(3232,'2015-03-11 00:00:00',11,3,1,1,2015),(3233,'2015-03-12 00:00:00',12,3,1,1,2015),(3234,'2015-03-13 00:00:00',13,3,1,1,2015),(3235,'2015-03-14 00:00:00',14,3,1,1,2015),(3236,'2015-03-15 00:00:00',15,3,1,1,2015),(3237,'2015-03-16 00:00:00',16,3,1,1,2015),(3238,'2015-03-17 00:00:00',17,3,1,1,2015),(3239,'2015-03-18 00:00:00',18,3,1,1,2015),(3240,'2015-03-19 00:00:00',19,3,1,1,2015),(3241,'2015-03-20 00:00:00',20,3,1,1,2015),(3242,'2015-03-21 00:00:00',21,3,1,1,2015),(3243,'2015-03-22 00:00:00',22,3,1,1,2015),(3244,'2015-03-23 00:00:00',23,3,1,1,2015),(3245,'2015-03-24 00:00:00',24,3,1,1,2015),(3246,'2015-03-25 00:00:00',25,3,1,1,2015),(3247,'2015-03-26 00:00:00',26,3,1,1,2015),(3248,'2015-03-27 00:00:00',27,3,1,1,2015),(3249,'2015-03-28 00:00:00',28,3,1,1,2015),(3250,'2015-03-29 00:00:00',29,3,1,1,2015),(3251,'2015-03-30 00:00:00',30,3,1,1,2015),(3252,'2015-03-31 00:00:00',31,3,1,1,2015),(3253,'2015-04-01 00:00:00',1,3,2,1,2015),(3254,'2015-04-02 00:00:00',2,4,2,1,2015),(3255,'2015-04-03 00:00:00',3,4,2,1,2015),(3256,'2015-04-04 00:00:00',4,4,2,1,2015),(3257,'2015-04-05 00:00:00',5,4,2,1,2015),(3258,'2015-04-06 00:00:00',6,4,2,1,2015),(3259,'2015-04-07 00:00:00',7,4,2,1,2015),(3260,'2015-04-08 00:00:00',8,4,2,1,2015),(3261,'2015-04-09 00:00:00',9,4,2,1,2015),(3262,'2015-04-10 00:00:00',10,4,2,1,2015),(3263,'2015-04-11 00:00:00',11,4,2,1,2015),(3264,'2015-04-12 00:00:00',12,4,2,1,2015),(3265,'2015-04-13 00:00:00',13,4,2,1,2015),(3266,'2015-04-14 00:00:00',14,4,2,1,2015),(3267,'2015-04-15 00:00:00',15,4,2,1,2015),(3268,'2015-04-16 00:00:00',16,4,2,1,2015),(3269,'2015-04-17 00:00:00',17,4,2,1,2015),(3270,'2015-04-18 00:00:00',18,4,2,1,2015),(3271,'2015-04-19 00:00:00',19,4,2,1,2015),(3272,'2015-04-20 00:00:00',20,4,2,1,2015),(3273,'2015-04-21 00:00:00',21,4,2,1,2015),(3274,'2015-04-22 00:00:00',22,4,2,1,2015),(3275,'2015-04-23 00:00:00',23,4,2,1,2015),(3276,'2015-04-24 00:00:00',24,4,2,1,2015),(3277,'2015-04-25 00:00:00',25,4,2,1,2015),(3278,'2015-04-26 00:00:00',26,4,2,1,2015),(3279,'2015-04-27 00:00:00',27,4,2,1,2015),(3280,'2015-04-28 00:00:00',28,4,2,1,2015),(3281,'2015-04-29 00:00:00',29,4,2,1,2015),(3282,'2015-04-30 00:00:00',30,4,2,1,2015),(3283,'2015-05-01 00:00:00',1,4,2,1,2015),(3284,'2015-05-02 00:00:00',2,5,2,1,2015),(3285,'2015-05-03 00:00:00',3,5,2,1,2015),(3286,'2015-05-04 00:00:00',4,5,2,1,2015),(3287,'2015-05-05 00:00:00',5,5,2,1,2015),(3288,'2015-05-06 00:00:00',6,5,2,1,2015),(3289,'2015-05-07 00:00:00',7,5,2,1,2015),(3290,'2015-05-08 00:00:00',8,5,2,1,2015),(3291,'2015-05-09 00:00:00',9,5,2,1,2015),(3292,'2015-05-10 00:00:00',10,5,2,1,2015),(3293,'2015-05-11 00:00:00',11,5,2,1,2015),(3294,'2015-05-12 00:00:00',12,5,2,1,2015),(3295,'2015-05-13 00:00:00',13,5,2,1,2015),(3296,'2015-05-14 00:00:00',14,5,2,1,2015),(3297,'2015-05-15 00:00:00',15,5,2,1,2015),(3298,'2015-05-16 00:00:00',16,5,2,1,2015),(3299,'2015-05-17 00:00:00',17,5,2,1,2015),(3300,'2015-05-18 00:00:00',18,5,2,1,2015),(3301,'2015-05-19 00:00:00',19,5,2,1,2015),(3302,'2015-05-20 00:00:00',20,5,2,1,2015),(3303,'2015-05-21 00:00:00',21,5,2,1,2015),(3304,'2015-05-22 00:00:00',22,5,2,1,2015),(3305,'2015-05-23 00:00:00',23,5,2,1,2015),(3306,'2015-05-24 00:00:00',24,5,2,1,2015),(3307,'2015-05-25 00:00:00',25,5,2,1,2015),(3308,'2015-05-26 00:00:00',26,5,2,1,2015),(3309,'2015-05-27 00:00:00',27,5,2,1,2015),(3310,'2015-05-28 00:00:00',28,5,2,1,2015),(3311,'2015-05-29 00:00:00',29,5,2,1,2015),(3312,'2015-05-30 00:00:00',30,5,2,1,2015),(3313,'2015-05-31 00:00:00',31,5,2,1,2015),(3314,'2015-06-01 00:00:00',1,5,2,1,2015),(3315,'2015-06-02 00:00:00',2,6,2,1,2015),(3316,'2015-06-03 00:00:00',3,6,2,1,2015),(3317,'2015-06-04 00:00:00',4,6,2,1,2015),(3318,'2015-06-05 00:00:00',5,6,2,1,2015),(3319,'2015-06-06 00:00:00',6,6,2,1,2015),(3320,'2015-06-07 00:00:00',7,6,2,1,2015),(3321,'2015-06-08 00:00:00',8,6,2,1,2015),(3322,'2015-06-09 00:00:00',9,6,2,1,2015),(3323,'2015-06-10 00:00:00',10,6,2,1,2015),(3324,'2015-06-11 00:00:00',11,6,2,1,2015),(3325,'2015-06-12 00:00:00',12,6,2,1,2015),(3326,'2015-06-13 00:00:00',13,6,2,1,2015),(3327,'2015-06-14 00:00:00',14,6,2,1,2015),(3328,'2015-06-15 00:00:00',15,6,2,1,2015),(3329,'2015-06-16 00:00:00',16,6,2,1,2015),(3330,'2015-06-17 00:00:00',17,6,2,1,2015),(3331,'2015-06-18 00:00:00',18,6,2,1,2015),(3332,'2015-06-19 00:00:00',19,6,2,1,2015),(3333,'2015-06-20 00:00:00',20,6,2,1,2015),(3334,'2015-06-21 00:00:00',21,6,2,1,2015),(3335,'2015-06-22 00:00:00',22,6,2,1,2015),(3336,'2015-06-23 00:00:00',23,6,2,1,2015),(3337,'2015-06-24 00:00:00',24,6,2,1,2015),(3338,'2015-06-25 00:00:00',25,6,2,1,2015),(3339,'2015-06-26 00:00:00',26,6,2,1,2015),(3340,'2015-06-27 00:00:00',27,6,2,1,2015),(3341,'2015-06-28 00:00:00',28,6,2,1,2015),(3342,'2015-06-29 00:00:00',29,6,2,1,2015),(3343,'2015-06-30 00:00:00',30,6,2,1,2015),(3344,'2015-07-01 00:00:00',1,6,3,1,2015),(3345,'2015-07-02 00:00:00',2,7,3,2,2015),(3346,'2015-07-03 00:00:00',3,7,3,2,2015),(3347,'2015-07-04 00:00:00',4,7,3,2,2015),(3348,'2015-07-05 00:00:00',5,7,3,2,2015),(3349,'2015-07-06 00:00:00',6,7,3,2,2015),(3350,'2015-07-07 00:00:00',7,7,3,2,2015),(3351,'2015-07-08 00:00:00',8,7,3,2,2015),(3352,'2015-07-09 00:00:00',9,7,3,2,2015),(3353,'2015-07-10 00:00:00',10,7,3,2,2015),(3354,'2015-07-11 00:00:00',11,7,3,2,2015),(3355,'2015-07-12 00:00:00',12,7,3,2,2015),(3356,'2015-07-13 00:00:00',13,7,3,2,2015),(3357,'2015-07-14 00:00:00',14,7,3,2,2015),(3358,'2015-07-15 00:00:00',15,7,3,2,2015),(3359,'2015-07-16 00:00:00',16,7,3,2,2015),(3360,'2015-07-17 00:00:00',17,7,3,2,2015),(3361,'2015-07-18 00:00:00',18,7,3,2,2015),(3362,'2015-07-19 00:00:00',19,7,3,2,2015),(3363,'2015-07-20 00:00:00',20,7,3,2,2015),(3364,'2015-07-21 00:00:00',21,7,3,2,2015),(3365,'2015-07-22 00:00:00',22,7,3,2,2015),(3366,'2015-07-23 00:00:00',23,7,3,2,2015),(3367,'2015-07-24 00:00:00',24,7,3,2,2015),(3368,'2015-07-25 00:00:00',25,7,3,2,2015),(3369,'2015-07-26 00:00:00',26,7,3,2,2015),(3370,'2015-07-27 00:00:00',27,7,3,2,2015),(3371,'2015-07-28 00:00:00',28,7,3,2,2015),(3372,'2015-07-29 00:00:00',29,7,3,2,2015),(3373,'2015-07-30 00:00:00',30,7,3,2,2015),(3374,'2015-07-31 00:00:00',31,7,3,2,2015),(3375,'2015-08-01 00:00:00',1,7,3,2,2015),(3376,'2015-08-02 00:00:00',2,8,3,2,2015),(3377,'2015-08-03 00:00:00',3,8,3,2,2015),(3378,'2015-08-04 00:00:00',4,8,3,2,2015),(3379,'2015-08-05 00:00:00',5,8,3,2,2015),(3380,'2015-08-06 00:00:00',6,8,3,2,2015),(3381,'2015-08-07 00:00:00',7,8,3,2,2015),(3382,'2015-08-08 00:00:00',8,8,3,2,2015),(3383,'2015-08-09 00:00:00',9,8,3,2,2015),(3384,'2015-08-10 00:00:00',10,8,3,2,2015),(3385,'2015-08-11 00:00:00',11,8,3,2,2015),(3386,'2015-08-12 00:00:00',12,8,3,2,2015),(3387,'2015-08-13 00:00:00',13,8,3,2,2015),(3388,'2015-08-14 00:00:00',14,8,3,2,2015),(3389,'2015-08-15 00:00:00',15,8,3,2,2015),(3390,'2015-08-16 00:00:00',16,8,3,2,2015),(3391,'2015-08-17 00:00:00',17,8,3,2,2015),(3392,'2015-08-18 00:00:00',18,8,3,2,2015),(3393,'2015-08-19 00:00:00',19,8,3,2,2015),(3394,'2015-08-20 00:00:00',20,8,3,2,2015),(3395,'2015-08-21 00:00:00',21,8,3,2,2015),(3396,'2015-08-22 00:00:00',22,8,3,2,2015),(3397,'2015-08-23 00:00:00',23,8,3,2,2015),(3398,'2015-08-24 00:00:00',24,8,3,2,2015),(3399,'2015-08-25 00:00:00',25,8,3,2,2015),(3400,'2015-08-26 00:00:00',26,8,3,2,2015),(3401,'2015-08-27 00:00:00',27,8,3,2,2015),(3402,'2015-08-28 00:00:00',28,8,3,2,2015),(3403,'2015-08-29 00:00:00',29,8,3,2,2015),(3404,'2015-08-30 00:00:00',30,8,3,2,2015),(3405,'2015-08-31 00:00:00',31,8,3,2,2015),(3406,'2015-09-01 00:00:00',1,8,3,2,2015),(3407,'2015-09-02 00:00:00',2,9,3,2,2015),(3408,'2015-09-03 00:00:00',3,9,3,2,2015),(3409,'2015-09-04 00:00:00',4,9,3,2,2015),(3410,'2015-09-05 00:00:00',5,9,3,2,2015),(3411,'2015-09-06 00:00:00',6,9,3,2,2015),(3412,'2015-09-07 00:00:00',7,9,3,2,2015),(3413,'2015-09-08 00:00:00',8,9,3,2,2015),(3414,'2015-09-09 00:00:00',9,9,3,2,2015),(3415,'2015-09-10 00:00:00',10,9,3,2,2015),(3416,'2015-09-11 00:00:00',11,9,3,2,2015),(3417,'2015-09-12 00:00:00',12,9,3,2,2015),(3418,'2015-09-13 00:00:00',13,9,3,2,2015),(3419,'2015-09-14 00:00:00',14,9,3,2,2015),(3420,'2015-09-15 00:00:00',15,9,3,2,2015),(3421,'2015-09-16 00:00:00',16,9,3,2,2015),(3422,'2015-09-17 00:00:00',17,9,3,2,2015),(3423,'2015-09-18 00:00:00',18,9,3,2,2015),(3424,'2015-09-19 00:00:00',19,9,3,2,2015),(3425,'2015-09-20 00:00:00',20,9,3,2,2015),(3426,'2015-09-21 00:00:00',21,9,3,2,2015),(3427,'2015-09-22 00:00:00',22,9,3,2,2015),(3428,'2015-09-23 00:00:00',23,9,3,2,2015),(3429,'2015-09-24 00:00:00',24,9,3,2,2015),(3430,'2015-09-25 00:00:00',25,9,3,2,2015),(3431,'2015-09-26 00:00:00',26,9,3,2,2015),(3432,'2015-09-27 00:00:00',27,9,3,2,2015),(3433,'2015-09-28 00:00:00',28,9,3,2,2015),(3434,'2015-09-29 00:00:00',29,9,3,2,2015),(3435,'2015-09-30 00:00:00',30,9,3,2,2015),(3436,'2015-10-01 00:00:00',1,9,4,2,2015),(3437,'2015-10-02 00:00:00',2,10,4,2,2015),(3438,'2015-10-03 00:00:00',3,10,4,2,2015),(3439,'2015-10-04 00:00:00',4,10,4,2,2015),(3440,'2015-10-05 00:00:00',5,10,4,2,2015),(3441,'2015-10-06 00:00:00',6,10,4,2,2015),(3442,'2015-10-07 00:00:00',7,10,4,2,2015),(3443,'2015-10-08 00:00:00',8,10,4,2,2015),(3444,'2015-10-09 00:00:00',9,10,4,2,2015),(3445,'2015-10-10 00:00:00',10,10,4,2,2015),(3446,'2015-10-11 00:00:00',11,10,4,2,2015),(3447,'2015-10-12 00:00:00',12,10,4,2,2015),(3448,'2015-10-13 00:00:00',13,10,4,2,2015),(3449,'2015-10-14 00:00:00',14,10,4,2,2015),(3450,'2015-10-15 00:00:00',15,10,4,2,2015),(3451,'2015-10-16 00:00:00',16,10,4,2,2015),(3452,'2015-10-17 00:00:00',17,10,4,2,2015),(3453,'2015-10-18 00:00:00',18,10,4,2,2015),(3454,'2015-10-19 00:00:00',19,10,4,2,2015),(3455,'2015-10-20 00:00:00',20,10,4,2,2015),(3456,'2015-10-21 00:00:00',21,10,4,2,2015),(3457,'2015-10-22 00:00:00',22,10,4,2,2015),(3458,'2015-10-23 00:00:00',23,10,4,2,2015),(3459,'2015-10-24 00:00:00',24,10,4,2,2015),(3460,'2015-10-25 00:00:00',25,10,4,2,2015),(3461,'2015-10-26 00:00:00',26,10,4,2,2015),(3462,'2015-10-27 00:00:00',27,10,4,2,2015),(3463,'2015-10-28 00:00:00',28,10,4,2,2015),(3464,'2015-10-29 00:00:00',29,10,4,2,2015),(3465,'2015-10-30 00:00:00',30,10,4,2,2015),(3466,'2015-10-31 00:00:00',31,10,4,2,2015),(3467,'2015-11-01 00:00:00',1,10,4,2,2015),(3468,'2015-11-02 00:00:00',2,11,4,2,2015),(3469,'2015-11-03 00:00:00',3,11,4,2,2015),(3470,'2015-11-04 00:00:00',4,11,4,2,2015),(3471,'2015-11-05 00:00:00',5,11,4,2,2015),(3472,'2015-11-06 00:00:00',6,11,4,2,2015),(3473,'2015-11-07 00:00:00',7,11,4,2,2015),(3474,'2015-11-08 00:00:00',8,11,4,2,2015),(3475,'2015-11-09 00:00:00',9,11,4,2,2015),(3476,'2015-11-10 00:00:00',10,11,4,2,2015),(3477,'2015-11-11 00:00:00',11,11,4,2,2015),(3478,'2015-11-12 00:00:00',12,11,4,2,2015),(3479,'2015-11-13 00:00:00',13,11,4,2,2015),(3480,'2015-11-14 00:00:00',14,11,4,2,2015),(3481,'2015-11-15 00:00:00',15,11,4,2,2015),(3482,'2015-11-16 00:00:00',16,11,4,2,2015),(3483,'2015-11-17 00:00:00',17,11,4,2,2015),(3484,'2015-11-18 00:00:00',18,11,4,2,2015),(3485,'2015-11-19 00:00:00',19,11,4,2,2015),(3486,'2015-11-20 00:00:00',20,11,4,2,2015),(3487,'2015-11-21 00:00:00',21,11,4,2,2015),(3488,'2015-11-22 00:00:00',22,11,4,2,2015),(3489,'2015-11-23 00:00:00',23,11,4,2,2015),(3490,'2015-11-24 00:00:00',24,11,4,2,2015),(3491,'2015-11-25 00:00:00',25,11,4,2,2015),(3492,'2015-11-26 00:00:00',26,11,4,2,2015),(3493,'2015-11-27 00:00:00',27,11,4,2,2015),(3494,'2015-11-28 00:00:00',28,11,4,2,2015),(3495,'2015-11-29 00:00:00',29,11,4,2,2015),(3496,'2015-11-30 00:00:00',30,11,4,2,2015),(3497,'2015-12-01 00:00:00',1,11,4,2,2015),(3498,'2015-12-02 00:00:00',2,12,4,2,2015),(3499,'2015-12-03 00:00:00',3,12,4,2,2015),(3500,'2015-12-04 00:00:00',4,12,4,2,2015),(3501,'2015-12-05 00:00:00',5,12,4,2,2015),(3502,'2015-12-06 00:00:00',6,12,4,2,2015),(3503,'2015-12-07 00:00:00',7,12,4,2,2015),(3504,'2015-12-08 00:00:00',8,12,4,2,2015),(3505,'2015-12-09 00:00:00',9,12,4,2,2015),(3506,'2015-12-10 00:00:00',10,12,4,2,2015),(3507,'2015-12-11 00:00:00',11,12,4,2,2015),(3508,'2015-12-12 00:00:00',12,12,4,2,2015),(3509,'2015-12-13 00:00:00',13,12,4,2,2015),(3510,'2015-12-14 00:00:00',14,12,4,2,2015),(3511,'2015-12-15 00:00:00',15,12,4,2,2015),(3512,'2015-12-16 00:00:00',16,12,4,2,2015),(3513,'2015-12-17 00:00:00',17,12,4,2,2015),(3514,'2015-12-18 00:00:00',18,12,4,2,2015),(3515,'2015-12-19 00:00:00',19,12,4,2,2015),(3516,'2015-12-20 00:00:00',20,12,4,2,2015),(3517,'2015-12-21 00:00:00',21,12,4,2,2015),(3518,'2015-12-22 00:00:00',22,12,4,2,2015),(3519,'2015-12-23 00:00:00',23,12,4,2,2015),(3520,'2015-12-24 00:00:00',24,12,4,2,2015),(3521,'2015-12-25 00:00:00',25,12,4,2,2015),(3522,'2015-12-26 00:00:00',26,12,4,2,2015),(3523,'2015-12-27 00:00:00',27,12,4,2,2015),(3524,'2015-12-28 00:00:00',28,12,4,2,2015),(3525,'2015-12-29 00:00:00',29,12,4,2,2015),(3526,'2015-12-30 00:00:00',30,12,4,2,2015),(3527,'2015-12-31 00:00:00',31,12,4,2,2015),(3528,'2016-01-01 00:00:00',1,12,1,2,2016),(3529,'2016-01-02 00:00:00',2,1,1,1,2016),(3530,'2016-01-03 00:00:00',3,1,1,1,2016),(3531,'2016-01-04 00:00:00',4,1,1,1,2016),(3532,'2016-01-05 00:00:00',5,1,1,1,2016),(3533,'2016-01-06 00:00:00',6,1,1,1,2016),(3534,'2016-01-07 00:00:00',7,1,1,1,2016),(3535,'2016-01-08 00:00:00',8,1,1,1,2016),(3536,'2016-01-09 00:00:00',9,1,1,1,2016),(3537,'2016-01-10 00:00:00',10,1,1,1,2016),(3538,'2016-01-11 00:00:00',11,1,1,1,2016),(3539,'2016-01-12 00:00:00',12,1,1,1,2016),(3540,'2016-01-13 00:00:00',13,1,1,1,2016),(3541,'2016-01-14 00:00:00',14,1,1,1,2016),(3542,'2016-01-15 00:00:00',15,1,1,1,2016),(3543,'2016-01-16 00:00:00',16,1,1,1,2016),(3544,'2016-01-17 00:00:00',17,1,1,1,2016),(3545,'2016-01-18 00:00:00',18,1,1,1,2016),(3546,'2016-01-19 00:00:00',19,1,1,1,2016),(3547,'2016-01-20 00:00:00',20,1,1,1,2016),(3548,'2016-01-21 00:00:00',21,1,1,1,2016),(3549,'2016-01-22 00:00:00',22,1,1,1,2016),(3550,'2016-01-23 00:00:00',23,1,1,1,2016),(3551,'2016-01-24 00:00:00',24,1,1,1,2016),(3552,'2016-01-25 00:00:00',25,1,1,1,2016),(3553,'2016-01-26 00:00:00',26,1,1,1,2016),(3554,'2016-01-27 00:00:00',27,1,1,1,2016),(3555,'2016-01-28 00:00:00',28,1,1,1,2016),(3556,'2016-01-29 00:00:00',29,1,1,1,2016),(3557,'2016-01-30 00:00:00',30,1,1,1,2016),(3558,'2016-01-31 00:00:00',31,1,1,1,2016),(3559,'2016-02-01 00:00:00',1,1,1,1,2016),(3560,'2016-02-02 00:00:00',2,2,1,1,2016),(3561,'2016-02-03 00:00:00',3,2,1,1,2016),(3562,'2016-02-04 00:00:00',4,2,1,1,2016),(3563,'2016-02-05 00:00:00',5,2,1,1,2016),(3564,'2016-02-06 00:00:00',6,2,1,1,2016),(3565,'2016-02-07 00:00:00',7,2,1,1,2016),(3566,'2016-02-08 00:00:00',8,2,1,1,2016),(3567,'2016-02-09 00:00:00',9,2,1,1,2016),(3568,'2016-02-10 00:00:00',10,2,1,1,2016),(3569,'2016-02-11 00:00:00',11,2,1,1,2016),(3570,'2016-02-12 00:00:00',12,2,1,1,2016),(3571,'2016-02-13 00:00:00',13,2,1,1,2016),(3572,'2016-02-14 00:00:00',14,2,1,1,2016),(3573,'2016-02-15 00:00:00',15,2,1,1,2016),(3574,'2016-02-16 00:00:00',16,2,1,1,2016),(3575,'2016-02-17 00:00:00',17,2,1,1,2016),(3576,'2016-02-18 00:00:00',18,2,1,1,2016),(3577,'2016-02-19 00:00:00',19,2,1,1,2016),(3578,'2016-02-20 00:00:00',20,2,1,1,2016),(3579,'2016-02-21 00:00:00',21,2,1,1,2016),(3580,'2016-02-22 00:00:00',22,2,1,1,2016),(3581,'2016-02-23 00:00:00',23,2,1,1,2016),(3582,'2016-02-24 00:00:00',24,2,1,1,2016),(3583,'2016-02-25 00:00:00',25,2,1,1,2016),(3584,'2016-02-26 00:00:00',26,2,1,1,2016),(3585,'2016-02-27 00:00:00',27,2,1,1,2016),(3586,'2016-02-28 00:00:00',28,2,1,1,2016),(3587,'2016-02-29 00:00:00',29,2,1,1,2016),(3588,'2016-03-01 00:00:00',1,3,1,1,2016),(3589,'2016-03-02 00:00:00',2,3,1,1,2016),(3590,'2016-03-03 00:00:00',3,3,1,1,2016),(3591,'2016-03-04 00:00:00',4,3,1,1,2016),(3592,'2016-03-05 00:00:00',5,3,1,1,2016),(3593,'2016-03-06 00:00:00',6,3,1,1,2016),(3594,'2016-03-07 00:00:00',7,3,1,1,2016),(3595,'2016-03-08 00:00:00',8,3,1,1,2016),(3596,'2016-03-09 00:00:00',9,3,1,1,2016),(3597,'2016-03-10 00:00:00',10,3,1,1,2016),(3598,'2016-03-11 00:00:00',11,3,1,1,2016),(3599,'2016-03-12 00:00:00',12,3,1,1,2016),(3600,'2016-03-13 00:00:00',13,3,1,1,2016),(3601,'2016-03-14 00:00:00',14,3,1,1,2016),(3602,'2016-03-15 00:00:00',15,3,1,1,2016),(3603,'2016-03-16 00:00:00',16,3,1,1,2016),(3604,'2016-03-17 00:00:00',17,3,1,1,2016),(3605,'2016-03-18 00:00:00',18,3,1,1,2016),(3606,'2016-03-19 00:00:00',19,3,1,1,2016),(3607,'2016-03-20 00:00:00',20,3,1,1,2016),(3608,'2016-03-21 00:00:00',21,3,1,1,2016),(3609,'2016-03-22 00:00:00',22,3,1,1,2016),(3610,'2016-03-23 00:00:00',23,3,1,1,2016),(3611,'2016-03-24 00:00:00',24,3,1,1,2016),(3612,'2016-03-25 00:00:00',25,3,1,1,2016),(3613,'2016-03-26 00:00:00',26,3,1,1,2016),(3614,'2016-03-27 00:00:00',27,3,1,1,2016),(3615,'2016-03-28 00:00:00',28,3,1,1,2016),(3616,'2016-03-29 00:00:00',29,3,1,1,2016),(3617,'2016-03-30 00:00:00',30,3,1,1,2016),(3618,'2016-03-31 00:00:00',31,3,1,1,2016),(3619,'2016-04-01 00:00:00',1,4,2,1,2016),(3620,'2016-04-02 00:00:00',2,4,2,1,2016),(3621,'2016-04-03 00:00:00',3,4,2,1,2016),(3622,'2016-04-04 00:00:00',4,4,2,1,2016),(3623,'2016-04-05 00:00:00',5,4,2,1,2016),(3624,'2016-04-06 00:00:00',6,4,2,1,2016),(3625,'2016-04-07 00:00:00',7,4,2,1,2016),(3626,'2016-04-08 00:00:00',8,4,2,1,2016),(3627,'2016-04-09 00:00:00',9,4,2,1,2016),(3628,'2016-04-10 00:00:00',10,4,2,1,2016),(3629,'2016-04-11 00:00:00',11,4,2,1,2016),(3630,'2016-04-12 00:00:00',12,4,2,1,2016),(3631,'2016-04-13 00:00:00',13,4,2,1,2016),(3632,'2016-04-14 00:00:00',14,4,2,1,2016),(3633,'2016-04-15 00:00:00',15,4,2,1,2016),(3634,'2016-04-16 00:00:00',16,4,2,1,2016),(3635,'2016-04-17 00:00:00',17,4,2,1,2016),(3636,'2016-04-18 00:00:00',18,4,2,1,2016),(3637,'2016-04-19 00:00:00',19,4,2,1,2016),(3638,'2016-04-20 00:00:00',20,4,2,1,2016),(3639,'2016-04-21 00:00:00',21,4,2,1,2016),(3640,'2016-04-22 00:00:00',22,4,2,1,2016),(3641,'2016-04-23 00:00:00',23,4,2,1,2016),(3642,'2016-04-24 00:00:00',24,4,2,1,2016),(3643,'2016-04-25 00:00:00',25,4,2,1,2016),(3644,'2016-04-26 00:00:00',26,4,2,1,2016),(3645,'2016-04-27 00:00:00',27,4,2,1,2016),(3646,'2016-04-28 00:00:00',28,4,2,1,2016),(3647,'2016-04-29 00:00:00',29,4,2,1,2016),(3648,'2016-04-30 00:00:00',30,4,2,1,2016),(3649,'2016-05-01 00:00:00',1,5,2,1,2016),(3650,'2016-05-02 00:00:00',2,5,2,1,2016),(3651,'2016-05-03 00:00:00',3,5,2,1,2016),(3652,'2016-05-04 00:00:00',4,5,2,1,2016),(3653,'2016-05-05 00:00:00',5,5,2,1,2016),(3654,'2016-05-06 00:00:00',6,5,2,1,2016),(3655,'2016-05-07 00:00:00',7,5,2,1,2016),(3656,'2016-05-08 00:00:00',8,5,2,1,2016),(3657,'2016-05-09 00:00:00',9,5,2,1,2016),(3658,'2016-05-10 00:00:00',10,5,2,1,2016),(3659,'2016-05-11 00:00:00',11,5,2,1,2016),(3660,'2016-05-12 00:00:00',12,5,2,1,2016),(3661,'2016-05-13 00:00:00',13,5,2,1,2016),(3662,'2016-05-14 00:00:00',14,5,2,1,2016),(3663,'2016-05-15 00:00:00',15,5,2,1,2016),(3664,'2016-05-16 00:00:00',16,5,2,1,2016),(3665,'2016-05-17 00:00:00',17,5,2,1,2016),(3666,'2016-05-18 00:00:00',18,5,2,1,2016),(3667,'2016-05-19 00:00:00',19,5,2,1,2016),(3668,'2016-05-20 00:00:00',20,5,2,1,2016),(3669,'2016-05-21 00:00:00',21,5,2,1,2016),(3670,'2016-05-22 00:00:00',22,5,2,1,2016),(3671,'2016-05-23 00:00:00',23,5,2,1,2016),(3672,'2016-05-24 00:00:00',24,5,2,1,2016),(3673,'2016-05-25 00:00:00',25,5,2,1,2016),(3674,'2016-05-26 00:00:00',26,5,2,1,2016),(3675,'2016-05-27 00:00:00',27,5,2,1,2016),(3676,'2016-05-28 00:00:00',28,5,2,1,2016),(3677,'2016-05-29 00:00:00',29,5,2,1,2016),(3678,'2016-05-30 00:00:00',30,5,2,1,2016),(3679,'2016-05-31 00:00:00',31,5,2,1,2016),(3680,'2016-06-01 00:00:00',1,6,2,1,2016),(3681,'2016-06-02 00:00:00',2,6,2,1,2016),(3682,'2016-06-03 00:00:00',3,6,2,1,2016),(3683,'2016-06-04 00:00:00',4,6,2,1,2016),(3684,'2016-06-05 00:00:00',5,6,2,1,2016),(3685,'2016-06-06 00:00:00',6,6,2,1,2016),(3686,'2016-06-07 00:00:00',7,6,2,1,2016),(3687,'2016-06-08 00:00:00',8,6,2,1,2016),(3688,'2016-06-09 00:00:00',9,6,2,1,2016),(3689,'2016-06-10 00:00:00',10,6,2,1,2016),(3690,'2016-06-11 00:00:00',11,6,2,1,2016),(3691,'2016-06-12 00:00:00',12,6,2,1,2016),(3692,'2016-06-13 00:00:00',13,6,2,1,2016),(3693,'2016-06-14 00:00:00',14,6,2,1,2016),(3694,'2016-06-15 00:00:00',15,6,2,1,2016),(3695,'2016-06-16 00:00:00',16,6,2,1,2016),(3696,'2016-06-17 00:00:00',17,6,2,1,2016),(3697,'2016-06-18 00:00:00',18,6,2,1,2016),(3698,'2016-06-19 00:00:00',19,6,2,1,2016),(3699,'2016-06-20 00:00:00',20,6,2,1,2016),(3700,'2016-06-21 00:00:00',21,6,2,1,2016),(3701,'2016-06-22 00:00:00',22,6,2,1,2016),(3702,'2016-06-23 00:00:00',23,6,2,1,2016),(3703,'2016-06-24 00:00:00',24,6,2,1,2016),(3704,'2016-06-25 00:00:00',25,6,2,1,2016),(3705,'2016-06-26 00:00:00',26,6,2,1,2016),(3706,'2016-06-27 00:00:00',27,6,2,1,2016),(3707,'2016-06-28 00:00:00',28,6,2,1,2016),(3708,'2016-06-29 00:00:00',29,6,2,1,2016),(3709,'2016-06-30 00:00:00',30,6,2,1,2016),(3710,'2016-07-01 00:00:00',1,7,3,2,2016),(3711,'2016-07-02 00:00:00',2,7,3,2,2016),(3712,'2016-07-03 00:00:00',3,7,3,2,2016),(3713,'2016-07-04 00:00:00',4,7,3,2,2016),(3714,'2016-07-05 00:00:00',5,7,3,2,2016),(3715,'2016-07-06 00:00:00',6,7,3,2,2016),(3716,'2016-07-07 00:00:00',7,7,3,2,2016),(3717,'2016-07-08 00:00:00',8,7,3,2,2016),(3718,'2016-07-09 00:00:00',9,7,3,2,2016),(3719,'2016-07-10 00:00:00',10,7,3,2,2016),(3720,'2016-07-11 00:00:00',11,7,3,2,2016),(3721,'2016-07-12 00:00:00',12,7,3,2,2016),(3722,'2016-07-13 00:00:00',13,7,3,2,2016),(3723,'2016-07-14 00:00:00',14,7,3,2,2016),(3724,'2016-07-15 00:00:00',15,7,3,2,2016),(3725,'2016-07-16 00:00:00',16,7,3,2,2016),(3726,'2016-07-17 00:00:00',17,7,3,2,2016),(3727,'2016-07-18 00:00:00',18,7,3,2,2016),(3728,'2016-07-19 00:00:00',19,7,3,2,2016),(3729,'2016-07-20 00:00:00',20,7,3,2,2016),(3730,'2016-07-21 00:00:00',21,7,3,2,2016),(3731,'2016-07-22 00:00:00',22,7,3,2,2016),(3732,'2016-07-23 00:00:00',23,7,3,2,2016),(3733,'2016-07-24 00:00:00',24,7,3,2,2016),(3734,'2016-07-25 00:00:00',25,7,3,2,2016),(3735,'2016-07-26 00:00:00',26,7,3,2,2016),(3736,'2016-07-27 00:00:00',27,7,3,2,2016),(3737,'2016-07-28 00:00:00',28,7,3,2,2016),(3738,'2016-07-29 00:00:00',29,7,3,2,2016),(3739,'2016-07-30 00:00:00',30,7,3,2,2016),(3740,'2016-07-31 00:00:00',31,7,3,2,2016),(3741,'2016-08-01 00:00:00',1,8,3,2,2016),(3742,'2016-08-02 00:00:00',2,8,3,2,2016),(3743,'2016-08-03 00:00:00',3,8,3,2,2016),(3744,'2016-08-04 00:00:00',4,8,3,2,2016),(3745,'2016-08-05 00:00:00',5,8,3,2,2016),(3746,'2016-08-06 00:00:00',6,8,3,2,2016),(3747,'2016-08-07 00:00:00',7,8,3,2,2016),(3748,'2016-08-08 00:00:00',8,8,3,2,2016),(3749,'2016-08-09 00:00:00',9,8,3,2,2016),(3750,'2016-08-10 00:00:00',10,8,3,2,2016),(3751,'2016-08-11 00:00:00',11,8,3,2,2016),(3752,'2016-08-12 00:00:00',12,8,3,2,2016),(3753,'2016-08-13 00:00:00',13,8,3,2,2016),(3754,'2016-08-14 00:00:00',14,8,3,2,2016),(3755,'2016-08-15 00:00:00',15,8,3,2,2016),(3756,'2016-08-16 00:00:00',16,8,3,2,2016),(3757,'2016-08-17 00:00:00',17,8,3,2,2016),(3758,'2016-08-18 00:00:00',18,8,3,2,2016),(3759,'2016-08-19 00:00:00',19,8,3,2,2016),(3760,'2016-08-20 00:00:00',20,8,3,2,2016),(3761,'2016-08-21 00:00:00',21,8,3,2,2016),(3762,'2016-08-22 00:00:00',22,8,3,2,2016),(3763,'2016-08-23 00:00:00',23,8,3,2,2016),(3764,'2016-08-24 00:00:00',24,8,3,2,2016),(3765,'2016-08-25 00:00:00',25,8,3,2,2016),(3766,'2016-08-26 00:00:00',26,8,3,2,2016),(3767,'2016-08-27 00:00:00',27,8,3,2,2016),(3768,'2016-08-28 00:00:00',28,8,3,2,2016),(3769,'2016-08-29 00:00:00',29,8,3,2,2016),(3770,'2016-08-30 00:00:00',30,8,3,2,2016),(3771,'2016-08-31 00:00:00',31,8,3,2,2016),(3772,'2016-09-01 00:00:00',1,9,3,2,2016),(3773,'2016-09-02 00:00:00',2,9,3,2,2016),(3774,'2016-09-03 00:00:00',3,9,3,2,2016),(3775,'2016-09-04 00:00:00',4,9,3,2,2016),(3776,'2016-09-05 00:00:00',5,9,3,2,2016),(3777,'2016-09-06 00:00:00',6,9,3,2,2016),(3778,'2016-09-07 00:00:00',7,9,3,2,2016),(3779,'2016-09-08 00:00:00',8,9,3,2,2016),(3780,'2016-09-09 00:00:00',9,9,3,2,2016),(3781,'2016-09-10 00:00:00',10,9,3,2,2016),(3782,'2016-09-11 00:00:00',11,9,3,2,2016),(3783,'2016-09-12 00:00:00',12,9,3,2,2016),(3784,'2016-09-13 00:00:00',13,9,3,2,2016),(3785,'2016-09-14 00:00:00',14,9,3,2,2016),(3786,'2016-09-15 00:00:00',15,9,3,2,2016),(3787,'2016-09-16 00:00:00',16,9,3,2,2016),(3788,'2016-09-17 00:00:00',17,9,3,2,2016),(3789,'2016-09-18 00:00:00',18,9,3,2,2016),(3790,'2016-09-19 00:00:00',19,9,3,2,2016),(3791,'2016-09-20 00:00:00',20,9,3,2,2016),(3792,'2016-09-21 00:00:00',21,9,3,2,2016),(3793,'2016-09-22 00:00:00',22,9,3,2,2016),(3794,'2016-09-23 00:00:00',23,9,3,2,2016),(3795,'2016-09-24 00:00:00',24,9,3,2,2016),(3796,'2016-09-25 00:00:00',25,9,3,2,2016),(3797,'2016-09-26 00:00:00',26,9,3,2,2016),(3798,'2016-09-27 00:00:00',27,9,3,2,2016),(3799,'2016-09-28 00:00:00',28,9,3,2,2016),(3800,'2016-09-29 00:00:00',29,9,3,2,2016),(3801,'2016-09-30 00:00:00',30,9,3,2,2016),(3802,'2016-10-01 00:00:00',1,10,4,2,2016),(3803,'2016-10-02 00:00:00',2,10,4,2,2016),(3804,'2016-10-03 00:00:00',3,10,4,2,2016),(3805,'2016-10-04 00:00:00',4,10,4,2,2016),(3806,'2016-10-05 00:00:00',5,10,4,2,2016),(3807,'2016-10-06 00:00:00',6,10,4,2,2016),(3808,'2016-10-07 00:00:00',7,10,4,2,2016),(3809,'2016-10-08 00:00:00',8,10,4,2,2016),(3810,'2016-10-09 00:00:00',9,10,4,2,2016),(3811,'2016-10-10 00:00:00',10,10,4,2,2016),(3812,'2016-10-11 00:00:00',11,10,4,2,2016),(3813,'2016-10-12 00:00:00',12,10,4,2,2016),(3814,'2016-10-13 00:00:00',13,10,4,2,2016),(3815,'2016-10-14 00:00:00',14,10,4,2,2016),(3816,'2016-10-15 00:00:00',15,10,4,2,2016),(3817,'2016-10-16 00:00:00',16,10,4,2,2016),(3818,'2016-10-17 00:00:00',17,10,4,2,2016),(3819,'2016-10-18 00:00:00',18,10,4,2,2016),(3820,'2016-10-19 00:00:00',19,10,4,2,2016),(3821,'2016-10-20 00:00:00',20,10,4,2,2016),(3822,'2016-10-21 00:00:00',21,10,4,2,2016),(3823,'2016-10-22 00:00:00',22,10,4,2,2016),(3824,'2016-10-23 00:00:00',23,10,4,2,2016),(3825,'2016-10-24 00:00:00',24,10,4,2,2016),(3826,'2016-10-25 00:00:00',25,10,4,2,2016),(3827,'2016-10-26 00:00:00',26,10,4,2,2016),(3828,'2016-10-27 00:00:00',27,10,4,2,2016),(3829,'2016-10-28 00:00:00',28,10,4,2,2016),(3830,'2016-10-29 00:00:00',29,10,4,2,2016),(3831,'2016-10-30 00:00:00',30,10,4,2,2016),(3832,'2016-10-31 00:00:00',31,10,4,2,2016),(3833,'2016-11-01 00:00:00',1,11,4,2,2016),(3834,'2016-11-02 00:00:00',2,11,4,2,2016),(3835,'2016-11-03 00:00:00',3,11,4,2,2016),(3836,'2016-11-04 00:00:00',4,11,4,2,2016),(3837,'2016-11-05 00:00:00',5,11,4,2,2016),(3838,'2016-11-06 00:00:00',6,11,4,2,2016),(3839,'2016-11-07 00:00:00',7,11,4,2,2016),(3840,'2016-11-08 00:00:00',8,11,4,2,2016),(3841,'2016-11-09 00:00:00',9,11,4,2,2016),(3842,'2016-11-10 00:00:00',10,11,4,2,2016),(3843,'2016-11-11 00:00:00',11,11,4,2,2016),(3844,'2016-11-12 00:00:00',12,11,4,2,2016),(3845,'2016-11-13 00:00:00',13,11,4,2,2016),(3846,'2016-11-14 00:00:00',14,11,4,2,2016),(3847,'2016-11-15 00:00:00',15,11,4,2,2016),(3848,'2016-11-16 00:00:00',16,11,4,2,2016),(3849,'2016-11-17 00:00:00',17,11,4,2,2016),(3850,'2016-11-18 00:00:00',18,11,4,2,2016),(3851,'2016-11-19 00:00:00',19,11,4,2,2016),(3852,'2016-11-20 00:00:00',20,11,4,2,2016),(3853,'2016-11-21 00:00:00',21,11,4,2,2016),(3854,'2016-11-22 00:00:00',22,11,4,2,2016),(3855,'2016-11-23 00:00:00',23,11,4,2,2016),(3856,'2016-11-24 00:00:00',24,11,4,2,2016),(3857,'2016-11-25 00:00:00',25,11,4,2,2016),(3858,'2016-11-26 00:00:00',26,11,4,2,2016),(3859,'2016-11-27 00:00:00',27,11,4,2,2016),(3860,'2016-11-28 00:00:00',28,11,4,2,2016),(3861,'2016-11-29 00:00:00',29,11,4,2,2016),(3862,'2016-11-30 00:00:00',30,11,4,2,2016),(3863,'2016-12-01 00:00:00',1,12,4,2,2016),(3864,'2016-12-02 00:00:00',2,12,4,2,2016),(3865,'2016-12-03 00:00:00',3,12,4,2,2016),(3866,'2016-12-04 00:00:00',4,12,4,2,2016),(3867,'2016-12-05 00:00:00',5,12,4,2,2016),(3868,'2016-12-06 00:00:00',6,12,4,2,2016),(3869,'2016-12-07 00:00:00',7,12,4,2,2016),(3870,'2016-12-08 00:00:00',8,12,4,2,2016),(3871,'2016-12-09 00:00:00',9,12,4,2,2016),(3872,'2016-12-10 00:00:00',10,12,4,2,2016),(3873,'2016-12-11 00:00:00',11,12,4,2,2016),(3874,'2016-12-12 00:00:00',12,12,4,2,2016),(3875,'2016-12-13 00:00:00',13,12,4,2,2016),(3876,'2016-12-14 00:00:00',14,12,4,2,2016),(3877,'2016-12-15 00:00:00',15,12,4,2,2016),(3878,'2016-12-16 00:00:00',16,12,4,2,2016),(3879,'2016-12-17 00:00:00',17,12,4,2,2016),(3880,'2016-12-18 00:00:00',18,12,4,2,2016),(3881,'2016-12-19 00:00:00',19,12,4,2,2016),(3882,'2016-12-20 00:00:00',20,12,4,2,2016),(3883,'2016-12-21 00:00:00',21,12,4,2,2016),(3884,'2016-12-22 00:00:00',22,12,4,2,2016),(3885,'2016-12-23 00:00:00',23,12,4,2,2016),(3886,'2016-12-24 00:00:00',24,12,4,2,2016),(3887,'2016-12-25 00:00:00',25,12,4,2,2016),(3888,'2016-12-26 00:00:00',26,12,4,2,2016),(3889,'2016-12-27 00:00:00',27,12,4,2,2016),(3890,'2016-12-28 00:00:00',28,12,4,2,2016),(3891,'2016-12-29 00:00:00',29,12,4,2,2016),(3892,'2016-12-30 00:00:00',30,12,4,2,2016),(3893,'2016-12-31 00:00:00',31,12,4,2,2016),(3894,'2017-01-01 00:00:00',1,1,1,1,2017),(3895,'2017-01-02 00:00:00',2,1,1,1,2017),(3896,'2017-01-03 00:00:00',3,1,1,1,2017),(3897,'2017-01-04 00:00:00',4,1,1,1,2017),(3898,'2017-01-05 00:00:00',5,1,1,1,2017),(3899,'2017-01-06 00:00:00',6,1,1,1,2017),(3900,'2017-01-07 00:00:00',7,1,1,1,2017),(3901,'2017-01-08 00:00:00',8,1,1,1,2017),(3902,'2017-01-09 00:00:00',9,1,1,1,2017),(3903,'2017-01-10 00:00:00',10,1,1,1,2017),(3904,'2017-01-11 00:00:00',11,1,1,1,2017),(3905,'2017-01-12 00:00:00',12,1,1,1,2017),(3906,'2017-01-13 00:00:00',13,1,1,1,2017),(3907,'2017-01-14 00:00:00',14,1,1,1,2017),(3908,'2017-01-15 00:00:00',15,1,1,1,2017),(3909,'2017-01-16 00:00:00',16,1,1,1,2017),(3910,'2017-01-17 00:00:00',17,1,1,1,2017),(3911,'2017-01-18 00:00:00',18,1,1,1,2017),(3912,'2017-01-19 00:00:00',19,1,1,1,2017),(3913,'2017-01-20 00:00:00',20,1,1,1,2017),(3914,'2017-01-21 00:00:00',21,1,1,1,2017),(3915,'2017-01-22 00:00:00',22,1,1,1,2017),(3916,'2017-01-23 00:00:00',23,1,1,1,2017),(3917,'2017-01-24 00:00:00',24,1,1,1,2017),(3918,'2017-01-25 00:00:00',25,1,1,1,2017),(3919,'2017-01-26 00:00:00',26,1,1,1,2017),(3920,'2017-01-27 00:00:00',27,1,1,1,2017),(3921,'2017-01-28 00:00:00',28,1,1,1,2017),(3922,'2017-01-29 00:00:00',29,1,1,1,2017),(3923,'2017-01-30 00:00:00',30,1,1,1,2017),(3924,'2017-01-31 00:00:00',31,1,1,1,2017),(3925,'2017-02-01 00:00:00',1,2,1,1,2017),(3926,'2017-02-02 00:00:00',2,2,1,1,2017),(3927,'2017-02-03 00:00:00',3,2,1,1,2017),(3928,'2017-02-04 00:00:00',4,2,1,1,2017),(3929,'2017-02-05 00:00:00',5,2,1,1,2017),(3930,'2017-02-06 00:00:00',6,2,1,1,2017),(3931,'2017-02-07 00:00:00',7,2,1,1,2017),(3932,'2017-02-08 00:00:00',8,2,1,1,2017),(3933,'2017-02-09 00:00:00',9,2,1,1,2017),(3934,'2017-02-10 00:00:00',10,2,1,1,2017),(3935,'2017-02-11 00:00:00',11,2,1,1,2017),(3936,'2017-02-12 00:00:00',12,2,1,1,2017),(3937,'2017-02-13 00:00:00',13,2,1,1,2017),(3938,'2017-02-14 00:00:00',14,2,1,1,2017),(3939,'2017-02-15 00:00:00',15,2,1,1,2017),(3940,'2017-02-16 00:00:00',16,2,1,1,2017),(3941,'2017-02-17 00:00:00',17,2,1,1,2017),(3942,'2017-02-18 00:00:00',18,2,1,1,2017),(3943,'2017-02-19 00:00:00',19,2,1,1,2017),(3944,'2017-02-20 00:00:00',20,2,1,1,2017),(3945,'2017-02-21 00:00:00',21,2,1,1,2017),(3946,'2017-02-22 00:00:00',22,2,1,1,2017),(3947,'2017-02-23 00:00:00',23,2,1,1,2017),(3948,'2017-02-24 00:00:00',24,2,1,1,2017),(3949,'2017-02-25 00:00:00',25,2,1,1,2017),(3950,'2017-02-26 00:00:00',26,2,1,1,2017),(3951,'2017-02-27 00:00:00',27,2,1,1,2017),(3952,'2017-02-28 00:00:00',28,2,1,1,2017),(3953,'2017-03-01 00:00:00',1,3,1,1,2017),(3954,'2017-03-02 00:00:00',2,3,1,1,2017),(3955,'2017-03-03 00:00:00',3,3,1,1,2017),(3956,'2017-03-04 00:00:00',4,3,1,1,2017),(3957,'2017-03-05 00:00:00',5,3,1,1,2017),(3958,'2017-03-06 00:00:00',6,3,1,1,2017),(3959,'2017-03-07 00:00:00',7,3,1,1,2017),(3960,'2017-03-08 00:00:00',8,3,1,1,2017),(3961,'2017-03-09 00:00:00',9,3,1,1,2017),(3962,'2017-03-10 00:00:00',10,3,1,1,2017),(3963,'2017-03-11 00:00:00',11,3,1,1,2017),(3964,'2017-03-12 00:00:00',12,3,1,1,2017),(3965,'2017-03-13 00:00:00',13,3,1,1,2017),(3966,'2017-03-14 00:00:00',14,3,1,1,2017),(3967,'2017-03-15 00:00:00',15,3,1,1,2017),(3968,'2017-03-16 00:00:00',16,3,1,1,2017),(3969,'2017-03-17 00:00:00',17,3,1,1,2017),(3970,'2017-03-18 00:00:00',18,3,1,1,2017),(3971,'2017-03-19 00:00:00',19,3,1,1,2017),(3972,'2017-03-20 00:00:00',20,3,1,1,2017),(3973,'2017-03-21 00:00:00',21,3,1,1,2017),(3974,'2017-03-22 00:00:00',22,3,1,1,2017),(3975,'2017-03-23 00:00:00',23,3,1,1,2017),(3976,'2017-03-24 00:00:00',24,3,1,1,2017),(3977,'2017-03-25 00:00:00',25,3,1,1,2017),(3978,'2017-03-26 00:00:00',26,3,1,1,2017),(3979,'2017-03-27 00:00:00',27,3,1,1,2017),(3980,'2017-03-28 00:00:00',28,3,1,1,2017),(3981,'2017-03-29 00:00:00',29,3,1,1,2017),(3982,'2017-03-30 00:00:00',30,3,1,1,2017),(3983,'2017-03-31 00:00:00',31,3,1,1,2017),(3984,'2017-04-01 00:00:00',1,4,2,1,2017),(3985,'2017-04-02 00:00:00',2,4,2,1,2017),(3986,'2017-04-03 00:00:00',3,4,2,1,2017),(3987,'2017-04-04 00:00:00',4,4,2,1,2017),(3988,'2017-04-05 00:00:00',5,4,2,1,2017),(3989,'2017-04-06 00:00:00',6,4,2,1,2017),(3990,'2017-04-07 00:00:00',7,4,2,1,2017),(3991,'2017-04-08 00:00:00',8,4,2,1,2017),(3992,'2017-04-09 00:00:00',9,4,2,1,2017),(3993,'2017-04-10 00:00:00',10,4,2,1,2017),(3994,'2017-04-11 00:00:00',11,4,2,1,2017),(3995,'2017-04-12 00:00:00',12,4,2,1,2017),(3996,'2017-04-13 00:00:00',13,4,2,1,2017),(3997,'2017-04-14 00:00:00',14,4,2,1,2017),(3998,'2017-04-15 00:00:00',15,4,2,1,2017),(3999,'2017-04-16 00:00:00',16,4,2,1,2017),(4000,'2017-04-17 00:00:00',17,4,2,1,2017),(4001,'2017-04-18 00:00:00',18,4,2,1,2017),(4002,'2017-04-19 00:00:00',19,4,2,1,2017),(4003,'2017-04-20 00:00:00',20,4,2,1,2017),(4004,'2017-04-21 00:00:00',21,4,2,1,2017),(4005,'2017-04-22 00:00:00',22,4,2,1,2017),(4006,'2017-04-23 00:00:00',23,4,2,1,2017),(4007,'2017-04-24 00:00:00',24,4,2,1,2017),(4008,'2017-04-25 00:00:00',25,4,2,1,2017),(4009,'2017-04-26 00:00:00',26,4,2,1,2017),(4010,'2017-04-27 00:00:00',27,4,2,1,2017),(4011,'2017-04-28 00:00:00',28,4,2,1,2017),(4012,'2017-04-29 00:00:00',29,4,2,1,2017),(4013,'2017-04-30 00:00:00',30,4,2,1,2017),(4014,'2017-05-01 00:00:00',1,5,2,1,2017),(4015,'2017-05-02 00:00:00',2,5,2,1,2017),(4016,'2017-05-03 00:00:00',3,5,2,1,2017),(4017,'2017-05-04 00:00:00',4,5,2,1,2017),(4018,'2017-05-05 00:00:00',5,5,2,1,2017),(4019,'2017-05-06 00:00:00',6,5,2,1,2017),(4020,'2017-05-07 00:00:00',7,5,2,1,2017),(4021,'2017-05-08 00:00:00',8,5,2,1,2017),(4022,'2017-05-09 00:00:00',9,5,2,1,2017),(4023,'2017-05-10 00:00:00',10,5,2,1,2017),(4024,'2017-05-11 00:00:00',11,5,2,1,2017),(4025,'2017-05-12 00:00:00',12,5,2,1,2017),(4026,'2017-05-13 00:00:00',13,5,2,1,2017),(4027,'2017-05-14 00:00:00',14,5,2,1,2017),(4028,'2017-05-15 00:00:00',15,5,2,1,2017),(4029,'2017-05-16 00:00:00',16,5,2,1,2017),(4030,'2017-05-17 00:00:00',17,5,2,1,2017),(4031,'2017-05-18 00:00:00',18,5,2,1,2017),(4032,'2017-05-19 00:00:00',19,5,2,1,2017),(4033,'2017-05-20 00:00:00',20,5,2,1,2017),(4034,'2017-05-21 00:00:00',21,5,2,1,2017),(4035,'2017-05-22 00:00:00',22,5,2,1,2017),(4036,'2017-05-23 00:00:00',23,5,2,1,2017),(4037,'2017-05-24 00:00:00',24,5,2,1,2017),(4038,'2017-05-25 00:00:00',25,5,2,1,2017),(4039,'2017-05-26 00:00:00',26,5,2,1,2017),(4040,'2017-05-27 00:00:00',27,5,2,1,2017),(4041,'2017-05-28 00:00:00',28,5,2,1,2017),(4042,'2017-05-29 00:00:00',29,5,2,1,2017),(4043,'2017-05-30 00:00:00',30,5,2,1,2017),(4044,'2017-05-31 00:00:00',31,5,2,1,2017),(4045,'2017-06-01 00:00:00',1,6,2,1,2017),(4046,'2017-06-02 00:00:00',2,6,2,1,2017),(4047,'2017-06-03 00:00:00',3,6,2,1,2017),(4048,'2017-06-04 00:00:00',4,6,2,1,2017),(4049,'2017-06-05 00:00:00',5,6,2,1,2017),(4050,'2017-06-06 00:00:00',6,6,2,1,2017),(4051,'2017-06-07 00:00:00',7,6,2,1,2017),(4052,'2017-06-08 00:00:00',8,6,2,1,2017),(4053,'2017-06-09 00:00:00',9,6,2,1,2017),(4054,'2017-06-10 00:00:00',10,6,2,1,2017),(4055,'2017-06-11 00:00:00',11,6,2,1,2017),(4056,'2017-06-12 00:00:00',12,6,2,1,2017),(4057,'2017-06-13 00:00:00',13,6,2,1,2017),(4058,'2017-06-14 00:00:00',14,6,2,1,2017),(4059,'2017-06-15 00:00:00',15,6,2,1,2017),(4060,'2017-06-16 00:00:00',16,6,2,1,2017),(4061,'2017-06-17 00:00:00',17,6,2,1,2017),(4062,'2017-06-18 00:00:00',18,6,2,1,2017),(4063,'2017-06-19 00:00:00',19,6,2,1,2017),(4064,'2017-06-20 00:00:00',20,6,2,1,2017),(4065,'2017-06-21 00:00:00',21,6,2,1,2017),(4066,'2017-06-22 00:00:00',22,6,2,1,2017),(4067,'2017-06-23 00:00:00',23,6,2,1,2017),(4068,'2017-06-24 00:00:00',24,6,2,1,2017),(4069,'2017-06-25 00:00:00',25,6,2,1,2017),(4070,'2017-06-26 00:00:00',26,6,2,1,2017),(4071,'2017-06-27 00:00:00',27,6,2,1,2017),(4072,'2017-06-28 00:00:00',28,6,2,1,2017),(4073,'2017-06-29 00:00:00',29,6,2,1,2017),(4074,'2017-06-30 00:00:00',30,6,2,1,2017),(4075,'2017-07-01 00:00:00',1,7,3,2,2017),(4076,'2017-07-02 00:00:00',2,7,3,2,2017),(4077,'2017-07-03 00:00:00',3,7,3,2,2017),(4078,'2017-07-04 00:00:00',4,7,3,2,2017),(4079,'2017-07-05 00:00:00',5,7,3,2,2017),(4080,'2017-07-06 00:00:00',6,7,3,2,2017),(4081,'2017-07-07 00:00:00',7,7,3,2,2017),(4082,'2017-07-08 00:00:00',8,7,3,2,2017),(4083,'2017-07-09 00:00:00',9,7,3,2,2017),(4084,'2017-07-10 00:00:00',10,7,3,2,2017),(4085,'2017-07-11 00:00:00',11,7,3,2,2017),(4086,'2017-07-12 00:00:00',12,7,3,2,2017),(4087,'2017-07-13 00:00:00',13,7,3,2,2017),(4088,'2017-07-14 00:00:00',14,7,3,2,2017),(4089,'2017-07-15 00:00:00',15,7,3,2,2017),(4090,'2017-07-16 00:00:00',16,7,3,2,2017),(4091,'2017-07-17 00:00:00',17,7,3,2,2017),(4092,'2017-07-18 00:00:00',18,7,3,2,2017),(4093,'2017-07-19 00:00:00',19,7,3,2,2017),(4094,'2017-07-20 00:00:00',20,7,3,2,2017),(4095,'2017-07-21 00:00:00',21,7,3,2,2017),(4096,'2017-07-22 00:00:00',22,7,3,2,2017),(4097,'2017-07-23 00:00:00',23,7,3,2,2017),(4098,'2017-07-24 00:00:00',24,7,3,2,2017),(4099,'2017-07-25 00:00:00',25,7,3,2,2017),(4100,'2017-07-26 00:00:00',26,7,3,2,2017),(4101,'2017-07-27 00:00:00',27,7,3,2,2017),(4102,'2017-07-28 00:00:00',28,7,3,2,2017),(4103,'2017-07-29 00:00:00',29,7,3,2,2017),(4104,'2017-07-30 00:00:00',30,7,3,2,2017),(4105,'2017-07-31 00:00:00',31,7,3,2,2017),(4106,'2017-08-01 00:00:00',1,8,3,2,2017),(4107,'2017-08-02 00:00:00',2,8,3,2,2017),(4108,'2017-08-03 00:00:00',3,8,3,2,2017),(4109,'2017-08-04 00:00:00',4,8,3,2,2017),(4110,'2017-08-05 00:00:00',5,8,3,2,2017),(4111,'2017-08-06 00:00:00',6,8,3,2,2017),(4112,'2017-08-07 00:00:00',7,8,3,2,2017),(4113,'2017-08-08 00:00:00',8,8,3,2,2017),(4114,'2017-08-09 00:00:00',9,8,3,2,2017),(4115,'2017-08-10 00:00:00',10,8,3,2,2017),(4116,'2017-08-11 00:00:00',11,8,3,2,2017),(4117,'2017-08-12 00:00:00',12,8,3,2,2017),(4118,'2017-08-13 00:00:00',13,8,3,2,2017),(4119,'2017-08-14 00:00:00',14,8,3,2,2017),(4120,'2017-08-15 00:00:00',15,8,3,2,2017),(4121,'2017-08-16 00:00:00',16,8,3,2,2017),(4122,'2017-08-17 00:00:00',17,8,3,2,2017),(4123,'2017-08-18 00:00:00',18,8,3,2,2017),(4124,'2017-08-19 00:00:00',19,8,3,2,2017),(4125,'2017-08-20 00:00:00',20,8,3,2,2017),(4126,'2017-08-21 00:00:00',21,8,3,2,2017),(4127,'2017-08-22 00:00:00',22,8,3,2,2017),(4128,'2017-08-23 00:00:00',23,8,3,2,2017),(4129,'2017-08-24 00:00:00',24,8,3,2,2017),(4130,'2017-08-25 00:00:00',25,8,3,2,2017),(4131,'2017-08-26 00:00:00',26,8,3,2,2017),(4132,'2017-08-27 00:00:00',27,8,3,2,2017),(4133,'2017-08-28 00:00:00',28,8,3,2,2017),(4134,'2017-08-29 00:00:00',29,8,3,2,2017),(4135,'2017-08-30 00:00:00',30,8,3,2,2017),(4136,'2017-08-31 00:00:00',31,8,3,2,2017),(4137,'2017-09-01 00:00:00',1,9,3,2,2017),(4138,'2017-09-02 00:00:00',2,9,3,2,2017),(4139,'2017-09-03 00:00:00',3,9,3,2,2017),(4140,'2017-09-04 00:00:00',4,9,3,2,2017),(4141,'2017-09-05 00:00:00',5,9,3,2,2017),(4142,'2017-09-06 00:00:00',6,9,3,2,2017),(4143,'2017-09-07 00:00:00',7,9,3,2,2017),(4144,'2017-09-08 00:00:00',8,9,3,2,2017),(4145,'2017-09-09 00:00:00',9,9,3,2,2017),(4146,'2017-09-10 00:00:00',10,9,3,2,2017),(4147,'2017-09-11 00:00:00',11,9,3,2,2017),(4148,'2017-09-12 00:00:00',12,9,3,2,2017),(4149,'2017-09-13 00:00:00',13,9,3,2,2017),(4150,'2017-09-14 00:00:00',14,9,3,2,2017),(4151,'2017-09-15 00:00:00',15,9,3,2,2017),(4152,'2017-09-16 00:00:00',16,9,3,2,2017),(4153,'2017-09-17 00:00:00',17,9,3,2,2017),(4154,'2017-09-18 00:00:00',18,9,3,2,2017),(4155,'2017-09-19 00:00:00',19,9,3,2,2017),(4156,'2017-09-20 00:00:00',20,9,3,2,2017),(4157,'2017-09-21 00:00:00',21,9,3,2,2017),(4158,'2017-09-22 00:00:00',22,9,3,2,2017),(4159,'2017-09-23 00:00:00',23,9,3,2,2017),(4160,'2017-09-24 00:00:00',24,9,3,2,2017),(4161,'2017-09-25 00:00:00',25,9,3,2,2017),(4162,'2017-09-26 00:00:00',26,9,3,2,2017),(4163,'2017-09-27 00:00:00',27,9,3,2,2017),(4164,'2017-09-28 00:00:00',28,9,3,2,2017),(4165,'2017-09-29 00:00:00',29,9,3,2,2017),(4166,'2017-09-30 00:00:00',30,9,3,2,2017),(4167,'2017-10-01 00:00:00',1,10,4,2,2017),(4168,'2017-10-02 00:00:00',2,10,4,2,2017),(4169,'2017-10-03 00:00:00',3,10,4,2,2017),(4170,'2017-10-04 00:00:00',4,10,4,2,2017),(4171,'2017-10-05 00:00:00',5,10,4,2,2017),(4172,'2017-10-06 00:00:00',6,10,4,2,2017),(4173,'2017-10-07 00:00:00',7,10,4,2,2017),(4174,'2017-10-08 00:00:00',8,10,4,2,2017),(4175,'2017-10-09 00:00:00',9,10,4,2,2017),(4176,'2017-10-10 00:00:00',10,10,4,2,2017),(4177,'2017-10-11 00:00:00',11,10,4,2,2017),(4178,'2017-10-12 00:00:00',12,10,4,2,2017),(4179,'2017-10-13 00:00:00',13,10,4,2,2017),(4180,'2017-10-14 00:00:00',14,10,4,2,2017),(4181,'2017-10-15 00:00:00',15,10,4,2,2017),(4182,'2017-10-16 00:00:00',16,10,4,2,2017),(4183,'2017-10-17 00:00:00',17,10,4,2,2017),(4184,'2017-10-18 00:00:00',18,10,4,2,2017),(4185,'2017-10-19 00:00:00',19,10,4,2,2017),(4186,'2017-10-20 00:00:00',20,10,4,2,2017),(4187,'2017-10-21 00:00:00',21,10,4,2,2017),(4188,'2017-10-22 00:00:00',22,10,4,2,2017),(4189,'2017-10-23 00:00:00',23,10,4,2,2017),(4190,'2017-10-24 00:00:00',24,10,4,2,2017),(4191,'2017-10-25 00:00:00',25,10,4,2,2017),(4192,'2017-10-26 00:00:00',26,10,4,2,2017),(4193,'2017-10-27 00:00:00',27,10,4,2,2017),(4194,'2017-10-28 00:00:00',28,10,4,2,2017),(4195,'2017-10-29 00:00:00',29,10,4,2,2017),(4196,'2017-10-30 00:00:00',30,10,4,2,2017),(4197,'2017-10-31 00:00:00',31,10,4,2,2017),(4198,'2017-11-01 00:00:00',1,11,4,2,2017),(4199,'2017-11-02 00:00:00',2,11,4,2,2017),(4200,'2017-11-03 00:00:00',3,11,4,2,2017),(4201,'2017-11-04 00:00:00',4,11,4,2,2017),(4202,'2017-11-05 00:00:00',5,11,4,2,2017),(4203,'2017-11-06 00:00:00',6,11,4,2,2017),(4204,'2017-11-07 00:00:00',7,11,4,2,2017),(4205,'2017-11-08 00:00:00',8,11,4,2,2017),(4206,'2017-11-09 00:00:00',9,11,4,2,2017),(4207,'2017-11-10 00:00:00',10,11,4,2,2017),(4208,'2017-11-11 00:00:00',11,11,4,2,2017),(4209,'2017-11-12 00:00:00',12,11,4,2,2017),(4210,'2017-11-13 00:00:00',13,11,4,2,2017),(4211,'2017-11-14 00:00:00',14,11,4,2,2017),(4212,'2017-11-15 00:00:00',15,11,4,2,2017),(4213,'2017-11-16 00:00:00',16,11,4,2,2017),(4214,'2017-11-17 00:00:00',17,11,4,2,2017),(4215,'2017-11-18 00:00:00',18,11,4,2,2017),(4216,'2017-11-19 00:00:00',19,11,4,2,2017),(4217,'2017-11-20 00:00:00',20,11,4,2,2017),(4218,'2017-11-21 00:00:00',21,11,4,2,2017),(4219,'2017-11-22 00:00:00',22,11,4,2,2017),(4220,'2017-11-23 00:00:00',23,11,4,2,2017),(4221,'2017-11-24 00:00:00',24,11,4,2,2017),(4222,'2017-11-25 00:00:00',25,11,4,2,2017),(4223,'2017-11-26 00:00:00',26,11,4,2,2017),(4224,'2017-11-27 00:00:00',27,11,4,2,2017),(4225,'2017-11-28 00:00:00',28,11,4,2,2017),(4226,'2017-11-29 00:00:00',29,11,4,2,2017),(4227,'2017-11-30 00:00:00',30,11,4,2,2017),(4228,'2017-12-01 00:00:00',1,12,4,2,2017),(4229,'2017-12-02 00:00:00',2,12,4,2,2017),(4230,'2017-12-03 00:00:00',3,12,4,2,2017),(4231,'2017-12-04 00:00:00',4,12,4,2,2017),(4232,'2017-12-05 00:00:00',5,12,4,2,2017),(4233,'2017-12-06 00:00:00',6,12,4,2,2017),(4234,'2017-12-07 00:00:00',7,12,4,2,2017),(4235,'2017-12-08 00:00:00',8,12,4,2,2017),(4236,'2017-12-09 00:00:00',9,12,4,2,2017),(4237,'2017-12-10 00:00:00',10,12,4,2,2017),(4238,'2017-12-11 00:00:00',11,12,4,2,2017),(4239,'2017-12-12 00:00:00',12,12,4,2,2017),(4240,'2017-12-13 00:00:00',13,12,4,2,2017),(4241,'2017-12-14 00:00:00',14,12,4,2,2017),(4242,'2017-12-15 00:00:00',15,12,4,2,2017),(4243,'2017-12-16 00:00:00',16,12,4,2,2017),(4244,'2017-12-17 00:00:00',17,12,4,2,2017),(4245,'2017-12-18 00:00:00',18,12,4,2,2017),(4246,'2017-12-19 00:00:00',19,12,4,2,2017),(4247,'2017-12-20 00:00:00',20,12,4,2,2017),(4248,'2017-12-21 00:00:00',21,12,4,2,2017),(4249,'2017-12-22 00:00:00',22,12,4,2,2017),(4250,'2017-12-23 00:00:00',23,12,4,2,2017),(4251,'2017-12-24 00:00:00',24,12,4,2,2017),(4252,'2017-12-25 00:00:00',25,12,4,2,2017),(4253,'2017-12-26 00:00:00',26,12,4,2,2017),(4254,'2017-12-27 00:00:00',27,12,4,2,2017),(4255,'2017-12-28 00:00:00',28,12,4,2,2017),(4256,'2017-12-29 00:00:00',29,12,4,2,2017),(4257,'2017-12-30 00:00:00',30,12,4,2,2017),(4258,'2017-12-31 00:00:00',31,12,4,2,2017),(4259,'2018-01-01 00:00:00',1,1,1,1,2018),(4260,'2018-01-02 00:00:00',2,1,1,1,2018),(4261,'2018-01-03 00:00:00',3,1,1,1,2018),(4262,'2018-01-04 00:00:00',4,1,1,1,2018),(4263,'2018-01-05 00:00:00',5,1,1,1,2018),(4264,'2018-01-06 00:00:00',6,1,1,1,2018),(4265,'2018-01-07 00:00:00',7,1,1,1,2018),(4266,'2018-01-08 00:00:00',8,1,1,1,2018),(4267,'2018-01-09 00:00:00',9,1,1,1,2018),(4268,'2018-01-10 00:00:00',10,1,1,1,2018),(4269,'2018-01-11 00:00:00',11,1,1,1,2018),(4270,'2018-01-12 00:00:00',12,1,1,1,2018),(4271,'2018-01-13 00:00:00',13,1,1,1,2018),(4272,'2018-01-14 00:00:00',14,1,1,1,2018),(4273,'2018-01-15 00:00:00',15,1,1,1,2018),(4274,'2018-01-16 00:00:00',16,1,1,1,2018),(4275,'2018-01-17 00:00:00',17,1,1,1,2018),(4276,'2018-01-18 00:00:00',18,1,1,1,2018),(4277,'2018-01-19 00:00:00',19,1,1,1,2018),(4278,'2018-01-20 00:00:00',20,1,1,1,2018),(4279,'2018-01-21 00:00:00',21,1,1,1,2018),(4280,'2018-01-22 00:00:00',22,1,1,1,2018),(4281,'2018-01-23 00:00:00',23,1,1,1,2018),(4282,'2018-01-24 00:00:00',24,1,1,1,2018),(4283,'2018-01-25 00:00:00',25,1,1,1,2018),(4284,'2018-01-26 00:00:00',26,1,1,1,2018),(4285,'2018-01-27 00:00:00',27,1,1,1,2018),(4286,'2018-01-28 00:00:00',28,1,1,1,2018),(4287,'2018-01-29 00:00:00',29,1,1,1,2018),(4288,'2018-01-30 00:00:00',30,1,1,1,2018),(4289,'2018-01-31 00:00:00',31,1,1,1,2018),(4290,'2018-02-01 00:00:00',1,2,1,1,2018),(4291,'2018-02-02 00:00:00',2,2,1,1,2018),(4292,'2018-02-03 00:00:00',3,2,1,1,2018),(4293,'2018-02-04 00:00:00',4,2,1,1,2018),(4294,'2018-02-05 00:00:00',5,2,1,1,2018),(4295,'2018-02-06 00:00:00',6,2,1,1,2018),(4296,'2018-02-07 00:00:00',7,2,1,1,2018),(4297,'2018-02-08 00:00:00',8,2,1,1,2018),(4298,'2018-02-09 00:00:00',9,2,1,1,2018),(4299,'2018-02-10 00:00:00',10,2,1,1,2018),(4300,'2018-02-11 00:00:00',11,2,1,1,2018),(4301,'2018-02-12 00:00:00',12,2,1,1,2018),(4302,'2018-02-13 00:00:00',13,2,1,1,2018),(4303,'2018-02-14 00:00:00',14,2,1,1,2018),(4304,'2018-02-15 00:00:00',15,2,1,1,2018),(4305,'2018-02-16 00:00:00',16,2,1,1,2018),(4306,'2018-02-17 00:00:00',17,2,1,1,2018),(4307,'2018-02-18 00:00:00',18,2,1,1,2018),(4308,'2018-02-19 00:00:00',19,2,1,1,2018),(4309,'2018-02-20 00:00:00',20,2,1,1,2018),(4310,'2018-02-21 00:00:00',21,2,1,1,2018),(4311,'2018-02-22 00:00:00',22,2,1,1,2018),(4312,'2018-02-23 00:00:00',23,2,1,1,2018),(4313,'2018-02-24 00:00:00',24,2,1,1,2018),(4314,'2018-02-25 00:00:00',25,2,1,1,2018),(4315,'2018-02-26 00:00:00',26,2,1,1,2018),(4316,'2018-02-27 00:00:00',27,2,1,1,2018),(4317,'2018-02-28 00:00:00',28,2,1,1,2018),(4318,'2018-03-01 00:00:00',1,3,1,1,2018),(4319,'2018-03-02 00:00:00',2,3,1,1,2018),(4320,'2018-03-03 00:00:00',3,3,1,1,2018),(4321,'2018-03-04 00:00:00',4,3,1,1,2018),(4322,'2018-03-05 00:00:00',5,3,1,1,2018),(4323,'2018-03-06 00:00:00',6,3,1,1,2018),(4324,'2018-03-07 00:00:00',7,3,1,1,2018),(4325,'2018-03-08 00:00:00',8,3,1,1,2018),(4326,'2018-03-09 00:00:00',9,3,1,1,2018),(4327,'2018-03-10 00:00:00',10,3,1,1,2018),(4328,'2018-03-11 00:00:00',11,3,1,1,2018),(4329,'2018-03-12 00:00:00',12,3,1,1,2018),(4330,'2018-03-13 00:00:00',13,3,1,1,2018),(4331,'2018-03-14 00:00:00',14,3,1,1,2018),(4332,'2018-03-15 00:00:00',15,3,1,1,2018),(4333,'2018-03-16 00:00:00',16,3,1,1,2018),(4334,'2018-03-17 00:00:00',17,3,1,1,2018),(4335,'2018-03-18 00:00:00',18,3,1,1,2018),(4336,'2018-03-19 00:00:00',19,3,1,1,2018),(4337,'2018-03-20 00:00:00',20,3,1,1,2018),(4338,'2018-03-21 00:00:00',21,3,1,1,2018),(4339,'2018-03-22 00:00:00',22,3,1,1,2018),(4340,'2018-03-23 00:00:00',23,3,1,1,2018),(4341,'2018-03-24 00:00:00',24,3,1,1,2018),(4342,'2018-03-25 00:00:00',25,3,1,1,2018),(4343,'2018-03-26 00:00:00',26,3,1,1,2018),(4344,'2018-03-27 00:00:00',27,3,1,1,2018),(4345,'2018-03-28 00:00:00',28,3,1,1,2018),(4346,'2018-03-29 00:00:00',29,3,1,1,2018),(4347,'2018-03-30 00:00:00',30,3,1,1,2018),(4348,'2018-03-31 00:00:00',31,3,1,1,2018),(4349,'2018-04-01 00:00:00',1,4,2,1,2018),(4350,'2018-04-02 00:00:00',2,4,2,1,2018),(4351,'2018-04-03 00:00:00',3,4,2,1,2018),(4352,'2018-04-04 00:00:00',4,4,2,1,2018),(4353,'2018-04-05 00:00:00',5,4,2,1,2018),(4354,'2018-04-06 00:00:00',6,4,2,1,2018),(4355,'2018-04-07 00:00:00',7,4,2,1,2018),(4356,'2018-04-08 00:00:00',8,4,2,1,2018),(4357,'2018-04-09 00:00:00',9,4,2,1,2018),(4358,'2018-04-10 00:00:00',10,4,2,1,2018),(4359,'2018-04-11 00:00:00',11,4,2,1,2018),(4360,'2018-04-12 00:00:00',12,4,2,1,2018),(4361,'2018-04-13 00:00:00',13,4,2,1,2018),(4362,'2018-04-14 00:00:00',14,4,2,1,2018),(4363,'2018-04-15 00:00:00',15,4,2,1,2018),(4364,'2018-04-16 00:00:00',16,4,2,1,2018),(4365,'2018-04-17 00:00:00',17,4,2,1,2018),(4366,'2018-04-18 00:00:00',18,4,2,1,2018),(4367,'2018-04-19 00:00:00',19,4,2,1,2018),(4368,'2018-04-20 00:00:00',20,4,2,1,2018),(4369,'2018-04-21 00:00:00',21,4,2,1,2018),(4370,'2018-04-22 00:00:00',22,4,2,1,2018),(4371,'2018-04-23 00:00:00',23,4,2,1,2018),(4372,'2018-04-24 00:00:00',24,4,2,1,2018),(4373,'2018-04-25 00:00:00',25,4,2,1,2018),(4374,'2018-04-26 00:00:00',26,4,2,1,2018),(4375,'2018-04-27 00:00:00',27,4,2,1,2018),(4376,'2018-04-28 00:00:00',28,4,2,1,2018),(4377,'2018-04-29 00:00:00',29,4,2,1,2018),(4378,'2018-04-30 00:00:00',30,4,2,1,2018),(4379,'2018-05-01 00:00:00',1,5,2,1,2018),(4380,'2018-05-02 00:00:00',2,5,2,1,2018),(4381,'2018-05-03 00:00:00',3,5,2,1,2018),(4382,'2018-05-04 00:00:00',4,5,2,1,2018),(4383,'2018-05-05 00:00:00',5,5,2,1,2018),(4384,'2018-05-06 00:00:00',6,5,2,1,2018),(4385,'2018-05-07 00:00:00',7,5,2,1,2018),(4386,'2018-05-08 00:00:00',8,5,2,1,2018),(4387,'2018-05-09 00:00:00',9,5,2,1,2018),(4388,'2018-05-10 00:00:00',10,5,2,1,2018),(4389,'2018-05-11 00:00:00',11,5,2,1,2018),(4390,'2018-05-12 00:00:00',12,5,2,1,2018),(4391,'2018-05-13 00:00:00',13,5,2,1,2018),(4392,'2018-05-14 00:00:00',14,5,2,1,2018),(4393,'2018-05-15 00:00:00',15,5,2,1,2018),(4394,'2018-05-16 00:00:00',16,5,2,1,2018),(4395,'2018-05-17 00:00:00',17,5,2,1,2018),(4396,'2018-05-18 00:00:00',18,5,2,1,2018),(4397,'2018-05-19 00:00:00',19,5,2,1,2018),(4398,'2018-05-20 00:00:00',20,5,2,1,2018),(4399,'2018-05-21 00:00:00',21,5,2,1,2018),(4400,'2018-05-22 00:00:00',22,5,2,1,2018),(4401,'2018-05-23 00:00:00',23,5,2,1,2018),(4402,'2018-05-24 00:00:00',24,5,2,1,2018),(4403,'2018-05-25 00:00:00',25,5,2,1,2018),(4404,'2018-05-26 00:00:00',26,5,2,1,2018),(4405,'2018-05-27 00:00:00',27,5,2,1,2018),(4406,'2018-05-28 00:00:00',28,5,2,1,2018),(4407,'2018-05-29 00:00:00',29,5,2,1,2018),(4408,'2018-05-30 00:00:00',30,5,2,1,2018),(4409,'2018-05-31 00:00:00',31,5,2,1,2018),(4410,'2018-06-01 00:00:00',1,6,2,1,2018),(4411,'2018-06-02 00:00:00',2,6,2,1,2018),(4412,'2018-06-03 00:00:00',3,6,2,1,2018),(4413,'2018-06-04 00:00:00',4,6,2,1,2018),(4414,'2018-06-05 00:00:00',5,6,2,1,2018),(4415,'2018-06-06 00:00:00',6,6,2,1,2018),(4416,'2018-06-07 00:00:00',7,6,2,1,2018),(4417,'2018-06-08 00:00:00',8,6,2,1,2018),(4418,'2018-06-09 00:00:00',9,6,2,1,2018),(4419,'2018-06-10 00:00:00',10,6,2,1,2018),(4420,'2018-06-11 00:00:00',11,6,2,1,2018),(4421,'2018-06-12 00:00:00',12,6,2,1,2018),(4422,'2018-06-13 00:00:00',13,6,2,1,2018),(4423,'2018-06-14 00:00:00',14,6,2,1,2018),(4424,'2018-06-15 00:00:00',15,6,2,1,2018),(4425,'2018-06-16 00:00:00',16,6,2,1,2018),(4426,'2018-06-17 00:00:00',17,6,2,1,2018),(4427,'2018-06-18 00:00:00',18,6,2,1,2018),(4428,'2018-06-19 00:00:00',19,6,2,1,2018),(4429,'2018-06-20 00:00:00',20,6,2,1,2018),(4430,'2018-06-21 00:00:00',21,6,2,1,2018),(4431,'2018-06-22 00:00:00',22,6,2,1,2018),(4432,'2018-06-23 00:00:00',23,6,2,1,2018),(4433,'2018-06-24 00:00:00',24,6,2,1,2018),(4434,'2018-06-25 00:00:00',25,6,2,1,2018),(4435,'2018-06-26 00:00:00',26,6,2,1,2018),(4436,'2018-06-27 00:00:00',27,6,2,1,2018),(4437,'2018-06-28 00:00:00',28,6,2,1,2018),(4438,'2018-06-29 00:00:00',29,6,2,1,2018),(4439,'2018-06-30 00:00:00',30,6,2,1,2018),(4440,'2018-07-01 00:00:00',1,7,3,2,2018),(4441,'2018-07-02 00:00:00',2,7,3,2,2018),(4442,'2018-07-03 00:00:00',3,7,3,2,2018),(4443,'2018-07-04 00:00:00',4,7,3,2,2018),(4444,'2018-07-05 00:00:00',5,7,3,2,2018),(4445,'2018-07-06 00:00:00',6,7,3,2,2018),(4446,'2018-07-07 00:00:00',7,7,3,2,2018),(4447,'2018-07-08 00:00:00',8,7,3,2,2018),(4448,'2018-07-09 00:00:00',9,7,3,2,2018),(4449,'2018-07-10 00:00:00',10,7,3,2,2018),(4450,'2018-07-11 00:00:00',11,7,3,2,2018),(4451,'2018-07-12 00:00:00',12,7,3,2,2018),(4452,'2018-07-13 00:00:00',13,7,3,2,2018),(4453,'2018-07-14 00:00:00',14,7,3,2,2018),(4454,'2018-07-15 00:00:00',15,7,3,2,2018),(4455,'2018-07-16 00:00:00',16,7,3,2,2018),(4456,'2018-07-17 00:00:00',17,7,3,2,2018),(4457,'2018-07-18 00:00:00',18,7,3,2,2018),(4458,'2018-07-19 00:00:00',19,7,3,2,2018),(4459,'2018-07-20 00:00:00',20,7,3,2,2018),(4460,'2018-07-21 00:00:00',21,7,3,2,2018),(4461,'2018-07-22 00:00:00',22,7,3,2,2018),(4462,'2018-07-23 00:00:00',23,7,3,2,2018),(4463,'2018-07-24 00:00:00',24,7,3,2,2018),(4464,'2018-07-25 00:00:00',25,7,3,2,2018),(4465,'2018-07-26 00:00:00',26,7,3,2,2018),(4466,'2018-07-27 00:00:00',27,7,3,2,2018),(4467,'2018-07-28 00:00:00',28,7,3,2,2018),(4468,'2018-07-29 00:00:00',29,7,3,2,2018),(4469,'2018-07-30 00:00:00',30,7,3,2,2018),(4470,'2018-07-31 00:00:00',31,7,3,2,2018),(4471,'2018-08-01 00:00:00',1,8,3,2,2018),(4472,'2018-08-02 00:00:00',2,8,3,2,2018),(4473,'2018-08-03 00:00:00',3,8,3,2,2018),(4474,'2018-08-04 00:00:00',4,8,3,2,2018),(4475,'2018-08-05 00:00:00',5,8,3,2,2018),(4476,'2018-08-06 00:00:00',6,8,3,2,2018),(4477,'2018-08-07 00:00:00',7,8,3,2,2018),(4478,'2018-08-08 00:00:00',8,8,3,2,2018),(4479,'2018-08-09 00:00:00',9,8,3,2,2018),(4480,'2018-08-10 00:00:00',10,8,3,2,2018),(4481,'2018-08-11 00:00:00',11,8,3,2,2018),(4482,'2018-08-12 00:00:00',12,8,3,2,2018),(4483,'2018-08-13 00:00:00',13,8,3,2,2018),(4484,'2018-08-14 00:00:00',14,8,3,2,2018),(4485,'2018-08-15 00:00:00',15,8,3,2,2018),(4486,'2018-08-16 00:00:00',16,8,3,2,2018),(4487,'2018-08-17 00:00:00',17,8,3,2,2018),(4488,'2018-08-18 00:00:00',18,8,3,2,2018),(4489,'2018-08-19 00:00:00',19,8,3,2,2018),(4490,'2018-08-20 00:00:00',20,8,3,2,2018),(4491,'2018-08-21 00:00:00',21,8,3,2,2018),(4492,'2018-08-22 00:00:00',22,8,3,2,2018),(4493,'2018-08-23 00:00:00',23,8,3,2,2018),(4494,'2018-08-24 00:00:00',24,8,3,2,2018),(4495,'2018-08-25 00:00:00',25,8,3,2,2018),(4496,'2018-08-26 00:00:00',26,8,3,2,2018),(4497,'2018-08-27 00:00:00',27,8,3,2,2018),(4498,'2018-08-28 00:00:00',28,8,3,2,2018),(4499,'2018-08-29 00:00:00',29,8,3,2,2018),(4500,'2018-08-30 00:00:00',30,8,3,2,2018),(4501,'2018-08-31 00:00:00',31,8,3,2,2018),(4502,'2018-09-01 00:00:00',1,9,3,2,2018),(4503,'2018-09-02 00:00:00',2,9,3,2,2018),(4504,'2018-09-03 00:00:00',3,9,3,2,2018),(4505,'2018-09-04 00:00:00',4,9,3,2,2018),(4506,'2018-09-05 00:00:00',5,9,3,2,2018),(4507,'2018-09-06 00:00:00',6,9,3,2,2018),(4508,'2018-09-07 00:00:00',7,9,3,2,2018),(4509,'2018-09-08 00:00:00',8,9,3,2,2018),(4510,'2018-09-09 00:00:00',9,9,3,2,2018),(4511,'2018-09-10 00:00:00',10,9,3,2,2018),(4512,'2018-09-11 00:00:00',11,9,3,2,2018),(4513,'2018-09-12 00:00:00',12,9,3,2,2018),(4514,'2018-09-13 00:00:00',13,9,3,2,2018),(4515,'2018-09-14 00:00:00',14,9,3,2,2018),(4516,'2018-09-15 00:00:00',15,9,3,2,2018),(4517,'2018-09-16 00:00:00',16,9,3,2,2018),(4518,'2018-09-17 00:00:00',17,9,3,2,2018),(4519,'2018-09-18 00:00:00',18,9,3,2,2018),(4520,'2018-09-19 00:00:00',19,9,3,2,2018),(4521,'2018-09-20 00:00:00',20,9,3,2,2018),(4522,'2018-09-21 00:00:00',21,9,3,2,2018),(4523,'2018-09-22 00:00:00',22,9,3,2,2018),(4524,'2018-09-23 00:00:00',23,9,3,2,2018),(4525,'2018-09-24 00:00:00',24,9,3,2,2018),(4526,'2018-09-25 00:00:00',25,9,3,2,2018),(4527,'2018-09-26 00:00:00',26,9,3,2,2018),(4528,'2018-09-27 00:00:00',27,9,3,2,2018),(4529,'2018-09-28 00:00:00',28,9,3,2,2018),(4530,'2018-09-29 00:00:00',29,9,3,2,2018),(4531,'2018-09-30 00:00:00',30,9,3,2,2018),(4532,'2018-10-01 00:00:00',1,10,4,2,2018),(4533,'2018-10-02 00:00:00',2,10,4,2,2018),(4534,'2018-10-03 00:00:00',3,10,4,2,2018),(4535,'2018-10-04 00:00:00',4,10,4,2,2018),(4536,'2018-10-05 00:00:00',5,10,4,2,2018),(4537,'2018-10-06 00:00:00',6,10,4,2,2018),(4538,'2018-10-07 00:00:00',7,10,4,2,2018),(4539,'2018-10-08 00:00:00',8,10,4,2,2018),(4540,'2018-10-09 00:00:00',9,10,4,2,2018),(4541,'2018-10-10 00:00:00',10,10,4,2,2018),(4542,'2018-10-11 00:00:00',11,10,4,2,2018),(4543,'2018-10-12 00:00:00',12,10,4,2,2018),(4544,'2018-10-13 00:00:00',13,10,4,2,2018),(4545,'2018-10-14 00:00:00',14,10,4,2,2018),(4546,'2018-10-15 00:00:00',15,10,4,2,2018),(4547,'2018-10-16 00:00:00',16,10,4,2,2018),(4548,'2018-10-17 00:00:00',17,10,4,2,2018),(4549,'2018-10-18 00:00:00',18,10,4,2,2018),(4550,'2018-10-19 00:00:00',19,10,4,2,2018),(4551,'2018-10-20 00:00:00',20,10,4,2,2018),(4552,'2018-10-21 00:00:00',21,10,4,2,2018),(4553,'2018-10-22 00:00:00',22,10,4,2,2018),(4554,'2018-10-23 00:00:00',23,10,4,2,2018),(4555,'2018-10-24 00:00:00',24,10,4,2,2018),(4556,'2018-10-25 00:00:00',25,10,4,2,2018),(4557,'2018-10-26 00:00:00',26,10,4,2,2018),(4558,'2018-10-27 00:00:00',27,10,4,2,2018),(4559,'2018-10-28 00:00:00',28,10,4,2,2018),(4560,'2018-10-29 00:00:00',29,10,4,2,2018),(4561,'2018-10-30 00:00:00',30,10,4,2,2018),(4562,'2018-10-31 00:00:00',31,10,4,2,2018),(4563,'2018-11-01 00:00:00',1,11,4,2,2018),(4564,'2018-11-02 00:00:00',2,11,4,2,2018),(4565,'2018-11-03 00:00:00',3,11,4,2,2018),(4566,'2018-11-04 00:00:00',4,11,4,2,2018),(4567,'2018-11-05 00:00:00',5,11,4,2,2018),(4568,'2018-11-06 00:00:00',6,11,4,2,2018),(4569,'2018-11-07 00:00:00',7,11,4,2,2018),(4570,'2018-11-08 00:00:00',8,11,4,2,2018),(4571,'2018-11-09 00:00:00',9,11,4,2,2018),(4572,'2018-11-10 00:00:00',10,11,4,2,2018),(4573,'2018-11-11 00:00:00',11,11,4,2,2018),(4574,'2018-11-12 00:00:00',12,11,4,2,2018),(4575,'2018-11-13 00:00:00',13,11,4,2,2018),(4576,'2018-11-14 00:00:00',14,11,4,2,2018),(4577,'2018-11-15 00:00:00',15,11,4,2,2018),(4578,'2018-11-16 00:00:00',16,11,4,2,2018),(4579,'2018-11-17 00:00:00',17,11,4,2,2018),(4580,'2018-11-18 00:00:00',18,11,4,2,2018),(4581,'2018-11-19 00:00:00',19,11,4,2,2018),(4582,'2018-11-20 00:00:00',20,11,4,2,2018),(4583,'2018-11-21 00:00:00',21,11,4,2,2018),(4584,'2018-11-22 00:00:00',22,11,4,2,2018),(4585,'2018-11-23 00:00:00',23,11,4,2,2018),(4586,'2018-11-24 00:00:00',24,11,4,2,2018),(4587,'2018-11-25 00:00:00',25,11,4,2,2018),(4588,'2018-11-26 00:00:00',26,11,4,2,2018),(4589,'2018-11-27 00:00:00',27,11,4,2,2018),(4590,'2018-11-28 00:00:00',28,11,4,2,2018),(4591,'2018-11-29 00:00:00',29,11,4,2,2018),(4592,'2018-11-30 00:00:00',30,11,4,2,2018),(4593,'2018-12-01 00:00:00',1,12,4,2,2018),(4594,'2018-12-02 00:00:00',2,12,4,2,2018),(4595,'2018-12-03 00:00:00',3,12,4,2,2018),(4596,'2018-12-04 00:00:00',4,12,4,2,2018),(4597,'2018-12-05 00:00:00',5,12,4,2,2018),(4598,'2018-12-06 00:00:00',6,12,4,2,2018),(4599,'2018-12-07 00:00:00',7,12,4,2,2018),(4600,'2018-12-08 00:00:00',8,12,4,2,2018),(4601,'2018-12-09 00:00:00',9,12,4,2,2018),(4602,'2018-12-10 00:00:00',10,12,4,2,2018),(4603,'2018-12-11 00:00:00',11,12,4,2,2018),(4604,'2018-12-12 00:00:00',12,12,4,2,2018),(4605,'2018-12-13 00:00:00',13,12,4,2,2018),(4606,'2018-12-14 00:00:00',14,12,4,2,2018),(4607,'2018-12-15 00:00:00',15,12,4,2,2018),(4608,'2018-12-16 00:00:00',16,12,4,2,2018),(4609,'2018-12-17 00:00:00',17,12,4,2,2018),(4610,'2018-12-18 00:00:00',18,12,4,2,2018),(4611,'2018-12-19 00:00:00',19,12,4,2,2018),(4612,'2018-12-20 00:00:00',20,12,4,2,2018),(4613,'2018-12-21 00:00:00',21,12,4,2,2018),(4614,'2018-12-22 00:00:00',22,12,4,2,2018),(4615,'2018-12-23 00:00:00',23,12,4,2,2018),(4616,'2018-12-24 00:00:00',24,12,4,2,2018),(4617,'2018-12-25 00:00:00',25,12,4,2,2018),(4618,'2018-12-26 00:00:00',26,12,4,2,2018),(4619,'2018-12-27 00:00:00',27,12,4,2,2018),(4620,'2018-12-28 00:00:00',28,12,4,2,2018),(4621,'2018-12-29 00:00:00',29,12,4,2,2018),(4622,'2018-12-30 00:00:00',30,12,4,2,2018),(4623,'2018-12-31 00:00:00',31,12,4,2,2018),(4624,'2019-01-01 00:00:00',1,1,1,1,2019),(4625,'2019-01-02 00:00:00',2,1,1,1,2019),(4626,'2019-01-03 00:00:00',3,1,1,1,2019),(4627,'2019-01-04 00:00:00',4,1,1,1,2019),(4628,'2019-01-05 00:00:00',5,1,1,1,2019),(4629,'2019-01-06 00:00:00',6,1,1,1,2019),(4630,'2019-01-07 00:00:00',7,1,1,1,2019),(4631,'2019-01-08 00:00:00',8,1,1,1,2019),(4632,'2019-01-09 00:00:00',9,1,1,1,2019),(4633,'2019-01-10 00:00:00',10,1,1,1,2019),(4634,'2019-01-11 00:00:00',11,1,1,1,2019),(4635,'2019-01-12 00:00:00',12,1,1,1,2019),(4636,'2019-01-13 00:00:00',13,1,1,1,2019),(4637,'2019-01-14 00:00:00',14,1,1,1,2019),(4638,'2019-01-15 00:00:00',15,1,1,1,2019),(4639,'2019-01-16 00:00:00',16,1,1,1,2019),(4640,'2019-01-17 00:00:00',17,1,1,1,2019),(4641,'2019-01-18 00:00:00',18,1,1,1,2019),(4642,'2019-01-19 00:00:00',19,1,1,1,2019),(4643,'2019-01-20 00:00:00',20,1,1,1,2019),(4644,'2019-01-21 00:00:00',21,1,1,1,2019),(4645,'2019-01-22 00:00:00',22,1,1,1,2019),(4646,'2019-01-23 00:00:00',23,1,1,1,2019),(4647,'2019-01-24 00:00:00',24,1,1,1,2019),(4648,'2019-01-25 00:00:00',25,1,1,1,2019),(4649,'2019-01-26 00:00:00',26,1,1,1,2019),(4650,'2019-01-27 00:00:00',27,1,1,1,2019),(4651,'2019-01-28 00:00:00',28,1,1,1,2019),(4652,'2019-01-29 00:00:00',29,1,1,1,2019),(4653,'2019-01-30 00:00:00',30,1,1,1,2019),(4654,'2019-01-31 00:00:00',31,1,1,1,2019),(4655,'2019-02-01 00:00:00',1,2,1,1,2019),(4656,'2019-02-02 00:00:00',2,2,1,1,2019),(4657,'2019-02-03 00:00:00',3,2,1,1,2019),(4658,'2019-02-04 00:00:00',4,2,1,1,2019),(4659,'2019-02-05 00:00:00',5,2,1,1,2019),(4660,'2019-02-06 00:00:00',6,2,1,1,2019),(4661,'2019-02-07 00:00:00',7,2,1,1,2019),(4662,'2019-02-08 00:00:00',8,2,1,1,2019),(4663,'2019-02-09 00:00:00',9,2,1,1,2019),(4664,'2019-02-10 00:00:00',10,2,1,1,2019),(4665,'2019-02-11 00:00:00',11,2,1,1,2019),(4666,'2019-02-12 00:00:00',12,2,1,1,2019),(4667,'2019-02-13 00:00:00',13,2,1,1,2019),(4668,'2019-02-14 00:00:00',14,2,1,1,2019),(4669,'2019-02-15 00:00:00',15,2,1,1,2019),(4670,'2019-02-16 00:00:00',16,2,1,1,2019),(4671,'2019-02-17 00:00:00',17,2,1,1,2019),(4672,'2019-02-18 00:00:00',18,2,1,1,2019),(4673,'2019-02-19 00:00:00',19,2,1,1,2019),(4674,'2019-02-20 00:00:00',20,2,1,1,2019),(4675,'2019-02-21 00:00:00',21,2,1,1,2019),(4676,'2019-02-22 00:00:00',22,2,1,1,2019),(4677,'2019-02-23 00:00:00',23,2,1,1,2019),(4678,'2019-02-24 00:00:00',24,2,1,1,2019),(4679,'2019-02-25 00:00:00',25,2,1,1,2019),(4680,'2019-02-26 00:00:00',26,2,1,1,2019),(4681,'2019-02-27 00:00:00',27,2,1,1,2019),(4682,'2019-02-28 00:00:00',28,2,1,1,2019),(4683,'2019-03-01 00:00:00',1,2,1,1,2019),(4684,'2019-03-02 00:00:00',2,3,1,1,2019),(4685,'2019-03-03 00:00:00',3,3,1,1,2019),(4686,'2019-03-04 00:00:00',4,3,1,1,2019),(4687,'2019-03-05 00:00:00',5,3,1,1,2019),(4688,'2019-03-06 00:00:00',6,3,1,1,2019),(4689,'2019-03-07 00:00:00',7,3,1,1,2019),(4690,'2019-03-08 00:00:00',8,3,1,1,2019),(4691,'2019-03-09 00:00:00',9,3,1,1,2019),(4692,'2019-03-10 00:00:00',10,3,1,1,2019),(4693,'2019-03-11 00:00:00',11,3,1,1,2019),(4694,'2019-03-12 00:00:00',12,3,1,1,2019),(4695,'2019-03-13 00:00:00',13,3,1,1,2019),(4696,'2019-03-14 00:00:00',14,3,1,1,2019),(4697,'2019-03-15 00:00:00',15,3,1,1,2019),(4698,'2019-03-16 00:00:00',16,3,1,1,2019),(4699,'2019-03-17 00:00:00',17,3,1,1,2019),(4700,'2019-03-18 00:00:00',18,3,1,1,2019),(4701,'2019-03-19 00:00:00',19,3,1,1,2019),(4702,'2019-03-20 00:00:00',20,3,1,1,2019),(4703,'2019-03-21 00:00:00',21,3,1,1,2019),(4704,'2019-03-22 00:00:00',22,3,1,1,2019),(4705,'2019-03-23 00:00:00',23,3,1,1,2019),(4706,'2019-03-24 00:00:00',24,3,1,1,2019),(4707,'2019-03-25 00:00:00',25,3,1,1,2019),(4708,'2019-03-26 00:00:00',26,3,1,1,2019),(4709,'2019-03-27 00:00:00',27,3,1,1,2019),(4710,'2019-03-28 00:00:00',28,3,1,1,2019),(4711,'2019-03-29 00:00:00',29,3,1,1,2019),(4712,'2019-03-30 00:00:00',30,3,1,1,2019),(4713,'2019-03-31 00:00:00',31,3,1,1,2019),(4714,'2019-04-01 00:00:00',1,3,2,1,2019),(4715,'2019-04-02 00:00:00',2,4,2,1,2019),(4716,'2019-04-03 00:00:00',3,4,2,1,2019),(4717,'2019-04-04 00:00:00',4,4,2,1,2019),(4718,'2019-04-05 00:00:00',5,4,2,1,2019),(4719,'2019-04-06 00:00:00',6,4,2,1,2019),(4720,'2019-04-07 00:00:00',7,4,2,1,2019),(4721,'2019-04-08 00:00:00',8,4,2,1,2019),(4722,'2019-04-09 00:00:00',9,4,2,1,2019),(4723,'2019-04-10 00:00:00',10,4,2,1,2019),(4724,'2019-04-11 00:00:00',11,4,2,1,2019),(4725,'2019-04-12 00:00:00',12,4,2,1,2019),(4726,'2019-04-13 00:00:00',13,4,2,1,2019),(4727,'2019-04-14 00:00:00',14,4,2,1,2019),(4728,'2019-04-15 00:00:00',15,4,2,1,2019),(4729,'2019-04-16 00:00:00',16,4,2,1,2019),(4730,'2019-04-17 00:00:00',17,4,2,1,2019),(4731,'2019-04-18 00:00:00',18,4,2,1,2019),(4732,'2019-04-19 00:00:00',19,4,2,1,2019),(4733,'2019-04-20 00:00:00',20,4,2,1,2019),(4734,'2019-04-21 00:00:00',21,4,2,1,2019),(4735,'2019-04-22 00:00:00',22,4,2,1,2019),(4736,'2019-04-23 00:00:00',23,4,2,1,2019),(4737,'2019-04-24 00:00:00',24,4,2,1,2019),(4738,'2019-04-25 00:00:00',25,4,2,1,2019),(4739,'2019-04-26 00:00:00',26,4,2,1,2019),(4740,'2019-04-27 00:00:00',27,4,2,1,2019),(4741,'2019-04-28 00:00:00',28,4,2,1,2019),(4742,'2019-04-29 00:00:00',29,4,2,1,2019),(4743,'2019-04-30 00:00:00',30,4,2,1,2019);
UNLOCK TABLES;








USE `ar_perfurmar` ;



-- -----------------------------------------------------
-- procedure d_alltables
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `d_alltables`()
BEGIN
delete from mei_dim_cliente;
delete from mei_dim_clientea;
delete from mei_dim_clienteb;
delete from mei_dim_funcionarioa;
delete from mei_dim_funcionariob;
delete from mei_dim_perfumea;
delete from mei_dim_perfumeb;
delete from mei_tfvendaa;
delete from mei_tfvendab;
delete from mei_tfvendapa;
delete from mei_tfvendapb;
delete from mei_tfvendas;
delete from pos_dim_cliente;
delete from pos_dim_data;
delete from pos_dim_funcionario;
delete from pos_dim_perfume;
delete from pos_tf_venda;
delete from pre_dim_clientea;
delete from pre_dim_clienteb;
delete from pre_dim_data;
delete from pre_dim_funcionarioa;
delete from pre_dim_funcionariob;
delete from pre_dim_perfumea;
delete from pre_dim_perfumeb;
delete from pre_tfvendaa;
delete from pre_tfvendab;
delete from pre_tfvendapa;
delete from pre_tfvendapb;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_ltDimCliente
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_ltDimCliente`()
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_cliente` 
(
`idCliente_fonte1`, 
`idCliente_fonte2`,
`nome`,
`cidade`,
`idade`,
`email`,
`telemovel`
)
select a.idCliente, b.idCliente, a.nome, a.cidade, a.idade, a.email, a.telemovel from mei_dim_clientea as a inner join mei_dim_clienteb as b
on a.email = b.email 
union all
select a.idCliente, b.idCliente, a.nome, a.cidade, a.idade, a.email, a.telemovel from mei_dim_clientea as a left join mei_dim_clienteb as b
on a.email = b.email where b.email is null
union all
select a.idCliente, b.idCliente, b.nome, b.cidade, b.idade, b.email, b.telemovel from mei_dim_clientea as a right join mei_dim_clienteb as b
on a.email = b.email where a.email is null;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_ltDimData
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_ltDimData`(in data date, in dia int, in mes int, in trimestre int, in semestre int, in ano int)
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_data` 
(
`data`,
`dia`,
`mes`,
`trimestre`,
`semestre`,
`ano`
)
VALUES(data, dia, mes, trimestre, semestre, ano);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_ltDimFuncionario
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_ltDimFuncionario`()
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_funcionario` 
(
`idFuncionario_fonte1`, 
`idFuncionario_fonte2`,
`nome`,
`cidade`,
`telemovel`
)
select a.idFuncionario, b.idFuncionario, a.nome, a.cidade, a.telemovel from mei_dim_funcionarioa as a inner join mei_dim_funcionariob as b
on a.telemovel = b.telemovel 
union all
select a.idFuncionario, b.idFuncionario, a.nome, a.cidade, a.telemovel from mei_dim_funcionarioa as a left join mei_dim_funcionariob as b
on a.telemovel = b.telemovel where b.telemovel is null
union all
select a.idFuncionario, b.idFuncionario, b.nome, b.cidade, b.telemovel from mei_dim_funcionarioa as a right join mei_dim_funcionariob as b
on a.telemovel = b.telemovel where a.telemovel is null;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_ltDimPerfume
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_ltDimPerfume`()
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_perfume` 
(
`idPerfume_fonte1`, 
`idPerfume_fonte2`,
`nome`,
`tipo`,
`categoria`
)
select a.idPerfume, b.idPerfume, a.nome, a.tipo, a.categoria from mei_dim_perfumea as a inner join mei_dim_perfumeb as b
on a.nome = b.nome 
union all
select a.idPerfume, b.idPerfume, a.nome, a.tipo, a.categoria from mei_dim_perfumea as a left join mei_dim_perfumeb as b
on a.nome = b.nome where b.nome is null
union all
select a.idPerfume, b.idPerfume, a.nome, a.tipo, a.categoria from mei_dim_perfumea as a right join mei_dim_perfumeb as b
on a.nome = b.nome where a.nome is null;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_ltVendas
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_ltVendas`(in id int, in dat date, in custo float, in idF int, in idC int, in fonte int)
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_vendas` 
(
`idVenda`,
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`,
`fonte`
)
values(id, dat, custo, idF, idC, fonte);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure ir_ltVendas -> ACRESCENTADO POR MIM !!!!!!!
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ir_ltVendas`(in id int, in dat date, in custo float, in idF int, in idC int, in fonte int)
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_vendas` 
(
`idVenda`,
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`,
`fonte`
)
values(id, dat, custo, idF, idC, fonte);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_ltVendasA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_ltVendasA`(in id int, in dat date, in custo float, in idF int, in idC int)
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_vendas` 
(
`idVenda`,
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`,
`fonte`
)
values(id, dat, custo, idF, idC, 1);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_ltVendasB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_ltVendasB`(in id int, in dat date, in custo float, in idF int, in idC int)
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_vendas` 
(
`idVenda`,
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`,
`fonte`
)
values(id, dat, custo, idF, idC, 2);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiDIMCliente
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiDIMCliente`(IN id INT, in nome varchar(45), IN morada varchar(45), in email varchar(45), in tlm int, IN dataN date, IN fonte INT)
BEGIN
DECLARE idade INT;

SET idade = FLOOR(DATEDIFF(NOW(), DATE(dataN))/365);

INSERT INTO 
`ar_perfurmar`.`mei_dim_cliente`
(
`idmei_dim_cliente`, 
`nome`,
`cidade`,
`email`,
`telemovel`,
`idade`,
`fonte`
)
VALUES(id, nome, morada, email, tlm, idade, fonte);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiDIMClienteA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiDIMClienteA`(IN id INT, in nome varchar(45), IN morada varchar(45), in email varchar(45), in tlm varchar(45), IN dataN date)
BEGIN
DECLARE idade INT;

SET idade = FLOOR(DATEDIFF(NOW(), DATE(dataN))/365);

INSERT INTO 
`ar_perfurmar`.`mei_dim_clientea`
(
`idCliente`, 
`nome`,
`cidade`,
`email`,
`telemovel`,
`idade`
)
VALUES(id, nome, morada, email, tlm, idade);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiDIMClienteB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiDIMClienteB`(IN id INT, in nome varchar(45), IN morada varchar(45), in email varchar(45), in tlm varchar(45), IN dataN date)
BEGIN
DECLARE idade INT;

SET idade = FLOOR(DATEDIFF(NOW(), DATE(dataN))/365);

INSERT INTO 
`ar_perfurmar`.`mei_dim_clienteb`
(
`idCliente`, 
`nome`,
`cidade`,
`email`,
`telemovel`,
`idade`
)
VALUES(id, nome, morada, email, tlm, idade);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiDIMFuncionarioA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiDIMFuncionarioA`(IN id INT, in nome varchar(45), in tlm varchar(45), IN morada varchar(45))
BEGIN

INSERT INTO 
`ar_perfurmar`.`mei_dim_funcionarioa`
(
`idFuncionario`, 
`nome`,
`telemovel`,
`cidade`
)
VALUES(id, nome, tlm, morada);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiDIMFuncionarioB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiDIMFuncionarioB`(IN id INT, in nome varchar(45), in tlm varchar(45), IN morada varchar(45))
BEGIN

INSERT INTO 
`ar_perfurmar`.`mei_dim_funcionariob`
(
`idFuncionario`, 
`nome`,
`telemovel`,
`cidade`
)
VALUES(id, nome, tlm, morada);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiDIMPerfumeA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiDIMPerfumeA`(IN id INT, in nome varchar(45), in stock int, IN preco float, in tipo varchar(45), in categoria varchar(45))
BEGIN

INSERT INTO 
`ar_perfurmar`.`mei_dim_perfumea`
(
`idPerfume`, 
`nome`,
`stock`,
`precoUnitario`,
`tipo`,
`categoria`
)
VALUES(id, nome, stock, preco, tipo, categoria);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiDIMPerfumeB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiDIMPerfumeB`(IN id INT, in nome varchar(45), in stock int, IN preco float, in tipo varchar(45), in categoria varchar(45))
BEGIN

INSERT INTO 
`ar_perfurmar`.`mei_dim_perfumeb`
(
`idPerfume`, 
`nome`,
`stock`,
`precoUnitario`,
`tipo`,
`categoria`
)
VALUES(id, nome, stock, preco, tipo, categoria);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiTFVendaA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiTFVendaA`(IN id INT, in dt date,in custo float, in idF int, in idC int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`mei_tfvendaa`
(
`idVenda`, 
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`
)
VALUES(id, dt, custo, idF, idC);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiTFVendaB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiTFVendaB`(IN id INT, in dt date,in custo float, in idF int, in idC int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`mei_tfvendab`
(
`idVenda`, 
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`
)
VALUES(id, dt, custo, idF, idC);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiTFVendaPA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiTFVendaPA`(IN id INT, in idP int, in custo float, in qt int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`mei_tfvendapa`
(
`idVenda`, 
`idPerfume`,
`precoVenda`,
`quantidade`
)
VALUES(id, idP, custo, qt);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meiTFVendaPB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meiTFVendaPB`(IN id INT, in idP int, in custo float, in qt int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`mei_tfvendapb`
(
`idVenda`, 
`idPerfume`,
`precoVenda`,
`quantidade`
)
VALUES(id, idP, custo, qt);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meitfvendasA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meitfvendasA`()
BEGIN

INSERT INTO 
`ar_perfurmar`.`mei_tfvendas`
(
`idVenda`, 
`idPerfume`,
`data`,
`idFuncionario`,
`idCliente`,
`precoVenda`,
`quantidade`,
`custoTotal`,
`fonte`
)
select b.SKVenda, ap.idPerfume, a.data, a.idFuncionario, a.idCliente, ap.precoVenda, ap.quantidade , a.custoTotal, 1 from mei_tfvendaa as a 
inner join mei_tfvendapa as ap on a.idVenda = ap.idVenda
inner join lookuptable_vendas as b where a.idVenda = b.idVenda and b.fonte =1;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meitfvendasAntigo
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meitfvendasAntigo`()
BEGIN

INSERT INTO 
`ar_perfurmar`.`mei_tfvendas`
(
`idVenda`, 
`idPerfume`,
`data`,
`idFuncionario`,
`idCliente`,
`precoVenda`,
`quantidade`,
`custoTotal`
)
select A.idVenda, P.idPerfume, A.data, A.idFuncionario, A.idCliente, P.precoVenda, P.quantidade, A.custoTotal from mei_tfvendaa AS A inner join mei_tfvendapa AS P where A.idVenda = P.idVenda
union all
select A.idVenda, P.idPerfume, A.data, A.idFuncionario, A.idCliente, P.precoVenda, P.quantidade, A.custoTotal from mei_tfvendab AS A inner join mei_tfvendapb AS P where A.idVenda = P.idVenda;

END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_meitfvendasB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_meitfvendasB`()
BEGIN

INSERT INTO 
`ar_perfurmar`.`mei_tfvendas`
(
`idVenda`, 
`idPerfume`,
`data`,
`idFuncionario`,
`idCliente`,
`precoVenda`,
`quantidade`,
`custoTotal`,
`fonte`
)
select b.SKVenda, ap.idPerfume, a.data, a.idFuncionario, a.idCliente, ap.precoVenda, ap.quantidade , a.custoTotal, 2 from mei_tfvendab as a 
inner join mei_tfvendapb as ap on a.idVenda = ap.idVenda
inner join lookuptable_vendas as b where a.idVenda = b.idVenda and b.fonte =2;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_posDIMCliente
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_posDIMCliente`(IN id INT, in nome varchar(45), IN morada varchar(45), in idade int, in email varchar(45), in tlm varchar(45))
BEGIN
INSERT INTO `ar_perfurmar`.`pos_dim_cliente` 
(
`idCliente`, 
`nome`,
`cidade`,
`idade`,
`email`,
`telemovel`
)
VALUES(id, nome, morada, idade, email, tlm);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_posDIMClienteU
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_posDIMClienteU`(IN id INT, in nome varchar(45), IN morada varchar(45), in dt date, in email varchar(45), in tlm varchar(45))
BEGIN
DECLARE idade INT;

SET idade = FLOOR(DATEDIFF(NOW(), DATE(dt))/365);
INSERT INTO `ar_perfurmar`.`pos_dim_clienteu` 
(
`idCliente`, 
`nome`,
`cidade`,
`idade`,
`email`,
`telemovel`
)
VALUES(id, nome, morada, idade, email, tlm);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_posDIMFuncionario
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_posDIMFuncionario`(IN id INT, in nome varchar(45), IN morada varchar(45), in tlm varchar(45))
BEGIN
INSERT INTO `ar_perfurmar`.`pos_dim_funcionario` 
(
`idFuncionario`, 
`nome`,
`cidade`,
`telemovel`
)
VALUES(id, nome, morada, tlm);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_posDIMPerfume
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_posDIMPerfume`(IN id INT, in nome varchar(45), IN tipo varchar(45), in categoria varchar(45))
BEGIN
INSERT INTO `ar_perfurmar`.`pos_dim_perfume` 
(
`idPerfume`, 
`nome`,
`tipo`,
`categoria`
)
VALUES(id, nome, tipo, categoria);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_posDimData
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_posDimData`(in data date, in dia int, in mes int, in trimestre int, in semestre int, in ano int)
BEGIN

INSERT INTO `ar_perfurmar`.`lookuptable_data` 
(
`data`,
`dia`,
`mes`,
`trimestre`,
`semestre`,
`ano`
)
VALUES(data, dia, mes, trimestre, semestre, ano);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_posTFVendas
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_posTFVendas`(IN skp INT, in skc int, in skf int, in skd int, in custo float, in preco float, in qt int )
BEGIN
INSERT INTO `ar_perfurmar`.`pos_tf_venda` 
( 
`SKPerfume`,
`SKCliente`,
`SKFuncionario`,
`SKData`,
`custoTotal`,
`precoUnitario`,
`quantidade`
)
VALUES(skp, skc, skf, skd, custo, preco, qt);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preDIMCliente
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preDIMCliente`(IN id INT, in nome varchar(45),in tlm int, in email varchar(45), in prof varchar(45), in dataN date, IN morada varchar(45), IN fonte int, in tipo varchar(1), in dataO timestamp)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_dim_cliente`
(
`idCliente`, 
`nome`,
`telemovel`,
`email`,
`profissao`,
`dataNascimento`,
`cidade`,
`fonte`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, nome, tlm, email, prof, dataN, morada, fonte, tipo, dataO);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preDIMClienteA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preDIMClienteA`(IN id INT, in nome varchar(45),in tlm varchar(45), in email varchar(45), in prof varchar(45), in dataN date, IN morada varchar(45), in tipo varchar(1), in dataO timestamp)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_dim_clienteA`
(
`idCliente`, 
`nome`,
`telemovel`,
`email`,
`profissao`,
`dataNascimento`,
`cidade`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, nome, tlm, email, prof, dataN, morada, tipo, dataO);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preDIMClienteB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preDIMClienteB`(IN id INT, in nome varchar(45),in tlm varchar(45), in email varchar(45), in prof varchar(45), in dataN date, IN morada varchar(45), in tipo varchar(1), in dataO timestamp)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_dim_clienteB`
(
`idCliente`, 
`nome`,
`telemovel`,
`email`,
`profissao`,
`dataNascimento`,
`cidade`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, nome, tlm, email, prof, dataN, morada, tipo, dataO);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preDIMFuncionarioA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preDIMFuncionarioA`(IN id INT, in nome varchar(45),in tlm varchar(45),  IN morada varchar(45), in tipo varchar(1), in dataO timestamp)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_dim_funcionarioA`
(
`idFuncionario`, 
`nome`,
`telemovel`,
`cidade`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, nome, tlm, morada, tipo, dataO);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preDIMFuncionarioB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preDIMFuncionarioB`(IN id INT, in nome varchar(45),in tlm varchar(45),  IN morada varchar(45), in tipo varchar(1), in dataO timestamp)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_dim_funcionarioB`
(
`idFuncionario`, 
`nome`,
`telemovel`,
`cidade`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, nome, tlm, morada, tipo, dataO);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preDIMPerfumeA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preDIMPerfumeA`(IN id INT, in nome varchar(45),in stock int, in preco float, in tip varchar(45), in idFamilia int)
BEGIN

INSERT INTO 
`ar_perfurmar`.`pre_dim_perfumeA`
(
`idPerfume`, 
`nome`,
`stock`,
`precoUnitario`,
`tipo`,
`categoria`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, nome, stock, preco, tip, (select tipo as categoria from perfumaria_perfurmarte.familiaolfativa as fm where fm.idFamiliaOlfativa = idFamilia)
, 'I', now());
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preDIMPerfumeB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preDIMPerfumeB`(IN id INT, in nome varchar(45),in stock int, in preco float, in tip varchar(45), in idFamilia int)
BEGIN

INSERT INTO 
`ar_perfurmar`.`pre_dim_perfumeB`
(
`idPerfume`, 
`nome`,
`stock`,
`precoUnitario`,
`tipo`,
`categoria`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, nome, stock, preco, tip, (select tipo as categoria from perfumaria_perfurmarte.familiaolfativa as fm where fm.idFamiliaOlfativa = idFamilia)
, 'I', now());
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preTFVendaA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preTFVendaA`(IN id INT, in dt date,in custo float, in idF int, in idC int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_tfvendaa`
(
`idVenda`, 
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, dt, custo, idF, idC, 'I', now());
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preTFVendaB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preTFVendaB`(IN id INT, in dt date,in custo float, in idF int, in idC int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_tfvendab`
(
`idVenda`, 
`data`,
`custoTotal`,
`idFuncionario`,
`idCliente`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, dt, custo, idF, idC, 'I', now());
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preTFVendaPA
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preTFVendaPA`(IN id INT, in idP int, in custo float, in qt int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_tfvendapa`
(
`idVenda`, 
`idPerfume`,
`precoVenda`,
`quantidade`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, idP, custo, qt, 'I', now());
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure i_preTFVendaPB
-- -----------------------------------------------------
DELIMITER $$
USE `ar_perfurmar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `i_preTFVendaPB`(IN id INT, in idP int, in custo float, in qt int)
BEGIN
INSERT INTO 
`ar_perfurmar`.`pre_tfvendapb`
(
`idVenda`, 
`idPerfume`,
`precoVenda`,
`quantidade`,
`tipoOperacao`,
`dataOperacao`
)
VALUES(id, idP, custo, qt, 'I', now());
END$$

DELIMITER ;











DROP SCHEMA IF EXISTS `dw` ;
CREATE SCHEMA IF NOT EXISTS `dw` DEFAULT CHARACTER SET utf8 ;
USE `dw` ;



--
-- Table structure for table `dim_cliente`
--
DROP TABLE IF EXISTS `dim_cliente`;
CREATE TABLE `dim_cliente` (
  `SKCliente` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `idade` int(11) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telemovel` int(11) DEFAULT NULL,
  PRIMARY KEY (`SKCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `dim_data`
--
DROP TABLE IF EXISTS `dim_data`;
CREATE TABLE `dim_data` (
  `SKData` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  PRIMARY KEY (`SKData`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `dim_funcionario`
--
DROP TABLE IF EXISTS `dim_funcionario`;
CREATE TABLE `dim_funcionario` (
  `SKFuncionario` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `telemovel` int(11) DEFAULT NULL,
  PRIMARY KEY (`SKFuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `dim_perfume`
--
DROP TABLE IF EXISTS `dim_perfume`;
CREATE TABLE `dim_perfume` (
  `SKPerfume` int(11) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`SKPerfume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `tf_vendas`
--
DROP TABLE IF EXISTS `tf_vendas`;
CREATE TABLE `tf_vendas` (
  `SKPerfume` int(11) NOT NULL,
  `SKCliente` int(11) NOT NULL,
  `SKFuncionario` int(11) NOT NULL,
  `SKData` int(11) NOT NULL,
  `custoTotal` float DEFAULT NULL,
  `precoUnitario` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  KEY `fk_tf_vendas_dim_cliente_idx` (`SKCliente`),
  KEY `fk_tf_vendas_dim_perfume1_idx` (`SKPerfume`),
  KEY `fk_tf_vendas_dim_funcionario1_idx` (`SKFuncionario`),
  KEY `fk_tf_vendas_dim_Data1_idx` (`SKData`),
  CONSTRAINT `fk_tf_vendas_dim_Data1` FOREIGN KEY (`SKData`) REFERENCES `dim_data` (`SKData`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tf_vendas_dim_cliente` FOREIGN KEY (`SKCliente`) REFERENCES `dim_cliente` (`SKCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tf_vendas_dim_funcionario1` FOREIGN KEY (`SKFuncionario`) REFERENCES `dim_funcionario` (`SKFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tf_vendas_dim_perfume1` FOREIGN KEY (`SKPerfume`) REFERENCES `dim_perfume` (`SKPerfume`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
