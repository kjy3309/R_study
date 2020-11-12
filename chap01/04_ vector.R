## 벡터 (1,2,3,4,...)

# 벡터 선언
v <- c(1,2,3,4,5,6,7,8,9,10)
v <- c(1:10)

# 벡터 연산
# replace() : 벡터의 특정 인덱스값을 변경시킨다.
v2 <- replace(v,10,0) #변경할 벡터, 변경할 인덱스, 변경할 값
# 변경할 값이 여러개인 경우
v3 <- replace(v2,c(1,2,3),c(11,22,33))

# append() : concat처럼 두 배열을 합치는 기능
v4 <- append(v2,v3)
append(v2,v3, after=1) # 1번 인덱스 이후 v3 를 추가해라.

# 한 줄에 두가지 문장이 있을 경우 ; 으로 구분을 줄 수 있다.
v2;v3

# 집합(set)

# 합집합(Union) - 중복 포함
union(v2,v3)
# 교집합(intersect) - 중복만 포함
intersect(v2,v3)
# 차집합(setdiff) - 서로 같지 않은 것만
setdiff(v2,v3)
# setequal() - 집합이 같은지 판별
setequal(v2,v3)

# 문자열 -> 합쳤을 경우 벡터로 저장
str <- paste("hello","R","welcome",sep = "_")


# strsplit() : 문자열을 특정한 구분자로 분리
vec <- strsplit('hello my name is kim',' ')
vec
class(vec)

#substring() : 문자열의 특정 영역을 자를 때 
str <- '123456789'
substring(str,2,5) # 2번째 문자열 전까지 자르는데.. 3번 4번 5번까지

#grep(): 특정 문자열 찾아내기(리눅스 명령어)
str <- c('JAVA','HTML','CSS','JS','J-Query','Oracle','JSP','MVC','SPRING','R')
grep('J',str) # str 변수 내에 J가 들어가는 인덱스 반환

# 기타 기능들...
# 1~100 까지 무작위로 숫자 뽑아내기
x <- sample(1:100,10)

# 찾는 값이 어디에 있는지 추출
match(x,25)


