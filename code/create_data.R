# Forecast horizon
h <- 4

nfci <- read.csv("brownlees\\gar-replication\\data\\input\\nfci.csv")
setnames(nfci, old = "USA", new = "nfci")
nfci_us <- nfci[, c("Dates", "nfci")]

gdp <- read.csv("brownlees\\gar-replication\\data\\input\\gdp.csv")
setnames(gdp, old = "USA", new = "gdp")
gdp_us <- gdp[, c("Dates", "gdp")]

# create lagged values at relevant forecast horizon
gdp_us[,"gdp_f"] <- sapply(1:nrow(gdp_us), function(x) gdp_us[,"gdp"][x+h])

# Merge datatables

data <- merge(gdp_us, nfci_us, by = "Dates")
write.csv(data, file = "data\\data.csv")