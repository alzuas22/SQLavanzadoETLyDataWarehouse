Ejercicio 5. CREAR FUNCIÓN DE LIMPIEZA DE ENTERO 

 

CREATE OR REPLACE FUNCTION keepcoding.clean_integer(input INT64) 

RETURNS INT64 

AS ( 

  CASE 

    WHEN input IS NULL THEN -999999 

    ELSE input 

  END 

); 