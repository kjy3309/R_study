install.packages('plotly')

#plotly : 그래프 그리는 라이브러리
library(plotly)
library(htmlwidgets) #htmlwigets : plotly 그래프를 html 로 저장

View(economics) # 연도별 실업율
## plot_ly(data,x,y)
e <- plot_ly(economics,x=~date,y=~unemploy)
e
e <- add_paths(e) # 점이 찍힌 순서대로 이어지는 그래프
add_lines(e) # 가까운 점간 이어지는 선을 그린 그래프프

# 라이브러리 폴더를 한 파일처럼 취급
saveWidget(e,'./p1.html',selfcontained = T)

# 라이브러리 폴더를 따로 취급 (그래프 간 공유해서 사용 가능)
saveWidget(e,'p1.html',libdir = 'lib')


# 마커 설정
mpg


subplot(
  plot_ly(mpg,x=~cty,y=~hwy, name = 'default'),
  plot_ly(mpg,x=~cty,y=~hwy) %>%
    add_markers(alpha=0.2, name='alpha')
)

p <- plot_ly(mpg,x=~cty, y=~hwy, alpha = 0.5)

# factor 는 구성되는 숫자의 갯수가 적고 명확해야 할 때 사용
subplot(
  add_markers(p,color = ~cyl) %>% colorbar(title='viridis'),
  add_markers(p,color = ~factor(cyl))
)

# 그래프 색상바 추가
col1 <- c('#132B43', '#56B1F7') # 두 사이의 색상 영역 지정
col2 <- viridisLite::inferno(10) # 10가지 색상 임의 추출
col3 <- colorRamp(c('red','white','blue')) # 3가지 색상을 기준으로

# subplot 을 통해 위의 색상을 이용, 3가지 그래프를 그리기기

subplot(
  add_markers(p,color=~cyl, colors=col1) %>% colorbar(title="default"),
  add_markers(p,color=~cyl, colors=col2),
  add_markers(p,color=~cyl, colors=col3)
) %>% hide_legend()

p <- plot_ly(mpg,x=~cty, y=~hwy, alpha = 0.3) 
p
# 마커 모양을 실린더 값에 따라 랜덤으로 대입
add_markers(p,symbols=~cyl, name='A single trace')


# 점 모양 설정(0~25)
# 복수 설정 할 수 있다.

# 단수 설정
add_markers(p,symbol=I(18))

# 테두리 색상
add_markers(p,symbol=I(18),stroke=I('black'), span=I(1))

# 점의 사이즈 조정
subplot(
  add_markers(p,size=~cyl, name='default'),
  add_markers(p,size=~cyl, sizes=c(1,500), name='limit')
)
