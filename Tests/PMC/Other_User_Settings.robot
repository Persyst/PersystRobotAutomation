*** Settings ***
Documentation    This test is going to test Basic User Settings
Resource         ../../Resources/PO/PMC/Common.robot
Resource         ../../Resources/PO/PMC/PMCApp.robot
Suite Setup      Run Keywords       Begin Web Suit
Suite Teardown   Run Keywords       End Web Suit

*** Variables ***
${Montage_Name}            Moji Montage (User)
${Go_To_EEG_Shortcut_value}       xpath=//div[text()=' Go to EEG ']/following-sibling::div
${Patient_Name}            A2_24

# Command line to run this test: robot -d results Tests/PMC/Other_User_Settings.robot

*** Test Cases ***
Test 'Reset User Interface'
    PMCApp.Navigate to Settings From Patient View
    PMCApp.Reset User Interface Settings From User Settings

Test Opening User Guide
    PMCApp.Open 'User Guide' PDF From User Settings

Test Create a New Montage
    [Tags]    testrun
    PMCApp.Add New Montage From User Settings
    sleep    1s
    PMCApp.Navigate Back to Main Setting Menu From Setting Pages
    sleep   5s
    PMCApp.Navigate From Setting to Patient View
    PMCApp.Select Patient Record By Patient Name    ${PATIENT_NAME}
    PMCApp.Navigate to EEG Page From Trends
    sleep    10s
    PMCApp.Change EEG Montage Setting    ${Montage_Name}
    sleep   3s

Test Editing a Created Montage
    PMCApp.Edit Montage From Montage Editor
    PMCApp.Delete Channels From a Montage
    PMCApp.Delete Channels From a Montage
    PMCApp.Delete Channels From a Montage
    PMCApp.Delete Channels From a Montage
    PMCApp.Add More Channels to Montage      Cz
    PMCApp.Add More Channels to Montage      O1
    Settings.Click 'Save' Montage Button
    PMCApp.Navigate Back to Main Setting Menu From Setting Pages
    sleep    3s
    PMCApp.Navigate From Setting to Patient View
    PMCApp.Select Patient Record By Patient Name    ${PATIENT_NAME}
    PMCApp.Navigate to EEG Page From Trends
    sleep    6s
    PMCApp.Change EEG Montage Setting        ${Montage_Name}
    sleep   5s

Test Deleting the Created Montage
    [Tags]    testrun
    PMCApp.Delete a Montage From Montage Editor

Test Creating Favorite Montage List
    PMCApp.Change 'Show All' Montage Status In Favorite Montage Setting    Disable
    Settings.Select Montage From List Of Favorite Montages                 Laplacian
    Navigate Back to Main Setting Menu From Setting Pages
    PMCApp.Navigate to EEG Page From Setting                     ${Patient_Name}
    sleep    6s
    PMCApp.Change EEG Montage Setting                            Laplacian
    sleep    5s
    PMCApp.Change List of Favorite Montages From Settings        Laplacian
    PMCApp.Change 'Show All' Montage Status In Favorite Montage Setting    Enable
    Navigate Back to Main Setting Menu From Setting Pages
    PMCApp.Navigate to EEG Page From Setting                     ${Patient_Name}
    PMCApp.Change EEG Montage Setting                            Neonatal Bipolar
    sleep   10s

Test Creating a New Comment Filter
    PMCApp.Create a New Comment Filter In Settings
    PMCApp.Navigate to EEG Page From Setting                     ${Patient_Name}
    PMCApp.Select a Comment Filter On EEG Page                   Moji Filter
    ${Filtered_Comment}     EEGPage.Get First Row's Text When Searched For Comment
    should contain    ${Filtered_Comment}   Moji Comment
    Delete a Comment Filter

Test Keyboard Setting
    PMCApp.Reset Keyboard Shortcut Settings
    PMCApp.Navigate Back to Main Setting Menu From Setting Pages
    PMCApp.Navigate From Setting to Patient View
    PMCApp.Select Patient Record By Patient Name                    ${PATIENT_NAME}
    PMCApp.Navigate to EEG Using Keyboard Shortcut
    PMCApp.Navigate to Trends Using Keyboard Shortcut
    PMCApp.Change Keyboard Shortcut Setting     Go to EEG        x
    PMCApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)         ${Patient_Name}
    press keys    None      x
    sleep    10s
    PMCApp.Verify EEG Page Loaded Successfully
    PMCApp.Reset Keyboard Shortcut Settings
    ${Shortcut_key}     get text  ${Go_To_EEG_Shortcut_value}
    should contain      ${Shortcut_key}         e
    PMCApp.Navigate Back to Main Setting Menu From Setting Pages

Test Update Password
    Common.Login With Credentials
    PMCApp.Navigate to Settings From Patient View
    PMCApp.Change User Password From User Settings          ${Login_Credentials}[Password]      Behrad123
    PMCApp.Logging Out From PMC
    PMCApp.Login Into PMC With Valid Credentials            ${Login_Credentials}[Username]      Behrad123
    PMCApp.Navigate to Settings From Patient View
    PMCApp.Change User Password From User Settings           Behrad123                          ${Login_Credentials}[Password]


