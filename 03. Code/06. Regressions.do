/******************************************************************************
File: 06.Regression.do
Purpose: Regressions of the data and regression analysis
Names: Bishmay, Manya
******************************************************************************/

clear all

use "$output/Required/final_required.dta", clear

replace literacy = "1" if literacy == "Y"
replace literacy = "0" if literacy == "N"
replace literacy = "0" if literacy == "Not Applicable"

encode literacy, gen(literacy1)
cap drop literacy
cap rename literacy1 literacy

* Step 1: Generate indicator variable for post-cutoff
gen post_cutoff = quarter >= tq(2020q2)

* Step 2: Center the running variable around the cutoff
gen centered_quarter = quarter - tq(2020q2)

* Step 3: Run separate regressions for pre- and post-cutoff
// reg share_edu_inc centered_quarter if post_cutoff == 0
display "Pre-Cutoff Coefficients:"
// reg share_edu_inc centered_quarter if post_cutoff == 1
display "Post-Cutoff Coefficients:"

* Step 4: Estimate RD effect (ATE as the jump at the cutoff)
// reg share_edu_inc c.centered_quarter##i.post_cutoff

// reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

* Interpretation:
* - The coefficient of `1.post_cutoff` in the RD regression represents the jump at the cutoff (ATE).
* - Coefficients of `centered_quarter` and the interaction term represent slope changes.

gen size_number = .
replace size_number = real(substr(size_group, 1, strpos(size_group, "-") - 1)) if strpos(size_group, "-") > 0
replace size_number = real(substr(size_group, 1, strpos(size_group, " ") - 1)) if missing(size_number)

replace region_type = "1" if region_type == "URBAN"
replace region_type = "0" if region_type == "RURAL"

encode religion, gen(religion1)
cap drop religion
rename religion1 religion

encode caste_category, gen (caste_category1)
cap drop caste_category
rename caste_category1 caste_category

save "$output/Required/final_required.dta", replace

* Loading the dataset

use "$output/Required/final_required.dta", clear

* Step 1: Run the three regressions for different models
 
* Model 1: Baseline regression without controls
reghdfe share_edu_inc c.centered_quarter##i.religion##i.post_cutoff, absorb(hh_id) cluster(hh_id)
eststo model1

* Model 2: Add controls
reghdfe share_edu_inc c.centered_quarter##i.religion##i.post_cutoff age_yrs literacy m_exp_internet m_exp_religious_obligations, absorb(hh_id) cluster(hh_id)
eststo model2

* Model 3: Add fixed effects
reghdfe share_edu_inc c.centered_quarter##i.religion##i.post_cutoff age_yrs literacy m_exp_internet m_exp_religious_obligations, absorb(hh_id centered_quarter religion) cluster(hh_id)
eststo model3

esttab model1 model2 model3 using "$latex/Tables/regression_table_religion.tex", replace wide label


* Model 1: Baseline regression without controls
reghdfe share_edu_inc c.centered_quarter##i.caste_category##i.post_cutoff, absorb(hh_id) cluster(hh_id)
eststo caste1

* Model 2: Add controls
reghdfe share_edu_inc c.centered_quarter##i.caste_category##i.post_cutoff age_yrs literacy m_exp_internet m_exp_religious_obligations, absorb(hh_id) cluster(hh_id)
eststo caste2

* Model 3: Add fixed effects
reghdfe share_edu_inc c.centered_quarter##i.caste_category##i.post_cutoff age_yrs literacy m_exp_internet m_exp_religious_obligations, absorb(hh_id centered_quarter caste_category) cluster(hh_id)
eststo caste3

esttab caste1 caste2 caste3 using "$latex/Tables/regression_table_caste.tex", replace wide label


/*
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

reghdfe share_edu_inc c.centered_quarter##i.post_cutoff age_yrs literacy m_exp_internet m_exp_religious_obligations, absorb(religion)

reghdfe share_edu_inc c.centered_quarter##i.post_cutoff i.religion##i.post_cutoff age_yrs literacy m_exp_internet m_exp_religious_obligations, absorb(hh_id religion) cluster(district)

reghdfe share_edu_inc ///
    c.centered_quarter##i.religion##i.post_cutoff ///
    age_yrs literacy m_exp_internet m_exp_religious_obligations, ///
    absorb(hh_id) cluster(hh_id)
*/

* With religion cutoffs

* Hindu


preserve
keep if religion == "Hindu"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff 

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* Muslims 

preserve
keep if religion == "Muslim"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* Christians

preserve
keep if religion == "Christian"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* Buddhists

preserve
keep if religion == "Buddhist"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* Jains

preserve
keep if religion == "Jain"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* Sikhs

preserve
keep if religion == "Sikh"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* With caste cuts

* Upper Caste

preserve
keep if caste_category == "Upper Caste"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* Intermediate Caste

preserve
keep if caste_category == "Intermediate Caste"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* SC 

preserve
keep if caste_category == "SC"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* ST 

preserve
keep if caste_category == "ST"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore

* OBC

preserve
keep if caste_category == "OBC"

* Regression for Share of Education across Religions
reg share_edu_inc c.centered_quarter##i.post_cutoff

* Regression for Education Expenditure across Religions
reg total_edu_exp_hh c.centered_quarter##i.post_cutoff

restore
