
# Modelo de pronóstico de supervivencia en cáncer de mama

## 1. Descripción

Este paquete contiene un modelo de pronóstico basado en expresión génica para estimar la supervivencia global de pacientes con cáncer de mama (TCGA-BRCA).

El modelo fue desarrollado mediante regresión de Cox con Elastic Net en el marco del TFE.

El sistema calcula:
- Un puntaje de riesgo relativo.
- Supervivencia estimada a 1 año.
- Supervivencia estimada a 3 años.
- Supervivencia estimada a 5 años.
- Supervivencia estimada a 10 años.

Estas estimaciones son resultados de un modelo experimental de investigación y no constituyen recomendaciones ni decisiones clínicas.

## 2. Archivos incluidos

| Archivo | Descripción |
|---|---|
| `modulo_pronostico.rds` | Modelo entrenado, genes y riesgo basal |
| `predecir_paciente.R` | Función para realizar predicciones [(Ver)](/predecir_paciente.R) |
| `paciente_001.csv` | Archivo de expresión de ejemplo [(Ver)](/paciente_001.csv)|

## 3. Requisitos

Se requiere R instalado.

El modelo utiliza el paquete `glmnet`.

Si no está instalado, ejecutar:

```r
install.packages("glmnet")
```

## 4. Preparación

Colocar los archivos del paquete en una misma carpeta y establecerla como directorio de trabajo:

```r
setwd("ruta/Paquete_TFM")
```

Cargar la función:

```r
source("predecir_paciente.R")
```

## 5. Ejecutar una predicción

Para utilizar el archivo de ejemplo:

```r
resultado <- predecir_paciente("paciente_001.csv", datos_transformados = TRUE)
```

El archivo de ejemplo contiene datos que ya fueron transformados mediante la función `log2(x + 1)`.

Para datos originales compatibles con la escala de expresión utilizada durante el entrenamiento:

```r
resultado <- predecir_paciente("nuevo_paciente.csv", datos_transformados = FALSE)
```

En este segundo caso, la función aplica automáticamente la transformación `log2(x + 1)`.

## 6. Formato de entrada

El archivo CSV debe contener dos columnas:

| Gene | Expression |
|---|---:|
| TSPAN6 | Valor de expresión |
| TNMD | Valor de expresión |
| DPM1 | Valor de expresión |

Se deben proporcionar todos los genes requeridos por el modelo, con identificadores coincidentes y valores numéricos no negativos.

La expresión debe corresponder al mismo tipo de medición, escala y procesamiento utilizados durante el entrenamiento.

## 7. Interpretación

El puntaje de riesgo es un predictor lineal relativo del modelo de Cox. Un valor mayor representa un mayor riesgo relativo estimado dentro del contexto del modelo.

Los porcentajes representan estimaciones de supervivencia global para los horizontes temporales indicados.

Las estimaciones a largo plazo deben interpretarse con precaución debido al seguimiento disponible y a la censura de los datos.

## 8. Información del entrenamiento

- Cohorte: TCGA-BRCA.
- Pacientes incluidos: 1062.
- Conjunto de entrenamiento: 849 pacientes.
- Conjunto de prueba: 213 pacientes.
- Variables iniciales: 12761 genes.
- Modelo: Cox Elastic Net.
- Parámetro alpha: 0.5.
- Selección de lambda: lambda.min.
- C-index en prueba: 0.7139.

## 9. Consideraciones

Este modelo tiene fines académicos y de investigación. No ha sido validado para uso clínico.

El archivo de ejemplo permite comprobar el funcionamiento técnico del paquete, pero no representa una validación clínica independiente.

Para reproducir el entrenamiento se requiere el código correspondiente y acceso a los datos originales.  Se puede hacer desde el apartado 5. [Replicar toda la parte experimental del TFE.  Aquí](/src/r/total/total.md) encontramo el detalle de lo que se hizo
