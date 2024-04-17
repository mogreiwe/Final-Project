# Regression analysis

data <- read.csv("data\\data.csv")

cg <- read.csv("brownlees\\gar-replication\\data\\input\\cg.csv")
setnames(cg, old = "USA", new = "cg")
cg <- cg[, c("Dates", "cg")]
cg$Dates <- as.Date(cg$Dates)
cg$Dates <- paste0(year(cg$Dates),"-Q",quarter(cg$Dates))

cr <- read.csv("brownlees\\gar-replication\\data\\input\\cr.csv")
setnames(cr, old = "USA", new = "cr")
cr <- cr[, c("Dates", "cr")]
cr$Dates <- as.Date(cr$Dates)
cr$Dates <- paste0(year(cr$Dates),"-Q",quarter(cr$Dates))

ts <- read.csv("brownlees\\gar-replication\\data\\input\\ts.csv")
setnames(ts, old = "USA", new = "ts")
ts <- ts[, c("Dates", "ts")]
ts$Dates <- as.Date(ts$Dates)
ts$Dates <- paste0(year(ts$Dates),"-Q",quarter(ts$Dates))

hp <- read.csv("brownlees\\gar-replication\\data\\input\\hp.csv")
setnames(hp, old = "USA", new = "hp")
hp <- hp[, c("Dates", "hp")]
hp$Dates <- as.Date(hp$Dates)
hp$Dates <- paste0(year(hp$Dates),"-Q",quarter(hp$Dates))

data <- merge(data,cg)
data <- merge(data,cr)
data <- merge(data,ts)
data <- merge(data,hp)

rqfit1 <- rq(gdp_f~gdp+nfci+cg+cr+ts+hp, data = data)
rqfit2 <- rq(gdp_f~gdp+poly(nfci,2)+cg+cr+ts+hp, data = data)

stargazer(list(rqfit1, rqfit2), title=c("(1)","(2)"), out = "output\\tables\\table.tex")