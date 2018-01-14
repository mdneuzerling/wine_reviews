library(tidyverse)
library(tidytext)
library(WikipediR)
library(XML)
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



"Riesling"

merlot <- page_content(
    language = "en", 
    project = "wikipedia", 
    page_name = "Merlot"
)$parse$text$`*`

require(tidyverse)
require(WikipediR)
grape_colour <- function(variety) {
    page_content(
        language = "en", 
        project = "wikipedia", 
        page_name = variety
    )$parse$text$`*` %>% 
        substr(regexpr("Color of berry skin", .), nchar(.)) %>% 
        substr(1, regexpr("</tr>", .)) %>% 
        regmatches(gregexpr("<td>(.*)</td>", .)) %>% 
        {gsub("<.*?>", "", .)}
}








