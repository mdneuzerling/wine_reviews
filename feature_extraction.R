library(tidyverse)
library(tidytext)
data("stop_words")

wine <- read_csv(
    paste0(Sys.getenv("GITHUB"), "/wine_reviews/wine_reviews.csv")
)

wine_words <- wine %>% 
    select(X1, description) %>%
    unnest_tokens(word, description) %>% 
    anti_join(stop_words, by = "word") %>% 
    filter(word != "wine") # Doesn't tell us anything about the wine

wine_words %>% 
    count(word, sort = TRUE) %>% 
    head(500) %>% 
    write.table("clipboard", sep = "\t", row.names = FALSE)
