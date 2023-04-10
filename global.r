library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(DT)
library(lubridate)

# Load dataset
starbucks <- read.csv("Starbucks_stock_history.csv")
starbucks$Date <- as.POSIXct(starbucks$Date)

choices <- c("Open","High","Low","Close","Volume","Dividends","Stock Splits")