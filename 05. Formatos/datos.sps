SET DECIMAL=DOT.

DATA LIST FILE= "./datos.txt"  free (",")
ENCODING="Locale"
/ puntaje horas ansiedad hombre 
  .

VARIABLE LABELS
puntaje "puntaje" 
 horas "horas" 
 ansiedad "ansiedad" 
 hombre "hombre" 
 .
VARIABLE LEVEL puntaje, horas, ansiedad, hombre 
 (scale).

EXECUTE.
