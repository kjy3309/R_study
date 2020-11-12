library('rvest')

url <- "https://news.naver.com/main/ranking/popularDay.nhn"

html_source <- read_html(url, encoding = "CP-949")

news <- html_source %>% html_nodes('li dl dt a') %>% html_attr('title')
news

title <- gsub(',', ' ', news)
title
class(title)

write.table(title, file = "./news.csv", append = TRUE, col.names = FALSE, row.names = FALSE, quote = FALSE)
