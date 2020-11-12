library(plotly)
library(dplyr)

## 히스토그램 - 특정 등급을 빈도로 측정할 경우 주로 사용,
## 일반적으로 Y 축은 빈도
View(diamonds)
plot_ly(diamonds, x=~cut) %>% add_histogram()

View(quakes)
plot_ly(quakes,x=~mag) %>% add_histogram()

View(mpg)
plot_ly(mpg,x=~drv, y=~hwy)


# 구동방식(drv) 별 고속도로 연비(hwy) 측정 -> 막대 그래프가 겹치는 형태

plot_ly(list,x=~drv, y=~hwy)

list <- mpg %>% group_by(drv) %>% summarise(total=sum(mean(hwy)))

plot_ly(list,x=~drv, y=~total)

scores <- read.csv('c:/R/chap01/data/ch02/csv_exam.csv')
View(scores)

#반별 과목 합계 
total <- scores %>% group_by(class) %>% summarise(mat=sum(math), eng=sum(english), sci=sum(science))

plot_ly(total, x=~class, y=~mat) %>% add_bars()

plot_ly(total,x=~class, y=~mat, type='bar', name='math') %>%
  add_trace(y=~eng, name='english') %>%
  add_trace(y=~sci, name='science') %>%
  layout(title='scores', yaxis=list(title='score'))


plot_ly(total,x=~class, y=~mat, type='bar', name='math') %>%
  add_trace(y=~eng, name='english') %>%
  add_trace(y=~sci, name='science') %>%
  layout(title='scores', yaxis=list(title='score'), barmode='stack')

scores %>% group_by(class) %>% summarise(tot=sum(math,english,science))
# `summarise()` ungrouping output (override with `.groups` argument)
total <- scores %>% group_by(class) %>% summarise(tot=sum(math,english,science),.groups='drop')

# 왼쪽에 쓸데없는 컬러바가 생겨서 없애줌
plot_ly(total,x=~class,y=~tot, type='bar', color=~class) %>% hide_colorbar()
