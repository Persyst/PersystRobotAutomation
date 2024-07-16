*** Settings ***
Documentation    This test is going to test User Shared Settings in PMC
Resource         ../../Resources/PO/PMC/Common.robot
Resource         ../../Resources/PO/PMC/PMCApp.robot
Suite Setup      Run Keywords       Begin Web Suit              AND         Reset Shared Settings
Suite Teardown   Run Keywords       Reset Shared Settings       AND         End Web Suit

*** Variables ***
${Patient_Name}                 A2_24
${Patient_Record_Name}          xpath=//div[text()=' Moji Unit ']/../../following-sibling::div
# Command line to run this test: robot -d results Tests/PMC/Shared_Settings.robot

*** Test Cases ***
Test Shared Comment Filters
    PMCApp.Go To Settings Page
    PMCApp.Navigate to Shared Settings
    PMCApp.Navigate to 'Shared Comment Filters' Settings Under Shared Setting
    PMCApp.Create a New Comment Filter In Settings
    PMCApp.Navigate to EEG Page From Setting         ${Patient_Name}
    PMCApp.Select a Comment Filter On EEG Page    Moji Filter
    ${Filtered_Comment}     EEGPage.Get First Row's Text When Searched For Comment
    should contain    ${Filtered_Comment}   Moji Comment
    PMCApp.Delete a Comment Filter

Test Record Filter
    PMCApp.Add New Record Filter in Shared Settings         Moji Record Filter      24
    Navigate Back to Main Setting Menu From Setting Pages
    PMCApp.Navigate From Setting to Patient View
    sleep   3s
    PatientView.Select A Record Filter      Moji Record Filter
    wait until page contains    A2_24
    wait until page does not contain    LE_A01
    PatientView.Cleaning the Record Filter From List Of Record
    PMCApp.Delete a Record Filter

Test Standard Comment
    PMCApp.Go To Settings Page
    PMCApp.Add a New Standard Comment From Shared Setting
    PMCApp.Navigate to EEG Page From Setting         ${Patient_Name}
    PMCApp.Reset Quick Comment Modal
    ${New_Comment}      set variable    xpath=//span[text()='New Moji Comment']
    page should contain element   ${New_Comment}
    PMCApp.Quit Quick Comment Modal
    # This last step is to
    Run Keyword And Ignore Error            PMCApp.Navigate to Patient View Using Keyboard Shortcut
