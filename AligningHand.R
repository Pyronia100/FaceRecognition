# R Code for aligning hand

#Read the data in
setwd("D:/Maths Project/Resources/Practicals/Intro to Shape Analysis")
mydata <- read.table("shapes.txt",header = FALSE, sep = "" ,col.names = seq(1,40))
#Load Shapes Package
library(shapes)
#Split X and Y Coords
mydatax <- mydata[1:56,]
mydatay <- mydata[57:112,]
#Plot 1 Hand
plot(mydatax[,1],mydatay[,1])
lines(mydatax[,1],mydatay[,1])
#Plot Centroid
plot(mydatax[,1],mydatay[,1], xlab =  'Hand 1 X Coordinates', ylab =  'Hand 1 y Coordinates', main = 'Centroid of Hand')
lines(mydatax[,1],mydatay[,1])
centroid = c(mean(mydatax[,1]),mean(mydatay[,1]))
for (i in seq(1,56)){
  lines(c(mydatax[i,1],centroid[1]),c(mydatay[i,1],centroid[2]),lty = 'dotted',col = 2)
}
points(centroid[1],centroid[2], col = 1, pch = 16)
text(centroid[1],centroid[2], labels='Centroid', adj = -0.5, cex = 0.8, col = 1)
#Plot 2 Hands on Plots next to Each Other
par(mfrow=c(1,2))
plot(mydatax[,1],mydatay[,1], xlab =  'Hand 1 X Coordinates', ylab =  'Hand 1 y Coordinates', main = 'Hand 1' )
text(mydatax[,1], mydatay[,1], labels=seq(1,56), adj = -1, cex = 0.8, col = 2)
lines(mydatax[,1],mydatay[,1])
plot(mydatax[,5],mydatay[,5], xlab =  'Hand 2 X Coordinates', ylab =  'Hand 2 y Coordinates', main = 'Hand 2' )
text(mydatax[,5], mydatay[,5], labels=seq(1,56), adj = -1, cex = 0.8, col = 2)
lines(mydatax[,5],mydatay[,5])
#Plot All Hands
for (i in seq(1,40)){
  plot(mydatax[,i],mydatay[,i])
  lines(mydatax[,i],mydatay[,i])
}

#Remove Means
mydataxlessmeans <- mydatax - colMeans(mydatax)
mydataylessmeans <- mydatay - colMeans(mydatay)

#Normalise
Normalisation <- (colSums(sqrt((mydataxlessmeans^2 + mydataylessmeans^2))))
zspacex <- mydataxlessmeans/Normalisation
zspacey <- mydataylessmeans/Normalisation


library(plyr)
# zx <- data.matrix(zspacex)
# zy<- data.matrix(zspacey)
# 
# b <- cbind(zx[,1],zy[,1])
# for (i in seq(2,40)){
#   a <-cbind(zx[,i],zy[,i])
#   b <- cbind(b,a)
# }
# dim(b)
# dim(b) <- c(56,2,40)
# mean <- procGPA(b)$mshape
# plot(mean[,1],mean[,2])
# lines(mean[,1],mean[,2])

#Above not needed turns out procgpa automatically normalises

#Put data into right shape
x <- data.matrix(mydatax)
y<- data.matrix(mydatay)  
c <- cbind(x[,1],y[,1])
for (i in seq(2,40)){
  d <-cbind(x[,i],y[,i])
  c<- cbind(c,d)
}
dim(c) <- c(56,2,40)

#Apply Proc
mean2 <- procGPA(c)$mshape
#Plot Mean shape
plot(mean2[,1],mean2[,2])
lines(mean2[,1],mean2[,2])

procrustes<- procGPA(c)
hist(procrustes$pcasd) #Scree Plot

#Varying Plot
plot(mydatax[,1],mydatay[,1])
for (i in seq(2,40)){
  points(mydatax[,i],mydatay[,i])
}

#Varying Plot
plot(procrustes$rotated[,1,1],procrustes$rotated[,2,1])
for (i in seq(2,40)){
  points(procrustes$rotated[,1,i],procrustes$rotated[,2,i])
}
lines(mean2[,1],mean2[,2])
