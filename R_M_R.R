setwd("C:/Users/Lenovo/Desktop/Ubiqum_data/task_6/github_3")

library(readr)
newproductNiluPau <- read_delim("newproductNiluPau.csv", 
                                ";", escape_double = FALSE, trim_ws = TRUE)
View(newproductNiluPau)

####MISSING VALUES####