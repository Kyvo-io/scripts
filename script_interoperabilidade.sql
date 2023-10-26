use monitro;

-- Registro
SELECT idRegistroComponente,tituloDado, dado, dataRegistro, nomeTipo, metrica FROM registroComponente 
INNER JOIN tipoComponente on fkTipoComponente_Componente = idTipoComponente
INNER JOIN metrica on fkMetrica = idMetrica
ORDER BY dataRegistro desc;

-- Descrição
SELECT * from descricaoComponente
INNER JOIN tipoComponente on fkTipoComponente_Componente = idTipoComponente;