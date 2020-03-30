library(tidyverse)

load("data/nazwiska.RData")

name_matrix200 <- nazwiska %>% 
  filter(liczba > 200)
name_matrix <- stringdistmatrix(a = name_matrix200$nazwisko, b = name_matrix200$nazwisko, method = "lv")

colnames(name_matrix) <- name_matrix200$nazwisko
rownames(name_matrix) <- name_matrix200$nazwisko

name_matrix[lower.tri(name_matrix)] <- 10000

mdf_2 <- reshape2::melt(name_matrix) %>% 
  filter(value != 10000) %>%
  filter(Var1 != Var2) %>% 
  rename(from = Var1, to = Var2) %>% 
  arrange(value)

mdf_2_n <- mdf_2 %>% 
  top_n(50, -value)

library(igraph)
library(ggraph)
library(ggplot2)

nowe <- mdf_2_n
xD <- graph_from_data_frame(mdf_2_n)

ggraph(xD, layout ="fr") + 
  geom_edge_link(aes(width = value), edge_colour = "darkgreen") + 
  geom_node_text(aes(label = name))

library(ggplot2)
nowe <- graph_from_data_frame(nowe) 
ggplot(mdf_2, aes(x=value)) + geom_histogram()

ggplot(mdf_2_n, aes(x= from, y = value)) + geom_col() + coord_flip()
ggplot(mdf_2_n, aes( x = from, y= to, fill=value)  ) + geom_tile()
tinder()


