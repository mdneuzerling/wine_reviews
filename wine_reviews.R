library(tidyverse)
library(e1071)
library(visdat)
library(naniar)
library(corrplot)

wine <- read.csv(
    "wine_reviews.csv"
)

#' Will take a minute
vis_dat(wine, warn_large_data = FALSE)

wine %>% 
    group_by(variety) %>% 
    summarise(avg_price = mean(price, na.rm = TRUE)) %>% 
    arrange(desc(avg_price))

ggplot(data = wine,
       aes(x = price,
           y = points)) +
  geom_miss_point()

wine %>% 
    ggplot(aes(x = price, y = points)) + 
        geom_point() +
        geom_smooth()

top_ten <- wine %>% 
    count(variety) %>% 
    arrange(desc(n)) %>% 
    pull(variety) %>% 
    head(10)

wine %>% 
    filter(variety %in% top_ten) %>% 
    ggplot(aes(x = price, y = point,color = variety)) + 
        geom_point()

wine_com <- wine %>% filter(!is.na(price))
cor(wine_com$price, wine_com$points)

price_model <- wine_com %>% lm(price ~ points + country, .) 

wine_com %>% lm(price ~ points, .) %>% summary # 0.1819
wine_com %>% lm(price ~ points + country, .) %>% summary # 0.1822
wine_com %>% lm(price ~ points + variety, .) %>% summary # 0.2158
wine_com %>% lm(price ~ points + taster_name, .) %>% summary # 0.1908
wine_com %>% lm(price ~ points + province, .) %>% summary # 0.1908


# imp <- amelia(wine)


