# 함수
# x1 에 1,2,3 대입하기
x1 <- c(1,2,3)
x2 <- c(20,5,400,12,99)

mean(x1) # x1에 대한 평균
max(x1) # x1 에 최대값
min(x1) # x1 에 최소값

# 특정 조건의 인덱스 반환
which(x2>90)
which.max(x2)
which.min(x2)

# Hello R Studio world 를 str 변수에 담기
str <- c("hello","R","Studio","world")
str
result <- paste(str, collpase =",") # 구분자를 줘서 문자합치기

## 함수 작성
# 매개변수와 반환값이 모두 있는 경우
f_ex1<-function (a,b){
  sum<-a+b
  return (sum)
}
f_ex1(3,4)

# 매개변수가 없고 반환값은 있는 경우
f_ex2<-function(){
  str <- '매개변수는 없다.'
  return(str)
}
f_ex2

# 매개변수가 벡터인 경우
# vector == c(10,20,30)
f_ex3 <- function(scores){
  for(score in scores){# for 문
    if(score>20){
      print(paste(score," 는 20점 이상"))
    }else{
      print(paste(score," 는 20점 미만"))
    }
  }
}

f_ex3(c(10,20,30))