setwd("~/Desktop/Coding/Data science")

library(wordcloud)
library(RColorBrewer)
library(tm) 
library(wordcloud2) 

#Example 1: giving words and frequencies and then creating a wordcloud
words <- c("SGH", "E-biznes", "Analiza", "Statystyka",
           "Marketing", "R", "SQL", "Wordcloud", "Nlp",
           "Machine Learning", "Nauka", "Internet",
           "Data Science", "Wizualizacja", "Studia", 
           "Rozwoj", "Python", "Regresja", "Excel",
           "Matematyka", "Dziekanat", "Teamsy")
#frequencies
freqs <- c(19, 10, 8, 15, 5, 20, 10, 5, 2,
           10, 10, 15, 10, 5, 15, 7, 15, 5, 10,
           15, 10, 10)
#generating wordcloud
set.seed(3)
wordcloud(words = words,
          freq = freqs,
          max.words = 25,
          colors = brewer.pal(8,"Dark2"))

#2: wordcloud with frequency dependent on usage 

tekst <- c("Many years ago we all were wondering what would happen with COVID19, nobody expected it to
cause a long lockdown at first, but here we are and even though we see a light at the end
of a tunnel it's still relatively far but not as far as those years that went by. COVID19 did something nobody expected-
           lasted far longer than the relatively logenst lockdown")

wordcloud(words= tekst,scale=c(1,.5),
          min.freq=1,max.words=100,random.order=TRUE, rot.per=.1,
          colors=brewer.pal(3,"Accent"),ordered.colors=FALSE,use.r.layout=FALSE, fixed.asp=TRUE)


#3: Simple Wordcloud

wordcloud("Jedni kiedy dostają szklankę dokładnie w połowie napełnioną mówią: 
          Ta szklanka jest w połowie pełna. 
          Ci drudzy mówią: Ta szklanka jest w połowie pusta. 
          Jednakże świat należy do tych, którzy patrzą na szklankę i mówią: 
          Co jest z tą szklanką? Przepraszam bardzo to ma być moja szklanka? Nie wydaje mi się. 
          Moja szklanka była pełna. I większa od tej",scale=c(2,.5),
          min.freq=1,max.words=100,random.order=TRUE, rot.per=.1,
          colors=brewer.pal(6,"Accent"),ordered.colors=FALSE, fixed.asp=TRUE)


# 4: Generowanie wordcloud from txt 

#text 
text <- readLines(file.choose())

#Corpus
docs <- VCorpus(x = VectorSource(text), readerControl = list(reader=readPlain, language="pl"))

#transformation of Corpus
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# small letters
docs <- tm_map(docs, content_transformer(tolower))
# removing numbers
docs <- tm_map(docs, removeNumbers)
# Upunctuation removal
docs <- tm_map(docs, removePunctuation)
# spaces removal 
docs <- tm_map(docs, stripWhitespace)
# Text stemming
docs <- tm_map(docs, stemDocument)

#word matrix 
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
 
#twordcloud        
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, scale=c(1,.5),
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

#5:  wordcloud2 - chinese characters 

wordcloud2(demoFreqC, size = 0.5, shape = 'star', color = "random-light",
           backgroundColor = 'black')

#6: wordcloud2 word rotation

wordcloud2(demoFreq, size = 0.6, shape = 'pentagon', color = "random-dark",
           backgroundColor = 'yellow', minRotation = -pi/6,
           maxRotation = -pi/6, rotateRatio = 1)


