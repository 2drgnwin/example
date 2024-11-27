
# No.1
#library(dpylr)
#str(df)

#df$Survived <- as.factor(df$Survived)
#tb <- table(df$Gender, df$Survived)

#a<-chisq.test(tb)
#round(a$statistic,4)
#260.717

# No.2

#df$Survived <- as.factor(df$Survived)
#b<-glm(Survived~Gender+SibSp + Parch + Fare, data = df, family ='binomial')
#round(b$coefficient[4],3)
#-0.201

#No.3
df$Survived <- as.factor(df$Survived)
b<-glm(Survived~Gender+SibSp + Parch + Fare, data = df, family ='binomial')

exp(b$coefficient)
#0.702
