df <- data.frame(
  name=c("김지훈","이유진","박동혁","김민지"),
  eng=c(90,80,60,70),
  math=c(50,60,90,20),
  class=c(1,1,2,2)
)

# R 파일 저장 및 불러오기
# 외부 파일로 내보내거나 불러오는 것 보다 빠르다
# 그래서 작업 중간 저장용으로 적합하다.

# 저장 : save(dataFrame, file='저장 경로)
save(df,file='./data/df_data.rda')
rm(df) # 원하는 변수만 지우는 함수
df

# 읽어오기 : load('불러올 경로')
load('./data/df_data.rda')
df
