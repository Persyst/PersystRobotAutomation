*** Settings ***
Documentation    This test is going to test User Shared Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Resource         ../../Resources/PO/Web/Pages/TrendsPage.robot
Suite Setup      Run Keywords       Begin Web Suit
Suite Teardown   Run Keywords       Reset Trends and EEG Default Settings       AND         End Web Suit

*** Variables ***
${Patient_Name}         LnP14D3Nw10ICU, FnLnP14D3Nw10ICU

# Command line to run this test: robot -d results Tests/Web/Shared_Settings.robot

*** Test Cases ***
Test Trends Default Setting
    PersystWebApp.Navigate to Settings From Patient View
    PersystWebApp.Navigate to Trends Default Settings
    Settings.Select Patient Record For Default Settings     ${Patient_Name}
    PersystWebApp.Change Trends Default Panel and Duration From Settings        ActiveNotifications       4 hours
    PersystWebApp.Navigate to Trends Page By URL        ${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_Trends_URL}
    TrendsPage.click on Setting Button
    ${Panel}    get text    id=panel-settings
    should contain    ${Panel}         ActiveNotifications
    ${Duration}     get text    id=duration-settings
    should contain    ${Duration}      4 hours

Test EEG Default Settings
    PersystWebApp.Navigate to Patient View From Trends
    PersystWebApp.Navigate to Settings From Patient View
    PersystWebApp.Navigate to EEG Default Settings
    PersystWebApp.Change EEG Montage Setting         Referential (Av12) Longitudinal
    PersystWebApp.Change EEG Page Duration Time           30
    PersystWebApp.Change EEG Sensitivity Option           70
    PersystWebApp.Change EEG Artifact Reduction Status    OFF
    PersystWebApp.Change EEG LFF Setting                  2
    PersystWebApp.Change EEG HFF Setting                  5
    PersystWebApp.Change Notch Filter Setting             50Hz
    PersystWebApp.Navigate From Setting to Patient View
    PersystWebApp.Search For Petient in Patient List With Patient Name  ${Patient_Name}
    PersystWebApp.Navigate to EEG Using Keyboard Shortcut
    EEGPage.Click the EEG Page Setting Button
    @{Setting_Values}    EEGPage.Get EEG Waveforms Settings
    @{Expected_Settings}      create list    Referential (Av12) Longitudinal\n>     30 Seconds\n>     70 uV\n>    ON    OFF   2 Hz\n>   5 Hz\n>
    lists should be equal       ${Setting_Values}       ${Expected_Settings}


