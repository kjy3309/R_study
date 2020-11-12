library(plotly)
library(dplyr)

# 점수 분포
scores <- read.csv('./data/ch02/csv_exam.csv')
scores
p1 <- plot_ly(scores, x='math', y=~math, type='box') # 수학에 대한 분포도도
p2 <- plot_ly(scores, x='english', y=~english) %>% add_boxplot(x='english')

subplot(p1,p2,
        shareY = TRUE,
        margin = 0
        ) %>% hide_legend() %>% layout(title='math & english SCORE', yaxis=list(title='score'))

View(mpg)
plot_ly(mpg,x=~drv,y=~hwy,type='box', color=I('dodgerblue'))

plot_ly(mpg,x=~drv,y=~hwy,type='box', color=~drv) %>% hide_legend() %>%
  layout(title='구동방식 별 연비', yaxis=list(title='고속도로연비비'))
