# 1. 설치된 패키지 확인
installed.packages()

# 2. 패키지 설치
install.packages("ggplot2")
# 설치 후 설치 위치를 확인할 것

# 3. 패키지 불러오기
library("ggplot2")

# 3. 설치한 패키지 사용
x <- c("a","a","a","b","b","c")
qplot(x)

# R 에서 sample 데이터를 제공해준다.
# mpg(mile per gallon)
mpg
View(mpg)

# drv= 구동방식, hwy=고속도로연비
qplot(data=mpg, x=drv, y=hwy, geom="line")
qplot(data=mpg, x=drv, y=hwy, geom="boxplot", colour=drv)

# API 보는 법
?qplot
