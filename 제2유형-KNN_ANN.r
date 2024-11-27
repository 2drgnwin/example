#install.packages("class")
library(class)
library(mlbench)
library(ModelMetrics)

# KNN
## DATA
data("PimaIndiansDiabetes2")
summary(PimaIndiansDiabetes2)
str(PimaIndiansDiabetes2)
df<-na.omit(PimaIndiansDiabetes2)
str(df)

## Model construction
idx <- sample(1:nrow(df), nrow(df)*0.8)
train <- df[idx,]
test <- df[-idx,]
###train을 독립과 종속으로 나눔
train_x <- train[,-9]
train_y <- train[,9]
test_x <- test[,-9]
test_y <- test[,9]
### md constuction
md <- knn(train = train_x, test = test_x,
          cl = train_y, k = 2)  # k는 근접이웃의 수
md
## Model evaluation
caret::confusionMatrix(md, reference = test_y)
library(ModelMetrics)
auc(pred = md, test_y)

#ANN
install.packages("nnet")
library(nnet)
## Model construction
md <-nnet(diabetes~., data = train, size = 2, maxit = 200)
## Model evaluation
pred <- predict(md, newdata = test, type = "class")
pred <- factor(pred, levels = levels(test$diabetes))
caret::confusionMatrix(pred, reference = test$diabetes)
auc(test$diabetes, pred)
