library(dplyr)
library(KoNLP)
library(stringr)
library(wordcloud2)

useNIADic()
tw <- read.csv('./data/ch03/twitter.csv',fileEncoding = "UTF-8",
               header = TRUE,
               stringsAsFactors = FALSE)
View(tw)
tw <- rename(tw,no=번호,id=계정이름,date=작성일,twit=내용)
View(tw)

## 1. 특수문자 제거
content <- str_replace_all(tw$twit,'\\W',' ')
## 2. 명사 추출
nouns <- extractNoun(content)
## 3. 빈도 추출(unlist 로 list 해제 후)
word_cnt <- table(unlist(nouns))
## 4. 데이터 프레임으로 변경
df_word <- as.data.frame(word_cnt,stringsAsFactors = FALSE)
View(df_word)
## 5. 빈도수로 내림차순(1글자 초과한...)
top100 <- df_word %>% filter(nchar(Var1)>1) %>% arrange(desc(Freq)) %>% head(300)
View(top100)
## 6. 시각화

# shape = circle,star,diamond,triangle,
my_cloud <- wordcloud2(top100,size=0.7,color='random-light',backgroundColor = 'black', shape = 'star')
library(htmlwidgets)
saveWidget(my_cloud,'C:/R/chap01/wordCloud.html',selfcontained = F)

## 가장 많이 이용되는 역을 워드 클라우드로 만들어보기
station <- read.csv('./data/ch02/202006_SUBWAY.csv', stringsAsFactors = FALSE)
View(station)
class(station)
table <- station %>% mutate(total=승차총승객수+하차총승객수) %>% select(역명,total)
df_words <- table %>% group_by(역명) %>% summarise(stotal=sum(total),.groups='drop')
View(df_words)
stations <- df_words %>% arrange(desc(stotal))
wordcloud2(stations,size=0.3,color='random-light')
