# Parameters
sigma_u = 1.257
beta = 0.529
gamma = 0.044

# Load data
data <- read.csv("data\\data.csv")

# Calculate conditional variance
for (i in 1:nrow(data)){
  if (i == 1){
    data[i,"sigma_it"] <- sigma_u - gamma*data[i,"nfci"]
  }
  else {
    data[i,"sigma_it"] <- (1-beta)*(sigma_u - gamma*data[i,"nfci"]) + beta*data[i-1,"sigma_it"]
  }
}

## Simulate path of GaR

# Simulate to get conditional quantiles of the error terms
for (i in 1:nrow(data)){
  data[i, "quant_it"] <- quantile(rnorm(100, 0, data[i,"sigma_it"]), probs = 0.05)
}

# Fit linear model for conditional mean
m1 <- lm(gdp_f ~ gdp + nfci, data = data)
data[,"gdp_fit"] <- m1$coefficients[1] + m1$coefficients[2]*data[,"gdp"] + m1$coefficients[3]*data[,"nfci"]
data[,"gar_est"] <- data[,"gdp_fit"] + data[,"quant_it"]

# Create plots
ggplot(data, aes(x = nfci, y = gar_est)) + geom_point() + theme_bw() + ylab(expression(GaR[.05]^{t+4})) + xlab("NFCI") + labs(title="h=4, n=100") + theme(plot.title = element_text(hjust = 0.5))
ggsave("output\\figures\\plot_raw.png")

ggplot(data, aes(x = nfci, y = gar_est)) + geom_point() + theme_bw() + ylab(expression(GaR[.05]^{t+4})) + xlab("NFCI") + labs(title="h=4, n=100") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_smooth(method='lm', formula= y~x, se = FALSE) + geom_smooth(method='lm', formula= y~poly(x,2), se = FALSE, color = "red")
ggsave("output\\figures\\plot_lmfit.png")
  