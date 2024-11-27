#Tree
library("rpart")
library("rpart.plot")
## data preparation
iris
str(iris)
summary(iris)

## data processing
df <- na.omit(iris)

##EDA

##Model construction
set.seed(1)
idx <-sample(1:nrow(df),nrow(df)*0.8)
train <- df[idx,]
test <- df[-idx,]
md <- rpart(Species~., data = train)
rpart.plot(md)
prp(md, type = 0, extra = 1)  # 노드의 type:모양 extra:추가정보 

##Model evaluation
pred <- predict(md, newdata = test, type = "class")
caret::confusionMatrix(pred, reference = test$Species)

library(ModelMetrics)
auc(test$Species, pred=pred)  # auc only works for binary outcomes at this time


# SVM 
install.packages("e1071")
library(e1071)
##Model construction
set.seed(1)
idx <-sample(1:nrow(df),nrow(df)*0.8)
train <- df[idx,]
test <- df[-idx,]
md <- svm(Species~., data = train)
##Model evaluation
pred <- predict(md, newdata = test, type = "class")
pred
caret::confusionMatrix(pred, reference = test$Species)
