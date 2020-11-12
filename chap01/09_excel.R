install.packages('readxl')
library('readxl')
excel <- read_excel('./data/excel_exam.xlsx',sheet = 1) #경로, 시트
excel
View(excel)

mean(excel$math)
mean(excel$science)

# 변수(컬럼) 이름이 없는 경우우
novar <- read_excel('./data/excel_exam_novar.xlsx', sheet = 1, col_names = F)
View(novar)

