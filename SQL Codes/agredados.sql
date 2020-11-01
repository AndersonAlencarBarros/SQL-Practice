SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome, email FROM cliente;
SELECT banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;

-- visualização das views, informações das tabelas
SELECT * FROM information_schema.columns WHERE table_name = 'banco';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'banco';

-- funções agregadas

-- AVG: calcula a media dos valores
SELECT valor FROM cliente_transacoes;
SELECT AVG(valor) FROM cliente_transacoes;
-- COUNT: contagem de dados
SELECT COUNT(numero), email FROM cliente WHERE email ILIKE '%gmail.com' GROUP BY email;
SELECT COUNT(email) FROM cliente WHERE email ILIKE '%gmail.com';
SELECT COUNT(id), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id;
SELECT COUNT(id), tipo_transacao_id FROM cliente_transacoes 
GROUP BY tipo_transacao_id HAVING COUNT(id) > 150;
-- MAX: retorna o maior numero
SELECT MAX(numero) FROM cliente;
SELECT MAX(valor), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id;
-- MIN: retorna o menor numero
SELECT MIN(valor) FROM cliente_transacoes;
-- SUM: soma de todos os elementos
SELECT SUM(valor) FROM cliente_transacoes;

SELECT SUM(valor), tipo_transacao_id FROM cliente_transacoes 
GROUP BY tipo_transacao_id ORDER BY tipo_transacao_id DESC; 

SELECT SUM(valor), tipo_transacao_id FROM cliente_transacoes 
GROUP BY tipo_transacao_id ORDER BY tipo_transacao_id ASC;