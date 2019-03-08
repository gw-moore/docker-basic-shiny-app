library(knitr)
library(readr)
library(shiny)
library(dplyr)
library(tidyr)
library(shinydashboard)
library(ggplot2)

df <- read.csv("./NIFI_OUTPUT.csv", stringsAsFactors = F, header=T)

df_long <- df %>% 
  gather(key = "METRIC", value = "VALUE", -COMM_GROUP)