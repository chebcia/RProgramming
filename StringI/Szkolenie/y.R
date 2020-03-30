library(tidyverse)
load("data/kody.RData")

macierz <- stringdistmatrix(a = kody$odp, b = kody$odp, method = "jw")

colnames(macierz) <- kody$id
rownames(macierz) <- kody$id

macierz[lower.tri(macierz)] <- 1000



mdf <- reshape2::melt(macierz) %>%
  filter(value!=1000)  %>%
  filter(Var1 != Var2)  %>%
   rename(from = Var1, to = Var2) %>% 
   arrange(value)

chordDiagram(mdf)
mdf_n <- mdf %>% 
  top_n(50, -value)


chordDiagram(mdf_n)

network<- graph_from_data_frame(mdf_n)
ggraph(network, layout = "tree") + 
  geom_edge_link(aes (width = value), edge_colour = "lightblue"  ) + 
  geom_node_text(aes (label = name)) + 
   theme_graph()



