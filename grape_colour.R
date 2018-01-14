require(tidyverse)
require(WikipediR)

grape_colour <- function(variety) {
    wiki <- tryCatch(
        page_content(
            language = "en", 
            project = "wikipedia", 
            page_name = variety
        )$parse$text$`*`,
        error = function(e) {
            return(NA)
        }
    )
    
    if (is.na(wiki)) {
        wiki
    } else {
        wiki %>% 
            substr(regexpr("Color of berry skin", .), nchar(.)) %>% 
            substr(1, regexpr("</tr>", .)) %>%
            regmatches(gregexpr("<td>(.*)</td>", .)) %>% 
            {gsub("<.*?>", "", .)} #remove HTML tags
    }
}
