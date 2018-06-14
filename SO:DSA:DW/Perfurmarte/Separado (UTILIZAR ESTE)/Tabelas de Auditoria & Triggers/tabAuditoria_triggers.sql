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

