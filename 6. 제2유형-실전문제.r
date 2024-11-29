# 출력을 원할 경우 print() 함수 활용
# 예시) print(df.head())

# setwd(), getwd() 등 작업 폴더 설정 불필요
# 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

train = read.csv("data/customer_train.csv")
test = read.csv("data/customer_test.csv")

# 사용자 코딩

# library
library(dplyr)
library(caret)
library(randomForest)
library(ModelMetrics)
#ls("package:caret")

# 1. data
###############
 #print(train %>% str)
 #print(train %>% summary)


# 2. D.P
###############
#df_train <- train[,-1]
#df_train$성별<- as.factor(df_train$성별) 
#df_train$주구매상품<- as.factor(df_train$주구매상품)
#df_train$주구매지점<- as.factor(df_train$주구매지점)
# df_train$환불금액 <- ifelse(is.na(df_train$환불금액), 0, df_train$환불금액)


# 3. split set
###############
#set.seed(63)
#partition<- createDataPartition(df$성별, p=0.7, list=FALSE)
#train_1 <- df[partition,]
#train_2 <- df[-partition,]
#print(nrow(train_1));print(nrow(train_2))
#table(train_1$성별)


# 4. train1 - M.C
#################
#md <- randomForest(성별~., data = train_1, ntree=400)
#print(md)

# 5. train1 M.E
####################
#pred <- predict(md, newdata = train_2)
#print(caret::confusionMatrix(pred, reference = train_2$성별))
#print(auc(train_2$성별,pred))

# 6. Final prediction
#train <- train %>% filter(회원ID != 1659)
df_train <- train[,-1]
df_train$성별<- as.factor(df_train$성별) 
df_train$주구매상품<- as.factor(df_train$주구매상품)
df_train$주구매지점<- as.factor(df_train$주구매지점)
df_train$환불금액 <- ifelse(is.na(df_train$환불금액), 0, df_train$환불금액)

df_test <- test[,-1]
df_test$환불금액 <- ifelse(is.na(df_test$환불금액), 0, df_test$환불금액)
df_test$주구매상품<- as.factor(df_test$주구매상품)
df_test$주구매지점<- as.factor(df_test$주구매지점)

levels(df_test$'주구매상품')<-levels(df_train$'주구매상품') 

md <- randomForest(성별~., data = df_train, ntree=400)
pred <- predict(md, newdata = df_test)

table(pred)
# 
# 답안 제출 참고
# 아래 코드는 예시이며 변수명 등 개인별로 변경하여 활용
# write.csv(data.frame변수,"result.csv",row.names = FALSE)
