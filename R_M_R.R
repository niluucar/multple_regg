setwd("C:/Users/pauve/Documents/UBIQUM/SCANS/PRACTICA6-NILUPAU/RSTUDIO")
setwd("C:/Users/Lenovo/Desktop/Ubiqum_data/task_6/github_3")
library(readr)
ExistingProdNiluPau <- read_delim("NiluPau.csv", ";", 
                      escape_double = FALSE, locale = locale(decimal_mark = ","), 
                      trim_ws = TRUE)
View(ExistingProdNiluPau)

####MISSING VALUES####

attributes(ExistingProdNiluPau)

str(ExistingProdNiluPau)

####Added zeros as N/A ####
ExistingProdNiluPau[is.na(ExistingProdNiluPau)] <- "0"
sum(is.na(ExistingProdNiluPau)) #total count of na's in the data set 


