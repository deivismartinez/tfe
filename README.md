# Máster Universitario en Bioinformática - TFE
## Desarrollo de un modelo para predicción de supervivencia global en cáncer de mama basado en expresión génica y asistencia explicativa mediante un modelo de lenguaje grande (LLM)
Este trabajo es una propuesta computacional para la predicción de supervivencia global de personas con cáncer de mama, a partir de datos de expresión génica. Se obtiene una metodología reproducible que permite estudiar el valor de la información molecular y clínica para la predicción pronóstica, complementado con el uso de LLM como herramienta explicativa.

El procedimiento metodológico se estructuró en varias etapas: obtención e integración de los datos, preparación de la matriz de expresión génica, construcción de las variables de supervivencia, división de los datos en conjuntos de entrenamiento y prueba, entrenamiento y evaluación de los modelos, implementación del módulo de predicción y desarrollo del componente de asistencia explicativa y técnicamente se presenta en 6 fases.

# <p align="center"><img width="450" height="165" alt="work_flow" src="images/fases.png" /></p>
## Con este repositorio podemos:
### 1. Usar el mólulo creado con el modelo seleccionado y entrenado.  [Aquí](/src/r/module/model.md) encontraremos la descripción de lo que necesitamos hacer
### 2. [Crear el módulo iniciando con el modelo seleccionado.  Aquí](/src/r/create/create.md) encontramos la forma como fue creado
### 3. [Entrenar los modelos con los datos seleccionados.  Aquí](/src/r/train/train.md) está el paso a paso para hacerlo
### 4. [Descargar, depurar y preparar los datos.  Aquí](/src/r/data/data.md) tenemos la forma cómo se hizo
### 5. [Replicar toda la parte experimental del TFE.  Aquí](/src/r/total/total.md) encontramos el detalle de lo que se hizo


Se construyó la siguiente arquitectura para la solución:
<p align="center"><img width="350" height="535" alt="work_flow" src="images/Architecture.png" /></p>

## Flujo de Trabajo en R para el análisis de los datos y la programación de los modelos de Machine Learning están en la carpeta 
El flujo de trabajo integra **Python** y **R** para el análisis y desarrollo del módulo lo encontramos en la sección de [src](/src/).

<br><br>

## Trabajo de Fin de Estudios

### Bioinformáfica:
|Presentado por:  |
|--|
| Ing. Deivis Martínez A.|
<div style="text-align: center;">
<p align="center"><img width="300" height="200" alt="Logo UNIR" src="https://upload.wikimedia.org/wikipedia/commons/d/df/Logo_UNIR.png" /></p>
</div>
1. Consultamos la base de datos [The Cancer Genome Atlas (TCGA)](https://portal.gdc.cancer.gov/projects/TCGA-BRCA) donde se encuentra la información o los datos usados en el proyecto.
2. Otra fuente [TCGA BRCA cancer dataset](https://zenodo.org/records/4309168)