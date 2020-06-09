library("dplyr") 
library("stringr")
library("tm")
library("qdap")
library("textclean")
library("caret") 
library("e1071") 



DC_classUTF8 <- stri_encode(DC_class$Text, to = "UTF-8") 
DC_class_vec <- VectorSource(DC_classUTF8)
DC_kor <- VCorpus(DC_class_vec)

#Czyszczenie bez stemmingu:
czysc_korpus  <- function(korpus, slowa = "", znaki=""){
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "”", "")))
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "“", "")))
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "-", "")))
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "'", "")))
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "’", "")))
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "‘", "")))
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "\n", "")))
  korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "\r", "")))
  korpus <- tm_map(korpus, content_transformer(tolower))
  korpus <- tm_map(korpus, removePunctuation)
  korpus <- tm_map(korpus, removeNumbers)
  korpus <- tm_map(korpus, removeWords, slowa)
  korpus <- tm_map(korpus, removeWords, stopwords("en"))
  korpus <- tm_map(korpus, stripWhitespace)
  korpus <- tm_map(korpus, content_transformer(function(x) trimws(x)))
  korpus <- tm_map(korpus, content_transformer(function(x) stri_remove_empty(x, na_empty = FALSE)))
}
  
  
  
  
  
  
korpus_dir_czysty <- czysc_korpus(DC_kor)
tdm_Tf <- DocumentTermMatrix(korpus_dir_czysty)

#Usunięcie rzadkich termów z poziomem 0.995:

tdm_Tf <- removeSparseTerms(tdm_Tf, 0.995)

#Rzutowanie dokument-term na macierz:

macierz <- as.matrix(tdm_Tf)
#rzutowanie na data frame
df<-data.frame(macierz)

#sumowanie kazdego słowa i zapis jako data frame
wyniki<-data.frame(colSums(df[,]))
library(data.table)
wyniki<-setDT(wyniki, keep.rownames = TRUE)[]


wyniki2<-wyniki %>% top_n(n=10) %>% arrange(desc(colSums.df.....)) 

ggplot(wyniki2,aes(x = nazwy , y=ilosc)) + geom_col(fill = "blue") + coord_flip() +  ggtitle("dc")+
  xlab("Termy")+
  ylab("Ilosc") +theme_bw()





Marvel_classUTF8 <- stri_encode(Marvel_class$Text, to = "UTF-8") 
Marvel_class_vec <- VectorSource(Marvel_classUTF8)
Marvel_kor <- VCorpus(Marvel_class_vec)

korpus_dir_czystymarvel <- czysc_korpus(Marvel_kor)
tdm_Tfmarvel <- DocumentTermMatrix(korpus_dir_czystymarvel)

#Usunięcie rzadkich termów z poziomem 0.995:

tdm_Tfmarvel <- removeSparseTerms(tdm_Tfmarvel, 0.995)

#Rzutowanie dokument-term na macierz:

macierzmarvel <- as.matrix(tdm_Tfmarvel)
#rzutowanie na data frame
df2<-data.frame(macierzmarvel)

#sumowanie kazdego słowa i zapis jako data frame
wynikimarvel<-data.frame(colSums(df2[,]))
library(data.table)
wynikimarvel<-setDT(wynikimarvel, keep.rownames = TRUE)[]


wyniki2marvel<-wynikimarvel %>% top_n(n=10) %>% arrange(desc(colSums.df2.....))



names(wyniki2)[1] = "nazwy"
names(wyniki2)[2] = "ilosc"

wyniki2$ozn <- "dc"
wyniki2marvel$ozn <- "marvel"


names(wyniki2marvel)[1] = "nazwy"
names(wyniki2marvel)[2] = "ilosc"

new <- rbind(wyniki2, wyniki2marvel)


new %>% group_by(nazwy) %>% ggplot(aes(x = new$nazwy , y=new$ilosc)) + geom_col() + coord_flip() + facet_wrap(~ozn)+  ggtitle("10 najliczniejszych termów")+
  xlab("Termy")+
  ylab("Liczba") +theme_bw()







