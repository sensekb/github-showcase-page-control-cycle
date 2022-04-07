library(dplyr)
library(gbm)

Tournament_Defending_2021 <- Tournament_Defending %>%
  na.omit() %>%
  dplyr::filter(Year == 2021) %>%
  dplyr::select(-c("Player","Year","Age","Pos", "League", "90s", "Born","Err","Int")) %>%
  dplyr::filter(`Tackles Tkl` >=0, `Tackles TklW` >=0, Clr >=0)

set.seed(222)                           
Tournament_Defending_2021_CleanNames <- Tournament_Defending_2021 %>%
  janitor::clean_names()



Boost_train_2021_Defending <- gbm(as.factor(nation) ~.,data = Tournament_Defending_2021_CleanNames, n.trees = 500)

RelativeInf_2021_Defending <- summary(Boost_train_2021_Defending)
relative.influence(Boost_train_2021_Defending)
RelativeInf_2021_Defending.plot <-as.data.frame(RelativeInf_2021_Defending)

pl <- ggplot(data = RelativeInf_2021_Defending.plot, aes(x=rel.inf, y= reorder(var,rel.inf)) ) + geom_bar(stat = "identity",fill = "#607D8B")
pl <- pl + theme_bw()
pl <- pl + xlab ('Relative Influence') + ylab('Predictor')
pl <- pl + labs(title = "Relative Influence of the Predictors")
pl <- pl + scale_x_continuous(limits = c(0,8), expand = c(0, 0.3)) 
pl

RelativeInf_2021_Defending.plot
