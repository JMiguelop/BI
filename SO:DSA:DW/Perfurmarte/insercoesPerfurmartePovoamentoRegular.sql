use perfumaria_perfurmarte;

select * from venda;
select * from vendaperfume;
select * from audvenda;

select * from cliente;
select * from audcliente;

select * from perfume;
select * from familiaolfativa;
select * from audperfume;

select * from funcionario;
select * from audfuncionario;



# NOVA VENDA #
INSERT INTO Venda VALUE (11, '2017-01-01 00:00:00', '200.50', 4, 10, '2017-01-01 00:00:00');
INSERT INTO vendaperfume VALUE (11, 9, '20.05', 10, '2017-01-01 00:00:00');

# NOVO CLIENTE #
INSERT INTO cliente VALUE (11, 'Joao Miguel Ferreira Lopes', 969790498, 'joao.miguelop@gmail.com', 'Estudante', '1991-04-13', 'Viana do Castelo', '2017-05-10 11:10:23', '2017-05-10 11:10:23');

# NOVA VENDA DO CLIENTE CRIADO ACIMA #
INSERT INTO Venda VALUE (12, '2017-01-15 00:00:00', '100', 3, 11, '2017-01-15 00:00:00');
INSERT INTO vendaperfume VALUE (12, 8, '50', 2, '2017-01-15 00:00:00');

# NOVO PERFUME COM UMA NOVA FAMILIA OLFATIVA #
INSERT INTO familiaolfativa VALUE (8, 'Oliveira', '2016-02-01 00:00:00');
INSERT INTO perfume VALUE (11, 'JLS99', 10, '69.99', 'Mulher', 8, '2016-02-01 00:00:00');

# NOVA VENDA DO PERFUME CRIADO ACIMA #
INSERT INTO Venda VALUE (13, '2017-02-22 00:00:00', '400', 2, 11, '2017-02-22 00:00:00');
INSERT INTO vendaperfume VALUE (13, 11, '50', 2, '2017-02-22 00:00:00');
#INSERT INTO vendaperfume VALUE (13, 8, '100', 3, '2017-02-22 00:00:00');

# NOVO FUNCIONARIO #
INSERT INTO funcionario VALUE (5, 'Andreia Patricia Neiva Cruz', 968612986, 'Braga', '2016-02-01 00:00:00', '2016-02-01 00:00:00');

# NOVO CLIENTE #
INSERT INTO cliente VALUE (12, 'Andreia Patricia Neiva Cruz', 968612986, 'andreia.cruz9@gmail.com', 'Estudante', '1992-07-15', 'New York', '2016-02-01 00:00:00', '2016-02-01 00:00:00');

# NOVA VENDA EFETUADA PELO FUNCIONARIO CRIADO ACIMA E PELO CLIENTE CRIADO ACIMA #
INSERT INTO venda VALUE (14, '2017-01-24 00:00:00', '300', 5, 12, '2017-01-24 00:00:00');
INSERT INTO vendaperfume VALUE (14, 1, '100', 3, '2017-01-24 00:00:00');



