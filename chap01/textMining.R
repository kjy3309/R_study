install.packages('rJava')
# cran 에 패키지가 없을 경우
install.packages('memoise')
install.packages('stringr')
install.packages("wordcloud2")

# 형태의 분석
install.packages('KONLP')
install.packages('remotes')
remotes::install_github('haven-jeon/KONLP',upgrade = 'never', INSTALL_opts=c("--no-multiarch"))

install.packages(c('Sejong','hash','tau','RSQLite','devtools'), type='binary')

library(dplyr)
library(KoNLP)
useNIADic()

txt <- readLines('C:/R/chap01/data/ch03/hiphop.txt')
head(txt)

# 특수문자 처리
library(stringr)
txt <- str_replace_all(txt,'\\W',' ') # \\w 모든 특수문자를 뜻하는 정규 표현식
head(txt)

nouns <- extractNoun(txt) #명시(noun)만 추출출
head(nouns)
class(nouns)
head(unlist(nouns)) # list 상태에서는 데이터 변경이 안된다.

word_cnt <- table(unlist(nouns)) # 각 단어의 빈도 체크
class(word_cnt) # 현재 테이블상태임.. 그래서 뭘 할수가 없네

df <- as.data.frame(word_cnt, stringsAsFactors = FALSE) # stringAsfactor 안하면 문자열을 factor로 취급해버릴 수 있음
View(df)
#변수명 변경
df_words <- rename(df,word=Var1, freq=Freq)
result_df <- df_words %>% arrange(desc(freq)) %>% filter(nchar(word)>1)
View(result_df) 

library(wordcloud2)
wordcloud2(result_df,color = 'random-light', size = 0.6)
