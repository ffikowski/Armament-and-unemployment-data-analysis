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
library(broom)
library(xtable)
library(papeR)

#Analyse der Sozaildaten:

social <- read.csv(file="C:/Users/Felix/Documents/Studium/Bachelorarbeit Papadia/Unemployment data/Unemployment data/socialfinal.csv")

detach(social)
rm(treatment)
attach(social)

#prozentualer Anteil Industriearbeiter & Handwerker an der Bevölkerung:
social$perIndu <- social$c33indu / social$c33pop1

#prozentualer Anteil arbeitender Frauen an der Bevölkerung:
social$perwomen <- social$c33erwp / social$c33pop1

#prozentualer Anteil Arbeiter in der Landwirtschaft an der Bevölkerung:
social$perland <- social$c33land / social$c33pop1

#Verhältnis von Arbeitern in Industrie und Handwerk zu Erwerbstätigen:
social$ratioArbErw <- social$c33indu / social$c33erwp

#Partizipationsrate:
social$ratioErwPop <- social$c33erwp / social$c33pop1

#pruzentualer Anteil von Beamten an der Bevölkerung:
social$perBeamt <- social$c33beamt / social$c33pop1

#prozentualer Anteil Arbeiter:
social$perArb <- social$c33arbei / social$c33pop1

#Percentage Angestellte:
social$perAng <- social$c33angs / social$c33pop1

social$treatment
social$treatment <- ifelse(treatment == 1, 'Treatment',"nontreatment")
social$treatment
treatment
social1 <- social %>% select(c33pop1, perIndu, perwomen, perland, ratioArbErw, perBeamt, perArb, perAng, treatment)
social1
is.factor(social1$treatment)
social1$treatment <- as.factor(social1$treatment)
is.factor(social1$treatment)


xtable(summarize(social1, type = "numeric", group = "treatment", quantiles = FALSE))

