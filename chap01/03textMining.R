library(dplyr) # 전처리
library(KoNLP) # 형태소 분석기
library(stringr) # 문자열 다루기
library(wordcloud2) # 워드클라우드 시각화
library(rvest) # html 요소 가져오기
library(RColorBrewer) # R 색상 조합 표

useNIADic()

url <- 'http://www.itworld.co.kr/main/'
html_source <- read_html(url,eencoding = 'CP-949')

# a 태그 안의 텍스트 추출
title <- html_source %>% html_nodes('a') %>% html_text();
head(title)

title <- str_replace_all(title,'\\W',' ')

# 명사 추출
nouns <- extractNoun(title)
word_cnt <- table(unlist(nouns))
class(unlist(nouns))
# 데이터프레임으로 변경
df_word <- as.data.frame(word_cnt,stringsAsFactors = FALSE)
df_word <- df_word %>% arrange(desc(Freq)) %>% head(200)

pal <- brewer.pal(8,'Dark2')
wordcloud2(df_word,size=0.9,color=pal)
