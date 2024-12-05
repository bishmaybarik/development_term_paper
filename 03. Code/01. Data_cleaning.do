/******************************************************************************
File: 01. Data_cleaning.do
Purpose: In this do file, we have done all the required data cleaning and merging.
Names: Bishmay, Manya
******************************************************************************/

//CMIE cleaning codes

clear all

use "$raw/dta/conspy_incpy_merged_2014_2021"

drop _merge

// List of variables
local vars month gender age_yrs relation_with_hoh religion caste caste_category nature_of_occupation ///
    inc_of_mem_frm_all_srcs inc_of_mem_frm_wages total_expenditure monthly_expense_on_education ///
    monthly_expense_on_school_colleg monthly_expense_on_school_academ state district region_type month_slot

// Loop through variables to drop missing observations
foreach var of local vars {
    // Check if the variable is string or numeric
    capture confirm string variable `var'
    if !_rc { 
        // If the variable is string
        cap drop if `var' == "."
    }
    else {
        // If the variable is numeric
        cap drop if `var' == .
    }
}


// Dropping logically inconsistent observations
foreach var in age_yrs inc_of_mem_frm_all_srcs inc_of_mem_frm_wages total_expenditure monthly_expense_on_education monthly_expense_on_school_colleg monthly_expense_on_school_academ total_edu_exp {
    cap drop if `var' < 0
}
cap drop if age_yrs > 100

// Only keeping the observations for years 2017 to 2021
gen year = substr(month, strpos(month, " ") + 1, .)

destring year, replace
drop if year < 2017

// saving this dataset
save "$output/main_cleaned.dta", replace