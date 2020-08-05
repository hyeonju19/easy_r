#DoitR_Part11-2
install.packages("ggiraphExtra")
install.packages("stringi")
install.packages("devtools")
install.packages("maps")
install.packages("mapproj")
install.packages("tibble")
install.packages("backports")
library(devtools)
library(backports)
devtools::install_github("cardiomoon/kormaps2014")


library(ggiraphExtra)
library(stringi)
library(devtools)
library(maps)
library(mapproj)
library(tibble)
library(kormaps2014)
library(dplyr)
library(ggplot2)

#대한민국 시도별 인구 단계 구분도 만들기 
korpop1$name <-iconv(korpop1$name, "UTF-8", "CP949")
str(changeCode(korpop1))
korpop1<-rename(korpop1, pop=총인구_명, name=행정구역별_읍면동)
str(changeCode(kormap1))
ggChoropleth(data = korpop1, 
             aes(fill = pop, 
                 map_id = code, 
                 tooltip = name), 
             map = kormap1,
             interactive = T) 

#대한민국 시도별 결핵 환자 수 단계 구분도 만들기
tbc$name <-iconv(tbc$name, "UTF-8", "CP949")
str(changeCode(tbc))
ggChoropleth(data = tbc,
             aes(fill = NewPts, 
                 map_id = code, 
                 tooltip = name), 
             map = kormap1,
             interactive = T) 






