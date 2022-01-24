## setting up working directory
setwd("~/Desktop/Coding/Data science")

## articles within directory
dir()

##### R Basics #####

## Variable assignement and removal
x <- 1:6
rm(x)

### arithmetics ###

2+2*2^2
x[3]*x[9]
10 %% 3 
10 %/% 3

### functions ###
pi
floor(pi) 
floor(-pi)
ceiling(pi) 
ceiling(-pi)
abs(x)
log(x,base=y)
exp(x)
sqrt(x)
factorial(x)
mean(x)
median(x)
var(x)
sd(x)
quantile(x)
summary(x)

#creating and removing a function
square_function <- function(n)
{
  n^2
}
square_function(8)

rm(square_function)

#sin, cos etc 
x <- 1:10
y <- sin(x)
y
plot(x,y, type = "s") 

# better looking
x <- 1:10
x <- seq(from=0,to = 2*pi,length.out = 100)
y <- sin(x)
plot(x,y,type="l")

### Reading data ###
library(readr)
PopularCreativeTypes <- read_csv("hollywood movies data/PopularCreativeTypes.csv")
read.csv2("hollywood movies data/PopularCreativeTypes.csv") 

TopGenres <- read_csv("hollywood movies data/TopGenres.csv")

#using table function and removing 
PopularCreativeTypes <- read.table(file="hollywood movies data/PopularCreativeTypes.csv", header = TRUE, sep = ";", dec = ",")

rm(TopGenres)
rm(PopularCreativeTypes)

### data filtering ### 

# head elements (beggining 3, apart from last 2)
head(TopGenres)
head(TopGenres,3)
head(TopGenres,-2)

# tail elements (last 3, apart from beginning 4)
tail(TopGenres)
tail(TopGenres,3)
tail(TopGenres,-4)

# specific elements access (4 row, 5 column, from 4 to 8 column)
TopGenres[4,5]
TopGenres[4,]
TopGenres[,4]
TopGenres[4:8,]

TopGenres[c(6,8,13),]


# column access
TopGenres$MOVIES
TopGenres$`TOTAL GROSS`

### basic statistics ### 
# movies with smallest earnings
min(TopGenres$`TOTAL GROSS`)
TopGenres[TopGenres$`TOTAL GROSS` == 100,]
TopGenres[TopGenres$`TOTAL GROSS` == min(TopGenres$`TOTAL GROSS`),]

## other statistics 

max(TopGenres$`TOTAL GROSS`)
mean(TopGenres$`TOTAL GROSS`)
median(TopGenres$`TOTAL GROSS`)
range(TopGenres$`TOTAL GROSS`)
sd(TopGenres$`TOTAL GROSS`)
var(TopGenres$`TOTAL GROSS`)
sd(TopGenres$`TOTAL GROSS`)^2
sd(TopGenres$`TOTAL GROSS`^2)
summary(TopGenres$`TOTAL GROSS`)
summary(TopGenres)
quantile(TopGenres$`TOTAL GROSS`)

# Genres with number of movies above the mean number of movies within a genre 
TopGenres[TopGenres$MOVIES > mean(TopGenres$MOVIES),]

# Genres with number of movies below the median number of movies within a genre 
TopGenres[TopGenres$MOVIES < median(TopGenres$MOVIES),]

# (movies > mediana) & (movies < mean)
TopGenres[(TopGenres$MOVIES > median(TopGenres$MOVIES)) & (TopGenres$MOVIES < mean(TopGenres$MOVIES)),]

### sorting ### 
sort(TopGenres$MOVIES)
order(TopGenres$MOVIES)
TopGenres <- TopGenres[order(TopGenres$MOVIES,decreasing = TRUE),]
TopGenres

summary(TopGenres$MOVIES)

### different types of classes manipulation 

# pasting different types of classes
paste("Claire has", 123, "dogs and", 6, "cats")

# printing
print("Claire hates animals")

# data types
number <- 5
word <- "6"
# class type
class(number)
class(word)
is.numeric(number)
is.numeric(word)
# checking/changing types
as.character(number)
as.character(34567.54678)
as.numeric("123")
as.numeric("123word")


### basic programming in R 

# if, else 
if (sum(1:5) > 10) {
  print('bigger')
} else {
  print('smaller or equal')
}

# if, else- more complicated
if (sum(1:7) > 10) {
  print('bigger')
} else if (sum(1:4) == 10) {
  print('equal')
} else {
  print('smaller')
}


wordnumber <- "3"
switch(wordnumber,
       '0' = cat('zero'),
       '1' = cat('one'),
       '2' = cat('two'),
       '3' = cat('three'),
       '4' = cat('four'),
       '5' = cat('five'),
       '6' = cat('six'),
       '7' = cat('seven'),
       '8' = cat('eight'),
       '9' = cat('nine'),
       cat('not number'))

# loop value for i 
for (i in 1:10)
  cat(paste('actual value of i is', i, '\n'))

# same thing differently 
for (i in 1:10) {
  cat('actual value of i i', i, '\n')
}

# same with while loop  
# 
i <- 1
while (i < 10) {
  cat(paste('actual value of i i', i, '\n'))
  i <- i + 1
}

# loop showing numbers not divided by 2
i <- 1
while (i < 10) {
  cat(paste('actual value of i i', i, '\n'))
  i <- i + 2
}


# for loop function with m parameter 
my_function <- function(n, m) {
  for (i in m:n) {
    if (i %% 2 == 0) {
      cat(i/2, 'divided by 2')
    } else {
      cat(i/2+0.5, 'divided by 2+0.5')
    }
  }
}
my_function(30,10)
my_function(10,30)
30:10
10:1

