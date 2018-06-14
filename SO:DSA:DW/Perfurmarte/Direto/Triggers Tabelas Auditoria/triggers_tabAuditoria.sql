USE `perfumaria_perfurmarte`;

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
DROP TRIGGER IF EXISTS tg_insercaoVenda;
delimiter &&
CREATE TRIGGER tg_insercaoVenda
  AFTER INSERT ON Venda
  FOR EACH ROW
  BEGIN
    INSERT INTO audVenda
		VALUES (
				NEW.idVenda, NEW.data, NEW.custoTotal,
                NEW.idFuncionario, NEW.idCliente, 'I', NOW()
                );
  END;
&& delimiter ;


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Trigger tg_updateVenda
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DROP TRIGGER IF EXISTS tg_updateVenda;
delimiter &&
CREATE TRIGGER tg_updateVenda
  AFTER UPDATE ON Venda
  FOR EACH ROW
  BEGIN
    INSERT INTO audVenda
		VALUES (
				NEW.idVenda, NEW.data, NEW.custoTotal,
                NEW.idFuncionario, NEW.idCliente, 'U', NOW()
                );
  END;
&& delimiter ;