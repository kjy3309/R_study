install.packages('XML')
library('XML')

# XML -> data.frame
xm12df <- xmlToDataFrame('./data/input.xml')
View(xm12df)
