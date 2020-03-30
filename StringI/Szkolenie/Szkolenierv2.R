library(tidyverse)
library(udpipe)
udpipe_download_model(language = "polish-lfg")
model<-udpipe_load_model( file = "polish-lfg-ud-2.4-190531.udpipe")


googlenews$doc_id <- 1:nrow(googlenews)
news_model <- udpipe_annotate(object = model, x = googlenews$title, doc_id = googlenews$doc_id)
