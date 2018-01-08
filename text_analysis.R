library(tidyverse)
library(tidytext)
data("stop_words")
library(wordcloud)
library(markovchain)

wine <- read_csv(
    paste0(Sys.getenv("GITHUB"), "/wine_reviews/wine_reviews.csv")
)

wine_words <- wine %>% 
    select(X1, description) %>%
    unnest_tokens(word, description)

#' Using just the first 2000 wine reviews takes a few minutes and roughly a 
#' gigabyte of RAM. I don't want to even think about training on all 130K
#' reviews.
fit <- markovchainFit(data = (wine_words %>% filter(X1 <= 2000))$word)

gen_review <- function() {
    markovchainSequence(n = 50, markovchain = fit$estimate) %>% 
        paste0(collapse = ' ')
}
