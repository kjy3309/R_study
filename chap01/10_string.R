library(plotly)
library(dplyr)

# 실업률 데이터 라인으로 그리기
View(economics)
plot_ly(economics,x=~date, y=~unemploy) %>% add_lines() %>%
  layout(title='실업률 추이', xaxis=list(title='연도'), yaxis=list(title='실업자 수'))


## 지하철 총 승객 수 일자별 그래프

subway <- read.csv('./data/ch02/202006_SUBWAY.csv', stringsAsFactors = F)
View(subway)
class(subway)


ex <- subway %>% group_by(사용일자) %>% summarise(총승객수 = sum(승차총승객수+하차총승객수))
View(ex)
ex$사용일자 <- ifelse(ex$사용일자>20200600, ex$사용일자-20200600,ex$사용일자)

# 상세 설정은 https://plotly.com/r
plot_ly(ex, x=~사용일자, y=~총승객수) %>% add_lines() %>% 
  layout(title='6월 승객 추이', xaxis=list(title='날짜', autotick=FALSE), yaxis=list(title='이용객 수'))

## 각 호선별 날짜별 이용 승객
list <- subway %>% group_by(사용일자, 노선명) %>% summarise(total=sum(승차총승객수+하차총승객수))
list$사용일자 <- ifelse(list$사용일자>20200600, list$사용일자-20200600,list$사용일자)

write.csv(file='C:/R/chap01/sample.csv',list)
list <- read.csv('C:/R/chap01/sample.csv')

plot_ly(list, x=~사용일자, y=~total) %>% add_lines(linetype=~노선명)
View(list)

# 1호선 ~ 9호선 만 나타내기
library(stringr) # 문자열을 다루는 라이브러리
g <- list %>% filter(str_detect(노선명,'^1호선')|str_detect(노선명,'^2호선')|
               str_detect(노선명,'^3호선')|str_detect(노선명,'^4호선')|
               str_detect(노선명,'^5호선')|str_detect(노선명,'^6호선')|
               str_detect(노선명,'^6호선')|str_detect(노선명,'^8호선')|
               str_detect(노선명,'^9호선'))
View(g)
plot_ly(g, x=~사용일자, y=~total) %>% add_lines(linetype=~노선명)
