# csv 읽어오기
# stringsAsFactors = F : string data 를 factor 로 읽지 않겠다.
df_csv <- read.csv('./data/csv_exam.csv',stringsAsFactors = F)
View(df_csv)
class(df_csv)

# 영어, 수학 평균

mean(df_csv$math)
df_csv

# data.frame -> csv 내보내기
df <- data.frame(
  name=c("김지훈","이유진","박동혁","김민지"),
  eng=c(90,80,60,70),
  math=c(50,60,90,20),
  class=c(1,1,2,2)
)

write.csv(df,'./data/df_out.csv')
