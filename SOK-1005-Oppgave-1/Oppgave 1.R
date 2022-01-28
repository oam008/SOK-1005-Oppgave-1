install.packages("readr")
install.packages("zoo")
install.packages("lubridate")
library(readr)
library(ggplot2)
library(scales)
library(zoo)
library(lubridate)
library(dplyr)

lower_troposphere

l_t <- head(lower_troposphere, - 12)

l_t <-
  l_t %>%
  mutate(dato = ymd(paste(Year, Mo, 1, sep = "-")))

l_t

l_t <-
  l_t %>%
  select(dato, Globe) %>%
  mutate(cma = rollmean(as.numeric(Globe), 13, fill = NA, align = "center"))
 
  

GlobalTemps <- ggplot(l_t, aes(x = dato, y = as.numeric(Globe))) + geom_point(size = 0.5, col = "blue") + geom_line(group = 1, col = "blue") + geom_line(aes(y = cma), col = "red", lwd = 1.2) + scale_y_continuous(breaks = seq(-1,1, by = 0.1)) + ggtitle("UAH Satellite-Based Temperature of the Global Lower Atmosphere") + xlab("Year") + ylab("T Departure from '91-'20 Avg (deg. C)")
GlobalTemps
