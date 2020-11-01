-- Funções

CREATE OR REPLACE FUNCTION somar (INTEGER, INTEGER)
RETURNS INTEGER
SECURITY DEFINER
-- RETURNS NULL ON NULL INPUT
CALLED ON NULL INPUT
LANGUAGE SQL
AS $$
	SELECT COALESCE($1, 0) + COALESCE($2, 0); -- COALESCE retorna o primeiro valor não nulo
$$;

SELECT somar(1,null);

CREATE OR REPLACE FUNCTION bancos_add(p_numero INTEGER, p_nome VARCHAR, p_ativo BOOLEAN)
RETURNS INTEGER
SECURITY INVOKER
LANGUAGE PLPGSQL
CALLED ON NULL INPUT
AS $$
DECLARE variavel_id INTEGER;
BEGIN -- inicio de uma transação
	IF p_numero IS NULL OR p_nome IS NULL OR p_ativo IS NULL THEN	-- tratamento de erros
		RETURN 0;
	END IF;
	
	SELECT INTO variavel_id numero
	FROM banco
	WHERE numero = p_numero;
	
	IF variavel_id IS NULL THEN
		INSERT INTO banco (numero, nome, ativo)
		VALUES (p_numero, p_nome, p_ativo);
	ELSE
		RETURN variavel_id;
	END IF; 
	
	SELECT INTO variavel_id numero
	FROM banco
	WHERE numero = p_numero;
	
	RETURN variavel_id;
END; -- END é equivalente ao COMMIT de uma transação
$$

SELECT bancos_add(1, 'Banco Novo', FALSE);
SELECT bancos_add(54343334, 'Banco Diferente do Novo', FALSE);
SELECT bancos_add(5434, 'Banco Novo', null);

SELECT numero, nome, ativo FROM banco 
WHERE numero = 54343334;