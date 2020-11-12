install.packages('dplyr')
library('dplyr')

df_data <- data.frame(
  var1 = c(20200901,20200902,20200903),
  var2 = c(500,600,650)
)

df_data

new_df <- df_data

new_df <- rename(new_df,date=var1, cnt=var2)
new_df

# 새로운 변수

new_df$score <- c(70,80,90)

new_df$total <- new_df$cnt + new_df$score

new_df
