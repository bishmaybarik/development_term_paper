/******************************************************************************
File: 02. covariates.do
Purpose: In this do file, we have merged and appended the data to add covariates.
Names: Bishmay, Manya
******************************************************************************/
// Covariates from People of India
******************************************************************************/
clear all

// Converting Household Files - CSV
local csv_dir "$raw/POI_csv"

// Converted Household Files - DTA
local dta_dir "$output/POI_dta"

// List of File Names

local files "people_of_india_20170101_20170430_R people_of_india_20170501_20170831_R people_of_india_20170901_20171231_R people_of_india_20180101_20180430_R people_of_india_20180501_20180831_R people_of_india_20180901_20181231_R people_of_india_20190101_20190430_R people_of_india_20190501_20190831_R people_of_india_20190901_20191231_R people_of_india_20200101_20200430_R people_of_india_20200501_20200831_R people_of_india_20200901_20201231_R people_of_india_20210101_20210430_R people_of_india_20210501_20210831_R people_of_india_20210901_20211231_R"

// Loop over each file, import the CSV, and save as .dta
foreach file of local files {
    // Display the current file being processed
    di "Processing `file'.csv"

    // Import the CSV file
    import delimited "`csv_dir'/`file'.csv", clear

    // Save the data as a .dta file
    save "`dta_dir'/`file'.dta", replace
}

di "All files have been processed and saved as .dta files."

********* APPENDING THE DATA ************
* Converting Household Files - CSV
local csv_dir "$raw/POI_csv"

* Converted Household Files - DTA
local dta_dir "$output/POI_dta"

use "$output/POI_dta/people_of_india_20170101_20170430_R", clear
keep hh_id mem_id district month_slot state discipline gender religion caste is_healthy is_on_regular_medication has_creditcard has_kisan_creditcard has_mobile has_health_ins has_lic has_bank_ac 

local files "people_of_india_20170101_20170430_R people_of_india_20170501_20170831_R people_of_india_20170901_20171231_R people_of_india_20180101_20180430_R people_of_india_20180501_20180831_R people_of_india_20180901_20181231_R people_of_india_20190101_20190430_R people_of_india_20190501_20190831_R people_of_india_20190901_20191231_R people_of_india_20200101_20200430_R people_of_india_20200501_20200831_R people_of_india_20200901_20201231_R people_of_india_20210101_20210430_R people_of_india_20210501_20210831_R people_of_india_20210901_20211231_R"

* Loop over each file and append all dta files
foreach file of local files {
    
	* Display the current file being processed
    di "Processing `file'"
	append using "`dta_dir'/`file'.dta", keep(hh_id mem_id district month_slot state discipline gender religion caste is_healthy is_on_regular_medication has_creditcard has_kisan_creditcard has_mobile has_health_ins has_lic has_bank_ac)
}

save "$output/POI_covariates", replace

******************************************************************************/
// Covariates from Aspirational India
******************************************************************************/
clear all

// Converting Household Files - CSV
local csv_dir "$raw/AI_csv"

// Converted Household Files - DTA
local dta_dir "$output/AI_dta"

// List of File Names

local files "aspirational_india_20170101_20170430_R aspirational_india_20170501_20170831_R aspirational_india_20170901_20171231_R aspirational_india_20180101_20180430_R aspirational_india_20180501_20180831_R aspirational_india_20180901_20181231_R aspirational_india_20190101_20190430_R aspirational_india_20190501_20190831_R aspirational_india_20190901_20191231_R aspirational_india_20200101_20200430_R aspirational_india_20200501_20200831_R aspirational_india_20200901_20201231_R aspirational_india_20210101_20210430_R aspirational_india_20210501_20210831_R aspirational_india_20210901_20211231_R"

// Loop over each file, import the CSV, and save as .dta
foreach file of local files {
    // Display the current file being processed
    di "Processing `file'.csv"

    // Import the CSV file
    import delimited "`csv_dir'/`file'.csv", clear

    // Save the data as a .dta file
    save "`dta_dir'/`file'.dta", replace
}

di "All files have been processed and saved as .dta files."

********* APPENDING THE DATA ************
* Converting Household Files - CSV
local csv_dir "$raw/AI_csv"

* Converted Household Files - DTA
local dta_dir "$output/AI_dta"

use "$output/AI_dta/aspirational_india_20170101_20170430_R", clear
keep hh_id month_slot age_group inc_group occupation_group edu_group water_group power_group travel_group size_group houses_owned bought_tv bought_computer computers_owned computers_owned bought_computer cars_owned bought_car two_wheelers_owned bought_two_wheeler has_borr borr_for_edu borr_frm_bank_for_edu borr_frm_lender_for_edu borr_frm_employer_for_edu borr_frm_rel_frnds_for_edu borr_frm_nbfc_for_edu borr_frm_shg_for_edu borr_frm_mfi_for_edu borr_frm_chtfund_for_edu borr_frm_cc_for_edu borr_frm_shops_for_edu borr_frm_oth_srcs_for_edu has_access_to_water_in_house has_toilet_in_house

local files "aspirational_india_20170101_20170430_R aspirational_india_20170501_20170831_R aspirational_india_20170901_20171231_R aspirational_india_20180101_20180430_R aspirational_india_20180501_20180831_R aspirational_india_20180901_20181231_R aspirational_india_20190101_20190430_R aspirational_india_20190501_20190831_R aspirational_india_20190901_20191231_R aspirational_india_20200101_20200430_R aspirational_india_20200501_20200831_R aspirational_india_20200901_20201231_R aspirational_india_20210101_20210430_R aspirational_india_20210501_20210831_R aspirational_india_20210901_20211231_R"

* Loop over each file and append all dta files
foreach file of local files {
    
	* Display the current file being processed
    di "Processing `file'"
	append using "`dta_dir'/`file'.dta", keep(hh_id month_slot age_group inc_group occupation_group edu_group water_group power_group travel_group size_group houses_owned bought_tv bought_computer computers_owned computers_owned bought_computer cars_owned bought_car two_wheelers_owned bought_two_wheeler has_borr borr_for_edu borr_frm_bank_for_edu borr_frm_lender_for_edu borr_frm_employer_for_edu borr_frm_rel_frnds_for_edu borr_frm_nbfc_for_edu borr_frm_shg_for_edu borr_frm_mfi_for_edu borr_frm_chtfund_for_edu borr_frm_cc_for_edu borr_frm_shops_for_edu borr_frm_oth_srcs_for_edu has_access_to_water_in_house has_toilet_in_house)
}

save "$output/AI_covariates", replace

******************************************************************************/
// Covariates from Consumption Pyramids
******************************************************************************/
clear all

// Converting Household Files - CSV
local csv_dir "$raw/CP_csv"

// Converted Household Files - DTA
local dta_dir "$output/CP_dta"

// List of File Names

local files "consumption_pyramids_20170131_MS_rev consumption_pyramids_20170228_MS_rev consumption_pyramids_20170331_MS_rev consumption_pyramids_20170430_MS_rev consumption_pyramids_20170531_MS_rev consumption_pyramids_20170630_MS_rev consumption_pyramids_20170731_MS_rev consumption_pyramids_20170831_MS_rev consumption_pyramids_20170930_MS_rev consumption_pyramids_20171031_MS_rev consumption_pyramids_20171130_MS_rev consumption_pyramids_20171231_MS_rev consumption_pyramids_20180131_MS_rev consumption_pyramids_20180228_MS_rev consumption_pyramids_20180331_MS_rev consumption_pyramids_20180430_MS_rev consumption_pyramids_20180531_MS_rev consumption_pyramids_20180630_MS_rev consumption_pyramids_20180731_MS_rev consumption_pyramids_20180831_MS_rev consumption_pyramids_20180930_MS_rev consumption_pyramids_20181031_MS_rev consumption_pyramids_20181130_MS_rev consumption_pyramids_20181231_MS_rev consumption_pyramids_20190131_MS_rev consumption_pyramids_20190228_MS_rev consumption_pyramids_20190331_MS_rev consumption_pyramids_20190430_MS_rev consumption_pyramids_20190531_MS_rev consumption_pyramids_20190630_MS_rev consumption_pyramids_20190731_MS_rev consumption_pyramids_20190831_MS_rev consumption_pyramids_20190930_MS_rev consumption_pyramids_20191031_MS_rev consumption_pyramids_20191130_MS_rev consumption_pyramids_20191231_MS_rev consumption_pyramids_20200131_MS_rev consumption_pyramids_20200229_MS_rev consumption_pyramids_20200331_MS_rev consumption_pyramids_20200430_MS_rev consumption_pyramids_20200531_MS_rev consumption_pyramids_20200630_MS_rev consumption_pyramids_20200731_MS_rev consumption_pyramids_20200831_MS_rev consumption_pyramids_20200930_MS_rev consumption_pyramids_20201031_MS_rev consumption_pyramids_20201130_MS_rev consumption_pyramids_20201231_MS_rev consumption_pyramids_20210131_MS_rev consumption_pyramids_20210228_MS_rev consumption_pyramids_20210331_MS_rev consumption_pyramids_20210430_MS_rev consumption_pyramids_20210531_MS_rev consumption_pyramids_20210630_MS_rev consumption_pyramids_20210731_MS_rev consumption_pyramids_20210831_MS_rev consumption_pyramids_20210930_MS_rev consumption_pyramids_20211031_MS_rev consumption_pyramids_20211130_MS_rev consumption_pyramids_20211231_MS_rev"

// Loop over each file, import the CSV, and save as .dta
foreach file of local files {
    // Display the current file being processed
    di "Processing `file'.csv"

    // Import the CSV file
    import delimited "`csv_dir'/`file'.csv", clear

    // Save the data as a .dta file
    save "`dta_dir'/`file'.dta", replace
}

di "All files have been processed and saved as .dta files."

********* APPENDING THE DATA ************
* Converting Household Files - CSV
local csv_dir "$raw/CP_csv"

* Converted Household Files - DTA
local dta_dir "$output/CP_dta"

use "$output/CP_dta/consumption_pyramids_20170131_MS_rev", clear
keep hh_id month_slot month m_exp_transport adj_m_exp_transport m_exp_internet m_exp_newspapers_n_magazines m_exp_edu m_exp_books_journals m_exp_school_academic_books m_exp_fiction_non_fiction_books m_exp_stationery m_exp_school_college_fees m_exp_pvt_tuition_fees m_exp_hobby_classes m_exp_school_transport m_exp_additional_prof_edu m_exp_overseas_edu m_exp_oth_edu m_exp_health m_exp_medicines m_exp_doctors_physio_fee m_exp_medical_tests m_exp_hospitalisation_fees m_exp_fitness m_exp_pocket_money

local files "consumption_pyramids_20170131_MS_rev consumption_pyramids_20170228_MS_rev consumption_pyramids_20170331_MS_rev consumption_pyramids_20170430_MS_rev consumption_pyramids_20170531_MS_rev consumption_pyramids_20170630_MS_rev consumption_pyramids_20170731_MS_rev consumption_pyramids_20170831_MS_rev consumption_pyramids_20170930_MS_rev consumption_pyramids_20171031_MS_rev consumption_pyramids_20171130_MS_rev consumption_pyramids_20171231_MS_rev consumption_pyramids_20180131_MS_rev consumption_pyramids_20180228_MS_rev consumption_pyramids_20180331_MS_rev consumption_pyramids_20180430_MS_rev consumption_pyramids_20180531_MS_rev consumption_pyramids_20180630_MS_rev consumption_pyramids_20180731_MS_rev consumption_pyramids_20180831_MS_rev consumption_pyramids_20180930_MS_rev consumption_pyramids_20181031_MS_rev consumption_pyramids_20181130_MS_rev consumption_pyramids_20181231_MS_rev consumption_pyramids_20190131_MS_rev consumption_pyramids_20190228_MS_rev consumption_pyramids_20190331_MS_rev consumption_pyramids_20190430_MS_rev consumption_pyramids_20190531_MS_rev consumption_pyramids_20190630_MS_rev consumption_pyramids_20190731_MS_rev consumption_pyramids_20190831_MS_rev consumption_pyramids_20190930_MS_rev consumption_pyramids_20191031_MS_rev consumption_pyramids_20191130_MS_rev consumption_pyramids_20191231_MS_rev consumption_pyramids_20200131_MS_rev consumption_pyramids_20200229_MS_rev consumption_pyramids_20200331_MS_rev consumption_pyramids_20200430_MS_rev consumption_pyramids_20200531_MS_rev consumption_pyramids_20200630_MS_rev consumption_pyramids_20200731_MS_rev consumption_pyramids_20200831_MS_rev consumption_pyramids_20200930_MS_rev consumption_pyramids_20201031_MS_rev consumption_pyramids_20201130_MS_rev consumption_pyramids_20201231_MS_rev consumption_pyramids_20210131_MS_rev consumption_pyramids_20210228_MS_rev consumption_pyramids_20210331_MS_rev consumption_pyramids_20210430_MS_rev consumption_pyramids_20210531_MS_rev consumption_pyramids_20210630_MS_rev consumption_pyramids_20210731_MS_rev consumption_pyramids_20210831_MS_rev consumption_pyramids_20210930_MS_rev consumption_pyramids_20211031_MS_rev consumption_pyramids_20211130_MS_rev consumption_pyramids_20211231_MS_rev"


* Loop over each file and append all dta files
foreach file of local files {
    
	* Display the current file being processed
    di "Processing `file'"
	append using "`dta_dir'/`file'.dta", keep(hh_id month_slot month m_exp_transport adj_m_exp_transport m_exp_internet m_exp_newspapers_n_magazines m_exp_edu m_exp_books_journals m_exp_school_academic_books m_exp_fiction_non_fiction_books m_exp_stationery m_exp_school_college_fees m_exp_pvt_tuition_fees m_exp_hobby_classes m_exp_school_transport m_exp_additional_prof_edu m_exp_overseas_edu m_exp_oth_edu m_exp_health m_exp_medicines m_exp_doctors_physio_fee m_exp_medical_tests m_exp_hospitalisation_fees m_exp_fitness m_exp_pocket_money)
}

save "$output/CP_covariates", replace































