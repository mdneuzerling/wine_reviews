library(tidyverse)
library(tidytext)
data("stop_words")
library(wordcloud)

wine <- read_csv(
    paste0(Sys.getenv("GITHUB"), "/wine_reviews/wine_reviews.csv")
)

wine_words <- wine %>% 
    select(X1, description) %>%
    unnest_tokens(word, description) %>% 
    anti_join(stop_words)

wine_words %>%
    count(word, sort = TRUE) %>%
    head(20) %>%
    mutate(word = reorder(word, n)) %>%
    ggplot(aes(word, n)) +
    geom_col() +
    xlab(NULL) +
    theme(text = element_text(size=1S6)) +
    coord_flip()

wine_words %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

