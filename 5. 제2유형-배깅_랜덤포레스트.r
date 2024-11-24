library(mlbench)
library(ModelMetrics)
library(caret)
library(randomForest)

# 배깅
## data processing
data("PimaIndiansDiabetes2")
summary(PimaIndiansDiabetes2)
str(PimaIndiansDiabetes2)
df<-na.omit(PimaIndiansDiabetes2)
str(df)


install.packages("ipred")

## Model construction
idx <- sample(1:nrow(df), nrow(df)*0.8)
train <- df[idx,]
test <- df[-idx,]
md <- bagging(diabetes~., data = train, nbagg = 25)

## Model evaluation
pred <- predict(md, newdata = test)
caret::confusionMatrix(pred, reference = test$diabetes)
auc(test$diabetes, pred)


# 랜덤포레스트 
## Model construction
md <- randomForest(diabetes~., data = train, ntree=100,
					proximity = TRUE)
md

## Model evaluation
pred <- predict(md, newdata = test)
caret::confusionMatrix(pred, reference = test$diabetes)
auc(est$diabetes, pred)