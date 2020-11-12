# https://www.mapbox.com 가입
Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1Ijoic2VpbGl1cyIsImEiOiJja2RzZmZmaWwwejJvMnhwYnA1Mm1kZXlkIn0.A8nY74lYX6WyjoSLUPXOsg')

library(plotly)
library(readxl)
library(dplyr)

excel <- read_excel('./data/ch03/cycle.xlsx',sheet=1)
View(excel)

map <- plot_mapbox(excel) %>%
  add_markers(
    x=~long,
    y=~lat,
    color=~area, # 구별 색상 변경
    size=~holder, # 거치대 개수에 따라 점 크기 변경
    text =~paste(store_name, '(',holder,'개)'), # 텍스트 내용
    hoverinfo = 'text' #마우스 오버 시 보여줄 내용
  )

# 초기 위치 변경, 줌 변경
m <- map %>% layout(
  title = '따릉이 정류소 현황',
  mapbox =list(
    zoom = 10,
    center = list(lon=127,lat=37.5)
  )
)

library(htmlwidgets)
saveWidget(m, './map.html',selfcontained = TRUE)

?add_markers


# map 스타일을 변경할 수 있다.
# basic, satellite, open-street-map, white-bg, carto-position
# carto-darkmatter, stamen-terrian, staman-toner, stamen-watercolor
map %>% layout(
  title = '따릉이 정류소 현황',
  mapbox =list(
    zoom = 10,
    center = list(lon=127,lat=37.5),
    style='stamen-terrian'
  )
)

# 공중 화장실

ex <- read_excel('./data/ch03/wc.xls')
View(ex)
head(ex)
ex$`좌표[X]
(조건부 선택 입력)`
ex$`좌표[Y]
(조건부 선택 입력)`
# 공중 화장실 구별로 색상 변경하여 좌표에 마커 찍기
# 마우스 오버 시 해당 화장실 이름 출력

ex <- rename(ex,화장실위치=`콘텐츠명
(필수 입력)`)

ex <- rename(ex,지역구=`구명
(선택입력)`)

View(ex)

plot_mapbox(ex) %>%
  add_markers(
    x=~`좌표[X]
(조건부 선택 입력)`,
    y=~`좌표[Y]
(조건부 선택 입력)`,
    color=~지역구, # 구별 색상 변경
    text =~화장실위치,
    hoverinfo = 'text' #마우스 오버 시 보여줄 내용
  )



dat <- ex %>% select('콘텐츠명\n(필수 입력)','구명\n(선택입력)',
  '좌표[X]\n(조건부 선택 입력)','좌표[Y]\n(조건부 선택 입력)') %>%
  rename(name='콘텐츠명\n(필수 입력)', area='구명\n(선택입력)',
          lon='좌표[X]\n(조건부 선택 입력)',lat='좌표[Y]\n(조건부 선택 입력)')

data <- dat %>% filter(!is.na(area)) %>% filter(!is.na(lon)) %>% filter(!is.na(lat))
View(data)

plot_mapbox(data) %>%
  add_markers(
    x=~lon,
    y=~lat,
    color=~area,
    text=~name,
    hoverinfo='text'
  ) %>% layout(mapbox=list(
    zoom=10, center=list(lon=127, lat=37.5)
  ))
