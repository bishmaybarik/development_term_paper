/******************************************************************************
File: 05. Summary.do
Purpose: Summary statistics of the data and regression analysis
Names: Bishmay, Manya
******************************************************************************/
clear all

use "$output/final.dta", clear

* Fixing the date variable

* Step 1: Convert the month variable to a stata date format
cap gen month_date = monthly(month, "MY")
format month_date %tm

* Step 2: Create the quarter variable
cap gen quarter = qofd(dofm(month_date))
format quarter %tq

* Step 3: Drop observations before 2019q1

drop if quarter < tq(2019q1)

* Step 4: Adjust 'quarter' variable for binscatter to centre around 2020q2

cap gen quarter_centered = quarter - tq(2020q2)

* Generating total educational expenditure of households

cap gen total_edu_exp_hh = m_exp_edu + m_exp_books_journals + m_exp_school_academic_books + m_exp_fiction_non_fiction_books + m_exp_stationery + m_exp_school_college_fees + m_exp_pvt_tuition_fees + m_exp_hobby_classes + m_exp_school_transport + m_exp_additional_prof_edu + m_exp_overseas_edu + m_exp_oth_edu

* Generating total income of members

cap gen total_income_mem = inc_of_mem_frm_all_srcs + inc_of_mem_frm_wages + inc_of_mem_frm_pension + inc_of_mem_frm_dividend + inc_of_mem_frm_interest + inc_of_mem_frm_fd_pf_ins

* Generating household income

* Generate household-level monthly income

rename total_income_mem total_inc_mem

cap egen total_inc_hh = total(total_inc_mem), by(hh_id month)

* Dropping redundant variables

cap drop inc_of_mem_frm_all_srcs inc_of_mem_frm_wages inc_of_mem_frm_pension inc_of_mem_frm_dividend inc_of_mem_frm_interest inc_of_mem_frm_fd_pf_ins m_exp_edu m_exp_books_journals m_exp_school_academic_books m_exp_fiction_non_fiction_books m_exp_stationery m_exp_school_college_fees m_exp_pvt_tuition_fees m_exp_hobby_classes m_exp_school_transport m_exp_additional_prof_edu m_exp_overseas_edu m_exp_oth_edu

cap drop month_slot emigration_immigration_reason age_mths relation_with_hoh marital_status caste edu discipline industry_of_occupation occupation age_group occupation_group edu_group gender_group

cap gen total_health_exp = m_exp_health + m_exp_medicines + m_exp_doctors_physio_fee + m_exp_medical_tests + m_exp_hospitalisation_fees + m_exp_health_ins_premium + m_exp_health_enhancement + m_exp_hygiene_prds

cap drop m_exp_health m_exp_medicines m_exp_doctors_physio_fee m_exp_medical_tests m_exp_hospitalisation_fees m_exp_health_ins_premium m_exp_health_enhancement m_exp_hygiene_prds

cap gen other_exp = m_exp_food + m_exp_cigarettes + m_exp_recreation + m_exp_electricity + m_exp_transport + m_exp_bus_train_n_ferry + m_exp_outstation_taxi_bus_train + m_exp_autorickshaw_n_cab + m_exp_landline_phone + m_exp_cell_phone + m_exp_cable_tv + m_exp_domestic_help + m_exp_social_obligations + m_exp_pocket_money + m_exp_pets

cap drop m_exp_food m_exp_cigarettes m_exp_recreation m_exp_electricity m_exp_transport m_exp_bus_train_n_ferry m_exp_outstation_taxi_bus_train m_exp_autorickshaw_n_cab m_exp_landline_phone m_exp_cell_phone m_exp_cable_tv m_exp_domestic_help m_exp_social_obligations m_exp_pocket_money m_exp_pets

cap gen share_edu_inc = total_edu_exp_hh/total_inc_hh

* Saving the new dataset

save "$output/Required/final_required.dta", replace

export delimited "$output/Required/final_required.csv", replace


* Making religion cuts

preserve
keep if religion == "Hindu"
save "$output/Required/relcuts/dta/hindu.dta", replace
export delimited "$output/Required/relcuts/csv/hindu.csv", replace
restore

preserve
keep if religion == "Muslim"
save "$output/Required/relcuts/dta/muslim.dta", replace
export delimited "$output/Required/relcuts/csv/muslim.csv", replace
restore

preserve
keep if religion == "Christian"
save "$output/Required/relcuts/dta/christian.dta", replace
export delimited "$output/Required/relcuts/csv/christian.csv", replace
restore

preserve
keep if religion == "Jain"
save "$output/Required/relcuts/dta/jain.dta", replace
export delimited "$output/Required/relcuts/csv/jain.csv", replace
restore

preserve
keep if religion == "Sikh"
save "$output/Required/relcuts/dta/sikh.dta", replace
export delimited "$output/Required/relcuts/csv/sikh.csv", replace
restore

preserve
keep if religion == "Khasi"
save "$output/Required/relcuts/dta/khasi.dta", replace
export delimited "$output/Required/relcuts/csv/khasi.csv", replace
restore
