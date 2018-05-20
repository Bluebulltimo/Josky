library("ggplot2")
View(ggplot2::mpg)
#plot hwy versus displ with class as color
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy,color = class))
#plot hwy versus cyl
ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = hwy))