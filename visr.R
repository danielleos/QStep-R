#!usr/bin/r

#clean up
rm(list=ls())

#load package
library(foreign)

#to install new package -- need new version of R...
#install.packages("car")
#to use library
#library(car)

#load data
healthFin = read.dta("http://j.mp/HEALTHfinance")
#write data as csv file
write.csv(healthFin, "~/Downloads/healthFin.csv")

#quick descriptives
hfSum = summary(healthFin)

### Bar Graphs ###

#create subset of lobbying data
partRates = subset(healthFin, select=c(partratetotalhealth, partratedpc, partratepharmprod, partrateprofessionals, partrateadvo, partratebusness, partrategov, rnmedschoolpartrate))

#test subset for finding rows and columns by dimensions of dataset
#testSub = healthFin[c(1:3),c(4:6,9:13)]

#compute the means of variables (aka columns)
#1 = rows, 2 = columns
lobbyMeans = apply(partRates, 2, mean)

#add names for variables
names(lobbyMeans) = c("Total Health Care", "Direct Patient Care", "Drugs/Health Products", "Health Professionals", "Health Advocacy", "Health Finance", "Local Government", "Health Education")

#actual barplot
par(mar=c(5.1, 10, 4.1, 2.1))

#cex = character expansion
#las = label reading, 1 = L to R
Ylabs = barplot(lobbyMeans, xlab="Percent Lobby Registration", xlim=c(0,26),horiz=T, cex.names=0.8, las=1)
box()
text(x=lobbyMeans, y=Ylabs, labels=paste(round(lobbyMeans,2)), pos=4)

### Scatterplots ###

plot(y=healthFin$partratebusness, x=healthFin$supplybusiness, ylab="Lobby Participation Rate", xlab="Number of Health Establishments")
