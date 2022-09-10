Sys.setlocale( 'LC_ALL','C' )
library("ldatuning")
library('stopwordsCN')
library("topicmodels")
# prepare data
library(tmcn)
data <- readRDS('C:/Users/HP/Downloads/principles_topicProportion_108.rds')
Sys.setlocale('LC_ALL','C')
library(tm)
#sampling <- sample(1:3, replace = FALSE,size = nrow(data)*0.8 )
#train_data <- data[sampling,]

#test_data <- data[-sampling,]
##Creating the document-term matrix for train data
doc.vec_train <- VectorSource(data$Abstract)
doc.corpus_train <- Corpus(doc.vec_train)
doc.corpus_train <- tm_map(doc.corpus_train , tolower)
doc.corpus_train <- tm_map(doc.corpus_train, removePunctuation)
doc.corpus_train <- tm_map(doc.corpus_train, removeNumbers)
doc.corpus_train <- tm_map(doc.corpus_train, removeWords, stopwordsCN(stopwords = NULL, useStopDic = TRUE))
doc.corpus_train <- tm_map(doc.corpus_train, stripWhitespace)

TDM_train <- TermDocumentMatrix(doc.corpus_train)
DTM_train <- DocumentTermMatrix(doc.corpus_train)
DTM_train




##plot the metrics to get number of topics
system.time({
  tunes <- FindTopicsNumber(
    dtm = DTM_train,
    topics = c(2:20),
    metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010"),
    method = "Gibbs",
    control = list(seed = 12345),
    mc.cores = 4L,
    verbose = TRUE
  )
})

FindTopicsNumber_plot(tunes)
