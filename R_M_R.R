setwd("C:/Users/pauve/Documents/UBIQUM/SCANS/PRACTICA6-NILUPAU/RSTUDIO")
setwd("C:/Users/Lenovo/Desktop/Ubiqum_data/task_6/github_3")
library(readr)
NiluPau <- read_delim("NiluPau.csv", 
                                ";", escape_double = FALSE, trim_ws = TRUE)
View(NiluPau)

####MISSING VALUES####

str()