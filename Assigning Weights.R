library(dplyr)
library(scales)
library(mice)
library(data.table)
library(janitor)
library("xlsx")



#Shooting----------------------------------------------------------------------------------------------------------------------------------------------------------
League_Shooting_Edited <- League_Shooting %>%
                                dplyr::mutate(Age_2022 = 2022 - Born)
                                            
Rarita_Shooting <- League_Shooting_Edited %>%
                      dplyr::filter(Pos %in% c("FW","MFFW","MF"))
Rarita_Shooting_Rating <- Rarita_Shooting %>%
                    dplyr::select(-c(`Performance PK`,`Performance PKatt`, League, Age
                       ,Born, `90s`, `Standard FK`,`Standard G/Sh`,Squad))

set.seed(222)
Rarita_Shooting_Rating <- Rarita_Shooting_Rating %>%
                  janitor::clean_names()

setcolorder(Rarita_Shooting_Rating,RelativeInf_2021_Shooting.plot$var)


#Imputation using pmm ----------------------------------------------------------------------------------------
set.seed(222)
Cleaned_Rarita_Shooting_Rating <- mice(data = Rarita_Shooting_Rating, method = "pmm",m=5)
Cleaned_Rarita_Shooting_Rating <- complete(Cleaned_Rarita_Shooting_Rating,1)
#-------------------------------------------------------------------------------------------------------------


Ratings_Shooting <- as.matrix(Cleaned_Rarita_Shooting_Rating[,-c(14,15,16,17,18)])%*%as.matrix(RelativeInf_2021_Shooting.plot$rel.inf)
Ratings_Shooting <- round(scales::rescale(Ratings_Shooting,to = c(1,99)))

Shooting_Rating_Complete <- cbind(Cleaned_Rarita_Shooting_Rating,Ratings_Shooting)
Rarita_Shooting_Rating_Complete <- Shooting_Rating_Complete %>%
                                      dplyr::filter(nation == "Rarita")








#Passing------------------------------------------------------------------------------------------------------------------------------------------------------------
League_Passing_Edited <- League_Passing %>%
                            dplyr::mutate(Age_2022 = 2022 - Born)


Rarita_Passing <- League_Passing_Edited %>%
                    dplyr::filter(Pos %in% c("MF","DFMF","FWMF","FW","DF"))

Rarita_Passing_Rating <- Rarita_Passing%>%
                           dplyr::select(-c("Age", "League", "90s", "Born","Squad"))
set.seed(222)
Rarita_Passing_Rating <- Rarita_Passing_Rating %>%
                          janitor::clean_names()

setcolorder(Rarita_Passing_Rating,RelativeInf_2021_Passing.plot$var)

#Impute-----------------------------------------------------------------------------------------
set.seed(222)
Cleaned_Rarita_Passing_Rating <- mice(data = Rarita_Passing_Rating, method = "pmm",m=5)
Cleaned_Rarita_Passing_Rating <- complete(Cleaned_Rarita_Passing_Rating,1)
#------------------------------------------------------------------------------------------------


Ratings_Passing <- as.matrix(Cleaned_Rarita_Passing_Rating[,-c(23,24,25,26,27)])%*%as.matrix(RelativeInf_2021_Passing.plot$rel.inf)
Ratings_Passing <- round(scales::rescale(Ratings_Passing,to = c(1,99)))

Passing_Rating_Complete <- cbind(Cleaned_Rarita_Passing_Rating,Ratings_Passing)
Rarita_Passing_Rating_Complete <- Passing_Rating_Complete %>%
                                    dplyr::filter(nation == "Rarita")










#Defending----------------------------------------------------------------------------------------------------------------------------------------------------------
League_Defending_Edited <- League_Defending %>%
             dplyr::mutate(Age_2022 = 2022 - Born)            

Rarita_Defending <- League_Defending_Edited %>%
  dplyr::filter(Pos %in% c("MF","DFMF","DF"))


Rarita_Defending_Rating <- Rarita_Defending%>%
  dplyr::select(-c("Age", "League", "90s", "Born","Squad","Err","Int"))

set.seed(222)
Rarita_Defending_Rating <- Rarita_Defending_Rating %>%
        janitor::clean_names()

setcolorder(Rarita_Defending_Rating,RelativeInf_2021_Defending.plot$var)

#Impute-----------------------------------------------------------------------------------------
set.seed(222)
Cleaned_Rarita_Defending_Rating <- mice(data = Rarita_Defending_Rating, method = "pmm",m=5)
Cleaned_Rarita_Defending_Rating <- complete(Cleaned_Rarita_Defending_Rating,1)
#------------------------------------------------------------------------------------------------

Ratings_Defending <- as.matrix(Cleaned_Rarita_Defending_Rating[,-c(22,23,24,25,26)])%*%as.matrix(RelativeInf_2021_Defending.plot$rel.inf)
Ratings_Defending <- round(scales::rescale(Ratings_Defending,to = c(1,99)))

Defending_Rating_Complete <- cbind(Cleaned_Rarita_Defending_Rating,Ratings_Defending)
Rarita_Defending_Rating_Complete <- Defending_Rating_Complete %>% 
                                        dplyr::filter(nation == "Rarita")










#Exporting----------------------------------------------------------------------------------------------------
write.xlsx(Shooting_Rating_Complete, file = "Rarita_Ratings.xlsx", sheetName = "Shooting Ratings", 
           col.names = TRUE, row.names = F, append = FALSE)

write.xlsx(Passing_Rating_Complete, file = "Rarita_Ratings.xlsx", sheetName = "Passing Ratings", 
           col.names = TRUE, row.names = F, append = TRUE)

write.xlsx(Defending_Rating_Complete, file = "Rarita_Ratings.xlsx", sheetName = "Defending Ratings", 
           col.names = TRUE, row.names = F, append = TRUE)

#--------------------------------------------------------------------------------------------------------------





# 
# 
# 
# 
# 
# 
# #Ratings for all shooting----------------------------------------------------------------------------------------------------------------------------------------
# League_Shooting_Ratings <- League_Shooting_Edited %>%
#                                       dplyr::select(-c(`Performance PK`,`Performance PKatt`, League, Year, Age
#                                                  ,Born, `90s`, Age_2022, `Standard FK`,`Standard G/Sh`,`Nation`,Pos,Squad))
# 
# 
# 
# colnames(League_Shooting_Ratings) <- c("Player","Gls","Standard_Sh","Standard_SoT","Standard_SoTP","Standard_Sh_per_Game","Standard_SoT_per_Game"
#                                                , "Standard_G_per_SoT","Standard_Dist","ExpectedxG","ExpectednpxG","ExpectednpxG_per_Sh","ExpectedGxG","ExpectednpGxG")
# 
# 
# set.seed(222)
# setcolorder(League_Shooting_Ratings,RelativeInf_2021_Shooting.plot$var)
# 
# Cleaned_League_Shooting_Ratings <- mice(data = League_Shooting_Ratings, method = "pmm",m=5)
# Cleaned_League_Shooting_Ratings <- complete(Cleaned_League_Shooting_Ratings,1)
# 
# 
# RatingsAll_Shooting <- as.matrix(Cleaned_League_Shooting_Ratings[,-14])%*%as.matrix(RelativeInf_2021_Shooting.plot$rel.inf)
# RatingsAll_Shooting <- round(scales::rescale(RatingsAll_Shooting,to = c(1,99)))
# 
# ShootingALL_Rating <- cbind(Cleaned_League_Shooting_Ratings,RatingsAll_Shooting)
# 
# 
# #Ratings for all passing----------------------------------------------------------------------------------------------------------------------------------------
# #Ratings for all defending----------------------------------------------------------------------------------------------------------------------------------------
# 
# 

