library(ggplot2)
library(quantreg)
library(data.table)
library(zoo)
library(lubridate)
library(stargazer)

#Housekeeping
set.seed(1234)
rm(list = ls())

#Initialize parameters
sigma_u = 1.257
beta = 0.529
gamma = 0.044
h <- 4

# Main file
setwd("C:/Users/Usuario/Desktop/Brown/Term 2/AEA/Final Project")

#run files
source("code\\create_data.R")
source("code\\simulation.R")
source("code\\qreg.R")