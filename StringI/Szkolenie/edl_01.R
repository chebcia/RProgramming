load("data/googlenews.RData")
summary(googlenews)
library(tidyverse)
news_general <- googlenews %>% 
filter(category == "general")

cat_n <- googlenews %>% 
  count(category)

cat_n
news_general <- googlenews %>% 
  group_by(author) %>% 
  top_n(1, author)  %>% 
  count(author)


googlenews %>%
  count(category, name) %>%
  arrange(desc(n)) %>% 
 group_by(category) %>% 
  top_n(3, n)

