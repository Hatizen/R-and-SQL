## K-means- all 

install.packages("scatterplot3d")

# Packages
# stats - needed for statistical analysis,
# dplyr- needed for data manipulation,
# ggplot2, ggfortify, scatterplot3d -packages useful for building clusters

library(stats)
library(dplyr)
library(ggplot2)
library(scatterplot3d)

# Data base
library(readr)
Mall_Customers <- read_csv("Mall_Customers.csv")

# Data base 
view(Mall_Customers)

#Data cleansing by removing non-numeric variables
#It is done by creating a new database with only columns containing numeric data
Customers = select(Mall_Customers,c(3,4,5))

# Getting rid of spaces and unusual characters in column names to avoid autoplot errors
Customers <- setNames(Customers, c("Age", "AnnualIncome", "SpendingScore"))

# K-means data for this dataset
## is it here to keep as below is a more detailed analysis?
results <- kmeans(Customers, 4)
results

# detailed data
### also asking if I keep it here
results$centers
results$size
results$cluster
results$withinss

# The optimal number of clusters, i.e. k-value, is checked by WSS (Total Within Sum of Squares)
# it is not available directly in R, so write it first
# wss plot fucntion in order to select the optimal number of clusters for analysis 
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")
  wss
}

# There are 3 variables: Age, Annual Revenue, and Spending Score, for more accurate measurement - pairwise analysis

# 1. Klustering through Annual Revenue and Spending Score

Customers_ANUNUAL_SPENDING = select(Mall_Customers,c(4,5))
Customers_ANUNUAL_SPENDING <- setNames(Customers_ANUNUAL_SPENDING, c("AnnualIncome", "SpendingScore"))

# Wss plot execution to detect the optimal number of k-means
wssplot(Customers_ANUNUAL_SPENDING)


# ANALYSIS AND VISUALIZATION
annualspending <- kmeans(Customers_ANUNUAL_SPENDING, 5, nstart = 10)

annualspending
annualspending$centers

# Simple visualization
plot(Customers_ANUNUAL_SPENDING[c('AnnualIncome','SpendingScore')], col = results$cluster)

# Visualization with ggplot
ggplot(Customers_ANUNUAL_SPENDING, aes(x = AnnualIncome, y = SpendingScore)) + 
  geom_point(stat = "identity", aes(color = as.factor(annualspending$cluster))) +
  scale_color_discrete(name=" ",labels=c(paste0("Cluster",1:4))) +
  ggtitle("Mall Customer Segmens") + ylab("SpendingScore")

# 2. Klustering by Age and Spending Score
Customers_AGE_SPENDING = select(Mall_Customers,c(3,5))
Customers_AGE_SPENDING <- setNames(Customers_AGE_SPENDING, c("Age", "SpendingScore"))

# Wss plot function
wssplot(Customers_AGE_SPENDING)

# ANALYSIS AND VISUALIZATION
agespending <- kmeans(Customers_AGE_SPENDING, 4, nstart = 10)

attributes(agespending)
agespending
agespending$size
agespending$cluster
agespending$centers
str(agespending)

# Simple visualization
plot(Customers_AGE_SPENDING[c("Age","SpendingScore")], col = results$claster) 

# Visualization with ggplot
ggplot(Customers_AGE_SPENDING, aes(x = Age, y = SpendingScore)) + 
  geom_point(stat = "identity", aes(color = as.factor(agespending$cluster))) +
  scale_color_discrete(name=" ",labels=c(paste0("Cluster",1:4))) +
  ggtitle("Mall Customer Segmens") + ylab("Spending Score")

#3. Kluster based on annual income and age
Customers_ANUNUAL_AGE = select(Mall_Customers,c(3,4))
Customers_ANUNUAL_AGE <- setNames(Customers_ANUNUAL_AGE, c("Age", "AnnualIncome"))

# Wss plot execution to detect the optimal number of k-means
wssplot(Customers_ANUNUAL_AGE)

# ANALYSIS AND VISUALIZATION
annualage <- kmeans(Customers_ANUNUAL_AGE, 4, nstart = 10)

annualage
annualage$centers
annualage$cluster

# Simple visualization 
plot(Customers_ANUNUAL_AGE[c('AnnualIncome','Age')], col = results$cluster)

# Visualization with ggplot
ggplot(Customers_ANUNUAL_AGE, aes(x = AnnualIncome, y = Age)) + 
  geom_point(stat = "identity", aes(color = as.factor(annualage$cluster))) +
  scale_color_discrete(name=" ",labels=c(paste0("Cluster",1:4))) +
  ggtitle("Mall Customer Segmens")

#4. Clustering of 3 variables at once
Customers_ANUNUAL_SPENDING_AGE = select(Mall_Customers,c(3,4,5))
Customers_ANUNUAL_SPENDING_AGE <- setNames(Customers_ANUNUAL_SPENDING_AGE, c("Age", "AnnualIncome", "SpendingScore"))

# Wss plot execution to detect the optimal number of k-means
wssplot(Customers_ANUNUAL_SPENDING_AGE)

# Analysis and visualisation  
annualspendingage <-kmeans(Customers_ANUNUAL_SPENDING_AGE, 5, nstart = 10)

annualspendingage

# Usage of the scatterplot3d package
library(scatterplot3d)

with(Customers_ANUNUAL_SPENDING_AGE, 
     scatterplot3d(Age, SpendingScore, AnnualIncome, type = "p", color = annualspendingage$cluster))
