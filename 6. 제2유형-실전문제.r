# 출력을 원할 경우 print() 함수 활용
# 예시) print(df.head())

# setwd(), getwd() 등 작업 폴더 설정 불필요
# 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

train = read.csv("data/customer_train.csv")
test = read.csv("data/customer_test.csv")

# 사용자 코딩
library(dplyr); library(caret); library(randomForest); library(ModelMetrics)
## data processing
#summary(train)
#str(train)
train$환불금액 <- ifelse(is.na(train$환불금액), 0, train$환불금액)
train$성별 <- as.factor(train$성별)
#str(train)
## model construction
#idx <- sample(1:nrow(train), nrow(train)*0.8)
#train_1 <- train[idx,]
#train_2 <- train[-idx,]

#md <- randomForest(성별~., data = train_1[,-1], ntree=400, mtry=3, do.trace=TRUE, proximity=TRUE)
#md

#pred <- predict(md, newdata = train_2[,-1])

#auc(train_2$성별,pred)

## model construction for test

test$환불금액 <- ifelse(is.na(test$환불금액), 0, test$환불금액)
#test$성별 <- as.factor(test$성별)
str(test)
md <- randomForest(성별~., data = train[,-1], ntree=100,mtry=3,do.trace=TRUE, proximity =TRUE)
pred <- predict(md, newdata = test[,-1])
pred
##출력
write.csv(pred,"result.csv",row.names = FALSE)
a <- read.csv("result.csv")
a
# 답안 제출 참고
# 아래 코드는 예시이며 변수명 등 개인별로 변경하여 활용
# write.csv(data.frame변수,"result.csv",row.names = FALSE)
