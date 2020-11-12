# R 을 이용하여 다음의 사이트를 크롤링 후 알맞은 형태로 전처리 하여 csv 파일을 생성 하시오.
# 크롤링할 사이트 : https://news.naver.com/main/ranking/popularDay.nhn
# 수집할 내용 : 뉴스
# 제목저장할 파일명 : news.csv
# * 수집 할 때마다 기존 파일에 append 시킬 것

install.packages('rvest')
library('rvest')



url <- 'https://news.naver.com/main/ranking/popularDay.nhn'
html_source <- read_html(url, encoding = "CP-949")
html_source

tit <- html_source %>% html_nodes('.ranking_section h4') %>% html_attr('class')
name <- html_source %>% html_nodes('.ranking_section h4') %>% html_text()
section <- data.frame(tit,name)
section


title <- html_source %>% html_nodes('dt a') %>% html_attr("title")
title
  
news <- data.frame(title)
write.csv(news,'C:/R/chap01/news.csv')
