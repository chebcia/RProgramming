library(tidyverse)
load("data/nazwiska.RData")

macierz1 <- stringdistmatrix(a = nazwiska, b = nazwiska, method = "jw")

colnames(macierz) <- nazwiska
rownames(macierz) <- nazwiska

macierz[lower.tri(macierz)] <- 1000



mdf <- reshape2::melt(macierz) %>%
  filter(value!=1000)  %>%
  filter(Var1 != Var2)  %>%
  rename(from = Var1, to = Var2) %>% 
  arrange(value)