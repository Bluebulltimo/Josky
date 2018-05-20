library(readr)
data08_09 <- read_csv("~/Premier League Data/data08-09.csv")
View(data08_09)
subset_A <- data08_09[,c('home_team','away_team','result')]
View(subset_A)