/******************************************************************************
File: 00. Master.do
Purpose: This is a do file, which sets the working directory of the respective authors. Please make sure you run this do file first before working on the rest of the do-files.
Names: Bishmay, Manya
******************************************************************************/

clear all
macro drop all
set more off

* global dir "/Users/bishmaybarik/Library/CloudStorage/OneDrive-ShivNadarInstitutionofEminence/Development Economics Term Paper MB" // Bishmay's Directory

* global dir "C:/Users/mp978/OneDrive - Shiv Nadar Institution of Eminence/Development Economics Term Paper MB" // Manya's Directory

* global dir "C:/Users/Admin/OneDrive - Shiv Nadar Institution of Eminence/Development Economics Term Paper MB" // Manya's Directory (laptop)

global dir "C:/Users/bb285/OneDrive - Shiv Nadar Institution of Eminence/Development Economics Term Paper MB" // Bishmay's Econ




* Setting the sub-folders

global raw "$dir/01. Raw"
global output "$dir/02. Output"
global latex "$dir/04. Latex"

* Setting sub-sub folders

global figure "$latex/Figures"
