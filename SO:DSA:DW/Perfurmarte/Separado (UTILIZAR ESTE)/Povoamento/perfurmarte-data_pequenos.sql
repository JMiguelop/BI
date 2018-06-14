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
