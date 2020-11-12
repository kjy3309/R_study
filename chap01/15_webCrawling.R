library('rvest')

url <- 'https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001'

# 만약 한글로 된 사이트일 경우 한글이 깨지거나, 못 불러오면.. encoding을 CP-949로 바꿔줘야 함
html_source <- read_html(url, encoding = "CP-949")
html_source


# 뉴스제목, 뉴스링크, 미디어를 하나의 data.frame 으로 만들기


link <- html_source %>% html_nodes('.type06_headline a') %>% html_attr('href')
link
media <- html_source %>% html_nodes('.writing') %>% html_text()
media
subject <- html_source %>% html_nodes('.type06_headline a') %>% html_text()
subject


# 링크
list <- html_nodes(html_source,"#main_content .type06_headline dt:not(.photo)")
list

# html_attr : 특정 속성의 값을 가져온다.
link <- html_nodes(list,"a") %>% html_attr("href")
link


#제목 , html_text : 태그 하위 텍스트를 가져옴
# gusb ('대상문자',' 변강내용', '대상 문구') : 문자 치환
title <- html_nodes(list,"a") %>% html_text()
title <-gsub('\t','',title)
title <-gsub('\r\n','',title)
title <-gsub(',','',title)
title

# 미디어
pub <- html_nodes(html_source,"#main_content .type06_headline dd span.writing") %>%
  html_text()
pub

news <- data.frame(link,title,pub)
View(news)

# write.csv(news,'C:/RR/data/ch01/news.csv')
write.table(news,file = 'C:/RR/data/ch01/news.csv',
            append = TRUE, row.names = FALSE, col.names = TRUE, 
            quote = FALSE, sep = ',')