#my_function <- function() {}
 roll <-function(die = 1:6) {
   dice <- sample(die,size=2,replace=TRUE)
   sum(dice)
 }

roll
roll()

rolls <- replicate(100000, roll())
qplot(rolls, binwidth =1)




