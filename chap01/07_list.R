##list
# 이 안에 여러가지 데이터 형태가 들어갈 수 있다.
# R 분석 결과가 list 로 제공되는 경우가 많다.
# 그렇기 때문에 데이터 사용 시 unlist() 해줘야 하는 경우도 생긴다.
# c(1,2,3,4,"5") 동일한 데이터형태만 가능
li <- list(a=1:3, b="string", c=1000)
li

# list 안 요소들을 뽑아내기
li$a
li$b
li$c

li$d <- list(x=0.014, y=0.0005)
li$d

# x와 y값 꺼내기
li$d$x
li$d$y

