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
