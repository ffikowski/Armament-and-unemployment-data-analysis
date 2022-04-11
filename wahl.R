library(foreign)
library(dplyr)
library(lmtest)
library(car)
library(sandwich)
library(AER)
library(plm)
library(ggplot2)
library(gplots)
library(ggpubr)

#Analse der Wahldaten:

wahl <- read.csv(file="C:/Users/Felix/Documents/Studium/Bachelorarbeit Papadia/Unemployment data/Unemployment data/wahlfinal.csv")

detach(wahl)
attach(wahl)

wahl$treatment <- ifelse(wahl$treatment == 1, 'treatment',"nontreatment")

#Verhältnis NSDAP-Stimmen zu Anzahl der Wahlberechtigten 1933:
wahl$NSDAP33 <- wahl$n333nsda / wahl$n333wb


#Verhältnis NSDAP-Stimmen zu Anzahl der abgegebenen Stimmen 1933:
wahl$NSDAP33AS <- wahl$n333nsda / wahl$n333as

#Verhältnis NSDAP-Stimmen zu Anzahl der Wahlberechtigten 1932
wahl$NSDAP32 <- wahl$n32nnsda / wahl$n32nwb

#Verhältnis NSDAP-Stimmen zu Anzahl der abgegebenen Stimmen 1932:
wahl$NSDAP32AS <- wahl$n32nnsda / wahl$n32nas


wahl1 <- wahl %>% select(NSDAP33, NSDAP33AS, NSDAP32, NSDAP32AS, treatment)
wahl1
is.factor(wahl1$treatment)
wahl1$treatment <- as.factor(wahl1$treatment)
is.factor(wahl1$treatment)


xtable(summarize(wahl1, type = "numeric", group = "treatment", quantiles = FALSE))

detach(wahl)


