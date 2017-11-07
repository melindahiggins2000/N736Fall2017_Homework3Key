* ==================================
  be sure to load the helpmkh.sas7bdat 
  dataset - run the helpmkh.sas program
  to apply the codebook and formats

  HOMEWORK 3 ANSWER KEY - SAS CODE
* ===================================;

* make a copy to WORK;

data helpmkh;
  set library.helpmkh;
  run;

* run proc univariate to get descriptive stats
  and check the normality assumptions of the
  following numeric/continuous vars;

proc univariate data=helpmkh plots;
  var age pss_fr pcs mcs cesd a15a a15b d1 e2b i1 i2;
  run;

* get frequencies for categorical variables;

proc freq data=helpmkh;
  tables female racegrp homeless g1b;
  run;

* use proc means to get summary stats by group
  parametric stats first;

proc means data=helpmkh n min max mean std;
  class treat;
  var age pss_fr pcs mcs cesd;
  run;

* non-parametric stats next;

proc means data=helpmkh n min max median q1 q3;
  class treat;
  var a15a a15b d1 e2b i1 i2;
  run;

* run t-tests for the parametric vars;

proc ttest data=helpmkh;
  class treat;
  var age pss_fr pcs mcs cesd;
  run;

* run Mann Whitney tests for the non-parametric vars;

proc npar1way data=helpmkh wilcoxon;
  class treat;
  var a15a a15b d1 e2b i1 i2;
  run;

* run chi-square tests for the categorical vars
  female racegrp homeless g1b
  and get the column % within groups;

proc freq data=helpmkh;
  table female*treat / chisq fisher expected norow nopercent;
  run;

proc freq data=helpmkh;
  table racegrp*treat / chisq fisher expected norow nopercent;
  run;

proc freq data=helpmkh;
  table homeless*treat / chisq fisher expected norow nopercent;
  run;

proc freq data=helpmkh;
  table g1b*treat / chisq fisher expected norow nopercent;
  run;
