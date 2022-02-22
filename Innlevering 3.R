#Innlevering 3

#Installere og hente pakker

library(rvest)
library(tidyverse)

#Oppgave 1

#Skrap tabellen fra nettsiden

url <- read_html("https://www.motor.no/aktuelt/motors-store-vintertest-av-rekkevidde-pa-elbiler/217132")
rekkevidde_table <- html_table(html_nodes(url, "table")[[1]], header = TRUE)
rekkevidde_table



#Rydde datasettet for unødvendig informasjon

rekkevidde_table <- rekkevidde_table[-c(19, 26),]

#Gir kolonnene nye navn og gjør de numeriske

colnames(rekkevidde_table) <- c("Modell", "WLTP", "Stopp", "Avvik")
rekkevidde_table$Stopp <- substr(rekkevidde_table$Stopp, 0, 3) %>% 
  as.numeric(rekkevidde_table$Stopp) 
rekkevidde_table$WLTP <- substr(rekkevidde_table$WLTP, 0, 3) %>% 
  as.numeric(rekkevidde_table$WLTP)


#Lager plot

rekkevidde_table %>%
  ggplot(aes(x = WLTP, y = Stopp)) + geom_point() +
  labs(title = "Rekkevidde på el-bil", x = "WLTP", y = "Stopp") +
  geom_abline(intercept = 0, slope = 1, col="red")+
  xlim(200, 600) + ylim(200, 600)
rekkevidde_table


#Oppgave 2

lm(Stopp ~ WLTP, data=rekkevidde_table)

#Vi ser at WLTP-tallet (som også er stigningstallet) er 0,87. 
#Det vil si at den faktiske rekkevidden er 87% av den reklamerte rekkevidden. 
# -26,645 er skjæringspunktet mellom y-aksen og funksjonen, og vi finner den faktiske rekkevidden
#for hver bil ved å gange den reklamerte rekkevidden for hver bil med 0,8671, og trekke fra 26,645. 
#Funksjonen viser oss altså korrelasjonen mellom faktisk rekkevidde og reklamert rekkevidde.

rekkevidde_table %>% ggplot(aes(x=WLTP, y= Stopp)) +
  geom_point() +
  geom_smooth(method=lm)  +
  labs(title= "Rekkevidde på el-bil", 
       x= "WLTP", 
       y= "Stopp") 


