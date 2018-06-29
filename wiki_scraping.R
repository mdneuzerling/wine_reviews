library(tidyverse)
library(rvest)

wiki_tables <- "https://en.wikipedia.org/wiki/List_of_grape_varieties" %>% 
    read_html %>% 
    html_nodes("table")
red_wines <- wiki_tables[[1]] %>% html_table %>% cbind(colour = "red")
white_wines <- wiki_tables[[2]] %>% html_table %>% cbind(colour = "white")
rose_wines <- wiki_tables[[3]] %>% html_table %>% cbind(colour = "rosé")
all_wines <- rbind(red_wines, white_wines, rose_wines)

varieties <- all_wines %>% 
    rename(
        variety = `Common Name(s)`,
        synonyms = `All Synonyms`,
        country_of_origin = `Country of origin`
    ) %>% 
    select(variety, synonyms, country_of_origin, colour) %>% 
    {rbind(
        select(., variety, country_of_origin, colour),
        rename(select(., synonyms, country_of_origin, colour),
               variety = synonyms)
    )} %>%
    unnest(variety = strsplit(variety, ", ")) %>%
    unnest(variety = strsplit(variety, " / ")) %>% 
    mutate(
        variety = gsub("\\.", "", variety), # remove periods 
        variety = gsub("\\s*\\([^\\)]+\\)", "", variety), # remove brackets and anything within
        variety = gsub("\\s*\\[[^\\)]+\\]", "", variety) # same for square brackets
    ) %>% 
    mutate_all(tolower) %>% 
    select(variety, colour, country_of_origin) %>% 
    arrange(variety) %>% 
    distinct
