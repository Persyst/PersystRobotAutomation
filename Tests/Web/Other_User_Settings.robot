*** Settings ***
Documentation    This test is going to test Basic User Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Suite Setup      Run Keywords       Begin Web Suit
Suite Teardown   Run Keywords       End Web Suit

*** Variables ***
${PATIENT_ID}              679
${Montage_Name}            Moji Montage (User)
${Go_To_EEG_Shortcut_value}       xpath=//div[text()=' Go to EEG ']/following-sibling::div
${Patient_Name}         LnP14D3Nw10ICU

# Command line to run this test: robot -d results Tests/Web/Other_User_Settings.robot

*** Test Cases ***
Test 'Reset User Interface'
    PersystWebApp.Reset User Interface Settings From User Settings

Test Opening User Guide
    PersystWebApp.Open 'User Guide' PDF From User Settings

Test Create a New Montage
    PersystWebApp.Add New Montage From User Settings
    sleep    1s
    PersystWebApp.Navigate Back to Main Setting Menu From Setting Pages
    PersystWebApp.Navigate From Setting to Patient View
    PersystWebApp.Search For Petient in Patient List With Patient Name    ${Patient_Name}
    PersystWebApp.Navigate to EEG Page From Trends
    sleep    10s
    PersystWebApp.Change EEG Montage Setting    ${Montage_Name}
    sleep   3s

Test Editing a Created Montage
    PersystWebApp.Edit Montage From Montage Editor
    PersystWebApp.Delete Channels From a Montage
    PersystWebApp.Delete Channels From a Montage
    PersystWebApp.Delete Channels From a Montage
    PersystWebApp.Delete Channels From a Montage
    PersystWebApp.Add More Channels to Montage      Cz
    PersystWebApp.Add More Channels to Montage      O1
    Settings.Click 'Save' Montage Button
    PersystWebApp.Navigate Back to Main Setting Menu From Setting Pages
    PersystWebApp.Navigate From Setting to Patient View
    PersystWebApp.Search For Petient in Patient List With Patient Name    ${Patient_Name}
    PersystWebApp.Navigate to EEG Page From Trends
    sleep    6s
    PersystWebApp.Change EEG Montage Setting        ${Montage_Name}
    sleep   5s

Test Deleting the Created Montage
    PersystWebApp.Delete a Montage From Montage Editor

Test Creating Favorite Montage List
    PersystWebApp.Change 'Show All' Montage Status In Favorite Montage Setting    Disable
    PersystWebApp.Change List of Favorite Montages From Settings        Laplacian
    PersystWebApp.Navigate to EEG Page From Setting                     ${PATIENT_ID}
    sleep    6s
    PersystWebApp.Change EEG Montage Setting                            Laplacian
    sleep    5s
    PersystWebApp.Change List of Favorite Montages From Settings        Laplacian
    PersystWebApp.Change 'Show All' Montage Status In Favorite Montage Setting    Enable
    PersystWebApp.Navigate to EEG Page From Setting                     ${PATIENT_ID}
    PersystWebApp.Change EEG Montage Setting                            Neonatal Bipolar
    sleep   10s

Test Creating a New Comment Filter
    PersystWebApp.Create a New Comment Filter In Settings
    PersystWebApp.Go To EEG Page By URL             ${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_EEG_URL}
    PersystWebApp.Select a Comment Filter On EEG Page    Moji Filter
    ${Filtered_Comment}     EEGPage.Get First Row's Text When Searched For Comment
    should contain    ${Filtered_Comment}   Moji Comment
    Delete a Comment Filter

Test Keyboard Setting
    PersystWebApp.Reset Keyboard Shortcut Settings
    PersystWebApp.Select Patient Record By Patient ID         ${PATIENT_ID}
    PersystWebApp.Navigate to EEG Using Keyboard Shortcut
    PersystWebApp.Navigate to Trends Using Keyboard Shortcut
    PersystWebApp.Change Keyboard Shortcut Setting     Go to EEG        x
    PersystWebApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)         ${PATIENT_ID}
    press keys    None      x
    sleep    10s
    PersystWebApp.Verify EEG Page Loaded Successfully
    PersystWebApp.Reset Keyboard Shortcut Settings
    ${Shortcut_key}     get text  ${Go_To_EEG_Shortcut_value}
    should contain      ${Shortcut_key}         e
    PersystWebApp.Navigate Back to Main Setting Menu From Setting Pages

Test Update Password
    persystwebapp.Navigate to Login Page and Login     mojgan      mojgan
    persystwebapp.Navigate to Settings From Patient View
    PersystWebApp.Change User Password From User Settings           mojgan      Behrad
    PersystWebApp.Logging Out From Persyst Web
    PersystWebApp.Login Into Persyst Web With Valid Credentials     mojgan      Behrad
    PersystWebApp.Navigate to Settings From Patient View
    PersystWebApp.Change User Password From User Settings           Behrad      mojgan


