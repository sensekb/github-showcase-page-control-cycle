library(dplyr)
library(randomForest)
library(rpart)
library(rpart.plot)
library(ggplot2)
library(gbm)

Shooting_2021_Model <- Tournament_Shooting_2021 %>%
                            dplyr::select(-c(`Performance PK`,`Performance PKatt`, League, Year, Age
                                             ,Born, `90s`, Age_2022, `Standard FK`,`Standard G/Sh`,Player)) %>%
                            dplyr::filter(`Standard SoT` >= 0) %>%
                            dplyr::filter(`Standard SoT/90` >= 0) %>%
                            dplyr::filter(`Standard G/SoT`>= 0) %>%
                            #dplyr::filter(!Pos == "DF") %>%
                            dplyr::select(-c(Pos))
set.seed(222)                           
Tournament_Shooting_2021_CleanNames <- Shooting_2021_Model %>%
                                      janitor::clean_names()


#Col_Names <- c("Nation","Gls","Standard_Sh","Standard_SoT","Standard_SoTP","Standard_Sh_per_Game","Standard_SoT_per_Game"
#, "Standard_G_per_SoT","Standard_Dist","ExpectedxG","ExpectednpxG","ExpectednpxG_per_Sh","ExpectedGxG","ExpectednpGxG")
#names(Shooting_2021_Model) <- Col_Names

# 
# RF_2021 <- randomForest(as.factor(Nation) ~ ., data = Shooting_2021_Model, ntree=1000)
# importance(RF_2021)
# varImpPlot(RF_2021)
# RF_2021
# 
# sml_Shooting_2021 <- Shooting_2021_Model %>%
#   dplyr::filter(Nation %in% c("Sobianitedrucy","Varijitri Isles"))
# 
# 
# 
# 
# sml_RF_2021 <-randomForest(as.factor(Nation) ~., data = sml_Shooting_2021, ntree=1000)
# sml_RF_2021
# varImpPlot(sml_RF_2021)


#Boosting--------------------------------------------------------------------------------------------------------------------------

Boost_train_2021_Shooting <- gbm(as.factor(nation) ~.,data = Tournament_Shooting_2021_CleanNames, n.trees = 500)

RelativeInf_2021_Shooting <- summary(Boost_train_2021_Shooting)
relative.influence(Boost_train_2021_Shooting)
RelativeInf_2021_Shooting.plot <-as.data.frame(RelativeInf_2021_Shooting)

pl <- ggplot(data = RelativeInf_2021_Shooting.plot, aes(x=rel.inf, y= reorder(var,rel.inf)) ) + geom_bar(stat = "identity",fill = "#607D8B")
pl <- pl + theme_bw()
pl <- pl + xlab ('Relative Influence') + ylab('Predictor')
pl <- pl + labs(title = "Relative Influence of the Predictors")
pl <- pl + scale_x_continuous(limits = c(0,15), expand = c(0, 0.3)) 
pl

RelativeInf_2021_Shooting.plot





#-----------------------------------------------------------------------------------------------------------------------------------


