
############################################################################
### Welcome to SCRUM
### 15.11.2017


### R Console symbols
# '>' means the line is ready for your commands, '+' means the continuation of the upper line
# '#' means a comment
3 * 
  5


# '<-' and '=' corresponds to assignment. They assign values to objects.
x <- 3  # creates a new object named as "x", and assigns the value of 3 to "x".
y = 5


# to see the contents of an object, just type its name
x
y


# that is in fact just a shortcut for using the print() function
print(x)


# a semicolon can be used to enter multiple commands in a single line
a <- 4; b <- 6; c <- a + b
a
b
c
# but, be careful about the readability of your codes


### Arithmetic operations
# R uses the common mathematical rules
0 * (40 + 2)
0 * 40 + 2


# those values can be assigned to objects
x <- 0 * 40 + 2
x
x * 3
x / 2
x^3
(x * 3)^2
exp(x)
log(x)  # calculates the natural logarithm
log10(x)	


# close R (remember to choose "no" when asked to save workspace)
quit()
q()
# or just close the window
# to avoid the prompt
q(save="no")


############################################################################
### open RStudio


### elements (panes) of the RStudio window:
### top left:     Script Editor
### bottom left:  Console
### top right:    Environement / Workspace and Command History
### bottom right: File Browser, Plots, Packages, Help, Viewer

### use R interactively by typing into the Console:
a <- 12

### open up new script file (Ctrl+Shift+n / Command+Shift+n)
### let's start working with a script file
### go to the script file editor and type in commands
### From File tab choose New File/R Script, or open a script with Open File


### Getting help in R
### there are two ways to get help in R
### first, you may use the "Help" tab at the right-side window
### you may search a specific function with the search box

### or, you can use the Console
help(plot)		# searching for a specific function
?plot			    # same with the previous code
??plot		    # a more advanced search

?xyplot
??xyplot

### lattice::xyplot means that there is a function called xyplot under the package
### lattice. So, first, we need to load lattice package to use xyplot().

x <- rnorm(15)  # generates 15 variables from a standard normal distribution
y <- rnorm(17)	# generates 17 variables from a standard normal distribution

plot(x, y)      # results in an error
# just copy the error link and google it
# or, ask somebody else. But, be sure that you can reproduce your error


### Classes of the objects
### some basic classes for the objects: 
### "character", "numerical", "integer", "logical"
### we can see the classes of the objects with "class()" function
name <- "Doctor"  # we need quotation marks to identify an object as a character
name
class(name)


# it is possible to include spaces in strings, as long as we keep them in quotation marks 
motto <- "SPSS, my a%$!"  


# a numeric variable
age <- 938	
class(age)


# normally, even if you enter an integer, it will be taken as a numerical.
class(5)


# in order to define a value as an integer, you will need to state it with the letter "L".
int <- 5L
class(int)
int2 <- 5.4L
# warnings are a special kind of errors. R continues to work, unlike errors;
# however, it informs you about that something's wrong
int2
class(int2) # since it contains a decimal, "int2" is automatically turned into a numerical


# logicals are binary variables with TRUE/FALSE values
logic <- c(TRUE, FALSE, FALSE)  # c() is concatenating which combines several objects in a single object, a vector
logic
class(logic)
# be careful that R does not specify three classes for three object in the vector
# vectors cannot contain objects from different classes
# therefore, we saw a single class for the whole vector

### Comparisons
x <- c(2, 4, 6, 3, 5) 
x
x > 3
x >= 3
x < 3
x <= 3
x == 3
x != 3


### and/or
x > 3 & x < 6
x < 3 | x > 5


# characters can be identified as a vector, as well
char <- c("Charmander", "Charmeleon", "Charizard")
char
class(char)


### as. functions
c1 <- c(-2:2)	  # creates a sequence from -2 to 2 with increaments of 1 as integers
c1
class(c1)

c2 <- as.numeric(c1)	# transforming the class of c1 into numeric
class(c2)
c2

c3 <- as.logical(c1)
class(c3)
c3		# only 0 is accepted as false

c4 <- as.character(c1)
class(c4)
c4    # note the quotation marks 


### Environment
ls()			      # lists the objects and functions already defined in the environment (workspace)
rm(logic)		    # removes the defined object or function from the environment. rm("a") also may be used
rm(age, name)	  # removes more than one objects
rm(list = ls())	# removes everything in the environment
ls()


# check your working directory
getwd()


### copy the data file(s) from the workshop website to the same directory
### use the Files pane (bottom right) to navigate to that directory
### then set the working directory to that same location:
### - use More icon in Files pane and then select 'Set as Working Directory'
### - use the Session menu, Set Working Directory, To Source File Location
### this just executes the setwd() command with the path filled in
setwd("~/Desktop/Ozan/Free/Scrum/Week1/")

### check your working directory again
getwd()

### don't forget to save the script once in a while
### and add comments to the script as needed


search()            # lists the packages loaded into the environment
?xyplot
??xyplot            # there is a xyplot function in the lattice package.
install.packages("lattice")  # downloading the package if it is not available
library(lattice)    # loading the lattice package into the environment
search()            # lattice package is added to the environment


### Subsetting
# a long vector
num <- 20:100
num

num[1]	    # subsets the first value in the object num
num[1:5]	  # subsets from the first and to the fifth values in the object num
num[c(1, 3)]# subsets the first and the third values in the object num
num[-1]	    # takes all the values except for the first value from the object num

mat1 <- matrix(c(1:8), nrow = 2) # creating a matrix including values from 1 to 8, with 2 rows
mat1
mat2 <- matrix(c(1:8), nrow = 2, byrow = TRUE)    # this time the values are written row by row
mat2
# like vectors, matrices can not hold objects from different classes
class(mat1)


mat1
mat1[1, ]	# subsetting only the first row of mat
mat1[, 2]	# subsetting the second column of mat
mat1[1, 2]	
mat1[-2, ]


### Data Frames
names <- c("Doctor", "Amy Pond", "Rory Williams")
ages <- c(938, 25, 26)
# we can't put these variables as they are into a matrix as their classes are different
matrix(c(names, ages), nrow = 3) # notice the quatation marks around the numbers. They are not numerics anymore, they are characters now

gang <- data.frame(member = names, age = ages)    # data.frame() can be used to create data sets which is also able to contain objects from different classes
gang


gang[1, ]
gang$age


### Reading data sets into the environment
dat <- read.table("toyData.txt", header = TRUE) # header is an argument
dat
?read.table # You can see the other arguments of the function from its help page.
# You will need to set the arguments to read the data correctly. For example, if
# the missing cases are denoted with a different character such as an asterix,
# you will need to set na.strings argument to "*". 

str(dat)     # structure of the data set
summary(dat) # descriptive statistics of the variables

boxplot(dat$Water ~ dat$Gender) # creating boxplots with respect to a factor variable in the data
# Be careful that when you want to use a variable from a data, you need to specify the data name and use $ to reach the variable in the data set
plot(dat$Age, dat$Water)  # a scatter plot to see if there is an association between the age and water



### Some points

### object/variables names:
### - must begin with a letter
### - contain alphanumeric symbols (A-Z, a-z, 0-9)
### - can also use . and _
### - should not:
###   - correspond to commands (confusion/errors)
###   - contain spaces
### - are case-sensitive
### - no (relevant) restriction on length

# check if something is a command/function
mean

# better to avoid naming objects after commands -> confusing!
mean <- c(2, 3, 4)
mean(mean)

# remove 'mean' vector
rm(mean)


### nesting of commands
x
mx <- mean(x)
sqrt(mx)
sqrt(mean(x))


### can also try out tab completion
### type 'box' and hit tab
### type 'p' and hit tab again; should complete to 'boxplot'
### now complete with '(num)' so we get
boxplot(x)

# close plot
dev.off()

### ***
list1 <- list(1, "f", 4+5i, TRUE)    # lists can include objects from different classes
list1

list2 <- list(c(1:5), c("a", "b"), TRUE)  # the length of the objects in a list may differ
list2

list3 <- list(nums = c(4.35, 6.43), logic = c(T, F, T), char = c("f", "g", "h"))	# names can be assigned to the branches of the lists
list3


list3[1]	  # subsets the whole branch of the list
list3[[1]]	# reaches the objects inside the branch

class(list3[1])
class(list3[[1]])

list3[1][1]
list3[[1]][1]

list3$num	# can also use the name of the branch to reach the objects inside of that branch
list3$char
list3$char[1]
### ***

genders <- factor(c("m", "f", "m", "m", "f"))	# factors can show categorical data
genders

genders2 <- factor(c("m", "f", "m", "m", "f"), levels = c("m", "f"), labels = c("male", "female"))	# The categories in the factors can be labeled
genders2

data()        # you can see the list of the data sets available in R.
data(mtcars)  # reading mtcars which is an available data set in R into the environment.

?mtcars
str(mtcars)     # structure of the data set
summary(mtcars) # descriptive statistics of the variables
# Four variables are actually categorical variables, but they 
# are defined as numericals in the data set. Therefore, descriptive statistics
# about these variables are meaningless. We need to convert them into factors.

mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)
summary(mtcars)
