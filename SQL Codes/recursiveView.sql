-- Recursive View

CREATE TABLE IF NOT EXISTS funcionarios (
	id SERIAL,
	nome VARCHAR(50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES funcionarios(id)
);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Ancelmo', null);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Beatriz', 1);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Magno', 1);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Cremilda', 2);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Wagner', 4);

SELECT * FROM funcionarios;

CREATE OR REPLACE RECURSIVE VIEW vw_func (id, gerente, funcionario) AS (
	SELECT id, gerente, nome
	FROM funcionarios
	WHERE gerente IS NULL
	
	UNION ALL
	
	SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
	FROM funcionarios
	JOIN vw_func ON vw_func.id = funcionarios.gerente
);

SElECT * FROM vw_func;
