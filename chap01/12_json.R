# jsonlite : json 파일 불러오는 패키지
# httr : 다른 URL 에 있는 자원 가져오는 패키지
install.packages('jsonlite')
install.packages('httr')

library('jsonlite')
library('httr')

# 로컬 파일에 있는 json 불러오기
result <- fromJSON('./data/input.json')

# 불러온 데이터를 data.frame 으로 변환
s2df <- as.data.frame(result)
View(s2df)

# 온라인에 있는 json 불러오기
url <- 'https://api.github.com/users/hadley/repos'
json2df <- as.data.frame(fromJSON(url))
View(json2df)

# tojson(data.frame > json)
json_result <- toJSON(json2df)

#prettify 는 json 을 예쁘게 보이게 해줌.. indent 는 들여쓰기기
prettify(json_result, indent = 4)

# json 에서 data.frame 으로 변경되기 위해서는 기본 데이터 틀이 맞아야 한다.