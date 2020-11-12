##matrix : 2차원 배열 형태
# 매트릭스 생성
mat <- matrix(1:12)
mat
mat <- matrix(1:12, nrow = 3) # 3행 형태태
mat
mat <- matrix(1:14, nrow = 3) # 행과 열은 모두 채워져 있어야 한다.

mat <- matrix(1:24, ncol=3)
mat

ncol(mat) # 해당 열의 갯수수
nrow(mat) # 해당 행의 갯수수

# 벡터를 행열로 합치기
v1 <- c(1:10)
v2 <- c(11:20)
v3 <- c(21:30)
cbind(v1,v2,v3) # 각 벡터가 각각의 열이 된다.
rbind(v1,v2,v3) # 각 벡터가 하나의 행이 된다.

# 행들의 평균
rowMeans(mat)
# 열들의 평균
colMeans(mat)
# 행열의 전체 평균
mean(mat)

# t(mat) -> # 행과 열을 바꿔준다.
mat
# 특정한 인덱스 값 불러내기
mat[2][1]
mat[2,]
mat[2,1:3]
