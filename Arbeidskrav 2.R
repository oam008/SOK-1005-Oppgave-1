library(ggplot2)
library(tidyverse)
library(dplyr)
library(jsonlite)

#Laster inn data fra URL

jasondata <- "https://static01.nyt.com/newsgraphics/2021/12/20/us-coronavirus-deaths-2021/ff0adde21623e111d8ce103fedecf7ffc7906264/scatter.json"

df_covid <- fromJSON(jasondata)

#OPPGAVE 1

#Lager en ekstra kolonne med antall vaksinerte i prosent

df_covid <- df_covid %>%
  mutate(vaccinated = fully_vaccinated_pct_of_pop*100)

#Lager en ny kontolle med forkortelse av stater

df_covid <- df_covid %>%
  mutate(state = abbreviate(df_covid$name))

#Lager et scatter plot som repliserer figuren i oppgaven

df_covid %>%
  ggplot(aes(x = vaccinated, y = deaths_per_100k)) + geom_point() + 
  #Legger til titler
  labs(title = "Covid-19 deaths since universal adult vaccine eligibility compared with vaccination rates", x = "Share of total population fully vaccinated", y = "monthly deaths per 100,000") + 
  #Legger til navn på stater
  geom_text(aes(label = state), size = 2, adj = -0.3) + 
  #Lager piler
  geom_segment(aes(x = 55, y = 20, xend = 54, yend = 20.5), arrow = arrow(length = unit(0.2, "cm"))) + 
  geom_segment(aes(x = 75, y = 9, xend = 76, yend = 8.5), arrow = arrow(length = unit(0.2, "cm"))) +
  #Lager tekst til pilene
  annotate( "text", x = 75, y = 10, label = "Higher vaccination rate, lower death rate") + 
  annotate( "text", x = 60, y = 20, label = "Lower vaccination rate, higher death rate")


#OPPGAVE 2

#Bruker lm-funksjonen
lm(deaths_per_100k ~ vaccinated, date = df_covid)

#Kopierer ggplotet fra oppgave 1
df_covid %>%
  ggplot(aes(x = vaccinated, y = deaths_per_100k)) + geom_point(aes(colour = name)) + 
  #Legger til geom_smooth
  geom_smooth(method = lm) + 
  labs(title = "Covid-19 deaths since universal adult vaccine eligibility compared with vaccination rates", x = "Share of total population fully vaccinated", y = "monthly deaths per 100,000") +
  geom_text(aes(label = state), adj = -0.2) +
  geom_segment(aes(x = 55, y = 20, xend = 54, yend = 20.5), arrow = arrow(length = unit(0.2, "cm"))) + 
  geom_segment(aes(x = 75, y = 9, xend = 76, yend = 8.5), arrow = arrow(length = unit(0.2, "cm"))) +
  annotate( "text", x = 75, y = 10, label = "Higher vaccination rate, lower death rate") + 
  annotate( "text", x = 60, y = 20, label = "Lower vaccination rate, higher death rate")


# Nede til høyre er dødsraten lav, og vaksinasjonsraten høy. Oppe til venstre er vaksinasjonsraten lav og dødsraten høy.
# Den blå linjen viser en lineær funksjon som viser forholdet mellom vaksinasjonsraten og dødsraten.
# Jo høyere vaksinasjonsrate, desto lavere dødsrate og vice versa. 
  
