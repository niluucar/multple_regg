setwd("C:/Users/pauve/Documents/UBIQUM/SCANS/PRACTICA6-NILUPAU/RSTUDIO")

library(readr)
newproductNiluPau <- read_delim("NiluPau.csv", 
                                ";", escape_double = FALSE, trim_ws = TRUE)
View(newproductNiluPau)

####MISSING VALUES####