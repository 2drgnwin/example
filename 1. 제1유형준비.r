# 1강 dpylr 패키지 사용법법
## select
str(iris)
View(iris)
library(dplyr)
iris %>% select(Petal.Length) %>% head
iris %>% select(Petal.Length, Species) %>% head
iris %>% select(- Species) %>% head
iris %>% filter(Species =='setosa') %>% head
iris %>% filter(Petal.Length < 3 ) %>% head
## mutate
iris %>% mutate(Petal.Q = Petal.Length/Petal.Width ) %>% head
str(iris) 
iris$Petal.Q <- iris$Petal.Length/iris$Petal.Width
str(iris) %>% head
##group by, summarise()
iris %>% group_by(Species) %>% 
  summarise(mean(Petal.Length))

iris %>% group_by(Species) %>% 
  summarise(sd(Petal.Length))
##arrange
iris %>% arrange(Petal.Length)
iris %>% arrange(-Petal.Length)
iris %>% arrange(desc(Petal.Length))

# 2강 결측값 이상값 처리
## 결측값 확인 
str(airquality)
is.na(airquality)
### 개수 확인
print(sum(is.na(airquality)))
summary(airquality)
### 행과열로 나눠서 확인
print(rowSums(is.na(airquality)))  # 5행 na 2개 
print(colSums(is.na(airquality)))  # 5행 na 2개 
table(is.na(airquality$Ozone))  # table : showing function of data freq
## 결측값 행 삭제
airquality1 <- airquality[complete.cases(airquality),]
str(airquality1)
airqulity2 <- na.omit(airquality) 
str(airqulity2)
## 결측값 열 삭제
airquality3 <- airquality[,colSums(is.na(airquality))==0]
str(airquality3)
## 결측값 대체
airquality$Ozone <- ifelse(is.na(airquality$Ozone),
                           median(airquality$Ozone, na.rm=TRUE),
                           airquality$Ozone)
table(is.na(airquality$Ozone))

## 이상치 제거
### ESD 이용 - 표준편차 3배 이내 추출
Ozone_m <- mean(airquality$Ozone)
Ozone_sd <- sd(airquality$Ozone)
esd <- airquality %>% filter(abs(Ozone-Ozone_m)/Ozone_sd < 3)
summary(esd)
str(esd)

### 사분위수(IQR) - boxplot의 장상최대최소한도 이내 추출
print(boxplot(airquality$Ozone))
boxscore<-boxplot(airquality$Ozone)
print(boxscore)
min_score <-boxscore$stats[1]
max_score <-boxscore$stats[5]
ozone_iqr <- airquality %>% filter(Ozone > min_score &
                                     Ozone < max_score)
str(ozone_iqr)
summary(ozone_iqr)

# 3강 데이터 변환
## 1. 데이터 유형 변환
a <- c(-1:3)
a; str(a)
b <- as.character(a)
b; str(b); typeof(b)  # character
c <- as.numeric(b)
c; str(c); typeof(C)
typeof(c)  # double
d <- as.integer(b)
d; str(d)
typeof(d)  # integer
e <- as.logical(a)
e; str(e)
typeof(e) 
f <- as.double(a)
f; str(f);
typeof(f) # double


## 2. 객체 변환
##차원 | 단일자료 | 다중자료
### 1차원 | Vector | List
### 2차원 | matrix | Data Frame

### 변환
df <- as.data.frame(a)
df ; str(df) ; typeof(df)
df <- as.data.frame(c(a,c,e))
df ; str(df) ; typeof(df)
### Data Frame
df <- data.frame(a,e,c,d)
str(df)
df <- data.frame(stu = c('a','b','c'),
                 M = c(80,90,85),
                 E = c(95,85,78))
### List
df_list <- as.list(df)
df_list ; str(df_list)
me <- list(name = "dreamingwings", mes = c("꿈꾸는 날개","빅데이터 분석기사 R")) 


### factor
a <- c(0:4)
a <- as.factor(a)
a;str(a);typeof(a)

### matrix
a <- as.matrix(a)
str(a)
class(a)
typeof(a)
b <- matrix(c(1:6), nrow = 3,ncol = 2)
b <- matrix(c(1:6), nrow = 3)
b <- matrix(c(1:6), ncol = 2)
b <- matrix(c(1:6), ncol = 2, byrow = TRUE)
b <- matrix(c(1:6), ncol = 2, byrow = TRUE, 
            dimnames = list(c('r1','r2','r3'), c('c1','c2')))

## 3. 날짜 데이터 변환
library(lubridate)
ymd("2023 12 31")
mdy("12 31 2023" )
yd_hm("12 31 2023" )
a <- ymd_hm("2023 12 31 16 40")
make_date(2024,1,18)
b <- make_datetime(2024,11,23,16,40)
a;b
difftime(a,b,units = "weeks")
difftime(a,b,units = "days")

## 4. 데이터 범위 변환
temp <- airquality$Temp
z_temp <- scale(temp)  # 표준화
summary(z_temp); sd(z_temp)
summary(temp)
minmax_temp <- scale(temp, min(temp), max(temp)-min(temp))  # 정규화

summary(minmax_temp)
summary(airquality$Temp)


# 4강 표본추출, 기술통계량 
## 1) smapling
lake <- sample(LakeHuron, 30, replace = TRUE)
print(lake)
table(LakeHuron);table(lake)  # replace여부 확인 가능

## 2) 대푯값
### mean
airquality
mean(airquality$Solar.R, na.rm = TRUE)
x <- c(1,2,3,3,3,3,3,3,3,3,3,3)
table(x)
mean(x)
mean(x, trim = 0.1)  # trim 은 다듬다, 0.1은 최소최대 1개씩 빼고 평균
mean(x, trim = 0.2)  # trim 은 다듬다, 0.2양쪽 두개
### median
y <- c(1,2,3,4,5,6,NA)
median(y, na.rm = TRUE)  # data 짝수이면 데이터값의 사잇값으로
### mode
x
table(x)
as.numeric(names(table(x)))[which.max(table(x))]

table(temp) ## 81도가 11개로 젤 많은데 25번째에 위치 
which.max(table(temp)) ## > 81 25 : 81도가 25번째* 
table(temp)[which.max(table(temp))] ## > 81 11 : 81도(이름) 11개(데이터) 출력
names(table(temp))[which.max(table(temp))] ## 81도(이름) 출력
as.numeric(names(table(temp))[which.max(table(temp))]) ## 숫자로 변환

#### ※* 25번째가 의미하는게 뭔지 찾는과정
dense_rank(temp)  # 각각의 수가 몇등인지 알려줌 동일하면 중복 => 개수 파악
table(dense_rank(temp))  # 몇번째 수가 몇개 있는지 알려줌 25 11

df <- data.frame(table(temp), dense_rank(table(temp)))
names(df) <-c('c1','c2','c3')
df %>% arrange(c3)


## 3) 산포도
temp <- airquality$Temp
solar <- airquality$Solar.R
var(temp)  # 분산
var(temp, solar, na.rm = TRUE)  #공분산
cov(temp, solar, use = 'na.or.complete')
sd(temp)  #표준편차
range(temp);summary(temp) # 범위
quantile(temp, 1)  # 퍼센타일
quantile(temp, 0.10)
q1 <- quantile(temp, 0.25)
q3 <- quantile(temp, 0.75)
IQR(temp)  # 1,3사분위수범위 interquantilerange

## 4) 순위 계산산
linenum <- row_number(temp)
rank112 <- min_rank(temp)  # (일반적)공동 2등 다음 4번째는 4등으로
rank113 <- dense_rank(temp)  # 공동2등 다음 4번째는 3등으로
rank <- data.frame(temp, linenum, rank112, rank113)
rank %>% arrange(linenum)

## 5) 데이터 파악하는 함수수
str(rank) ; head(rank) ; tail(rank, 3)
table(iris$Species)
length(iris$Sepal.Length)
length(rank)
summary(rank)
install.packages('psych')
library(psych)
describe(rank)

### 범주형별로 수치형 데이터 분석
aggregate(iris$Sepal.Length ~ iris$Species, iris,
          FUN = mean)
iris %>% group_by(Species) %>% summarise(mean(Sepal.Length)) ##자리수는 round로

###상관계수
cor(rank)
cor(rank$rank112, rank$linenum, method = 'pearson')  # 일반적
cor(rank$rank112, rank$linenum, method = 'spearman')
cor(rank$rank112, rank$linenum, method = 'kendal')


