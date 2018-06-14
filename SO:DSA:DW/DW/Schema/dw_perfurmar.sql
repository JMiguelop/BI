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
