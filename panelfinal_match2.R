library(foreign)
library(dplyr)
library(lmtest)
library(car)
library(sandwich)
library(AER)
library(plm)
library(ggplot2)
library(gplots)
library(sjPlot)
library(sjmisc)
library(sjlabelled)

#Regression erneut mit gematchten Gemeinden:

panelmatch2 <- read.csv(file="C:/Users/Felix/Documents/Studium/Bachelorarbeit Papadia/Unemployment data/Unemployment data/rpanelyearly2.csv")

attach(panelmatch2)

panelmatch2$aircraft <- panelmatch2$aircraft / 1000

fixed.time.yearly2 <- plm(tot_unt_Arbeitslose_Einw ~ aircraft + factor(YEAR), data=panelmatch2, index=c("Gemeinde", "YEAR"), model="within")
summary(fixed.time.yearly2)
fixef(fixed.time.yearly2)

x2 <- coeftest(fixed.time.yearly2, vcovHC)
coeftest(fixed.time.yearly2, vcov=vcovHC(fixed.time,type="HC0",cluster="group"))
tab_model(fixed.time.yearly2, show.se = TRUE,show.stat = TRUE,collapse.se = TRUE, p.style = "stars")

stargazer(x2)

texreg(x1)


detach(panelmatch2)
