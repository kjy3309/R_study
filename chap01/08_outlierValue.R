ol <- data.frame(
  gender = c(2,2,1,3,2,1),
  score = c(50,40,30,20,40,200)
)

ol

table(ol$gender) # table 은 특정 값의 빈도를 나타낸다.

# 숫자의 종류가 적을 경우 table 을 통해 결측치를 찾을 수 있다.

# 숫자의 종류가 다양할 경우 차트를 통해 이상치를 찾는다.
boxplot(ol$score)

# 이상치의 결측 처리
ol$gender <- ifelse(ol$gender == 3,NA,ol$gender)
ol$score <- ifelse(ol$score > 70,NA,ol$score)

new_ol <- na.omit(ol)
new_ol
