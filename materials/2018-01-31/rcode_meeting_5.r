############################################################################

### 2018/01/31
### Fifth Meeting of the SCRUM Club
### Topic: Last Session on R (for now)

############################################################################

### show installed packages

library()

### see installation location, version, and 'priority'

installed.packages()[, c("LibPath", "Version", "Priority")]

### list loaded packages

print(.packages())

### packages for which there is a new version

old.packages()
old.packages()[, c("LibPath", "Installed", "ReposVer")]

### update packages

update.packages()

### all packages available on CRAN:
### https://cran.r-project.org/web/packages/available_packages_by_name.html

### how many are currently available?
nrow(available.packages(contrib.url("http://cran.r-project.org")))

### growth in number of packages over the years

setwd("/home/wviechtb/work/orgs_grps_assocs/scrum-club/meetings/2018-01-31")

dat <- read.table("data_packages.dat", header=TRUE, colClasses=c("character", "integer", "Date"))

par(mar=c(6,5.5,4,2))
par(mgp=c(4,1,0))
plot(dat$date, dat$count, type="p", pch=19, cex=1.2, xlab="", ylab="Number of CRAN Packages", xaxt="n", yaxt="n")
grid(nx=10, ny=10)
axis(side=1, at=dat$date, label=dat$date, las=2, cex.axis=0.7)
axis(side=2, at=seq(0,12000,500), las=2)
axis(side=3, at=dat$date, label=dat$vers, las=2, cex.axis=0.7)

res <- loess(count ~ as.numeric(date), data=dat)
sav <- predict(res)
lines(dat$date, sav, lwd=2, col="gray70")

points(dat$date, dat$count, type="p", pch=19, cex=1.2)

### task views: https://cran.r-project.org/web/views/

### search among installed packages (title and description)

help.search("factor analysis")

### install and load sos package

#install.packages("sos")
library(sos)

### search all packages on CRAN for a term

findFn("structural equation modeling")

### get nothing if there are too many hits :(

findFn("factor analysis")

### install and load CRANsearcher package

#install.packages("CRANsearcher")
library(CRANsearcher)

### try CRANsearcher

CRANsearcher()

### some websites to search all CRAN packages
### - https://www.r-pkg.org/
### - https://www.rdocumentation.org/
### - https://rseek.org/
### - https://crantastic.org/

### Journal of Statistical Software: https://www.jstatsoft.org/

### R packages not on CRAN:
### - Bioconductor: https://www.bioconductor.org/
### - R-Forge: https://r-forge.r-project.org/
### - GitHub: https://github.com/
### - ...

############################################################################

### package vignettes are often a good way to learn how a package works
### example: https://cran.r-project.org/package=lme4

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

### citing R and packages

citation()
citation("sos")

############################################################################

### where to get help:
### - Google!
### - R mailing lists: https://www.r-project.org/mail.html
###   read posting guide first: https://www.r-project.org/posting-guide.html
### - Stack Exchange: https://stackexchange.com/
###   especially https://stackoverflow.com/ and https://stats.stackexchange.com/

############################################################################

### ggplot2: http://ggplot2.tidyverse.org/

setwd("/home/wviechtb/work/orgs_grps_assocs/scrum-club/meetings/2018-01-31")

dat <- read.table("data_packages.dat", header=TRUE, colClasses=c("character", "integer", "Date"))

#install.packages("ggplot2")
library(ggplot2)

ggplot(data=dat, aes(x=as.numeric(date), y=count)) +
       geom_smooth(method="loess", se=FALSE, color="gray70") + geom_point(size=4) +
       theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=10),
             axis.text.y  = element_text(size=15),
             axis.title.y = element_text(face="bold", size=15),
             panel.grid.major = element_blank(),
             panel.grid.minor = element_blank()) +
       scale_x_continuous("", breaks=as.numeric(dat$date), labels=dat$date,
             sec.axis = sec_axis(~., breaks=as.numeric(dat$date), labels=dat$vers)) +
       scale_y_continuous("Number of CRAN Packages", breaks=seq(0,12000,500))

### there are even more graphing packages

library(lattice)

xyplot(conc ~ time | Subject, data=Indometh,
       panel = function(x,y) panel.xyplot(x, y, pch=19, type="o"))

############################################################################

### tidyverse: https://www.tidyverse.org/

### Shiny: https://shiny.rstudio.com/

### other R implementations:
### - https://mran.microsoft.com/open
### - https://github.com/oracle/fastr
### - http://www.renjin.org/
### - http://www.pqr-project.org/
### - ...

############################################################################

### in general how to proceed
### - 'official' manuals: https://cran.r-project.org/manuals.html
### - contributed documentation: https://cran.r-project.org/other-docs.html
### - books: https://www.r-project.org/doc/bib/R-books.html
### - UseR! series: https://www.springer.com/series/6991
### - search amazon.com for "R":
###   http://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=R
### - R-Bloggers: https://www.r-bloggers.com/
### most importantly: tackle a concrete problem/task/project using R

############################################################################
