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
#ls("package:caret")

# 1. data
###############
 print(train %>% str)
 print(train %>% summary)


# 2. D.P
###############
#df <- na.omit(train)



# 3. split set
###############

#partition<- createDataPartition(df$성별, p=0.7, list=FALSE)
#train_1 <- train[partition,]
#train_2 <- train[-partition,]
#print(nrow(train_1));print(nrow(train_2))
#table(train_1$성별)
# 4. M.E


# 답안 제출 참고
# 아래 코드는 예시이며 변수명 등 개인별로 변경하여 활용
# write.csv(data.frame변수,"result.csv",row.names = FALSE)
