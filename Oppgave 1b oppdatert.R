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

lower_troposphere <- read_table("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")
mid_troposphere <- read_table("http://vortex.nsstc.uah.edu/data/msu/v6.0/tmt/uahncdc_mt_6.0.txt")
tropopause <- read_table("http://vortex.nsstc.uah.edu/data/msu/v6.0/ttp/uahncdc_tp_6.0.txt")
lower_stratosphere <- read_table("http://vortex.nsstc.uah.edu/data/msu/v6.0/tls/uahncdc_ls_6.0.txt")


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

df_combined <-head(combined, - 12)

df_combined <- %>%
  df_combined %>%
  mutate(date = ymd(paste(Year, Mo, 1, sep = "-")))

df_combined <- df_combined[-c(1,2)]
  
  
df_combined <- %>%
  pivot_longer(-date,
               names_to = "level",
               values_to = "temperature") %>%
  ggplot(df_combined, mapping = aes(x = date, y = as.numeric(temperature), color = level)) + geom_line() + xlab("Year") + ylab("Temperature in deg. C")
