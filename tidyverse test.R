library(tidyverse)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

View(filter(mpg, cyl == 8))

View(filter(diamonds, carat > 3))
