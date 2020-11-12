install.packages('rJava')
install.packages('RJDBC')

library('rJava')
library('RJDBC')

jdbcDriver <- JDBC(driverClass = 'oracle.jdbc.driver.OracleDriver', classPath = 'ojdbc8.jar')

## connection 연결
url <- 'jdbc:oracle:thin:@gdportal.iptime.org:1521:xe'
id <- 'C##WEB_USER'
pass <- 'pass'

con <- dbConnect(jdbcDriver,url,id,pass)
con

# csv 파일 가져오기
# data frame 만들기
df <- read.csv('./data/csv_exam.csv')
View(df)
class(df)

#apply(데이터, [행|열], 콜백) : 반복 연산 시 사용
sqls <- sprintf('INSERT INTO lms VALUES(%s)', 
                apply(df,1, function(i){ # i: 한 줄의 데이터
  paste(i,collapse = ',')
})) # 1: row / 2: column

sqls # insert 문 리스트

#sqls 에서 쿼리문을 하나씩 빼서 전송

# lapply(데이터, 콜백)
lapply(sqls, function(sql){
  dbSendQuery(con,sql)
})

# select SQL 날리기
sql <- 'SELECT * FROM lms'
dq <- dbGetQuery(con,sql)
View(dq)
