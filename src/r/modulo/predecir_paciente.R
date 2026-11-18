# Verificar que glmnet esté instalado y cargar su espacio de nombres
if (!requireNamespace("glmnet", quietly = TRUE)) {
  stop("El paquete glmnet no está instalado. Ejecuta install.packages('glmnet').")
}

# Verificar que exista el modelo desarrollado en este TFE
if (!file.exists("modulo_pronostico.rds")) {
  stop("No se encuentra el archivo modulo_pronostico.rds.")
}

predecir_paciente <- function(archivo, datos_transformados = FALSE) {
  
  # 1. Cargar el modelo desarrollado en esta investigación
  modulo <- readRDS("modulo_pronostico.rds")
  
  modelo <- modulo$modelo
  genes <- modulo$genes
  tiempos <- modulo$tiempos_evento
  riesgo_basal <- modulo$riesgo_basal
  horizontes <- modulo$horizontes
  
  # 2. Leer el archivo de expresión del paciente
  datos <- read.csv(archivo, stringsAsFactors = FALSE, check.names = FALSE)
  
  # 3. Validamos la estructura del archivo para garantizar 
  # que funcione el modelo con estos datos de entrada
  if (!all(c("Gene", "Expression") %in% names(datos))) {
    stop("El archivo debe contener las columnas Gene y Expression.")
  }
  
  if (anyNA(datos$Gene) || any(trimws(datos$Gene) == "")) {
    stop("Hay identificadores de genes vacíos o faltantes.")
  }
  
  if (anyDuplicated(datos$Gene)) {
    stop("El archivo contiene genes duplicados.")
  }
  
  if (!is.numeric(datos$Expression) ||  any(!is.finite(datos$Expression)) ||
      any(datos$Expression < 0)) {
    stop("Expression debe contener valores numéricos finitos y no negativos.")
  }
  
  # 4. Comprobamos que estén todos los genes requeridos
  faltantes <- setdiff(genes, datos$Gene)
  
  if (length(faltantes) > 0) {
    stop(paste("Faltan", length(faltantes),"genes requeridos por el modelo."))
  }
  
  # 5. Ordenar los genes según los requiere el modelo
  datos <- datos[match(genes, datos$Gene), ]
    expresion <- as.numeric(datos$Expression)
  
  # 6. Aplicamos transformación si los datos son originales
  if (!datos_transformados) {
    expresion <- log2(expresion + 1)
  }
  
  # 7. Construimos la matriz de entrada
  nueva_matriz <- matrix(expresion, nrow = 1, dimnames = list(NULL, genes))
  
  # 8. Calcular el puntaje de riesgo
  puntaje <- as.numeric(stats::predict(modelo, newx = nueva_matriz, s = "lambda.min", type = "link"))
  
  # 9. Calcular supervivencia estimada
  supervivencia <- sapply(horizontes, function(anios) {
    
    tiempo_dias <- anios * 365.25
    posicion <- findInterval(tiempo_dias, tiempos)
    
    if (posicion == 0) {
      H0 <- 0
    } else {
      H0 <- riesgo_basal[posicion]
    }
    
    exp(-H0 * exp(puntaje))
  })
  
  # 10. Organizar resultados
  tabla <- data.frame(Anios = horizontes, Supervivencia = as.numeric(supervivencia),Porcentaje = round(as.numeric(supervivencia) * 100, 2))
  
  resultado <- list(paciente = basename(archivo), puntaje_riesgo = puntaje, supervivencia = tabla)
  
  # 11. Guardar resultados en CSV
  nombre_salida <- paste0(tools::file_path_sans_ext(basename(archivo)), "_pronostico.csv")
  
  write.csv(data.frame(Puntaje_riesgo = puntaje, tabla), nombre_salida, row.names = FALSE)
  
  # 12. Mostramos los resultados
  cat("\n====================================\n")
  cat("       RESULTADO PRONOSTICO\n")
  cat("====================================\n")
  cat("Paciente:", basename(archivo), "\n")
  cat("Puntaje de riesgo:", round(puntaje, 6), "\n\n")
  
  print(tabla)
  
  cat("\nArchivo generado:", nombre_salida, "\n")
  
  return(resultado)
}