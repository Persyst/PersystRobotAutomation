*** Settings ***
Documentation    This test is going to test User Shared Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Suite Setup      Run Keywords       Begin Web Suit              AND         Reset Shared Settings
Suite Teardown   Run Keywords       Reset Shared Settings       AND         End Web Suit

*** Variables ***
${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_EEG_URL}   http://192.168.156.119/PersystMobile/record-views/eeg/37508/0?readOnly=false
${Patient_Name}         LnP14D3Nw10ICU
${Patient_Record_Name}          xpath=//div[text()=' Moji Unit ']/../../following-sibling::div

# Command line to run this test: robot -d results Tests/Web/Shared_Settings.robot

*** Test Cases ***
Test Create Unit and Assignment
    Navigate to Unit Definitions in Shared Settings
    PersystWebApp.Add a New Unit in Shared Settings                   Moji Unit     This is description
    PersystWebApp.Assign a Patient to a Unit from Shared Setting      Moji Unit     ${Patient_Name}
    PersystWebApp.Navigate From Setting to Patient View
    wait until page contains element    ${Patient_Record_Name}      40s
    ${Patient_Record_Name}    get text        ${Patient_Record_Name}
    should contain    ${Patient_Record_Name}       ${Patient_Name}

Test Shared Comment Filters
    PersystWebApp.Go To Settings Page
    PersystWebApp.Navigate to Shared Settings
    PersystWebApp.Navigate to 'Shared Comment Filters' Settings Under Shared Setting
    page should contain    The shared filters are read only based on your privileges. Click on a filter to see its properties.

Test Standard Comment
    PersystWebApp.Go To Settings Page
    PersystWebApp.Add a New Standard Comment From Shared Setting
    PersystWebApp.Go To EEG Page By URL    ${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_EEG_URL}
    PersystWebApp.Reset Quick Comment Modal
    ${New_Comment}      set variable    xpath=//span[text()='New Moji Comment']
    page should contain element   ${New_Comment}



