##factor : 카테고리, 영역을 의미
# vector 와 모양은 같지만 속성은 다르다.
vec <- c(8,8,9,2,3,3,4,5,1,5,6,8,0)
vec

#factor -> vector 에서 중복을 제거하고, 정렬한다.
factor(vec)
factor(vec,levels = c(1:5))
# levels 를 오름차순으로 정렬
factor(vec,levels = c(1:5),ordered = T)

#value 와 levels 를 같이 보여준다.
f <- factor(c('a','b','c','d','1','2','2','4','3','3'))
f
lv <- levels(f) #levels 만 따로 추출출
class(f)
class(lv)
nlevels(f) # f 안의 levels 갯수
summary(f) # 각 레벨의 값들이 몇개씩 들어있나
