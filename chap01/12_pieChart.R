library(plotly)
library(dplyr)


# 지하철 이용이 많은 순으로 10개의 비율 확인
## 노선별 총 승객수를 구해서 가장 많은 총 승객수 TOP 10 추출
sub <- read.csv('./data/ch02/202006_SUBWAY.csv', stringsAsFactors = F)
table <- sub %>% mutate(총승객수 = 승차총승객수+하차총승객수)
View(table)

list <- table %>% group_by(노선명) %>% summarise(total=sum(총승객수))
View(list)

result <- list %>% arrange(desc(total)) %>% head(10)
View(result)

plot_ly(result, labels=~노선명, values =~total, type='pie')

plot_ly(result, labels=~노선명, values =~total, type='pie',
        textinfo='label+percent', # 차트 내 표현방법
        insidetextfont = list(color='white'), # 차트 내 글자 색상
        showlegend = FALSE,
        hoverinfo='text',
        text=~paste(total,'명'),
        marker = list(line=list(color='white',width=5)), # 파이 별 간격 설정
        hole=0.5
        )
