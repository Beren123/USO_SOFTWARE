install.packages("readr")

library(readr)

lq_raw <- read_lines("/home/nitnelav/lq.txt", skip = 2)

str(lq_raw)

diez<-rep(1:ceiling(length(lq_raw)/10), each = 10)
diez<-diez[1:length(lq_raw)]

lq_text<-cbind(diez, lq_raw)
lq_text<-as.data.frame(lq_text)

lq_text<-aggregate(formula = lq_raw ~ diez,
                   data = lq_text,
                   FUN = paste,
                   collapse = " ")
lq_mt<-as.matrix(lq_text)

lq_mt<-gsub("[[:cntrl:]]", " ", lq_mt)
lq_mt<-tolower(lq_mt)
lq_mt<-removeWords(lq_mt, words = stopwords("spanish"))
lq_mt<-removePunctuation(lq_mt)
lq_mt<-removeNumbers(lq_mt)
lq_mt<-stripWhitespace(lq_mt)

lq_corpus<-Corpus(VectorSource(lq_mt))
lq_corpus

wordcloud(lq_corpus, max.words = 80, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))

lq_tdm<-TermDocumentMatrix(lq_corpus)
lq_tdm

lq_mat<-as.matrix(lq_tdm)
dim(lq_mat)

lq_mat2<-rowSums(lq_mat)
lq_mat2<-sort(lq_mat2, decreasing = TRUE)
lq_df <- data.frame(palabra = names(lq_mat2), frec = lq_mat2)

lq_mat3<-lq_df[1:10,]

ggplot(lq_mat3, aes(palabra, frec)) +
  geom_bar(stat = "identity", color = "black", fill = "#87CEFA") +
  geom_text(aes(hjust = 1.3, label = frec)) + 
  coord_flip() + 
  labs(title = "Diez palabras más frecuentes en La última Pregunta",  x = "Palabras", y = "Número de usos")
