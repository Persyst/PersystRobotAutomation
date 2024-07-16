*** Settings ***
Documentation    This test is going to test User Shared Settings
Resource         ../../Resources/PO/PMC/Common.robot
Resource         ../../Resources/PO/PMC/PMCApp.robot
Resource         ../../Resources/PO/PMC/Pages/TrendsPage.robot
Suite Setup      Run Keywords       Begin Web Suit
Suite Teardown   Run Keywords       Reset Trends and EEG Default Settings       AND         End Web Suit

*** Variables ***
${Patient_Name}         A2_24

# Command line to run this test: robot -d results Tests/PMC/Trends_EEG_Default_Settings.robot

*** Test Cases ***
Test EEG Default Settings
    PMCApp.Go To Settings Page
    PMCApp.Navigate to EEG Default Settings
    PMCApp.Change EEG Montage Setting         Referential (Av12) Longitudinal
    PMCApp.Change EEG Page Duration Time           30
    PMCApp.Change EEG Sensitivity Option           70
    PMCApp.Change EEG Artifact Reduction Status    OFF
    PMCApp.Change EEG LFF Setting                  2
    PMCApp.Change EEG HFF Setting                  5
    PMCApp.Change Notch Filter Setting             50Hz
    PMCApp.Navigate From Setting to Patient View
    PMCApp.Select Patient Record By Patient Name            ${Patient_Name}
    PMCApp.Navigate to EEG Using Keyboard Shortcut
    EEGPage.Click the EEG Page Setting Button
    @{Setting_Values}    EEGPage.Get EEG Waveforms Settings
    @{Expected_Settings}      create list    Referential (Av12) Longitudinal\n>     30 Seconds\n>     70 uV\n>    ON    OFF   2 Hz\n>   5 Hz\n>
    lists should be equal       ${Setting_Values}       ${Expected_Settings}

Test Trends Default Setting
    PMCApp.Navigate to User's Settings From EEG Page
    PMCApp.Navigate to Trends Default Settings
    Settings.Select Patient Record For Default Settings     ${Patient_Name}
    PMCApp.Change Trends Default Panel and Duration From Settings        ActiveNotifications       4 hours
    PMCApp.Navigate From Setting to Patient View
    PMCApp.Select Patient Record By Patient Name            ${Patient_Name}
    TrendsPage.click on Setting Button
    ${Panel}    get text    id=panel-settings
    should contain    ${Panel}         ActiveNotifications
    ${Duration}     get text    id=duration-settings
    should contain    ${Duration}      4 hours




