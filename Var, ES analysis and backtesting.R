#Value at risk 
#Gaussian
#AMZN VaR
AMZN <- read.csv("AMZN.csv")
class(AMZN$Date)
date.AMZN<-as.Date(AMZN$Date,format="%Y-%m-%d")
AMZN<-cbind(date.AMZN,AMZN[,-1])
AMZN<-AMZN[order(AMZN$date),]
library(xts)
AMZN<-xts(AMZN[,2:7],order.by=AMZN[,1])
names(AMZN)<-paste(c("AMZN.Open","AMZN.High","AMZN.Low",
                     "AMZN.Close","AMZN.Adjusted","AMZN.Volume"))
head(AMZN)
AMZN.log.ret<-AMZN[,5]
AMZN.log.ret[c(1:3,nrow(AMZN.log.ret)),]
options(digits = 7)
AMZN.log.ret$AMZN.log.ret<-diff(log(AMZN.log.ret$AMZN.Adjusted))
head(AMZN.log.ret)
options(digits =3)
AMZN.log.ret<-AMZN.log.ret[,2]
head(AMZN.log.ret)
AMZN.ret<-AMZN.log.ret[-1]
head(AMZN.ret)
AMZN.mean<-mean(AMZN.ret)
AMZN.risk<-sd(AMZN.ret)
AMZN.mean
AMZN.risk
plot(AMZN.ret)
VaR01.Gaussian.AMZN<- -(AMZN.mean+AMZN.risk*qnorm(0.01))
VaR01.Gaussian.AMZN

VaR05.Gaussian.AMZN<- -(AMZN.mean+AMZN.risk*qnorm(0.05))
VaR05.Gaussian.AMZN

x2 <- seq(min(AMZN.ret), max(AMZN.ret), length = 40)
fun <- dnorm(x2, mean = mean(AMZN.ret), sd = sd(AMZN.ret))
hist(AMZN.ret, prob = TRUE, col = "white",
     ylim = c(0, max(fun)),
     main = "Histogram of AMZN returns",xlab="AMZN Returns")
lines(x2, fun, col = "blue", lwd = 1.5)
legend("topleft", legend=c("Normal Distribution"),
       col=c("blue"), lty=1:2, cex=0.8)


#TSLA VaR
TSLA <- read.csv("TSLA.csv")
class(TSLA$Date)
date.TSLA<-as.Date(TSLA$Date,format="%Y-%m-%d")
TSLA<-cbind(date.TSLA,TSLA[,-1])
TSLA<-TSLA[order(TSLA$date),]
library(xts)
TSLA<-xts(TSLA[,2:7],order.by=TSLA[,1])
names(TSLA)<-paste(c("TSLA.Open","TSLA.High","TSLA.Low",
                     "TSLA.Close","TSLA.Adjusted","TSLA.Volume"))
head(TSLA)
TSLA.log.ret<-TSLA[,5]
TSLA.log.ret[c(1:3,nrow(TSLA.log.ret)),]
options(digits = 7)
TSLA.log.ret$TSLA.log.ret<-diff(log(TSLA.log.ret$TSLA.Adjusted))
head(TSLA.log.ret)
options(digits =3)
TSLA.log.ret<-TSLA.log.ret[,2]
head(TSLA.log.ret)
TSLA.ret<-TSLA.log.ret[-1]
head(TSLA.ret)
TSLA.mean<-mean(TSLA.ret)
TSLA.mean
TSLA.risk<-sd(TSLA.ret)
TSLA.risk
VaR01.Gaussian.TSLA<- -(TSLA.mean+TSLA.risk*qnorm(0.01))
VaR01.Gaussian.TSLA

VaR05.Gaussian.TSLA<- -(TSLA.mean+TSLA.risk*qnorm(0.05))
VaR05.Gaussian.TSLA

hist(TSLA.ret)

#AAPL VaR
AAPL <- read.csv("AAPL.csv")
class(AAPL$Date)
date.AAPL<-as.Date(AAPL$Date,format="%Y-%m-%d")
AAPL<-cbind(date.AAPL,AAPL[,-1])
AAPL<-AAPL[order(AAPL$date),]
library(xts)
AAPL<-xts(AAPL[,2:7],order.by=AAPL[,1])
names(AAPL)<-paste(c("AAPL.Open","AAPL.High","AAPL.Low",
                     "AAPL.Close","AAPL.Adjusted","AAPL.Volume"))
head(AAPL)
AAPL.log.ret<-AAPL[,5]
AAPL.log.ret[c(1:3,nrow(AAPL.log.ret)),]
options(digits = 7)
AAPL.log.ret$AAPL.log.ret<-diff(log(AAPL.log.ret$AAPL.Adjusted))
head(AAPL.log.ret)
options(digits =3)
AAPL.log.ret<-AAPL.log.ret[,2]
head(AAPL.log.ret)
AAPL.ret<-AAPL.log.ret[-1]
head(AAPL.ret)
tail(AAPL.ret)
AAPL.mean<-mean(AAPL.ret)
AAPL.risk<-sd(AAPL.ret)
AAPL.mean
AAPL.risk
VaR01.Gaussian.AAPL<- -(AAPL.mean+AAPL.risk*qnorm(0.01))
VaR01.Gaussian.AAPL

VaR05.Gaussian.AAPL<- -(AAPL.mean+AAPL.risk*qnorm(0.05))
VaR05.Gaussian.AAPL

hist(AAPL.ret)
abline(v=c(-0.0635,-0.0326), col=c("blue", "red"), lty=c(2,2), lwd=c(3, 3))

#Portfolio VaR
port.ret<-(AMZN.ret+TSLA.ret+AAPL.ret)/3
port.ret[1:5]

port.mean<-mean(port.ret)
port.mean

port.risk<-sd(port.ret)
port.risk

VaR01.Gaussian<- -(port.mean+port.risk*qnorm(0.01))
VaR01.Gaussian

VaR05.Gaussian<- -(port.mean+port.risk*qnorm(0.05))
VaR05.Gaussian


x2 <- seq(min(port.ret), max(port.ret), length = 40)
fun <- dnorm(x2, mean = mean(port.ret), sd = sd(port.ret))
hist(port.ret, prob = TRUE, col = "white",
     ylim = c(0, 30),
     main = "Histogram of Portfolio returns",xlab="Portfolio Returns")
lines(x2, fun, col = "blue", lwd = 1.5)
legend("topleft", legend=c("Normal Distribution"),
       col=c("blue"), lty=1:2, cex=0.8)







#Historical
ret.data<-cbind(AMZN.ret[-1,],TSLA.ret[-1,],AAPL.ret[-1,]) 
ret.data[c(1:3,nrow(ret.data)),]


library(PerformanceAnalytics)
VaR01.Historical.AMZN<-VaR(AMZN.ret,p=0.99,method="historical")
VaR01.Historical.AMZN
VaR05.Historical.AMZN<-VaR(AMZN.ret,p=0.95,method="historical")
VaR05.Historical.AMZN

VaR01.Historical.TSLA<-VaR(TSLA.ret,p=0.99,method="historical")
VaR01.Historical.TSLA
VaR05.Historical.TSLA<-VaR(TSLA.ret,p=0.95,method="historical")
VaR05.Historical.TSLA

VaR01.Historical.AAPL<-VaR(AAPL.ret,p=0.99,method="historical")
VaR01.Historical.AAPL
VaR05.Historical.AAPL<-VaR(AAPL.ret,p=0.95,method="historical")
VaR05.Historical.AAPL

VaR01.Historical.Port<-VaR(port.ret,p=0.99,method="historical")
VaR01.Historical.Port
VaR05.Historical.Port<-VaR(port.ret,p=0.95,method="historical")
VaR05.Historical.Port

x2 <- seq(min(port.ret), max(port.ret), length = 40)
fun <- dnorm(x2, mean = mean(port.ret), sd = sd(port.ret))
hist(port.ret, prob = TRUE,col = "white",
     main = "Histogram of Portfolio returns",xlab="Portfolio Returns")
lines(x2, fun, col = 1, lwd = 2)

abline(v=c(-0.0635,-0.0326), col=c("blue", "red"), lty=c(2,2), lwd=c(3, 3))

legend("topleft", legend=c("Normal Distribution", "99% CI VaR = -0.0635","95% CI VaR = -0.0326"),
       col=c("black", "blue","red"), lty=c(1,2,2), cex=0.60)
 






#Gaussian Expected Shortfall
ES01.Gaussian.AMZN<-(AMZN.mean+AMZN.risk*(dnorm(qnorm(.01))/.01))
ES01.Gaussian.AMZN
ES05.Gaussian.AMZN<-(AMZN.mean+AMZN.risk*(dnorm(qnorm(.05))/.05))
ES05.Gaussian.AMZN

ES01.Gaussian.TSLA<-(TSLA.mean+TSLA.risk*(dnorm(qnorm(.01))/.01))
ES01.Gaussian.TSLA
ES05.Gaussian.TSLA<-(TSLA.mean+TSLA.risk*(dnorm(qnorm(.05))/.05))
ES05.Gaussian.TSLA

ES01.Gaussian.AAPL<-(AAPL.mean+AAPL.risk*(dnorm(qnorm(.01))/.01))
ES01.Gaussian.AAPL
ES05.Gaussian.AAPL<-(AAPL.mean+AAPL.risk*(dnorm(qnorm(.05))/.05))
ES05.Gaussian.AAPL

ES01.Gaussian.port<-(port.mean+port.risk*(dnorm(qnorm(.01))/.01))
ES01.Gaussian.port
ES05.Gaussian.port<-(port.mean+port.risk*(dnorm(qnorm(.05))/.05))
ES05.Gaussian.port


#Historical Expected Shortfall
ES01.Historical.AMZN<-ES(AMZN.ret, method="historical",p=0.99)
ES01.Historical.AMZN
ES05.Historical.AMZN<-ES(AMZN.ret, method="historical",p=0.95)
ES05.Historical.AMZN

ES01.Historical.TSLA<-ES(TSLA.ret, method="historical",p=0.99)
ES01.Historical.TSLA
ES05.Historical.TSLA<-ES(TSLA.ret, method="historical",p=0.95)
ES05.Historical.TSLA

ES01.Historical.AAPL<-ES(AAPL.ret, method="historical",p=0.99)
ES01.Historical.AAPL
ES05.Historical.AAPL<-ES(AAPL.ret, method="historical",p=0.95)
ES05.Historical.AAPL

ES01.Historical.port<-ES(port.ret, method="historical",p=0.99)
ES01.Historical.port
ES05.Historical.port<-ES(port.ret, method="historical",p=0.95)
ES05.Historical.port

#EVT
library(dplyr)
library(ggplot2)
library(evir)
library(POT)
library(PerformanceAnalytics)

meplot(AMZN.ret, lty =1)
meplot(TSLA.ret,lty =2)
meplot(AAPL.ret,lty =2)
meplot(port.ret,lty =2)

mrlplot(AMZN.ret,u.range=c(0,quantile(AMZN.ret,probs=0.99))
        ,col=c("green","black","green"),nt=200,main = "AMZN Mean Residual Life Plot")
abline(v =0.004,lty = 2)

mrlplot(TSLA.ret,u.range=c(0,quantile(TSLA.ret,probs=0.99)),
        col=c("green","black","green"),nt = max(100, length(TSLA.ret)),
        main = "TSLA Mean Residual Life Plot" )
abline(v =0.026,lty = 2)

mrlplot(AAPL.ret,u.range=c(0,quantile(AAPL.ret,probs=0.99)),
        col=c("green","black","green"),nt=200, main = "AAPL Mean Residual Life Plot" )
abline(v =0.0185,lty = 2)

mrlplot(port.ret,u.range=c(0,quantile(port.ret,probs=0.99)),
        col=c("green","black","green"),nt=200,main = "Portfolio Mean Residual Life Plot" )
abline(v = 0.025,lty =2)


gpd.AMZN<-gpd(AMZN.ret, threshold = 0.004)
EVT99.AMZN<-riskmeasures(gpd.AMZN,0.99)
EVT95.AMZN<-riskmeasures(gpd.AMZN,0.95)
EVT99.AMZN
EVT95.AMZN

gpd.TSLA<-gpd(TSLA.ret, threshold = 0.026)
EVT99.TSLA<-riskmeasures(gpd.TSLA,0.99)
EVT95.TSLA<-riskmeasures(gpd.TSLA,0.95)
EVT99.TSLA
EVT95.TSLA

gpd.AAPL<-gpd(AAPL.ret, threshold = 0.0185)
EVT99.AAPL<-riskmeasures(gpd.AAPL,0.99)
EVT95.AAPL<-riskmeasures(gpd.AAPL,0.95)
EVT99.AAPL
EVT95.AAPL

gpd.port<-gpd(port.ret, threshold = 0.025)
EVT99.port<-riskmeasures(gpd.port,0.99)
EVT95.port<-riskmeasures(gpd.port,0.95)
EVT99.port
EVT95.port




#Backtesting
library(GAS)
library(segMGarch)

#AMZN 99% Gaussian
E.G99.AMZN <- sum(AMZN.ret[508:757] < -0.042)
E.G99.AMZN
AMZN.ret[508:757] < -0.042
p = 0.01
T = 250
x = 1

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 248
n01 = 1
n10 =1
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC




#AMZN 99% Historical
E.H99.AMZN <- sum(AMZN.ret[508:757] < -0.0505)
E.H99.AMZN
AMZN.ret[508:757] < -0.0505
p = 0.01
T = 250
x = 1

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 248
n01 = 1
n10 =1
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC




#AMZN 99% EVT
E.EVT99.AMZN <- sum(AMZN.ret[508:757] < -0.0523)
E.EVT99.AMZN
AMZN.ret[508:757] < -0.0523
p = 0.01
T = 250
x = 1

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 248
n01 = 1
n10 =1
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#AMZN 95% Gaussian
E.G95.AMZN <- sum(AMZN.ret[508:757] < -0.0294)
E.G95.AMZN
AMZN.ret[508:757] < -0.0294
p = 0.05
T = 250
x = 5

LR.POF <- -2*log(((1-p)^(T-x)*(p^(x)))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 240
n01 = 5
n10 =5
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#AMZN 95% Historical
E.H95.AMZN <- sum(AMZN.ret[508:757] < -0.0286)
E.H95.AMZN
AMZN.ret[508:757] < -0.0286
p = 0.05
T = 250
x = 9

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 232
n01 = 9
n10 =9
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#AMZN 95% EVT
E.EVT95.AMZN <- sum(AMZN.ret[508:757] < -0.0303)
E.EVT95.AMZN
AMZN.ret[508:757] < -0.0303
p = 0.05
T = 250
x = 5

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 240
n01 = 5
n10 =5
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#TSLA 99% Gaussian
E.G99.TSLA <- sum(TSLA.ret[508:757] < -0.0945)
E.G99.TSLA
TSLA.ret[508:757] < -0.0945
p = 0.01
T = 250
x = 1

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 248
n01 = 1
n10 =1
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC




#TSLA 99% Historical
E.H99.TSLA <- sum(TSLA.ret[508:757] < -0.132)
E.H99.TSLA
TSLA.ret[508:757] < -0.132
p = 0.01
T = 250
x = 0

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 250
n01 = 0
n10 =0
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#TSLA 99% EVT
E.EVT99.TSLA <- sum(TSLA.ret[508:757] < -0.122)
E.EVT99.TSLA
TSLA.ret[508:757] < -0.122
p = 0.01
T = 250
x = 1

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 248
n01 = 1
n10 =1
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#TSLA 95% Gaussian
E.G95.TSLA <- sum(TSLA.ret[508:757] < -0.0658)
E.G95.TSLA
TSLA.ret[508:757] < -0.0658
p = 0.05
T = 250
x = 7

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 236
n01 = 7
n10 =7
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC




#TSLA 95% Historical
E.H95.TSLA <- sum(TSLA.ret[508:757] < -0.0577)
E.H95.TSLA
TSLA.ret[508:757] < -0.0577
p = 0.05
T = 250
x = 9

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 232
n01 = 9
n10 = 9
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC

dim(TSLA.ret)

#TSLA 95% EVT
E.EVT95.TSLA <- sum(TSLA.ret[508:757] < -0.0688)
E.EVT95.TSLA
TSLA.ret[508:757] < -0.0688
p = 0.05
T = 250
x = 5

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 240
n01 = 5
n10 =5
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC




#AAPL 99% Gaussian
E.G99.AAPL <- sum(AAPL.ret[508:757] < -0.048)
E.G99.AAPL
AAPL.ret[508:757] < -0.048
p = 0.01
T = 250
x = 0

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 250
n01 = 0
n10 =0
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#AAPL 99% Historical
E.H99.AAPL <- sum(AAPL.ret[508:757] < -0.0624)
E.H99.AAPL
AAPL.ret[508:757] < -0.0624
p = 0.01
T = 250
x = 0

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 250
n01 = 0
n10 =0
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC


#AAPL 99% EVT
E.EVT99.AAPL <- sum(AAPL.ret[508:757] < -0.0579)
E.EVT99.AAPL
AAPL.ret[508:757] < -0.0579
p = 0.01
T = 250
x = 0

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 250
n01 = 0
n10 =0
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#AAPL 95% Gaussian
E.G95.AAPL <- sum(AAPL.ret[508:757] < -0.0334)
E.G95.AAPL
AAPL.ret[508:757] < -0.0334
p = 0.05
T = 250
x = 9

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 233
n01 = 8
n10 =8
n11 = 1

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC





#AAPL 95% Historical
E.H95.AAPL <- sum(AAPL.ret[508:757] < -0.0315)
E.H95.AAPL
AAPL.ret[508:757] < -0.0315
p = 0.05
T = 250
x = 10

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 231
n01 = 9
n10 =9
n11 = 1

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#AAPL 95% EVT
E.EVT95.AAPL <- sum(AAPL.ret[508:757] < -0.0323)
E.EVT95.AAPL
AAPL.ret[508:757] < -0.0323
p = 0.05
T = 250
x = 9

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 233
n01 = 8
n10 =8
n11 = 1

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC


#PORT 99% Gaussian
E.G99.port <- sum(port.ret[508:757] < -0.0501)
E.G99.port
port.ret[508:757] < -0.0501
p = 0.01
T = 250
x = 1

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 248
n01 = 1
n10 =1
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC

digits = 7

#PORT 99% Historical
E.H99.port <- sum(port.ret[508:757] < -0.0635)
E.H99.port
port.ret[508:757] < -0.0635
p = 0.01
T = 250
x = 0

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 250
n01 = 0
n10 =0
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC


#PORT 99% EVT
E.EVT99.port <- sum(port.ret[508:757] < -0.0598)
E.EVT99.port
port.ret[508:757] < -0.0598
p = 0.01
T = 250
x = 0

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 250
n01 = 0
n10 =0
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC




#PORT 95% Gaussian
E.G95.port <- sum(port.ret[508:757] < -0.0348)
E.G95.port
port.ret[508:757] < -0.0348
p = 0.05
T = 250
x = 7

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 236
n01 = 7
n10 =7
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#PORT 95% Historical
E.H95.port <- sum(port.ret[508:757] < -0.0326)
E.H95.port
port.ret[508:757] < -0.0326
p = 0.05
T = 250
x = 10

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 230
n01 = 10
n10 =10
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#PORT 95% EVT
E.EVT95.port <- sum(port.ret[508:757] < -0.0342)
E.EVT95.port
port.ret[508:757] < -0.0342
p = 0.05
T = 250
x = 8

LR.POF <- -2*log(((1-p)^(T-x)*(p^x))/((1-(x/T))^(T-x)*(x/T)^(x)))
LR.POF

n00 = 234
n01 = 8
n10 =8
n11 = 0

pi0 = (n01)/(n00+n01)
pi1 = (n11)/(n10+n11)
pi = (n01+n11)/(n00+n01+n10+n11)

LR.IND <- -2*log(((1-pi)^(n00+n10)*(pi^(n01+n11)))/((1-pi0)^(n00)*(pi0^(n01))*(1-pi1)^(n10)*(pi1^(n11))))
LR.IND

LR.CC = LR.POF + LR.IND                 
LR.CC



#Comparisons

library(ggplot2)

Stock <- c("AMZN 99%","AMZN 99%","AMZN 99%","AMZN 99%","AMZN 99%", "AMZN 99%",
           "AMZN 95%","AMZN 95%","AMZN 95%","AMZN 95%","AMZN 95%", "AMZN 95%",
           "TSLA 99%","TSLA 99%","TSLA 99%","TSLA 99%","TSLA 99%", "TSLA 99%",
           "TSLA 95%","TSLA 95%","TSLA 95%","TSLA 95%","TSLA 95%", "TSLA 95%",
           "AAPL 99%","AAPL 99%","AAPL 99%","AAPL 99%","AAPL 99%", "AAPL 99%",
           "AAPL 95%","AAPL 95%","AAPL 95%","AAPL 95%","AAPL 95%", "AAPL 95%",
           "Port 99%","Port 99%","Port 99%","Port 99%","Port 99%", "Port 99%",
           "Port 95%","Port 95%","Port 95%","Port 95%","Port 95%", "Port 95%")

Method <- c("Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES",
            "Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES",
            "Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES",
            "Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES",
            "Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES",
            "Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES",
            "Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES",
            "Gaussian VaR","Historical VaR","EVT VaR","Gaussian ES","Historical ES","EVT ES")

HypotheticalPortfolioValues <- c(504,606,627.60,603.60,769.20,810,352.80,343.20,363.60,470.40,495.60
                                 ,530.40,1134,1584,1344,1392,2064,1956,789.60,692.40,
                                 825.60,1088.40,1185.60,1236,576,748.80,694.80
                                 ,712.80,1072.80,1002,400.80,378,387.60,556.80,
                                 612,594,601.20,762,717.60,746.40,1110,1062,
                                 417.60,391.20,410.40,584.40,664.80,622.80)

data<-data.frame(Stock, Method, HypotheticalPortfolioValues)
data
ggplot(data, aes(fill=Method, y=HypotheticalPortfolioValues, x=Stock)) + 
  geom_point(aes(colour = Method)) + xlab("Stock and CI") 


