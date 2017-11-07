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

proc means data=helpmkh;





proc corr data=helpmkh;
  var homeless age female pss_fr pcs mcs cesd indtot;
  run;

* ============================================.
* Given the stronger correlation between indtot
* and homeless, let's run a t-test to see the comparison
* ============================================;

proc ttest data=helpmkh;
  class homeless;
  var indtot;
  run;

* ============================================.
* Let's run a logistic regression of indtot to predict
* the probability of being homeless
* we'll also SAVE the predicted probabilities
* and the predicted group membership
*
* let's look at different thresholds pprob
* ctable gives us the classification table
*
* use the plots=roc to get the ROC curve
* ============================================;

proc logistic data=helpmkh plots=roc;
  model homeless = indtot / ctable pprob=(0.2 to 0.8 by 0.1);
  output out=m1 p=prob;
  run;

* ============================================
  using the saved probabilities
  make a plot against the indtot predictor
* ============================================;

proc gplot data = m1;
  plot prob*indtot;
run;

* ============================================.
* Given the correlation matrix above, it looks like
* gender, pss_fr, pcs, and indtot are all significantly
* associated with being homeless
*
* let's put all of these together into 1
* model
* ============================================;

proc logistic data=helpmkh;
  model homeless = female pss_fr pcs indtot;
  run;

* ============================================
  let's also run using variable selection
* ============================================;

proc logistic data=helpmkh;
  model homeless = female pss_fr pcs indtot / selection=forward;
  run;
