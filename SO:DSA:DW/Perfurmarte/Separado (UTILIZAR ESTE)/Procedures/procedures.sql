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
