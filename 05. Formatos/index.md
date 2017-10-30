---
title       : Diferentes formatos de datos
subtitle    : Transformaciones, importaciones y exportaciones desde R.
author      : Valentín Vergara Hidd
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax, quiz, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
logo        : escudoof.gif
biglogo     : marcaderecha.png

--- .segue bg:lightgreen
# Diferentes formatos de archivo


--- .segue bg:lightgreen
## Archivos de SPSS

---

## Formatos

R puede leer prácticamente cualquier tipo de archivo. Desde texto plano hasta algunos propietarios como SPSS, SAS, Stata, etc.

La ventaja de esto es que no necesitamos más que R y algunos paquetes instalados para poder empezar a trabajar con datos que otros han desarrollado para sus propios objetivos (datos secundarios.)

Para ello, es fundamental trabajar con el paquete **foreign**. Se instala de esta forma.


```r
install.packages("foreign", repos = 'https://dirichlet.mat.puc.cl/')
```

```
## Installing package into 'C:/Users/valentin.vergara/Documents/R/win-library/3.3'
## (as 'lib' is unspecified)
```

```
## package 'foreign' successfully unpacked and MD5 sums checked
```

```
## Warning: cannot remove prior installation of package 'foreign'
```

```
## 
## The downloaded binary packages are in
## 	C:\Users\valentin.vergara\AppData\Local\Temp\RtmpuS6HqT\downloaded_packages
```
Con este paquete, podremos leer archivos en formatos propietarios. 

--- .class #id 

## Primer ejemplo: SPSS.
El primer archivo que vamos a trabajar está hecho para SPSS. Se llama [examen.sav] y lo pueden encontrar en INFODA. Para leerlo, hay que cargar el paquete **foreign**, previamente instalado y a continuación creamos un objeto [spss1] que contenga los datos, utilizando para ello la función *read.spss*.


```r
library(foreign)
spss1<-read.spss("./examen.sav", to.data.frame = TRUE)
```

```
## Warning in read.spss("./examen.sav", to.data.frame = TRUE): ./examen.sav:
## Unrecognized record type 7, subtype 18 encountered in system file
```

---
Para conocer el contenido del objeto [spss1], podemos usar la función str.


```r
str(spss1)
```

```
## 'data.frame':	20 obs. of  3 variables:
##  $ puntaje : num  62 58 52 55 75 82 38 55 48 68 ...
##  $ horas   : num  40 31 35 26 51 48 25 37 30 44 ...
##  $ ansiedad: num  40 65 34 91 46 52 48 61 34 74 ...
##  - attr(*, "variable.labels")= Named chr  "Puntaje en el Examen" "Horas de preparación (estudio)" "Escala de Ansiedad"
##   ..- attr(*, "names")= chr  "puntaje" "horas" "ansiedad"
##  - attr(*, "codepage")= int 28591
```

---
O bien, si lo que nos interesa simplemente es el nombre de cada una de las variables del *dataframe* [spss1]:

```r
names(spss1)
```

```
## [1] "puntaje"  "horas"    "ansiedad"
```
Luego, para conocer sus dimensiones, la función es:

```r
dim(spss1)
```

```
## [1] 20  3
```
El resultado de esta función indica que hay 20 filas y 3 columnas; lo que es igual a 20 casos en 3 variables.

---
## Modificar el dataframe
Imaginemos que estamos interesados en  crear una nueva variable, que llamaremos [hombre] y cuyo valor será 1 si la persona es hombre; y 0 en cualquier otro caso. Como no poseemos la información, lo haremos de forma aleatoria. Para ello, vamos a crear un objeto [hombre], con 20 valores al azar.

```r
hombre<-sample(c(0,1),20,replace = TRUE)
```
Y luego, crearemos un objeto [spss2], donde se incluirá [hombre] a los contenidos de [spss1]

```r
spss2<-cbind(spss1,hombre)
```

---
Para asegurarnos que se creó, veamos las primeras 6 filas del objeto [spss2]:

```r
head(spss2)
```

```
##   puntaje horas ansiedad hombre
## 1      62    40       40      0
## 2      58    31       65      1
## 3      52    35       34      0
## 4      55    26       91      0
## 5      75    51       46      1
## 6      82    48       52      0
```

Luego, nos aseguramos que el objeto [spss2] sea aún un objeto de tipo *dataframe*

```r
is.data.frame(spss2)
```

```
## [1] TRUE
```

--- 
## Exportar los datos

En la mayoría de los casos, no debería ser necesario exportar los datos a otro formato, dado que todo lo que se ha hecho en una sesión de R queda guardado en el script (el archivo con extensión .R). Sin embargo, en los casos que se quiera exportar, el paquete **foreign** tiene la función write.foreign.


```r
write.foreign(spss2, "./datos.txt", "./datos.sps", package = "SPSS")
```
Los archivos resultantes se deberían poder leer desde SPSS.

--- .segue bg:lightgreen
## Planillas de Cálculo creadas con MS Excel

---
## Instalación de paquetes.

Existen varios paquetes que permiten leer planillas de cáculo creadas con MS Excel, con la desventaja de necesitar dependencias externas para funcionar (Java, Pearl, OCDB, etc). Por tanto, trabajaremos con el paquete que no requiere dependencias externas.

```r
install.packages("readxl")
```

```
## Installing package into 'C:/Users/valentin.vergara/Documents/R/win-library/3.3'
## (as 'lib' is unspecified)
```

```
## Error in contrib.url(repos, "source"): trying to use CRAN without setting a mirror
```

```r
library(readxl)
```

```
## Warning: package 'readxl' was built under R version 3.3.3
```

---
## Lectura de los datos.
Vamos a trabajar con la planilla **survey.xls**, disponible en INFODA. Para ello, crearemos un objeto [excel1] que contenga la planilla.

```r
excel1<-read_excel("./survey.xlsx")
```

Para ver los nombres de las variables, utilizamos la función names.

```r
names(excel1)
```

```
## [1] "id"           "satisfaccion" "edad"         "escolaridad" 
## [5] "sexo"         "transporte"   "casado"       "mot_trab"
```

---
## Más información sobre los datos.
Copmo alternativa, si se quiere obtener más información del dataframe:

```r
str(excel1)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	79 obs. of  8 variables:
##  $ id          : chr  "001" "002" "003" "004" ...
##  $ satisfaccion: num  84.7 82.8 68.2 70 81.4 87.7 68.7 89.2 88.7 85.6 ...
##  $ edad        : num  29 21 21 23 29 47 45 21 46 28 ...
##  $ escolaridad : num  12 12 12 11 12 12 10 12 14 14 ...
##  $ sexo        : chr  "M" "M" "F" "F" ...
##  $ transporte  : chr  "BUS" "CAR" "CAR" "CAR" ...
##  $ casado      : num  1 1 0 0 1 1 0 1 1 0 ...
##  $ mot_trab    : num  1 1 1 2 1 3 3 1 2 1 ...
```

---
## Incluir información en el dataframe
Imaginemos que los 79 estudiantes pertenecen a colegios municipales, subvencionados o particulares. Vamos a crear un objeto [dependencia] con 79 valores al azar.


```r
dependencia<-sample(c("Municipal", "Subvencionado", "Particular"), 79, replace = TRUE)
```

y luego incluímos este objeto en el dataframe [excel1], para crear un nuevo objeto [excel2]

```r
excel2<-cbind(excel1,dependencia)
```

---
Revisamos las dimensiones del nuevo dataframe:

```r
dim(excel2)
```

```
## [1] 79  9
```
Si interesa conocer en mayor detalle el dataframe, se pueden observar las seis primeras observaciones.

```r
head(excel2)
```

```
##    id satisfaccion edad escolaridad sexo transporte casado mot_trab
## 1 001         84.7   29          12    M        BUS      1        1
## 2 002         82.8   21          12    M        CAR      1        1
## 3 003         68.2   21          12    F        CAR      0        1
## 4 004         70.0   23          11    F        CAR      0        2
## 5 005         81.4   29          12    F        CAR      1        1
## 6 006         87.7   47          12    F        CAR      1        3
##     dependencia
## 1    Particular
## 2     Municipal
## 3     Municipal
## 4 Subvencionado
## 5     Municipal
## 6 Subvencionado
```

---
## Exportar datos
Para exportar el dataframe recién creado, hay que cargar un paquete adicional.

```r
install.packages("xlsx")
```

```
## Installing package into 'C:/Users/valentin.vergara/Documents/R/win-library/3.3'
## (as 'lib' is unspecified)
```

```
## Error in contrib.url(repos, "source"): trying to use CRAN without setting a mirror
```

```r
library(xlsx)
```

```
## Loading required package: rJava
```

```
## Loading required package: xlsxjars
```

---
Una vez cargado el paquete, se exportan los datos.

```r
write.xlsx(excel2, "./excel2.xlsx", sheetName = "Hoja1")
```

--- .segue bg:lightgreen
# ¿Preguntas?










