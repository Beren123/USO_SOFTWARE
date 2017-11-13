---
title       : Diferencias de Medias
subtitle    : Dos medias y $k$ medias, con supuestos.
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

--- 
## Comparar grupos.
En estas sesiones vamos a trabajar en comparaciones de medias. En términos generales, trabajaremos con variables dependientes $Y$:
$$ Y \in \mathbb{R} \; | \; \infty^{-} < Y < \infty^{+}$$
y con variables independientes $X$:
$$ X \in \mathbb{Z} \; | \; \infty^{-} < Y < \infty^{+}.$$

Asumimos además que $\mu$ corresponde a la media artimética poblacional y $\sigma^{2}$ a la varianza de la población.


--- .segue bg:royalblue
# Datos para esta clase.

---
## Datos simulados: fumadores
Vamos a simular datos sobre la edad de muerte de un grupo de 35 personas, jun to con optras características relevantes.

```r
fumadores<-data.frame(id = 1:36,
                edad_muerte = c(sample(70:90,18,replace = TRUE), sample(60:80, 18, 
                replace = TRUE)),
                fuma = c(rep("No", 18), rep("Sí",18)),
                sexo = sample(c("Hombre", "Mujer"), 36, replace = TRUE))
head(fumadores, 5)
```

```
##   id edad_muerte fuma   sexo
## 1  1          85   No  Mujer
## 2  2          85   No Hombre
## 3  3          87   No Hombre
## 4  4          76   No  Mujer
## 5  5          82   No  Mujer
```

---
## Datos simulados: bebedores
Simularemos ahora los datos sobre la cantidad de tragos por semana que bebían 2581 personas antes y después de un experimento en el que se les sometía a un programa de erducación sobrer los efectos del alcohol. Se midió también su editorial preferida de comics.

```r
bebedores<-data.frame(id = 1:2581,
                editorial = sample(c("Marvel", "DC"), 2581, replace = TRUE),
                grupo = c(rep("Tratamiento", 1200), rep("Control", 1381)),
                tragos_pre = rpois(2581,10),
                tragos_post = c(rpois(1200, 7), rpois(1381,10)))
head(bebedores,5)
```

```
##   id editorial       grupo tragos_pre tragos_post
## 1  1        DC Tratamiento         16           9
## 2  2    Marvel Tratamiento         15          10
## 3  3    Marvel Tratamiento          4           6
## 4  4    Marvel Tratamiento         12           7
## 5  5        DC Tratamiento          8           6
```

---
## Datos reales: Simce 2016
Leeremos el archivop [simce4_2016.xlsx], que pueden descargar de INFODA. Son los datos reales, para cada establecimiento, de sus puntajes para 4º Básico en Lectura y Matemática, además de otras variables.

```r
library(readxl)
simce<-read_excel("./simce4_2016.xlsx")

simce$dependencia<-factor(simce$dependencia, levels = c(1,2,3),
                    labels = c("Municipal", "Particular Subvencionado", "Particular"))

simce$gse<-factor(simce$gse, levels = c(1,2,3,4,5),
                  labels = c("Bajo", "Medio Bajo", "Medio", "Medio Alto", "Alto"))

simce$rural<-factor(simce$rural, levels = c(1,2),
                    labels = c("Urbano", "Rural"))
```

---
Posteriormente, comprobamos las variables recodificadas:

```r
head(simce)
```

```
## # A tibble: 6 x 10
##     rbd region comuna dependencia        gse  rural nalu_lect nalu_mat
##   <dbl>  <dbl>  <chr>      <fctr>     <fctr> <fctr>     <dbl>    <dbl>
## 1     5     15  ARICA   Municipal      Medio Urbano        26       28
## 2     8     15  ARICA   Municipal Medio Bajo Urbano         2        2
## 3     9     15  ARICA   Municipal      Medio Urbano        26       28
## 4    10     15  ARICA   Municipal Medio Bajo Urbano         2        2
## 5    11     15  ARICA   Municipal Medio Bajo Urbano         2        2
## 6    12     15  ARICA   Municipal Medio Bajo Urbano        26       28
## # ... with 2 more variables: lect <dbl>, mat <dbl>
```

--- .segue bg:royalblue
# Diferencias de dos medias

--- .segue bg:royalblue
## Muestras independientes.

---
## Supuestos.

### Variable dependiente normalmente distribuida
Asumimos que la variable dependiente tiene una distribución **similar** a la normal en ambos niveles de la variable independiente. A pesar de esto, la prueba T es robusta para desviaciones de la distribución normal, únicamente si se garantiza que:
$$ \frac{n_{mayor}}{n_{menor}} \leq 1,5$$

### Homocedasticidad.
Las varianzas de ambos grupos son iguales. En caso de no cumplirse este supuesto, se pueden hacer algunas correcciones que vienen  incluidas en la función del test.

---
## Error Estándar.
Recordemos que para la variable aleatoria $X$, la **varianza de su distribución de muestreo** equivale a:
$$ \hat{\sigma}^{2}_{\overline{X}} = \frac{\sigma^{2}}{n}$$
De esta forma, la diferencia entre dos grupos tiene el siguiente **error estándar**
$$ \hat{\sigma}_{\overline{X}_{2}- \overline{X}_{1}} =  \sqrt{\hat{\sigma}^{2}_{\overline{X}}} = \sqrt{\frac{\sigma^{2}_{1}}{n_{1}} + \frac{\sigma^{2}_{2}}{n_{2}}}$$
Estas medidas son relevantes para construir los **intervalos de confianza**.

---
## Ejemplo: fumadores
### Verificando supuestos.
Para conocer si una variable distribuye normal, utilizaremos el test *shapiro-wilk*

```r
shapiro.test(fumadores$edad_muerte)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  fumadores$edad_muerte
## W = 0.94279, p-value = 0.06209
```
La variable aparentemente es normal, pero debemos asegurarnos que lo sea para cada **nivel** de la variable [fuma]

---


```r
tapply(fumadores$edad_muerte, fumadores$fuma, shapiro.test)
```

```
## $No
## 
## 	Shapiro-Wilk normality test
## 
## data:  X[[i]]
## W = 0.91635, p-value = 0.1114
## 
## 
## $Sí
## 
## 	Shapiro-Wilk normality test
## 
## data:  X[[i]]
## W = 0.89792, p-value = 0.05287
```

---
Si no obtenemos normalidad, podemos verificar el *ratio* entre el $n$ de ambos grupos:

```r
length(fumadores$fuma[fumadores$fuma=="Sí"])/length(fumadores$fuma[fumadores$fuma=="No"])
```

```
## [1] 1
```

### Homocedasticidad.
Para verificar este supuesto, utilizamos la prueba de Bartlett, cuya hipótesis nula es:
$$ H_{0}: \; \sigma^{2}_{fuma} - \sigma^{2}_{no\;  fuma} = 0 $$

```r
bartlett.test(fumadores$edad_muerte~fumadores$fuma)
```

```
## 
## 	Bartlett test of homogeneity of variances
## 
## data:  fumadores$edad_muerte by fumadores$fuma
## Bartlett's K-squared = 1.7797, df = 1, p-value = 0.1822
```

---
## T-test
La hipótesis nula es:
$$ H_{0}: \; \overline{Y}_{fuma} - \overline{Y}_{no\;  fuma} = 0 $$
Veamos primero los promedios de edad de muerte para ambos grupos:

```r
tapply(fumadores$edad_muerte, fumadores$fuma, mean)
```

```
##       No       Sí 
## 79.44444 68.61111
```
Al parecer, la diferencia no es cero.

---
Probemos que esta diferencia efectivamente es distinta de cero.

```r
t.test(edad_muerte~fuma, data = fumadores, var.equal=TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  edad_muerte by fuma
## t = 5.2667, df = 34, p-value = 7.741e-06
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##   6.653071 15.013596
## sample estimates:
## mean in group No mean in group Sí 
##         79.44444         68.61111
```

---
## Alternativa no-paramétrica.
Si no logramos cumplir el primer supuesto, ya sea porque la variable no distribuye normal, o porquer la razón entre el tamaño de ambos grupos es mayor a 1,5; se puede utilizar una prueba no-paramétrica.

La prueba de Mann Whitney compara **medianas** con la siguiente hipótesis nula:
$$ H_{0}: \; Y_{fuma} - Y_{no\;  fuma} = 0 $$

---
La función en R:


```r
wilcox.test(edad_muerte~fuma, data=fumadores)
```

```
## Warning in wilcox.test.default(x = c(85L, 85L, 87L, 76L, 82L, 86L, 78L, :
## cannot compute exact p-value with ties
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  edad_muerte by fuma
## W = 281, p-value = 0.0001734
## alternative hypothesis: true location shift is not equal to 0
```
