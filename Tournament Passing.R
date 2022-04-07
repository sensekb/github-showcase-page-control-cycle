library(dplyr)
library(gbm)

Tournament_Passing_2021 <- Tournament_Passing %>%
                            na.omit() %>%
                            dplyr::filter(Year == 2021) %>%
                            dplyr::select(-c("Player","Year","Age","Pos", "League", "90s", "Born")) %>%
                            dplyr::filter(Ast >=0, xA >=0, `Long Cmp` >=0, `1/3` >=0)
set.seed(222)                           
Tournament_Passing_2021_CleanNames <- Tournament_Passing_2021 %>%
                                        janitor::clean_names()



Boost_train_2021_Passing <- gbm(as.factor(nation) ~.,data = Tournament_Passing_2021_CleanNames, n.trees = 500)

RelativeInf_2021_Passing <- summary(Boost_train_2021_Passing)
relative.influence(Boost_train_2021_Passing)
RelativeInf_2021_Passing.plot <-as.data.frame(RelativeInf_2021_Passing)

pl <- ggplot(data = RelativeInf_2021_Passing.plot, aes(x=rel.inf, y= reorder(var,rel.inf)) ) + geom_bar(stat = "identity",fill = "#607D8B")
pl <- pl + theme_bw()
pl <- pl + xlab ('Relative Influence') + ylab('Predictor')
pl <- pl + labs(title = "Relative Influence of the Predictors")
pl <- pl + scale_x_continuous(limits = c(0,10), expand = c(0, 0.3)) 
pl

RelativeInf_2021_Passing.plot
