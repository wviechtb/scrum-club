############################################################################

### 2017/12/13
### Third Meeting of the SCRUM Club
### Topic: Continue with R

############################################################################

### copy the code/data files for today's meeting to some directory
### https://github.com/wviechtb/scrum-club/tree/master/materials/2017-12-13

### start R or RStudio

### check if the working directory is set to the same location to which you
### saved the code/data files

getwd()

### if not, set the working directory (adjust the path based on your computer)

setwd("/home/wviechtb/work/orgs_grps_assocs/scrum-club/meetings/2017-12-13")

### on Windows, the path may look something like this

#setwd("C:/Users/Wolfgang/Documents/scrum_club/meetings/2017-12-13/")

############################################################################

### A few points that I think are worth clarifying when working with R.

### 1) One can have many datasets loaded simultaneously. In fact, datasets
###    are simply objects in your workspace and there is in principle no
###    limit as to how many are available at the same time. An example:

dat1 <- read.table("data_example1.txt", header=TRUE, as.is=TRUE)
dat2 <- read.table("data_example2.txt", header=TRUE, sep=",",
                   na.strings="", as.is=TRUE)
dat1
dat2

ls()

dat3 <- merge(dat1, dat2, by.x="id", by.y="subjno")
dat3

### 2) Datasets loaded into your workspace are not linked in any way to the
###    data that are stored on your computer. An example:

dat1
dat1$age[4] <- 35 # change the age of the 4th person in the dataset to 35
dat1

### But data_example1.txt on your computer is unchanged. If you want to make
### changes permanent, you have to write the object to a file. For example:

write.table(dat1, "dat_example1_corrected.txt", row.names=FALSE,
            na="", sep="\t", quote=FALSE)

### 3) Objects are not linked.

dat3 # note that dat3 is unchanged (age of 4th person is still 32)

age <- dat1$age # now have a vector called 'age' in your workspace
ls()
age
age[4] <- 126   # change 4th value in the age vector to 126
age
dat1            # dat1 is unchanged

### clean up workspace a bit (keep things tidy!)

rm(dat1, dat2, dat3, age) # explicitly specify which objects to remove from workspace
rm(list=ls())             # this removes all existing objects from your workspace

ls()

############################################################################

### a few more data management things not covered so far (and a bit of review)

dat <- read.table("data_example1.txt", header=TRUE, as.is=TRUE)
dat

### sorting a data frame

dat[order(dat$age),]
dat

### change is not permanent unless you 'backassign' the sorted data frame

dat <- dat[order(dat$age),]
dat

### rename a variable

names(dat)
names(dat) == "age"
names(dat)[names(dat) == "age"]
names(dat)[names(dat) == "age"] <- "years"
dat

### generate a new variable based on an existing one

dat$days <- dat$years * 365
dat

### remember: if you change the 'years' value of the 4th peson, this won't
### have any effect on the 'days' value of the 4th person (R is not Excel!)

dat$years[4] <- 35
dat

### so you would have to rerun the code that creates the 'days' variable

dat$days <- dat$years * 365
dat

### remove a variable from a data frame

dat$days <- NULL
dat

### reverse code a variable (y is on a 1 to 5 scale)

dat$yrev <- 6 - dat$y
dat

### recode a variable

dat$sex[dat$sex == "female"] <- "woman"
dat$sex[dat$sex == "male"]   <- "man"
dat

### for more complex recoding, there is a nice function in the 'car' package

install.packages("car")
library(car)
help(recode)

### create subsets

dat.m <- subset(dat, sex=="man")
dat.f <- subset(dat, sex=="woman")
dat.m
dat.f

############################################################################

### clean slate

rm(list=ls())

### To get data from Excel into R, one option is to save the data as a tab
### delimited text file (in Excel, use "Save As" and then select "Text (Tab
### delimited)" under "Save as type") and then read it in with read.table().

dat <- read.table("scrum_club_topics_survey.txt", header=TRUE, sep="\t",
                  na.strings="", as.is=TRUE)

### You can also read Excel data directly into R. There are several packages
### that provide such functionality (e.g., readxl, XLConnect, xlsx, openxlsx,
### gdata). I cannot tell you which one works best, but let's try gdata:

install.packages("gdata")
library(gdata)
dat <- read.xls("scrum_club_topics_survey.xls", as.is=TRUE)

### A package may load a function with a name that is identical to a function
### that is already loaded. The existing function is then 'masked' by the
### newly loaded function. You can always access a function from a package
### (even if it was masked) with 'package::function'.

object.size(dat)        # uses object.size() from 'gdata'
gdata::object.size(dat) # force using object.size() from 'gdata'
utils::object.size(dat) # force using object.size() from 'utils'

### Actually, gdata requires Perl (https://en.wikipedia.org/wiki/Perl) to be
### installed for this to work. Another package that works without external
### dependencies is readxl, so let's try this:

install.packages("readxl")
library(readxl)
dat <- read_xls("scrum_club_topics_survey.xls")

### inspect structure of data

str(dat)

### rename variables to more usable (shorter) names

var.names <- c("name", "r", "python", "matlab", "julia", "git", "project", "refman", "present", "mindmap", "spssalt", "opensci", "editors", "writeco", "socmedia", "markdown", "latex", "shiny", "jupyter", "linux", "parallel", "cloud", "scripting", "score")
print(cbind(var.names, names(dat)), quote=FALSE)
names(dat) <- var.names

head(dat)

### remove the 'name' and 'score' variables

dat$name  <- NULL
dat$score <- NULL

### recode blanks to NA (missing) and the text responses to numbers

dat[dat == ""]          <- NA
dat[dat == "Very Low"]  <- 1
dat[dat == "Low"]       <- 2
dat[dat == "Medium"]    <- 3
dat[dat == "High"]      <- 4
dat[dat == "Very High"] <- 5

head(dat)

### careful: the variables are still character variables

dat$r
str(dat)

### we need to convert all variables into numeric variables

### tedious approach

dat$r      <- as.numeric(dat$r)
dat$python <- as.numeric(dat$python)
# and so on

### quicker

dat <- data.frame(apply(dat, 2, as.numeric))

dat$r
str(dat)
head(dat)

### inspect dataset

View(dat)

### Person 14 stopped after the first question (on R), person 25 stopped
### about half-way through the questionnaire, and person 30 gave 5's to
### all topics (such enthusiasm!).

### get mean of each item

round(apply(dat, 2, mean, na.rm=TRUE), 2)

### nice function in the 'psych' package

install.packages("psych")
library(psych)
describe(dat)

### describe() returns a data frame; let's sort it!

res <- describe(dat)
res[order(res$mean, decreasing=TRUE),]

### did earlier topics get a higher/lower rating?

plot(res$vars, res$mean, pch=19, type="o", ylim=c(1,5),
    xlab="Variable in Survey", ylab="Mean Rating")
text(res$vars, res$mean - .15, pos=2, rownames(res), srt=90, offset=0)

### who is most/least enthusiastic?

x <- apply(dat, 1, mean, na.rm=TRUE)
x
sort(x)
x
names(x) <- 1:length(x)
x
sort(x)

dat[21,]
dat[2,]

### barplot of the sorted means

barplot(sort(x), xlab="Person", ylab="Mean Enthusiasm", las=2)

### histogram of a single item

hist(dat$git, col="lightgray", xlab="Rating", main="Histogram for Git/GitHub")

### corresponding barplot

barplot(table(dat$git), xlab="Rating", ylab="Frequency")

### scatterplot of refman versus present

plot(dat$refman, dat$present, pch=19, xlab="Reference Manager Rating",
     ylab="Presentation Software Rating")

### correlation

cor(dat$refman, dat$present)
cor(dat$refman, dat$present, use="complete.obs")

### correlation testing

cor.test(dat$refman, dat$present)

### binning of x-y values

install.packages("hexbin")
library(hexbin)

res <- hexbin(dat$refman, dat$present)
plot(res, xlab="Reference Manager Rating", ylab="Presentation Software Rating")

### save a graph in various formats (saved to current working directory)

pdf("plot.pdf")
barplot(table(dat$git), xlab="Rating", ylab="Frequency", main="Interest in Git/GitHub")
dev.off()

postscript("plot.eps")
barplot(table(dat$git), xlab="Rating", ylab="Frequency", main="Interest in Git/GitHub")
dev.off()

png("plot.png")
barplot(table(dat$git), xlab="Rating", ylab="Frequency", main="Interest in Git/GitHub")
dev.off()

png("plot.png", width=1000, height=1000, pointsize=24)
barplot(table(dat$git), xlab="Rating", ylab="Frequency", main="Interest in Git/GitHub")
dev.off()

### linear regression

res <- lm(refman ~ present, data=dat)
res
summary(res)

### multiple regression

res <- lm(refman ~ present + python, data=dat)
summary(res)

### two-way contingency table

table(dat$refman, dat$present)
table(dat$refman, dat$present, useNA="ifany")

### chi-square and Fisher's exact test of independence

chisq.test(table(dat$refman, dat$present))
fisher.test(table(dat$refman, dat$present))

############################################################################

### principal component analysis
### note: scree() and principal() are from the 'psych' package

scree(dat, factors=FALSE)

res <- principal(dat, nfactors=2, rotate="oblimin")
print(res, cut=0.3, sort=TRUE)

### hierarchical cluster analysis of individuals

res <- hclust(dist(dat), method="ward.D")
plot(res)
rect.hclust(res, k=2, border=c("red", "blue"))

### categorize people into three clusters

sav <- cutree(res, 2)
sav

### get means of items within each cluster

dat1 <- subset(dat, sav==1)
dat2 <- subset(dat, sav==2)

sav1 <- sort(apply(dat1, 2, mean, na.rm=TRUE), decreasing=TRUE)
sav2 <- sort(apply(dat2, 2, mean, na.rm=TRUE), decreasing=TRUE)

### barplot of item means for the three clusters

barplot(cbind(sav1, sav2), beside=TRUE, names.arg=c(names(sav1), names(sav2)), las=2)

### hierarchical cluster analysis of topics

res <- hclust(dist(t(dat)), method="ward.D")
plot(res)
rect.hclust(res, k=3, border=c("red", "blue", "green"))

############################################################################
############################################################################
############################################################################

### show installed packages

library()

### all packages available on CRAN:
### http://cran.r-project.org/web/packages/available_packages_by_name.html

### task views: http://cran.r-project.org/web/views/

### search among installed packages (title and description)

help.search("factor analysis")

### install and load sos package

install.packages("sos")
library(sos)

### search all packages on CRAN for a term

findFn("structural equation")

### get nothing if there are too many hits :(

findFn("factor analysis")

### package vignettes are often a good way to learn how a package works
### example: https://cran.r-project.org/package=sos

### some potential indicators of 'good' packages:
### - written by a known expert in the field
### - package has been around for some time
### - package has been updated over the years
### - listed under one or multiple task view
### - has a vignette or other supporting documentation
### - paper/book about package has been published
### - help files are comprehensive and free of errors
### - has been cited in papers
### - ...

### Journal of Statistical Software: http://www.jstatsoft.org/

### citing R and packages

citation()
citation("sos")

### where to get help:
### Google
### mailing lists: http://www.r-project.org/mail.html
### read posting guide first: http://www.r-project.org/posting-guide.html
### Stack Exchange: http://stackexchange.com/
### especially http://stackoverflow.com/ and http://stats.stackexchange.com/

############################################################################
