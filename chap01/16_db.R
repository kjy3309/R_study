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


# select SQL 날리기
sql <- 'SELECT * FROM member'
dq <- dbGetQuery(con,sql)
View(dq)
