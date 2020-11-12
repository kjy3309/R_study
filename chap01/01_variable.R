##1. 변수선언
a<-1 # 변수에 1을 할당
a # 변수를 호출

arr=3 # 이런 형태로 대입 가능하나 권고하지 않음

arr <- c(1,2,3,4,5) # combine 함수 : 배열처럼 저장장
arr1 <- c(1:5)

#seq() : 연속되는 값을 넣는데 유용
arr2 <- seq(1,5)
arr3 <- seq(1,10, by=2)

## 2. 변수 계산
# arr 에 각 2씩을 더하라
arr <- arr+2
arr1+arr2 # arr1 과 arr2의 값을 모두 더하라

## 3. 비교 연산
arr1 == arr2 # 변수에 있는 값을 하나하나 비교한다.

## 4. 문자열 다루기
str <- "Hello"
str2 <- "R-studio"
str <- c(str,str2)
str3 <- 'hello'+"R" # java 처럼 문자열을 더할 수 없다.

