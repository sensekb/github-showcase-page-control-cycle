# SOA Case Study 2022: Rarita Football League

### Team Control Cycle
Sumeet Singh, James Li, Asel Lewliyadde, Ngoc Phuong Dung Vo, Kawitsara Boonvisud


## Project Outline
> This repository showcases our attempt at the [SOA Student Case Study 2022](https://www.soa.org/research/opportunities/2022-student-research-case-study-challenge).  

We were proposed with buiding a competitive soccer team to build a long-term brand for Rarita's football program that will propel economic growth and prosperity in Rarita. We employed methods such as gradient boosting machines and linear regression to provide rationale to our team selection. With our proposed squad, we then proposed an implementation plan with the assumptions that our team selection will lead to a competitive result in the FSA league, and an economic analysis was then conducted that studied the impacts of the year cashflows of this team to Rarita's GDP, GNI and other relevant measures. Additionally, preventative measures such as building out a larger squad, diversifying assets and purchasing indemnity insurance are part of the mitigating measures made to de-risk the potential scenarios associated with constructing an elite football team. 

## Team Selection
Our initial 11 player squad consisted of the following players:
|Position|Player|Initial Salary|
|:---|:---|:---|
|FW|X. Petersen|5,120,000|
|FW|N.Yamashita|8,270,000|
|FW|D. Bengtsson|8,190,000|
|MF|O.Wanjala|1,750,000|
|MF|X. Leroy|5,630,000|
|MF|F. Chin|1,340,000|
|DF|B. Ayuba|21,950,000|
|DF|T. Okoro|730,000|
|DF|Q. Sano|7,200,000|
|DF|Q.bin Ismail|920,000|
|GK|F. Akuma|15,461,250|

To formalise our procedure for team selection we produced player ratings to provide a clear numeric comparison between the numerous players that could be chosen by aggregating weighted key performance indicators. A generalised boosting algorithm was trained to determine the player statistics that are key in predicting the success of the team they belong to through the variable importance. The variable importance  acted as a proxy to then determine the weights to apply to key player performance indicators to then be aggregated into the overall rating. The plot below shows the relative influence as determined by the boosting algorithm and was used to assign weights to the individual key player indicators to provide an aggregate rating. This process was repeated for all the 4 positions.

![Figure 1](Shooting%20Rel%20Influence.png)

## Implementation Plan

![Figure 2](Proposed&Expenses.png)


## Risk Consideration

As part of our risk considerations, we aimed at creating a safe sporting environment for our players whilst managing the various liability and investment risks that could potentially occur. We broke this down into 4 main areas; health, reputational, operational and investment risk. The health risk was quite easy to identify and mainly concerns the fitness and ongoing health status of our players. We added extra players into the squad in case any sickness or injuries affect our starting 11. As part of our operational risks, we want to ensure that our projected revenues are not too volatile and that it can sustain our costs. We aim to allocate into stable revenue streams such as extending broadcasting contracts. Moreover, we can mitigate investment risks by diversifying our investments into both short term assets and long term bonds.
