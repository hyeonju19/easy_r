install.packages("corrplot")
install.packages("tidyverse")
install.packages("tidyquant")
install.packages("wesanderson")
install.packages("gridExtra")

install.packages(c("corrplot","tidyverse", "tidyquant", "wesanderson", "gridExtra"), type="binary")

library(ggplot2)
library(dplyr)
library(corrplot)
library(readr)
library(tidyverse)
library(data.table)
library(lubridate)
library(tidyquant)
library(wesanderson)
library(gridExtra)
library(RColorBrewer)

install.packages("readr")
library(readr)
case <- read_csv("corona/Case.csv")
patient_info <- read_csv("corona/PatientInfo.csv")
patient_route <- read_csv("corona/PatientRoute.csv")
region <- read_csv("corona/Region.csv")
search_trend <- read_csv("corona/SearchTrend.csv")
seoul_floating <- read_csv("corona/SeoulFloating.csv")
time <- read_csv("corona/Time.csv")
time_age <- read_csv("corona/TimeAge.csv")
time_gender <- read_csv("corona/TimeGender.csv")
time_province <- read_csv("corona/TimeProvince.csv")
weather <- read_csv("corona/Weather.csv")

#기저질환이 있는 환자 추출
str(patient_info)
patient_info$disease <-replace(patient_info$disease,
                               is.na(patient_info$disease)==TRUE, FALSE)

table(patient_info$disease)

diseased <-patient_info %>% filter(disease==TRUE)
head(diseased)

diseased %>% 
  ggplot(aes(sex)) + geom_bar(aes(fill=age))+ theme_light()+
  ggtitle("성별 나이별 기저 환자수") +
  theme(plot.title = element_text(hjust=0.5))+
  scale_fill_brewer(palette = "Greens")

table(diseased$state)
