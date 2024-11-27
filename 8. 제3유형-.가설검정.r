################################
# Z 검정
################################
## 양측
x_bar <- 0.052
sigma <- 0.008
n <- 64
mu <- 0.05
alpha <- 0.05
p_value <- (1-pnorm(x_bar, mu, sigma/sqrt(n)))/2
alpha > p_value #Ture → rejcet H0

## 단측
mu <- 220
n <- 30
x_bar <- 231
s <- 20
alpha <- 0.05
p_value <- ( 1-pnorm(x_bar,mu,s/sqrt(n)) ) # 0.001295638
#reject H0(귀무가설 기각, 대립가설 채택)

################################
# F 검정
################################
a <- rnorm(50,153,11)
b <- rnorm(60,167,17)
var.test(a,b)
var.test(b,a)
var.test(b, a, alternative = 'greater') # b > a 검정 p-value = 0.03207

################################
# chisquare 검정
################################
set.seed(1)
ex <- data.frame(
  age = sample(c("20대","30대","40대"), 100, replace = TRUE),
  gender = sample(c("남성","여성"),100,replace=TRUE),
  region = sample(c("수도권","광역시","그 외"),100,replace=TRUE),
  score1 = rpois(100,40),
  score2 = rpois(100,40),
  score3 = rpois(100,40)
)
ex

#적합도 검정
#나이대별 비율이 같은지
tb<-table(ex$age)
chisq.test(tb, p=c(1/3, 1/3, 1/3))
chisq.test(tb, p =rep(1/length(tb),length(tb)))

# 독립성 검정
# 응시자 나이와 성별간 관계가 있는지 (H0:없다)
tb<-table(ex$age,ex$gender)
chisq.test(tb) # p-value = 0.1479 관계가 없다

# 동질성 검정
# 나이대별 응시지역은 비슷한가
tb<-table(ex$age,ex$region)
chisq.test(tb)  # p-value = 0.1747 #비슷


################################
# t 검정
################################
#단일 20넘는지?
t1 <- rnorm(10, 21.5, 2.23)
shapiro.test(t1)  # 정규성 테스트
t.test(t1, alternative = "greater", mu =20)

# 쌍체표본
## 다이어트 약이 효과가 있는지
df <- data.frame(
  before = c(95,85,75,52,60),
  after = c(90,83,70,51,58)
)
## 정규성을 만족한다고 가정
## 다이어트 약은 빠져야 효과가 있는거니 
## H0 효과 없는거는 greater 
t.test(df$before,df$after, alternative ="greater", paired = TRUE)
## p-value 0.01153

# 독립표본
## isu가 몸무게 더 가볍냐?
## 1. 정규성 테스트 : 30명 넘으면 정규성 만족
## 2. 분산이 같은지 : 

isu <- rnorm(50,67.5,2.8)
noisu <- rnorm(50,68.2,2.5)
var.test(isu,noisu)  #  p-value = 0.9413 등분산 만족

t.test(isu,noisu,alternative="less", var.equal = TRUE)

# p-value = 0.04743
var.test(score3~gender,data=ex)
## score3의 점수는 gender에 따라 다르니?
t.test(score3~gender,data = ex, var.equal = TRUE)
## 차이없음음