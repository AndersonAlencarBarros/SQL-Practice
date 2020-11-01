-- Views

CREATE OR REPLACE VIEW vw_bancos AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT * FROM vw_bancos;

-- uso de 'alias' para a view
CREATE OR REPLACE VIEW vw_bancos2 (banco_numero, banco_nome, banco_ativo) AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT banco_numero FROM vw_bancos2;

INSERT INTO vw_bancos2 (banco_numero, banco_nome, banco_ativo) 
VALUES (51, 'Banco Nice', TRUE);

-- inserir na view insere na tabela original
SELECT numero, nome, ativo FROM banco WHERE numero = 51;

UPDATE vw_bancos2 SET banco_ativo = FALSE
WHERE banco_numero = 51;

DELETE FROM vw_bancos2 WHERE banco_numero = 51;

-- se esse query tool fosse fechada, essa
-- view desaparece
CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
	SELECT nome FROM agencia
);

SELECT nome FROM vw_agencia;

-- view com uma condicao logica
CREATE OR REPLACE VIEW vw_banco_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

INSERT INTO vw_banco_ativos (numero, nome, ativo)
VALUES (51, 'Banco Bom', FALSE);

-- todos os bancos ativos
SELECT * FROM vw_banco_ativos;

CREATE OR REPLACE VIEW vw_bancos_com_a AS (
	SELECT numero, nome, ativo
	FROM vw_banco_ativos
	WHERE nome ILIKE 'a%'
) WITH LOCAL CHECK OPTION;

-- viola a regra, pois nao comeca com 'a'
INSERT INTO vw_bancos_com_a (numero, nome, ativo)
VALUES (333, 'Banco BBB', true);

-- viola a regra de vw_banco_ativos
-- caso remova WITH LOCAL CHECK OPTION
-- de vw_banco_ativos nao violaria.
-- Poderia remover e substituir em
-- vw_bancos_com_a WITH LOCAL CHECK OPTION
-- por WITH CASCADED CHECK OPTION
INSERT INTO vw_bancos_com_a (numero, nome, ativo)
VALUES (335, 'Alfa Omega', false);

SELECT * FROM vw_bancos_com_a;