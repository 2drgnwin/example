# 6강 분석모형 평가
install.packages("Metrics")
install.packages("ModelMetrics")

library(caret); 
#library(Metrics); 
library(ModelMetrics); 
library(ggplot2)

## 회귀모형 평가
### Goodness of fit for Training Set
x <- c(2,3,4,5)
y <- c(4,6,8,9)
df <- data.frame(x,y)
md <- lm(y ~ x, df)
summary(md)
### Prediction performance test for Test set
y_true <- c(3,5,7,9)
y_pred <- c(2,5,8,10)
RMSE(y_true,y_pred)
((-0.2)^2+(0.1)^2+(0.4)^2+(-0.3)^2 )/4


## 분류모형 평가
### Prediction performance test for Test set
y_true <- c(0,1,1,1,1,0); y_pred <- c(0,0,1,0,1,0)
y_true <- factor(y_true); y_pred <- factor(y_pred)
cm <- confusionMatrix(y_pred,y_true); print(cm)
cm$byClass
auc(y_pred,y_true)  # pred true 입력 순서 주의의


#7강 예측함수, 선형회귀, 로지스틱회귀
## 선형회귀귀
### 1. 데이터 수집 및 전처리리
#install.packages("mlbench")
library(mlbench)  #data library
data("trees")
head(trees)
str(trees)
summary(trees)
df <- trees

### 2. 데이터 모형 구축
set.seed(1)
idx <-sample(1:nrow(df), nrow(df)*0.8)
train <- df[idx,]
test <- df[-idx,]
md <- lm(Volume ~ ., data = train)
summary(md)

### 3. 데이터 모형 평가
pred <- predict(md, newdata = test)
pred <- predict(md, newdata = test, type = "response")
RMSE(test$Volume, pred)


## GLM(Binary Target)
### data exploration and preparation
data("PimaIndiansDiabetes2")
head(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

### data processing
df <- na.omit(PimaIndiansDiabetes2)

### EDA
#### Categorical X Categorical : Bar char
ggplot(df, aes(x = factor(pregnant), fill = factor(diabetes))) +
  geom_bar(position = "fill") +
  #labs(x = i, y = "percent") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#### Categorical X Numeric : Box plot
var.num <- names(df)[1:8][-1]
for(i in var.num){
  plot <- ggplot(df, aes(x = factor(diabetes), y = df[,i])) +
    geom_boxplot() +
    labs(x = "diabetes", y = i) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
  print(plot)
}

## Model construction
set.seed(1)
idx <-sample(1:nrow(df), nrow(df)*0.8)
train <- df[idx,]
test <- df[-idx,]
md <- glm(diabetes ~ ., data = train , family = binomial )
summary(md)

pred <- predict(md, newdata = test, type = "response")
pred
### cutoff 설정
pred <- as.factor(ifelse(pred>0.5,"pos","neg"))

## model evaluation
confusionMatrix(pred, reference = test$diabetes)
auc(test$diabetes, pred = pred)

