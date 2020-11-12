library('ggplot2')
class(mpg)

# 통합 도시연비 total <- (cty+hwy)/2
new <- mpg$cty + mpg$hwy
mpg$total <- new / 2
mpg$total
View(mpg$total)
hist(mpg$total)
summary(mpg$total)

# 조건문 ( 3항 연산자처럼 쓰는 방법)
#total 이 20보다 크거나 같으면 'pass' 아니면 'fail'
mpg$test <- ifelse(mpg$total>=20,"pass","fail")
mpg$test

head(mpg$test)
hist(mpg$test) # histogram 은 x 축이 숫자여야 한다.
qplot(mpg$test)

# total 이 30보다 크거나 같으면 "A"
# total 이 20보다 크거나 같으면 "B"
# 나머지는 c
# 이 변수의 이름은 grade 이다
mpg$grade <-ifelse(mpg$total>=30,"A",ifelse(mpg$total>=20,"B","C"))
head(mpg$grade)
qplot(mpg$grade)