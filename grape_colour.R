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
        {gsub("<.*?>", "", .)} #remove HTML tags
}