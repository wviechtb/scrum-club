### clear global environment
rm(list = ls())

### reading in an SPSS dataset
### you can use the foreign package which has priority recommended
### this means it is installed with R, but not automatically loaded
### we can make the functions contained in it available:
library(foreign)

### if for some reason foreign is not installed yet:
install.packages("foreign")

### before reading an SPSS dataset into R, R needs to know the folder it is in
### the current 'working directory' or folder R uses can be obtained with getwd()
getwd()

### for now I set it to the desktop on my Mac:
setwd("~/Desktop")
setwd("~/Documents/Werk")

### on a Microsoft Windows computer
setwd("C:\\Work related files\\Datasets")

### now read the data into R as an object and name it "dat"
### use.value.labels = TRUE converts nominal variables into factors using labels as levels
### to.data.frame = TRUE makes sure the object is of class data frame
dat <- read.spss("Methadone_RCT.sav", use.value.labels = TRUE, to.data.frame = TRUE)

### it is also possible to read in Stata, SAS, Excel, etc. files
### directly, but will not get into this; see the R Data Import/Export
### manual: https://cran.r-project.org/doc/manuals/R-data.html

### you can view the object by running its name, but it is shown in the console
dat

### a better way would be to use View()
View(dat)

### inspect data
str(dat)
head(dat)
tail(dat)
ncol(dat)
nrow(dat)
dim(dat)
colnames(dat)
names(dat)
summary(dat)

### you can also view variables (or columns) seperately
dat$Age

### or individual cells
dat$Age[1]

### add a variable to the dataset
dat$Delta_pain <- dat$Pain_1_week - dat$Pain_baseline

### provide some descriptive statistics

### number of patients or records
length(dat$ID)

### in case of longitudinal data in long format
length(unique(dat$ID))

### ...back to descriptives
mean(dat$Age)
sd(dat$Age)
median(dat$Age)
quantile(dat$Age, probs=c(0.05,0.95))
IQR(dat$Age)
min(dat$Age)
max(dat$Age)
range(dat$Age)
summary(dat$Age)
table(dat$Age)

### in the context of this study, subgroup means would make sense
?aggregate
aggregate(dat$Age, by = list(dat$Allocation), FUN = mean)
aggregate(dat$Pain_baseline, by = list(dat$Allocation), FUN = mean)
aggregate(dat$Pain_1_week, by = list(dat$Allocation), FUN = mean)
aggregate(dat$Pain_3_week, by = list(dat$Allocation), FUN = mean)

### in case of missing values, explicitely instruct R what to do
aggregate(dat$Pain_3_week, by = list(dat$Allocation), FUN = mean, na.rm = TRUE)


### logicals revisited (note: TRUE treated as 1, FALSE treated as 0)
dat$Age > 65
table(dat$Age > 65)
sum(dat$Age > 65)
mean(dat$Age > 65) # compare to:
mean(dat$Age[dat$Age > 65])

### subsetting data
dat_adv_age <- subset(dat, dat$Age > 65)
length(dat_adv_age$ID)
mean(dat_adv_age$Age)

### MISSINGS
is.na(dat)
sum(is.na(dat))
sum(is.na(dat$Pain_3_weeks))
sum(is.na(dat$Pain_3_weeks)) / length(dat$ID)

### number of missings for each variable seperately
?apply
apply(dat, MARGIN = 2, FUN = function(x) sum(is.na(x)))

### data visualization
### a histogram to assess the distribution of the duration of pain before treatment start
hist(dat$Pain_duration)

hist(dat$Pain_duration, xlab = "Pain duration (weeks)")

hist(dat$Pain_duration, xlab = "Pain duration (weeks)",
     main = "Histogram of pain duration")

### boxplot of pain 1 week after treatment start
boxplot(dat$Pain_1_week)

boxplot(dat$Pain_1_week ~ dat$Allocation)

boxplot(dat$Pain_1_week ~ dat$Allocation, ylim = c(0, 10))

boxplot(dat$Pain_1_week ~ dat$Allocation, ylim = c(0, 10),
        ylab = "Pain score on week 1 (NRS)")

boxplot(dat$Pain_1_week ~ dat$Allocation, ylim = c(0, 10),
        ylab = "Pain score on week 1 (NRS)", main = "Boxplot of pain by allocation")

### scatterplot of age and duration of pain
plot(dat$Age ~ dat$Pain_duration)

plot(dat$Age ~ dat$Pain_duration, col = "red")

plot(dat$Age ~ dat$Pain_duration, xlim = c(0, 35), ylim = c(40, 100))

plot(dat$Age ~ dat$Pain_duration, xlim = c(0, 35), ylim = c(40, 100),
     xlab = "Duration of pain (weeks)", ylab = "Age (years)")

### you might not like the large open circles
plot(dat$Age ~ dat$Pain_duration, xlim = c(0, 35), ylim = c(40, 100),
     xlab = "Duration of pain (weeks)", ylab = "Age (years)", cex = .5)

plot(dat$Age ~ dat$Pain_duration, xlim = c(0, 35), ylim = c(40, 100),
     xlab = "Duration of pain (weeks)", ylab = "Age (years)", pch = 15)

?pch

plot(dat$Age ~ dat$Pain_duration, xlim = c(0, 35), ylim = c(40, 100),
     xlab = "Duration of pain (weeks)", ylab = "Age (years)", pch = 15)

abline(lm(dat$Age ~ dat$Pain_duration))
