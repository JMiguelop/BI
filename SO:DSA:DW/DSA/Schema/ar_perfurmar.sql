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
