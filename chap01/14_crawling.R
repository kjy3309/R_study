install.packages('rvest') # html 요소 추출 패키지
library('rvest')

# 1. url 준비
url <- 'https://tv.naver.com/jtbc.youth'
# 2. html 가져오기
html_source <- read_html(url, encoding = "UTF-8")
html_source
#html_nodes() : selector 에 걸리는 요소들
#html_node() : selector 에 걸리는 요소
#class="title" 을 가져온다. > a 태그 > tooltip 태그 > text

title <- html_source %>% html_nodes('.title a tooltip') %>% html_text()
title

list <- as.data.frame(title)
View(list)


url <- 'https://en.wikipedia.org/wiki/Student%27s_t-distribution'
html_source <- read_html(url, encoding = "UTF-8")

table <- html_source %>% html_nodes('.wikitable') %>% html_table()
table
# data.frame 변경
list <- as.data.frame(table)
View(list)
