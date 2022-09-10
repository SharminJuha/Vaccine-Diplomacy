library(stm)
library(quanteda)

# prepare data
data <- read.csv('C:/Users/HP/Downloads/Private AI principles & Abstract Scores.csv')


processed <- textProcessor(data$Principle, metadata=data)

out <- prepDocuments(processed$documents, processed$vocab, processed$meta)

docs <- out$documents
vocab <- out$vocab
meta <- out$meta
#meta

poliblogInteraction <- stm(out$documents, out$vocab, K=14,  
                             data=out$meta,seed=8458159)


prep <- estimateEffect(1:14~Year, poliblogInteraction, metadata=out$meta)



save.image('firm_106principle.RData')



library(stminsights)
run_stminsights()



