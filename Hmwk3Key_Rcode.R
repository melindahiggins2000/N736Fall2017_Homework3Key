# ==================================
# Homework 3 Answer Key
# 
# Melinda Higgins, PhD
# dated 11/5/2017
# ==================================

# ==================================
# we're be working with the 
# helpmkh dataset
# ==================================

library(tidyverse)
library(haven)

helpdat <- haven::read_spss("helpmkh.sav")

# ============================================.
# For this homework we'll use the helpmkh dataset
#
# Let's review the baseline variables
# overall and by treat group
# ============================================.

h1 <- helpdat %>%
  select(treat, age, pss_fr, pcs, mcs, cesd,
         a15a, a15b, d1, e2b, i1, i2, female,
         racegrp, homeless, g1b)

# get descriptive stats for a selection of vars
h1 %>%
  select(age, pss_fr, pcs, mcs, cesd,
         a15a, a15b, d1, e2b, i1, i2) %>%
  summary()

# get more stats with pastecs::stat.desc()
library(pastecs)
h1 %>%
  select(age, pss_fr, pcs, mcs, cesd,
         a15a, a15b, d1, e2b, i1, i2) %>%
  pastecs::stat.desc()

# get frequency tables for categorical vars
table(h1$female)
table(h1$racegrp)
table(h1$homeless)
table(h1$g1b)

# can also use the CrossTable function
# from the gmodels package
# get frequencies and proportions
# by group and overall
# and get chi-square tests
# use the Pearson's Chi-square tests
# without the Yates continuity correction
library(gmodels)
gmodels::CrossTable(h1$female, h1$treat,
           expected=TRUE,
           prop.r=FALSE,
           prop.t=FALSE,
           prop.chisq=FALSE,
           chisq=TRUE,
           fisher=TRUE)

gmodels::CrossTable(h1$racegrp, h1$treat,
                    expected=TRUE,
                    prop.r=FALSE,
                    prop.t=FALSE,
                    prop.chisq=FALSE,
                    chisq=TRUE,
                    fisher=TRUE)

gmodels::CrossTable(h1$homeless, h1$treat,
                    expected=TRUE,
                    prop.r=FALSE,
                    prop.t=FALSE,
                    prop.chisq=FALSE,
                    chisq=TRUE,
                    fisher=TRUE)

gmodels::CrossTable(h1$g1b, h1$treat,
                    expected=TRUE,
                    prop.r=FALSE,
                    prop.t=FALSE,
                    prop.chisq=FALSE,
                    chisq=TRUE,
                    fisher=TRUE)

# run homogenity of variance tests
# for the t-tests to see if you need
# pooled or unpooled t-tests
# all were ok - run pooled t.tests
# set var.equal=TRUE
bartlett.test(age ~ treat, data=h1)
t.test(age ~ treat, h1, var.equal=TRUE)

bartlett.test(pss_fr ~ treat, data=h1)
t.test(pss_fr ~ treat, h1, var.equal=TRUE)

bartlett.test(pcs ~ treat, data=h1)
t.test(pcs ~ treat, h1, var.equal=TRUE)

bartlett.test(mcs ~ treat, data=h1)
t.test(mcs ~ treat, h1, var.equal=TRUE)

bartlett.test(cesd ~ treat, data=h1)
t.test(cesd ~ treat, h1, var.equal=TRUE)

# run Mann Whitney/Wilcoxon non-parametric tests
wilcox.test(a15a ~ treat, h1)
wilcox.test(a15b ~ treat, h1)
wilcox.test(d1 ~ treat, h1)
wilcox.test(e2b ~ treat, h1)
wilcox.test(i1 ~ treat, h1)
wilcox.test(i2 ~ treat, h1)


