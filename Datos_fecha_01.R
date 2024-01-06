library(tidyverse)
library(data.table)


#ejemplo
path_1 <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/transporte-y-obras-publicas/sube/dataset_viajes_sube.csv"

data_csv <- read.csv(path_1)
summary(data_csv)

# Extraer el día, mes, año y hora
data_csv$Dia <- as.numeric(substr(data_csv$DIA, 1, 2)) #dato de dia en los dos primeros caracteres
data_csv$Mes <- substr(data_csv$DIA, 3, 5) #dato de mes entre los caracteres 3 a 5
data_csv$Mes <- factor(data_csv$Mes,
                       levels = c("JAN", "FEB","MAR", "APR",
                                  "MAY", "JUN","JUL", "AUG",
                                  "SEP", "OCT", "NOV", "DEC")) #defino los meses como factor
meses_ordenados <- c("JAN", "FEB", "MAR", "APR",
                     "MAY", "JUN", "JUL", "AUG",
                     "SEP", "OCT", "NOV", "DEC") #Defino el orden
data_csv$NumeroMes <- match(data_csv$Mes, meses_ordenados) # Genero el mach con el orden que defini previamente
data_csv$Anio <- as.numeric(substr(data_csv$DIA, 6, 9)) #dato de año entre los caracteres 6 a 9
data_csv$Hora <- substr(data_csv$DIA, 12, 19) #dato de dia entre los caracteres 12 a 19
data_csv$Hora <- as.ITime(data_csv$Hora, format = "%H:%M:%S") #convierto a formato de hs usando paquete data.table
data_csv$FechaCompleta <- as.Date(paste(data_csv$Anio,
                                        data_csv$NumeroMes,
                                        data_csv$Dia,
                                        sep = "-")) 
# Verificacion
summary(data_csv)

