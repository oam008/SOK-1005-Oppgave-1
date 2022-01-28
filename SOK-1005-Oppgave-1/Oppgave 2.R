install.packages("readr")
install.packages("zoo")
install.packages("lubridate")
library(readr)
library(ggplot2)
library(scales)
library(zoo)
library(lubridate)
library(dplyr)
library(tidyr)




lower_troposphere <-
  lower_troposphere %>%
  select(Year, Mo, NoPol) %>%
  rename(lowertrop = NoPol)

mid_troposphere <-
  mid_troposphere %>%
  select(NoPol) %>%
  rename(midtrop = NoPol)

tropopause <-
  tropopause %>%
  select(NoPol) %>%
  rename(tropop = NoPol)

lower_stratosphere <-
  lower_stratosphere %>%
  select(NoPol) %>%
  rename(lowerstrat = NoPol)

combined <- cbind(lower_troposphere, mid_troposphere, tropopause, lower_stratosphere)

df_combined2 <- head(combined, - 12)

df_combined2 <-
  df_combined2 %>%
  mutate(date = ymd(paste(Year, Mo, 1, sep = "-")))

df_combined2 <- df_combined2[-c(1,2)]

df_combined2 %>%
  pivot_longer(-date,
               names_to = "level",
               values_to = "temeprature")

df_combined2 %>%
  pivot_longer(-date,
               names_to = "level",
               values_to = "temperature") %>%
ggplot(df_combined2, mapping = aes(x = date, y = as.numeric(temperature), color = level)) + geom_line() + xlab("Year") + ylab("Temperature in deg. C")

