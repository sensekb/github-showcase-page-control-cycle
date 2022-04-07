library(dplyr)
library(gbm)

Tournament_Goalkeeping_2021 <- Tournament_Goalkeeping %>%
            na.omit() %>%
          dplyr::filter(Year == 2021) %>%
           dplyr::select(-c("Player","Year","Age","Pos", "League", "Playing Time 90s", "Born","Playing Time MP","Playing Time Starts","Playing Time Min")) %>%
           dplyr::filter(`Performance CS%` >=0)





Boost_train_2021_Goalkeeping <- gbm(as.factor(Nation) ~.,data = Tournament_Goalkeeping_2021, n.trees = 500)

RelativeInf_2021_Goalkeeping <- summary(Boost_train_2021_Goalkeeping)
relative.influence(Boost_train_2021_Goalkeeping)
RelativeInf_2021_Goalkeeping.plot <-as.data.frame(RelativeInf_2021_Goalkeeping)

pl <- ggplot(data = RelativeInf_2021_Goalkeeping.plot, aes(x=rel.inf, y= reorder(var,rel.inf)) ) + geom_bar(stat = "identity",fill = "#607D8B")
pl <- pl + theme_bw()
pl <- pl + xlab ('Relative Influence') + ylab('Predictor')
pl <- pl + labs(title = "Relative Influence of the Predictors")
pl <- pl + scale_x_continuous(limits = c(0,8), expand = c(0, 0.3)) 
pl

RelativeInf_2021_Goalkeeping.plot

