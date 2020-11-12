# scv_exam.csv 파일 불러오기

ex <- read.csv('./data/ch02/csv_exam.csv', stringsAsFactors = F)
View(ex) # 별도의 뷰어로 보여줌

head(ex) # 위에서 부터  6개 데이터 보여줌
head(ex,10) # n개를 보여줌

tail(ex) # 아래서부터 6개 데이터 보여줌줌

dim(ex)

str(ex) #column

# summary -> data.frame
ex <- summary(ex)
View(ex)

library('ggplot2')
class(mpg)
ex <- summary(mpg)
View(ex)
# 도시연비(cty)
# 최소연비 9
# 최대연비 35
# 평균연비 16.86
# 주요연비 14~19