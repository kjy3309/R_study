# Rserve 설치
# https://cran.rstudio.com/bin/windows/contrib/4.0/Rserve_1.7-3.1.zip
# 압축 풀고 C:\Program Files\R\R-4.0.1\library\ 에 압축 푼 폴더(Rserve) 붙여넣기

install.packages('rJava')
install.packages('RJDBC')
install.packages('Rserve')
install.packages('DBI')

library(Rserve)
Rserve(args = 'RS-encoding utf8') # R에서 실행시키면 에러로그를 볼 수 없다.
# 그래서 실행은 cmd에서 진행
# c:\Program Files\R\R-4.0.1\library\Rserve\libs\x64 의 3개 파일 복사
# C:\Program Files\R\R-4.0.1\bin\x64 에 붙여넣기

# cd C:\Program Files\R\R-4.0.1\bin\x64 <- 이 과정이 귀찮으면 환경설정 할 것
# Rserve --RS-encoding utf8