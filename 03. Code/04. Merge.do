/******************************************************************************
File: 04. Merge.do
Purpose: In this do file, we have merged and appended the data to add covariates.
Names: Bishmay, Manya
******************************************************************************/

clear all

// Converting Household Files - CSV
local csv_dir "$raw/IP_csv"

// Converted Household Files - DTA
local dta_dir "$output/IP_dta"

// List of File Names

local files "member_income_20170131_MS_rev member_income_20170228_MS_rev member_income_20170331_MS_rev member_income_20170430_MS_rev member_income_20170531_MS_rev member_income_20170630_MS_rev member_income_20170731_MS_rev member_income_20170831_MS_rev member_income_20170930_MS_rev member_income_20171031_MS_rev member_income_20171130_MS_rev member_income_20171231_MS_rev member_income_20180131_MS_rev member_income_20180228_MS_rev member_income_20180331_MS_rev member_income_20180430_MS_rev member_income_20180531_MS_rev member_income_20180630_MS_rev member_income_20180731_MS_rev member_income_20180831_MS_rev member_income_20180930_MS_rev member_income_20181031_MS_rev member_income_20181130_MS_rev member_income_20181231_MS_rev member_income_20190131_MS_rev member_income_20190228_MS_rev member_income_20190331_MS_rev member_income_20190430_MS_rev member_income_20190531_MS_rev member_income_20190630_MS_rev member_income_20190731_MS_rev member_income_20190831_MS_rev member_income_20190930_MS_rev member_income_20191031_MS_rev member_income_20191130_MS_rev member_income_20191231_MS_rev member_income_20200131_MS_rev member_income_20200229_MS_rev member_income_20200331_MS_rev member_income_20200430_MS_rev member_income_20200531_MS_rev member_income_20200630_MS_rev member_income_20200731_MS_rev member_income_20200831_MS_rev member_income_20200930_MS_rev member_income_20201031_MS_rev member_income_20201130_MS_rev member_income_20201231_MS_rev member_income_20210131_MS_rev member_income_20210228_MS_rev member_income_20210331_MS_rev member_income_20210430_MS_rev member_income_20210531_MS_rev member_income_20210630_MS_rev member_income_20210731_MS_rev member_income_20210831_MS_rev member_income_20210930_MS_rev member_income_20211031_MS_rev member_income_20211130_MS_rev member_income_20211231_MS_rev"

// Loop over each file, import the CSV, and save as .dta
foreach file of local files {
    // Display the current file being processed
    di "Processing `file'.csv"

    // Import the CSV file
    import delimited "`csv_dir'/`file'_csv/`file'.csv", clear

    // Save the data as a .dta file
    save "`dta_dir'/`file'.dta", replace
}

di "All files have been processed and saved as .dta files."

********* APPENDING THE DATA ************

* Converted Household Files - DTA
local dta_dir "$output/IP_dta"

use "$output/IP_dta/member_income_20211231_MS_rev.dta", clear

local files "member_income_20170131_MS_rev member_income_20170228_MS_rev member_income_20170331_MS_rev member_income_20170430_MS_rev member_income_20170531_MS_rev member_income_20170630_MS_rev member_income_20170731_MS_rev member_income_20170831_MS_rev member_income_20170930_MS_rev member_income_20171031_MS_rev member_income_20171130_MS_rev member_income_20171231_MS_rev member_income_20180131_MS_rev member_income_20180228_MS_rev member_income_20180331_MS_rev member_income_20180430_MS_rev member_income_20180531_MS_rev member_income_20180630_MS_rev member_income_20180731_MS_rev member_income_20180831_MS_rev member_income_20180930_MS_rev member_income_20181031_MS_rev member_income_20181130_MS_rev member_income_20181231_MS_rev member_income_20190131_MS_rev member_income_20190228_MS_rev member_income_20190331_MS_rev member_income_20190430_MS_rev member_income_20190531_MS_rev member_income_20190630_MS_rev member_income_20190731_MS_rev member_income_20190831_MS_rev member_income_20190930_MS_rev member_income_20191031_MS_rev member_income_20191130_MS_rev member_income_20191231_MS_rev member_income_20200131_MS_rev member_income_20200229_MS_rev member_income_20200331_MS_rev member_income_20200430_MS_rev member_income_20200531_MS_rev member_income_20200630_MS_rev member_income_20200731_MS_rev member_income_20200831_MS_rev member_income_20200930_MS_rev member_income_20201031_MS_rev member_income_20201130_MS_rev member_income_20201231_MS_rev member_income_20210131_MS_rev member_income_20210228_MS_rev member_income_20210331_MS_rev member_income_20210430_MS_rev member_income_20210531_MS_rev member_income_20210630_MS_rev member_income_20210731_MS_rev member_income_20210831_MS_rev member_income_20210930_MS_rev member_income_20211031_MS_rev member_income_20211130_MS_rev "

* Converted Household Files - DTA
local dta_dir "$output/IP_dta"

* Loop over each file, import the CSV, and save as .dta
foreach file of local files {
    
	* Display the current file being processed
    di "Processing `file'"
	append using "`dta_dir'/`file'.dta"
}

save "$output/IP_covariates.dta", replace


* Saving the data

save "$output/final.dta", replace

********************************************************************************
********************************************************************************
**************************** Trimming variables ********************************
********************************************************************************
********************************************************************************

use "$output/IP_covariates.dta", clear

cap keep hh_id mem_id state district region_type month month_slot emigration_immigration_reason gender age_yrs age_mths relation_with_hoh marital_status religion caste caste_category literacy edu discipline nature_of_occupation industry_of_occupation occupation inc_of_mem_frm_all_srcs inc_of_mem_frm_wages inc_of_mem_frm_pension inc_of_mem_frm_dividend inc_of_mem_frm_interest inc_of_mem_frm_fd_pf_ins

cap drop if age_yrs < 0

cap drop if religion == "Data Not Available"
cap drop if religion == "Not Applicable"
cap drop if caste_category == "Data Not Available"
cap drop if caste_category == "Not Applicable"

save "$output/IP_covariates.dta", replace

*************************** CP Covariates **************************************

use "$output/CP_covariates.dta", clear

cap keep hh_id month age_group occupation_group edu_group gender_group size_group tot_exp adj_tot_exp m_exp_food adj_m_exp_food m_exp_cigarettes m_exp_mobiles_n_accessories m_exp_recreation m_exp_electricity m_exp_transport m_exp_bus_train_n_ferry m_exp_outstation_taxi_bus_train m_exp_autorickshaw_n_cab m_exp_cell_phone m_exp_landline_phone m_exp_edu m_exp_internet m_exp_cable_tv m_exp_books_journals m_exp_school_academic_books m_exp_fiction_non_fiction_books m_exp_stationery m_exp_school_college_fees m_exp_pvt_tuition_fees m_exp_hobby_classes m_exp_school_transport m_exp_additional_prof_edu m_exp_overseas_edu m_exp_oth_edu m_exp_health m_exp_medicines m_exp_doctors_physio_fee m_exp_medical_tests m_exp_hospitalisation_fees m_exp_health_ins_premium m_exp_health_enhancement m_exp_domestic_help m_exp_social_obligations m_exp_religious_obligations m_exp_pocket_money m_exp_pets m_exp_hygiene_prds

cap drop if age_group == "Data Not Available"

save "$output/CP_covariates.dta", replace

*************************** Merge **************************************

use "$output/IP_covariates.dta", clear

merge m:1 hh_id month using "$output/CP_covariates.dta"

save "$output/final.dta", replace

cap drop if _merge == 2

cap drop _merge

save "$output/final.dta", replace
