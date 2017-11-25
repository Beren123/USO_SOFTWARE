---
title       : Modelo de Regresión
subtitle    : Regresión Lineal
author      : Valentín Vergara Hidd
job         : Uso de Software en Investigación Social
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax, quiz, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
logo        : escudoof.gif
biglogo     : marcaderecha.png

---. segue bg:royalblue
# Datos para esta clase

---
## Datos desde R.
Vamos a cargar un *dataframe* que viene precargado en R. 


```r
data(mtcars)
```
Para saber qué contiene el *datafreme*, usamos la ayuda de R; y luego utilizamos la función str.

```r
help(mtcars)
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

---
## Datos simulados
También trabajaremos con datos simulados, tal como las clases anteriores. Para ello, crearemos el siguiente *dataframe*, con datos de 1000 pacientes en tratamiento y cuya variable dependiene es una escala de dolor:

```r
regresion<-data.frame(id = 1:1000,
              dolor = rnorm(1000, mean = 65, sd = 15),
              edad = sample(40:80, 1000, replace = T),
              diagnostico = sample(c("Ébola", "Cáncer", "Lepra", "Bulimia"),
                                   1000, replace = T),
              drogas = sample(c("Sí", "No", 1000, replace = T)),
              hr_trabajo = rpois(1000, 40))
```

---
Para verificar los datos, usamos la función head.

```r
head(regresion)
```

```
##   id    dolor edad diagnostico drogas hr_trabajo
## 1  1 59.53870   55     Bulimia   TRUE         37
## 2  2 51.15708   64       Lepra   1000         55
## 3  3 47.17656   73       Lepra    Sí         37
## 4  4 77.88181   40      �<U+0089>bola     No         36
## 5  5 59.19429   61      �<U+0089>bola   TRUE         44
## 6  6 44.09850   51     Bulimia   1000         37
```

--- .segue bg:royalblue
## Un paso previo: correlación.

---
## Dos variables numéricas.
Cuando tenemos dos variables numéricas, $X$ y $Y$, establecemos su correlación como:

<<INSERT FORMULA HERE>>

Noten que si invertimos el orden de $Y$ y $X$, no obtendremos diferencias. Esto implica que esta prueba no distingue entre variables *dependientes* e *independientes*

---
## Correlación en R.
Por ejemplo, si utilizamos el *dataframe* [mtcars] y buscamos la correlación entre millas por galón y peso del auto:

```r
cor.test(mtcars$mpg, mtcars$wt)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mtcars$mpg and mtcars$wt
## t = -9.559, df = 30, p-value = 1.294e-10
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.9338264 -0.7440872
## sample estimates:
##        cor 
## -0.8676594
```

---
## Graficando en una nube de puntos.

```r
plot(mtcars$mpg, mtcars$wt)
```

![plot of chunk unnamed-chunk-6](assets/fig/unnamed-chunk-6-1.png)
