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

summary(ExistingProdNiluPau)
####Added zeros as N/A ####
ExistingProdNiluPau[is.na(ExistingProdNiluPau)] <- "0"
sum(is.na(ExistingProdNiluPau)) #total count of na's in the data set 
sum(is.na(ExistingProdNiluPau$Best_seller_rank))

####Removing Outliers####

ggplot(data=ExistingProdNiluPau, aes(x=ExistingProdNiluPau$Volume)) + 
  geom_histogram(bindwith=0.5, col="black",fill="lightgreen", alpha = .7) #+xlim(c(0, 1500))
#Acording to this graph, we can see outliers obviously. 
#We should remove them for getting best result before running the model.

ExistingProdNiluPau = ExistingProdNiluPau[ExistingProdNiluPau$Volume <=6000,]

####Product_num attributes
#We should not use this variable into the model. This attributes are only Id numbers of products.
#So,they will not make sense to use in the model.We should replace all romws of it null.

ExistingProdNiluPau$Product_ID<-NULL


####Graphs ####

ggplot(data = ExistingProdNiluPau,mapping = aes(x = Best_seller_rank,fill=Volume))+geom_histogram()+
  geom_text(stat="count",aes(label=..count..,y=..count..), vjust=10)


