
################################################################################
### SCRUM CLUB!!!
### Week 4: Loops, functions and regression in R
### 17.01.2018


### Loops
# if / else loop, tests the logical information in the "if" section. If it is 
# TRUE, than R executes the command.

# a simple if statement.
x <- 5
if(x < 10) {  # here we are testing the if statement. If it is correct, the commands un the curly brackets will be run.
  print("smaller than 10")
}

# if the statement is not lead to a TRUE, the commands in the if statement will be ignored.
x <- 15
if(x < 10) {  
  print("smaller than 10")
}

# an if statement with else.
x <- 5
if(x <= 36) {   
  print("section01")
} else {  # the first bracket closes the first if part, and "else" next to it accepts the mutual conditions.
  print("section02")
}

# adding else if command for testing more statements.
x <- 42
if(x > 0 & x <= 36) { 
  print("section01")
} else if(x > 36 & x <= 56) {	# You may add more than one condition with "else if"
  print("section02")
} else {
  print("not in the class")
}

x <- 60
if(x > 0 & x <= 36) { 
  print("section01")
} else if (x > 36 & x <= 56) {    # You may add more than one condition with "else if"
  print("section02")
} else {print("not in the class")
}


# for loops
for(i in 1:10) {	# assigns the values given in the condition for the object, one by one.
  print(i)
}

res <- rep(NA, 10)
for(i in 1:10) {
  res[i] <- i^2
}
res

x <- c("a", "b", "c")
for(i in seq_along(x)) {	# "seq_along" uses the length of the vector.
  print(i)
}

# if you want to use the values in the vector, you need to specify it with subsetting.
for(i in seq_along(x)) {
  print(x[i])
}

# or, you can run the loop directly over the vector. 
for(i in x) {
  print(i)
}


# while
count <- 0
while(count <= 10) {	# if the condition is logically true, the loop will continue. Otherwise, the commands will be broken.
  print(count^2)	
  count <- count + 1	# increases the count by one. When it becomes 10, while will breake the operation.
}


# repeat 
x <- 2
repeat {	# repeats the commands until it is said to stop. 
  print(x)
  if(x > 250) { 
    break	# when x becomes greater than 250, R will stop the operation.
  } else {
    x <- x^2
  }
}

# be careful when using while and repeat. You need to specifically state the breaking
# commands. Otherwise, you will get an "infinite loop", which never stops working.

# you may use a loop inside of another loop.
match <- function(x, y) {	# let's create a function which searches for the same objects in two different vectors.
  
  l1 <- length(x)	# l1 is the number of elements in the first vector.
  l2 <- length(y)	# l2 is the number of elements in the second vector.
  
  match <- NULL
  
  for(i in 1:l1) {	 
    for(j in 1:l2) {	
      if(x[i] == y[j]) {match = append(match, x[i])}
    }
  }
  
  res <- list(matches = match, nOfMatches = length(match))
  return(res)
}

a <- c("d", "g", "t", "h", "u")
b <- c("e", "f", "d", "j", "g")

m <- match(a, b)
m


# single line loops: apply, lapply, sapply, and tapply.
set.seed(356)  # setting the seed helps you to regenerate the same random numbers. 
rnorm(5)  # generating five numbers form standard normal distribution.
rnorm(5)  # generating another five numbers from the same distribution. These will be different numbers from the first five numbers.

# but, if we set the seed to the same number again.
set.seed(356)
rnorm(5)  # we can generate the same first five numbers again.

set.seed(123)
x <- matrix(rnorm(25, mean = rep(1:5, each = 5), sd = rep(0.1, 25)), nrow = 5)
x  # now, we should all be able to generate the same numbers. 


# apply(): Holds a function over a dimension of an array with any dimension.
args(apply)
means <- apply(x, 2, mean)  # taking the means of the values at each column, (2 is the column dimension) in the object x.
means

apply(x, 1, function(t) {sum(t)^2})	# you may define your specific function in 
# apply. E.g. here, I want to sum all the values in each row and take 
# their squares.

# it is possible to add arguments of the function that we use in apply.
apply(x, 2, quantile, probs = c(0.25, 0.75))	# finding the 1st and 3rd 
# quartiles in each column. Here probs is an argument of quartile.


# lapply(): Loops over the branches of a list and holds the function you desire.
args(lapply)

x <- list(a = rnorm(10, mean = 5), b = rnorm(100, mean = 5),
          c = rnorm(1000, mean = 5), d = rnorm(10000, mean = 5))

lapply(x, mean) # taking the means of the values at each branch of the list.


# sapply(): Simplifies the result of lapply() whenever it is possible.
sapply(x, mean)


# tapply(): Holds a function through the subsets which is defined as a vector by the user.
args(tapply)	# X is object you will hold the function. Index states the subsets, 
# function is the function you will use, and simplify can be used as in sapply()

z <- c(rnorm(10, mean = 0), rnorm(10, mean = 5), rnorm(10, mean = 20))
z

f <- rep(1:3, each = 10)
f

tapply(z, f, mean)


####################################################################################
### Linear Regression

data(mtcars)  # reading a data that is available in R.
str(mtcars)   # structure of the data.
?mtcars

# in order to build a linear regression we need to use lm function.
# lm requires a formula on which the regression will be built. First we need to define
# the response variable in the formula. Then covariates will follow a ~.
fit1 <- lm(mpg ~ hp + wt, data = mtcars)
fit1
summary(fit1)

# excluding the intercept coefficient.
fit2 <- lm(mpg ~ -1 + hp + wt, data = mtcars)
summary(fit2)

# adding the interaction between two variables.
fit3 <- lm(mpg ~ hp + wt + hp * wt, data = mtcars)
summary(fit3)

# or, in short:
fit3 <- lm(mpg ~ hp * wt, data = mtcars)
summary(fit3)


### Linear Models with Categorical Covariates
str(mtcars)
?mtcars  # help page shows that some of the variables are categorical variables. 
# However, these categorical variables are coded as numerical variables.
# Following codes convert these variables into factors that can keep categorical variables

mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)

summary(mtcars)

# we can add factors to models just like the numerical covariates. 
fit4 <- lm(mpg ~ cyl, data = mtcars)
summary(fit4) # R will take the first level of the factor as the reference group.

# two categorical covariates.
fit5 <- lm(mpg ~ am + cyl, data = mtcars)
summary(fit5)

# two covariates with their interactions.
fit6 <- lm(mpg ~ am + cyl + am * cyl, data = mtcars)
summary(fit6)

# full model. Using "." means that we want to include all the covariates in the data. 
fit7 <- lm(mpg ~ ., data = mtcars)
summary(fit7)


### Transformations
# a simple model with two numerical covariates.
fit <- lm(mpg ~ disp + wt, data = mtcars)
summary(fit)

plot(mtcars$disp, mtcars$mpg, xlab = "Displacement", ylab = "MPG", pch = 19) # the relation between disp and mpg doesn't seem to be linear.
abline(lm(mpg ~ disp, data = mtcars)) # adding the line that shows the linear relation between disp and mpg.

mtcars$lnDisp <- log(mtcars$disp)   # let's try to take the log of disp to have a linear relation.
fit <- lm(mpg ~ lnDisp + wt, data = mtcars)
summary(fit)

plot(mtcars$lnDisp, mtcars$mpg, xlab = "log(Displacement)", ylab = "MPG", pch = 19) 
abline(lm(mpg ~ lnDisp, data = mtcars)) # now, it looks better.


# Box-Cox
fit <- lm(mpg ~ disp + hp + drat + wt + qsec, data = mtcars)
summary(fit)

plot(fit)	# draws 4 graphs on the residuals. 
# or
layout(matrix(c(1, 2, 3, 4), 2, 2))
plot(fit)
graphics.off()

library(MASS)
boxcox(fit)
mtcars$lnMpg <- log(mtcars$mpg)
fit <- lm(lnMpg ~ disp + hp + drat + wt + qsec, data = mtcars)
summary(fit)

layout(matrix(c(1, 2, 3, 4), 2, 2))
plot(fit)
graphics.off()

# checking the normality of the residuals.
shapiro.test(fit$residuals)

# checking non-constant error variance.
install.packages("car")
library(car)
ncvTest(fit)
# hypotheses for Non-constant variance test
# H0: Constant error variance
# H1: Error variance changes with the level of the response


### Multicollinearity
fit <- lm(lnMpg ~ disp + hp + drat + wt + qsec, data = mtcars)

pairs(subset(mtcars, select = c("mpg", "disp", "hp", "wt", "drat", "qsec")))
round(cor(subset(mtcars, select = c("mpg", "disp", "hp", "wt", "drat", "qsec"))), 3)
# disp seems to be correlated with the other covariates
# It may cause multicollinearity

# Checking multicollinearity with VIF
vif(fit)


### Ridge Regression
# a method to overcome the multicollinearity or overfitting problem.
# It aims to give a penalty for using more coefficients.
# This is done by adding a term which includes the sum of the squares of the coefficients
# multiplied by a "ridge coefficient" to the sum of squares error term.

# There is a function as lm.ridge() under MASS package
?lm.ridge

ridge <- lm.ridge(lnMpg ~ disp + hp + drat + wt + qsec, data = mtcars, lambda = 1) # lambda is equal to 0 as default.
# Therefore, the default ridge regression is the same with the usual linear regression.
ridge

names(ridge)   # two lambda estimators are suggested by the function itself.
ridge$kHKB
ridge$kLW

# http://www.m-hikari.com/ams/ams-2010/ams-9-12-2010/dorugadeAMS9-12-2010.pdf


### Logistic Regression
crabs <- read.table("horseshoecrabs.txt", header = TRUE)
str(crabs)

crabs$binarySatel <- ifelse(crabs$Satellites > 0, 1, 0) # converting the satellites variable to a binary variable.

crabs.glm <- glm(binarySatel ~ Width + Weight, family = "binomial", data = crabs)
summary(crabs.glm)

crabs.glm2 <- glm(binarySatel ~ Width, family = "binomial", data = crabs)
summary(crabs.glm2)

# calculating the pi_hat values with the backtransformation of logit function.
pi_hat <- exp(crabs.glm2$coeff[1] + crabs.glm2$coeff[2] * crabs$Width) / (1 + exp(crabs.glm2$coeff[1] + crabs.glm2$coeff[2] * crabs$Width))
plot(crabs$Width, pi_hat, pch = 19)

