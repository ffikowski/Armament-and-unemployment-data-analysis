library(foreign)
library(dplyr)
library(lmtest)
library(car)
library(sandwich)
library(AER)
library(plm)
library(ggplot2)
library(gplots)


library(htmlwidgets)
library(webshot)

library(sjPlot)
library(sjmisc)
library(sjlabelled)
library(jtools)
library(stargazer)
library(texreg)

## Panelregression ##

#einspielen der Daten

panelyearly <- read.csv(file="C:/Users/Felix/Documents/Studium/Bachelorarbeit Papadia/Unemployment data/Unemployment data/rpanelyearly.csv")

attach(panelyearly)

summary(panelyearly)
sd(aircraft)
sd(tot_unt_Arbeitslose_Einw)
mean(tot_unt_Arbeitslose_Einw)

#Einheiten in tsd RM werden in Mil. RM umgerechnet:

panelyearly$aircraft <- panelyearly$aircraft / 1000

#Regressionsmodell

fixed.time.yearly <- plm(tot_unt_Arbeitslose_Einw ~ aircraft + factor(YEAR), data=panelyearly, index=c("Gemeinde", "YEAR"), model="within")

#Reg. ohne clustered SE.

summary(fixed.time.yearly)
fixef(fixed.time)

#mit clustered SE

coeftest(fixed.time.yearly, vcovHC)
x1 <- coeftest(fixed.time.yearly, vcov=vcovHC(fixed.time.yearly,type="HC0",cluster="group"))
x1
tab_model(fixed.time.yearly, show.se = TRUE,show.stat = TRUE,collapse.se = TRUE, p.style = "stars")

stargazer(x1)
texreg(x1)


detach(panelyearly)
