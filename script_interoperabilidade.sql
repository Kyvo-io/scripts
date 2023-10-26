use monitro;
SELECT tituloDado, dado, dataRegistro, nomeTipo FROM registroComponente 
INNER JOIN tipoComponente on fkTipoComponente_Componente = idTipoComponente
ORDER BY dataRegistro desc;