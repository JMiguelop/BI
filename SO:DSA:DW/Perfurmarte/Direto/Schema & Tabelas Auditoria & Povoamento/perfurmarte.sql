DROP SCHEMA IF EXISTS `perfumaria_perfurmarte` ;
CREATE SCHEMA IF NOT EXISTS `perfumaria_perfurmarte` DEFAULT CHARACTER SET utf8 ;
USE `perfumaria_perfurmarte` ;

-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: perfumaria_perfurmarte
-- ------------------------------------------------------
-- Server version	5.7.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audcliente`
--

DROP TABLE IF EXISTS `audcliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audcliente` (
  `idCliente` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` int(9) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `profissao` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audcliente`
--

LOCK TABLES `audcliente` WRITE;
/*!40000 ALTER TABLE `audcliente` DISABLE KEYS */;
INSERT INTO `audcliente` VALUES (11,'Ana Maria Silva Vicente',983883737,'mariav@gmail.com','Estudante','2000-12-12','Barcelos','U','2017-01-27 04:06:56'),(6,'Mário A V Santos Silva ',244042707,'marioavsantossilva@gmail.com','Rádio e TV','1955-10-14','Famalicão','U','2017-01-27 04:20:06');
/*!40000 ALTER TABLE `audcliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audfuncionario`
--

DROP TABLE IF EXISTS `audfuncionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audfuncionario` (
  `idFuncionario` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `telemovel` int(9) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audfuncionario`
--

LOCK TABLES `audfuncionario` WRITE;
/*!40000 ALTER TABLE `audfuncionario` DISABLE KEYS */;
INSERT INTO `audfuncionario` VALUES (3,'Janine Freitas',964379585,'Guimarães','U','2017-01-27 04:20:49');
/*!40000 ALTER TABLE `audfuncionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audperfume`
--

DROP TABLE IF EXISTS `audperfume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audperfume` (
  `idPerfume` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precoUnitario` float DEFAULT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audperfume`
--

LOCK TABLES `audperfume` WRITE;
/*!40000 ALTER TABLE `audperfume` DISABLE KEYS */;
/*!40000 ALTER TABLE `audperfume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audvenda`
--

DROP TABLE IF EXISTS `audvenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audvenda` (
  `idVenda` int(11) NOT NULL,
  `idPerfume` int(11) NOT NULL,
  `idFuncionario` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `data` timestamp NULL DEFAULT NULL,
  `precoUnit` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `custoTotal` float DEFAULT NULL,
  `tipoOperacao` varchar(1) DEFAULT NULL,
  `dataOperacao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audvenda`
--

LOCK TABLES `audvenda` WRITE;
/*!40000 ALTER TABLE `audvenda` DISABLE KEYS */;
/*!40000 ALTER TABLE `audvenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `idCartao` int(11) NOT NULL COMMENT 'Identificador univoco do cliente no sistema. Trata-se de um valor inteiro atribuido de forma sequencial sempre que se insere um novo cliente no sistema. Este identificador sera o identificador atribuido ao cartao de cliente.',
  `nome` varchar(45) NOT NULL COMMENT 'Nome completo de um cliente registado no sistema. ',
  `telemovel` varchar(45) DEFAULT NULL COMMENT 'Contem o contacto telefonico de um cliente. Pode ser um contacto de telemovel (principal) em que os dois primeiros inteiros correspondem a operadora seguido do resto do numero: 914477203; Caso o cliente nao possua um contacto de telemovel podera associar-se um contacto telefonico. Neste caso os 3 primeiros digitos correspondem ao indicativo da regiao e o restante o numero do contacto.',
  `email` varchar(45) DEFAULT NULL COMMENT 'Corresponde ao contacto de correio electronico do cliente. Os valores deste campo deverão ser conter o nome do email seguido de um arroba e o respectivo dominio do email.',
  `profissao` varchar(45) DEFAULT NULL COMMENT 'Profissao do cliente. Podera conter o nome do ramo da atividade, cargo desempenhado, etc.',
  `dataNascimento` date DEFAULT NULL COMMENT 'Corresponde a data de nascimento do cliente com dia, mes e ano.',
  `cidade` varchar(45) DEFAULT NULL COMMENT 'Cidade actual onde o cliente reside. Apenas e guardada o nome da cidade.',
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCartao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Avelino F Pereira Rodrigues','220978420','avelinofpereirarodrigues@gmail.com','Ciências Biológicas','1991-06-03','Famalicão','2015-11-09 11:10:23','2015-11-09 11:10:23'),(2,'Custódio Pereira Jorge','259148419','custodiopereirajorge@gmail.com','História','1968-01-19','Braga','2015-11-12 11:10:23','2015-11-12 11:10:23'),(3,'Silva Mário A V Santos','207101636','silvamarioavsantos@gmail.com','Materiais','1971-12-04','Famalicão','2015-11-19 11:10:23','2015-11-19 11:10:23'),(4,'Elaine Rodrigues Silva','928051373','elainerodriguessilva@gmail.com','Serviço Social','1981-06-16','Vizela','2015-11-21 11:10:23','2015-11-21 11:10:23'),(5,'Helena C Moreira Silva','966401648','helenacmoreirasilva@gmail.com','Gestão Comercial','1967-08-03','Braga','2015-11-22 11:10:23','2015-11-22 11:10:23'),(6,'Mário A V Santos Silva ','244042707','marioavsantossilva@gmail.com','Rádio e TV','1955-10-14','Famalicão','2015-11-25 11:10:23','2015-11-25 11:10:23'),(7,'José M Araújo Soares','274670206','josemaraujosoares@gmail.com','Fabricação Mecânica','1953-06-11','Famalicão','2015-12-19 11:10:23','2015-12-19 11:10:23'),(8,'Gisela M Almeida Benjamim','274253030','giselamalmeidabenjamim@gmail.com','Logística','1983-07-03','Esposende','2015-12-28 11:10:23','2015-12-28 11:10:23'),(9,'Alves Pereira & Martins Lda','202268788','alvespereira&martinslda@gmail.com','Materiais','1964-02-21','Famalicão','2016-01-08 11:10:23','2016-01-08 11:10:23'),(10,'Hermínio Antunes Vicente','938282747','herminioantunesvicente@gmail.com','Estética e Cosmética','1974-05-16','Barcelos','2016-01-15 11:10:23','2016-01-15 11:10:23'),(11,'Ana Maria Silva Vicente','983883737','mariav@gmail.com','Estudante','2000-12-12','Barcelos','2016-01-15 11:10:23','2016-01-15 11:10:23');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familiaolfativa`
--

DROP TABLE IF EXISTS `familiaolfativa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `familiaolfativa` (
  `idFamiliaOlfativa` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador da familia olfativa a que um dado conjunto de perfumes se insere. Por exemplo: Oriental, Floral, Amadeirado etc.. O conjunto destas chaves caracterizam o catalogo de tipos de familias olfativas disponiveis no negocio. ',
  `tipo` varchar(45) NOT NULL COMMENT 'Corresponde ao tipo de pessoa a que um perfume se destina. Por exemplo Homem, Crianca, Mulher etc..',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFamiliaOlfativa`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familiaolfativa`
--

LOCK TABLES `familiaolfativa` WRITE;
/*!40000 ALTER TABLE `familiaolfativa` DISABLE KEYS */;
INSERT INTO `familiaolfativa` VALUES (1,'Amadeirado','2015-01-01 21:50:01'),(2,'Chipre','2015-01-01 21:50:01'),(3,'Cítrico','2015-01-01 21:50:01'),(4,'Floral','2015-01-01 21:50:02'),(5,'Floriental','2015-01-01 21:50:02'),(6,'Fougère','2015-01-01 21:50:02'),(7,'Oriental','2015-01-01 21:50:03');
/*!40000 ALTER TABLE `familiaolfativa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionario` (
  `idFuncionario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria para que todos os funcionarios da perfumaria sejam identificados no negocio por um identificador sequencial do tipo inteiro.',
  `nome` varchar(45) NOT NULL COMMENT 'Corresponde ao nome completo de um funcionario no negocio ate um maximo de 45 caracteres.',
  `telemovel` int(9) NOT NULL COMMENT 'Contem o contacto telefonico principal e operacional de um funcionario. Pode ser um contacto de telemovel (principal) em que os dois primeiros inteiros correspondem a operadora seguido do restante numero: 914477203; Caso o funcionario nao possua um contacto de telemovel podera associar-se um contacto telefonico. Neste caso os 3 primeiros digitos correspondem ao indicativo da regiao e o restante o numero do contacto.',
  `cidade` varchar(45) NOT NULL COMMENT 'Cidade ou regiao onde reside um funcionario registado no sistema com um idFuncionario.\n',
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFuncionario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,'Ana Sousa',281933401,'Famalicão','2015-01-01 20:57:47','2015-01-01 20:57:47'),(2,'Carlos Sa',259718730,'Barcelos','2015-01-01 20:57:47','2015-01-01 20:57:47'),(3,'Janine Freitas',964379585,'Guimarães','2015-01-01 20:57:47','2015-01-01 20:57:47'),(4,'Joao Lopes',210892089,'Braga','2016-01-01 21:00:01','2016-01-01 21:00:01');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfume`
--

DROP TABLE IF EXISTS `perfume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perfume` (
  `idPerfume` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador univoco de um perfume no catalogo de perfumes comercializados pela loja. Cada perfume possui um id que e atribuido sequencialmente pelo sistema sempre que se comercializa novos perfumes.',
  `nome` varchar(45) NOT NULL COMMENT 'String com o nome de um determinado perfume.',
  `stock` int(11) NOT NULL COMMENT 'Stock (quantidade) disponivel de um determinado perfume na loja.',
  `precoUnitario` float NOT NULL COMMENT 'Preco unitario de venda de um determinado perfume em euros. O preco unitario corresponde ao valor final a que o artigo sera vendido na perfumaria.',
  `tipo` varchar(15) DEFAULT NULL COMMENT 'Corresponde ao tipo de pessoa a que um perfume se destina. Por exemplo Homem, Crianca, Mulher etc..',
  `idFamiliaOlfativa` int(11) NOT NULL COMMENT 'Identificador da familia olfativa a que o perfume se insere. Por exemplo: Oriental, Floral, Amadeirado etc..',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPerfume`),
  KEY `fk_Perfume_FamiliaOlfativa1_idx` (`idFamiliaOlfativa`),
  CONSTRAINT `fk_Perfume_FamiliaOlfativa1` FOREIGN KEY (`idFamiliaOlfativa`) REFERENCES `familiaolfativa` (`idFamiliaOlfativa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfume`
--

LOCK TABLES `perfume` WRITE;
/*!40000 ALTER TABLE `perfume` DISABLE KEYS */;
INSERT INTO `perfume` VALUES (1,'Zen Sun',75,59.68,'Mulher',3,'2015-01-01 21:50:01'),(2,'La Vie est belle',6,47,'Mulher',5,'2015-01-01 21:50:01'),(3,'Yellow Diamond',10,38.12,'Mulher',1,'2015-01-01 21:50:02'),(4,'Misteriosa',21,41.97,'Mulher',7,'2015-01-01 21:50:02'),(5,'Essential',55,46.47,'Homem',3,'2015-06-29 19:50:01'),(6,'Sauvage',74,54.67,'Homem',6,'2015-07-01 20:50:01'),(7,'Vip Club',17,42.54,'Homem',2,'2015-07-01 20:50:01'),(8,'The Dreamer',12,55.44,'Homem',7,'2016-01-03 21:00:53'),(9,'Toute petite',44,24.64,'Menina',3,'2016-01-03 21:00:53'),(10,'Jeune homme',66,24.64,'Menino',3,'2016-01-03 21:00:54');
/*!40000 ALTER TABLE `perfume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venda`
--

DROP TABLE IF EXISTS `venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venda` (
  `idVenda` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador univoco de uma venda realizada por um determinado funcionario no negocio. Trata-se de um identificador sequencial do tipo inteiro.',
  `data` datetime NOT NULL COMMENT 'Data de registo de uma determinada venda realizada no negocio. Alem do dia possui tambem a hora do registo da venda.',
  `custoTotal` float NOT NULL COMMENT 'Custo total de uma venda realizada por um funcionario a um cliente. Este custo total corresponde ao total faturado numa compra feita por um cliente de um ou varios artigos. O valor faturado corresponde ao custo total em euros.',
  `idFuncionario` int(11) NOT NULL COMMENT 'Identificador do funcionario que registou uma determinada venda realizada a um determinado cliente, no sistema.',
  `idCliente` int(11) DEFAULT NULL COMMENT 'Identificador (chave) do cliente que realizou uma compra de um ou mais artigos no sistema. ',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVenda`),
  KEY `fk_Venda_Funcionario_idx` (`idFuncionario`),
  KEY `fk_Venda_Cliente1_idx` (`idCliente`),
  CONSTRAINT `fk_Venda_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCartao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Funcionario` FOREIGN KEY (`idFuncionario`) REFERENCES `funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venda`
--

LOCK TABLES `venda` WRITE;
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
INSERT INTO `venda` VALUES (1,'2015-01-15 10:38:30',243.32,2,5,'2015-01-15 10:38:30'),(2,'2015-01-15 10:38:30',73.92,3,9,'2015-01-15 10:38:30'),(3,'2015-03-01 11:15:13',65.3,1,8,'2015-03-01 11:15:13'),(4,'2015-05-11 14:24:11',42.54,4,2,'2015-05-11 13:24:11'),(5,'2015-05-28 21:54:33',166.32,2,6,'2015-05-28 20:54:33'),(6,'2015-05-28 21:54:33',166.32,2,2,'2015-05-28 20:54:33'),(7,'2016-03-09 10:02:31',38.31,2,4,'2016-03-09 10:02:31'),(8,'2016-06-09 22:12:38',127.62,2,3,'2016-06-09 21:12:38'),(9,'2016-08-26 11:38:19',47.55,1,1,'2016-08-26 10:38:19'),(10,'2016-11-12 12:22:21',166.32,3,7,'2016-11-12 12:22:21');
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendaperfume`
--

DROP TABLE IF EXISTS `vendaperfume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendaperfume` (
  `idVenda` int(11) NOT NULL COMMENT 'Identificador da venda realizada por um cliente.',
  `idPerfume` int(11) NOT NULL COMMENT 'Identificador de um perfume no sistema',
  `precoVenda` float NOT NULL COMMENT 'Preco em euros a que um determinado perfume foi vendido a data da realizacao da venda. ',
  `quantidade` int(11) NOT NULL COMMENT 'Quantidade vendida de um artigo adquirido por um cliente numa venda registada no sistema.',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVenda`,`idPerfume`),
  KEY `fk_VendaPerfume_Venda1_idx` (`idVenda`),
  KEY `fk_VendaPerfume_Perfume1_idx` (`idPerfume`),
  CONSTRAINT `fk_VendaPerfume_Perfume1` FOREIGN KEY (`idPerfume`) REFERENCES `perfume` (`idPerfume`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VendaPerfume_Venda1` FOREIGN KEY (`idVenda`) REFERENCES `venda` (`idVenda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendaperfume`
--

LOCK TABLES `vendaperfume` WRITE;
/*!40000 ALTER TABLE `vendaperfume` DISABLE KEYS */;
INSERT INTO `vendaperfume` VALUES (1,6,60.83,4,'2015-01-15 10:38:30'),(2,4,59.68,2,'2015-01-15 10:38:30'),(3,7,32.65,2,'2015-03-01 11:15:13'),(4,8,32.65,3,'2015-05-11 13:24:11'),(5,2,41.97,1,'2015-05-28 20:54:33'),(6,10,55.44,1,'2015-05-28 20:54:33'),(7,9,38.12,2,'2016-03-09 10:02:31'),(8,1,46.47,3,'2016-06-09 21:12:38'),(9,3,24.64,1,'2016-08-26 10:38:19'),(10,5,32.65,3,'2016-11-12 12:22:21');
/*!40000 ALTER TABLE `vendaperfume` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-27  4:24:16
