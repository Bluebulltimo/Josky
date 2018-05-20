#5. DATA TRANSFORMATION.
library("nycflights13")
library("tidyverse")

#dplyr Basics
#1. Find all flights that:
  #a. Had an arrival delay of two or more hours
     filter(flights, arr_delay >= 2)
     
  #b. Flew to Houston (IAH or HOU)
     filter(flights, dest %in% c('IAH','HOU'))
  
  #c. Were operated by United, American, or Delta
     airlines #shows full names of the airlines
     filter(flights, carrier %in% c('UA','AA','DL'))
     
  #d. Departed in summer (July, August, and September)
     filter(flights,month %in% c(7,8,9))
     
  #e. Arrived more than two hours late, but didn't leave late
     #!(x & y) is the same as !x | !y
     #!(x | y) is the same as !x & !y // 
     filter(flights, !(!(arr_delay > 2) | !(dep_delay <= 0)))
     filter(flights, arr_delay > 2 & dep_delay <= 0)
     filter(flights, !(arr_delay <= 2 | dep_delay > 0))

  #f. Were delayed by at least an hour, but made up over 30 minutes in flight
  	 filter(flights, dep_delay >= 1 & air_time > 30)

  #g. Departed between midnight and 6 a.m. (inclusive)
  	 filter(flights, dep_time %in% c(1:600,2400)) 
  	 
#2. Another useful dplyr filtering helper is between(). What does it do?
  	#Can you use it to simplify the code needed to answer the previous
  	#challenges?
  	 
#3. How many flights have a missing dep_time? What other variables are
  	 #missing? What might these rows represent?
  	 flights %>% filter(is.na(flights$dep_time))
  	 dep_time_na <- flights %>% filter(is.na(flights$dep_time))
  	 glimpse(dep_time_na)
  	 #show cols with Na and their numbers
  	 colSums(is.na(flights)>0)
  	 
#4. Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is
  	 #FALSE & NA not missing? Can you figure out the general rule? (NA * 0
  	 #is a tricky counterexample!)


#Arrange Rows with arrange()
#1. How could you use arrange() to sort all missing values to the start?
#(Hint: use is.na().)
	names(flights)[colSums(is.na(flights)) > 0] #get names of cols with Na
	arrange(flights, desc(is.na(dep_time)),is.na(dep_delay),is.na(arr_time),is.na(tailnum),is.na(air_time))
  	 
#2. Sort flights to find the most delayed flights. Find the flights that left
#earliest.
	arrange(flights, dep_delay) #flights that left earliest
	arrange(flights, desc(dep_delay)) #most delayed flights

#3. Sort flights to find the fastest flights.
	arrange(flights, air_time) #the fastest
	arrange(flights, desc(air_time)) #took longest in the air

#4. Which flights traveled the longest? Which traveled the shortest?
	arrange(flights, distance) #traveled shortest distance
	arrange(flights, desc(distance)) ##traveled longest distance

#Select Columns with select()
#1. Brainstorm as many ways as possible to select dep_time, dep_delay,
#arr_time, and arr_delay from flights.
	flights %>% select(contains('time'), contains('delay'))
	flights %>% select(starts_with('dep'), starts_with('arr'))

#2. What happens if you include the name of a variable multiple times in a
#select() call?
	flights %>% select(year, year, year)

#3. What does the one_of() function do? Why might it be helpful in
#conjunction with this vector?
	vars <- c("year", "month", "day", "dep_delay", "arr_delay")
	flights %>% select(one_of(vars))
	
#4. Does the result of running the following code surprise you? How do the
#select helpers deal with case by default? How can you change that
#default?
	select(flights, contains("TIME"))
	select(flights, contains("TIME", ignore.case = FALSE))

#1. Currently dep_time and sched_dep_time are convenient to look at, but
#hard to compute with because they are not really continuous numbers.
#Convert them to a more convenient representation of number of minutes
#since midnight.
	flights_sml <- flights %>% select(year:day,contains('dep'),contains('time'))

	convert2mins <- function(x) {
		
  		x = (x%/%100 * 60) + (x%%100)
	}

	(flights_sml <- flights_sml %>%  mutate(dep_time = convert2mins(dep_time), sched_dep_time = convert2mins(sched_dep_time) ))

#2. Compare air_time with arr_time - dep_time. What do you expect to
#see? What do you see? What do you need to do to fix it?
	flights_sml %>% mutate (diff_time = arr_time - dep_time, air_time = convert2mins (air_time)) 