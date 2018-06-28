library(rvest)

wiki_page <- read_html("https://en.wikipedia.org/wiki/List_of_grape_varieties")
wiki_tables <- wiki_page %>% html_nodes("table")
red_wines <- wiki_tables[[1]] %>% html_table %>% cbind(colour = "red")
white_wines <- wiki_tables[[2]] %>% html_table %>% cbind(colour = "white")
rose_wines <- wiki_tables[[3]] %>% html_table %>% cbind(colour = "rosé")
all_wines <- rbind(red_wines, white_wines, rose_wines)

all_wines %>% 
    rename(
        variety = `Common Name(s)`,
        synonyms = `All Synonyms`,
        country_of_origin = `Country of origin`
    ) %>% 
    select(variety, synonyms, country_of_origin, colour) %>% 
    unnest(synonyms = strsplit(synonyms, ", "))

colnames(varieties) <- c("variety", "synonyms", "country_of_origin",
                         "pedigree", "hectared_cultivates", 
                         "year_of_introduction", "colour")



swiki_tables %>% {purrr(
    c(1, 2),
    function(x) {html_table(wikitables[[x]])})} %>% purrr::reduce(rbind)
