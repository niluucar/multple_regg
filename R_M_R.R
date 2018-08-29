#### PACKAGES ####
install.packages("caret", dependencies = c("Depends", "Suggests"))
library(ggplot2)
library(dplyr)
library(caret)

setwd("C:/Users/pauve/Documents/UBIQUM/SCANS/PRACTICA6-NILUPAU/RSTUDIO")
setwd("C:/Users/Lenovo/Desktop/Ubiqum_data/task_6/github_3")
library(readr)
library(dplyr)
ExistingProdNiluPau <- read_delim("NiluPau.csv", ";", 
                                  escape_double = FALSE, locale = locale(decimal_mark = ","), 
                                  trim_ws = TRUE)
View(ExistingProdNiluPau)
str(ExistingProdNiluPau)


##remove repited warranties##
warranty<- ExistingProdNiluPau[ExistingProdNiluPau$Product_type == "Extended Warranty",]
View(warranty)
warrantyrepeated <- warranty[3:10,]
mean(warranty$Prices)
meanwarrantygender
mean.default(warrantyrepeated$Gender)
meanwarrantyage
mean.default(warrantyrepeated$Age)
meanwarrantyinstore
mean.default(warrantyrepeated$In_store)

ExistingProdNiluPau$Prices[ExistingProdNiluPau$X1 >=34 & ExistingProdNiluPau$X1 <=41] <- meanwarranty
ExistingProdNiluPau$Gender[ExistingProdNiluPau$X1 >=34 & ExistingProdNiluPau$X1 <=41] <- meanwarrantygender
ExistingProdNiluPau$Age[ExistingProdNiluPau$X1 >=34 & ExistingProdNiluPau$X1 <=41] <- meanwarrantyage
ExistingProdNiluPau$In_store[ExistingProdNiluPau$X1 >=34 & ExistingProdNiluPau$X1 <=41] <- meanwarrantyinstore
ExistingProdNiluPau$Product_ID<-NULL
ExistingProdNiluPau$X1<-NULL

ExistingProdNiluPau$Best_seller_rank<-NULL

ExistingProdNiluPau <- distinct(ExistingProdNiluPau,.keep_all = FALSE)

####MISSING VALUES####

str(ExistingProdNiluPau)

summary(ExistingProdNiluPau)

####Changing n/a's in the WIDTH column median of the column####

#According to the histogram of the width value. The distribution of this value does not have a normal distribution.
#For this reason,We can mean value for changing the n/a values.
#We will create a new column for this change. Then we will remove existing width column.

ExistingProdNiluPau$Width_mean <- ifelse(is.na(ExistingProdNiluPau$Width), 
                                         mean(ExistingProdNiluPau$Width, na.rm=TRUE),
                                         ExistingProdNiluPau$Width)

ExistingProdNiluPau$Width_mean <- round(ExistingProdNiluPau$Width_mean,digits = 2)


#### Removing columns, If volume < total of service reviews ####
ExistingProdNiluPau$total_review <- ExistingProdNiluPau$Positive_service_review+
  ExistingProdNiluPau$Negative_service_review

ExistingProdNiluPau = ExistingProdNiluPau[ExistingProdNiluPau$total_review <=ExistingProdNiluPau$Volume ,]

#HISTOGRAM OF WÝDTH BEFORE DOING THE CHANGES
ggplot(data=ExistingProdNiluPau, aes(x=ExistingProdNiluPau$Width)) + 
  geom_histogram(bindwith=0.5, col="black",fill="lightgreen", alpha = .7)

#HISTOGRAM OF WIDTH COLUMN BEFORE DOING THE CHANGES

#After adding the maen value in the new column. We should check the histogram of this new column. 
#The new distribution of the new weight column has the same distribution with the old one. 
#Then we can use this new column in the model.
ggplot(data=ExistingProdNiluPau, aes(x=ExistingProdNiluPau$Width_mean)) + 
  geom_histogram(bindwith=0.5, col="black",fill="lightgreen", alpha = .7)

####REMOVING THE COLUMNS####
#Product id column values does not add  any meaning to the dataset or model. 
#So,We should remove the product_id column.
#best seller rank column has lost of missing values(n/a's). So, we should remove it.
#It does not add any values to the model.#(We should check it also from other techniques.)
#We will remove the X1 colums. This column includes the number of the rows. It does not make any sense for teh model.
#We will remove the old widht column. Because we have the new one without any n/a values.
ExistingProdNiluPau$Best_seller_rank<-NULL
ExistingProdNiluPau$Width<-NULL
ExistingProdNiluPau$Depth <- NULL

####Checking the n/a's in the data set####

sum(is.na(ExistingProdNiluPau)) #total count of na's in the data set 


####Removing Outliers####

ggplot(data=ExistingProdNiluPau, aes(x=ExistingProdNiluPau$Volume)) + 
  geom_histogram(bindwith=0.5, col="black",fill="lightgreen", alpha = .7) #+xlim(c(0, 1500))
#Acording to this graph, we can see outliers obviously. 
#We should remove them for getting best result before running the model.

ExistingProdNiluPau = ExistingProdNiluPau[ExistingProdNiluPau$Volume <=6000,]

####Product_num attributes
#We should not use this variable into the model. This attributes are only Id numbers of products.
#So,they will not make sense to use in the model.We should replace all romws of it null.

####Graphs ####
#graphs for product_type vs. volume 

ggplot(data = ExistingProdNiluPau,mapping = aes(x =Product_type,y=Volume,fill=Product_type))+geom_bar(stat="identity")

#### dummify the data####

ExistingProdNiluPau2 <- dummyVars("~.", data = ExistingProdNiluPau)

readyData <- data.frame(predict(ExistingProdNiluPau2, newdata = ExistingProdNiluPau))
View(readyData)
