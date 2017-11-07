* Encoding: UTF-8.
* ============================================.
* Homework 3 - Answer Key
*
* Melinda Higgins, PhD
* dated 10/30/2017
* ============================================.

* ============================================.
* Working with the helpmkh.sav dataset
* ============================================.

* ============================================.
* Descriptive statistics for the variables for the whole sample
* ============================================.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=age pss_fr pcs mcs cesd a15a a15b d1 e2b i1 i2 female racegrp homeless g1b
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* ============================================.
* Descriptive stats by Treatment Group
* ============================================.

SORT CASES  BY treat.
SPLIT FILE LAYERED BY treat.

FREQUENCIES VARIABLES=age pss_fr pcs mcs cesd a15a a15b d1 e2b i1 i2 female racegrp homeless g1b
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

SPLIT FILE OFF.

* ============================================.
* T-tests to compare these normally distributed
* variables by treatment group
* ============================================.

T-TEST GROUPS=treat(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=age pss_fr pcs mcs cesd
  /CRITERIA=CI(.95).

* ============================================.
* non-parametric Mann Whiteny tests for
* the non-normal/skewed variables by treatment group
* ============================================.

NPAR TESTS
  /M-W= a15a a15b d1 e2b i1 i2 BY treat(0 1)
  /STATISTICS=DESCRIPTIVES QUARTILES
  /MISSING ANALYSIS.

* ============================================.
* run chi-square tests for the categorical, dichotomous
* variables - check expected counts
* and report relative %'s within column
* i.e. %s within treatment group
* ============================================.

CROSSTABS
  /TABLES=female racegrp homeless g1b BY treat
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).
