install.packages("this.path")
library(this.path)
setwd(this.dir())
source("predecir_paciente.R")
resultado <- predecir_paciente(
  "paciente_001.csv",
  datos_transformados = TRUE
)
