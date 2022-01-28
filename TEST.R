install.packages("readr")
library(readr)
library(ggplot2)

lower_troposphere
view(lower_troposphere)

l_t <- head(lower_troposphere, - 12)

l_t

l_t$new.group <- paste(l_t$Year, l_t_Mo)

view(l_t)




