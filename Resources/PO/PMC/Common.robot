*** Settings ***
Library     SeleniumLibrary     timeout=0:00:30
Library     ImageHorizonLibrary
Resource    Pages/LoginPage.robot
Resource    Pages/TrendsPage.robot
Resource    PMCApp.robot

*** Variables ***
${Server}                       Prod
&{Trends_Page_URL}              Test=https://pmctest.pmc.ninja/record-views/trends/642/0?readOnly=false        EU=https://eu.pmc.persyst.com/record-views/trends/212/0?readOnly=false
&{Setting_Page_URL}             Test=https://pmctest.pmc.ninja/record-views/user-settings        EU=https://eu.pmc.persyst.com/record-views/user-settings
&{Patinet_View_URL}             Test=https://pmctest.pmc.ninja/record-views     EU=https://eu.pmc.persyst.com/record-views      Prod=https://pmc.persyst.com/record-views
${COMPARISON_IMAGES_PATH}       C:\\Users\\mojgan.dadashi\\pycharmProjects\\PersystRobotAutomation\\ScreenShots\\PMC
@{Browser}                      chrome      Edge        Firefox
&{Login_Credentials}            Username=mojgan.dadashi@persyst.com     Password=NpNl582.
${A2_24_EEG_URL}                https://pmctest.pmc.ninja/record-views/eeg/599/0?readOnly=false
${A2_24_Trends_URL}             https://pmctest.pmc.ninja/record-views/trends/599/0?readOnly=false
&{colors}                       yellow=#dfca74       white=#ffffff
${PMC_Prod_URL}                 https://pmc.persyst.com/login
&{PMC_LOGIN_PAGE_URL} =        Test=https://pmctest.pmc.ninja/login        EU=https://eu.pmc.persyst.com/login
&{PMC_EEG_PAGE_URL} =          Test=https://pmctest.pmc.ninja/record-views/eeg/642/0?readOnly=false        EU=https://eu.pmc.persyst.com/record-views/eeg/212/0?readOnly=false
*** Keywords ***
#==============================Setting the URLS========================================================================
Set the EEG Page URL
    set global variable     ${EEG_URL}          ${PMC_EEG_PAGE_URL}[${Server}]
    [Return]    ${EEG_URL}

Set Patient View URL
    set global variable     ${Patient_View_URL}          ${Patinet_View_URL}[${Server}]
    [Return]     ${Patient_View_URL}

Set the Trends Page URL
    set global variable     ${Trends_URL}          ${Trends_Page_URL}[${Server}]
    [Return]    ${Trends_URL}

Set the Settings URL
    set global variable     ${Setting_URL}          ${Setting_Page_URL}[${Server}]
    [Return]    ${Setting_URL}

Begin Web Suit With No Login
    set selenium timeout    50s
    imagehorizonlibrary.set reference folder            ${COMPARISON_IMAGES_PATH}
    open browser           sbout:blank  ${Browser}[0]
    set window size    1552  928

End Web Test
    close browser

Begin Web Suit
#    [Arguments]         ${Login_Server_URL}             ${Login_Credentials}
    set selenium timeout    15s
    imagehorizonlibrary.set reference folder            ${COMPARISON_IMAGES_PATH}
    open browser           sbout:blank  ${Browser}[0]
    PMCApp.Go to "Login" page       ${PMC_LOGIN_PAGE_URL}[${Server}]
    PMCApp.Login Into PMC With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]
    set window size    1552  928
    #maximize browser window

End Web Suit
    close browser

Login With Credentials
      PMCApp.Go to "Login" page         ${PMC_LOGIN_PAGE_URL}[${Server}]
      PMCApp.Login Into PMC With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]

Compare the Images
    [Arguments]    ${IMAGE_NAME}
    set confidence    0.8
    sleep    3s
    Capture Page Screenshot    ${IMAGE_NAME}_missing.png
    Log    Screenshot captured: ${IMAGE_NAME}_missing.png    console=True
    imagehorizonlibrary.wait for    ${IMAGE_NAME}
    imagehorizonlibrary.does exist  ${IMAGE_NAME}

Reset the Trends Setting
    [Arguments]                         ${PATIENT_NAME}
    PMCApp.Search For Petient in Patient List With Patient Name         ${PATIENT_NAME}
    Change Trends Page Duration                   4hours
    Change Panel Setting From Trends Setting      Comprehensive
    PMCApp.Change Artifact Reduction Status On Trends   ON
    Close Setting Menu

Reset EEG Setting
    [Arguments]                         ${PATIENT_NAME}
    Go To EEG Page By URL
#    PMCApp.Navigate to EEG From Record List Page By Patient Name        ${PATIENT_NAME}
    Change EEG Montage Setting              Bipolar longitudinal A
    Change EEG Page Duration Time           10
    Change EEG Sensitivity Option           7
    Change EEG Artifact Reduction Status    ON
    Change EEG LFF Setting                  0.16
    Change EEG HFF Setting                  70
    Change Notch Filter Setting             60Hz
    Change EEG Page Font Size               2
    Change Channel Per Page Setting         All
    Change EEG Calibration Status           OFF
    Change Major Grid Status                ON
    Change Minor Grid Status                ON
    Change Comment Line Status              OFF
    Change EEG Comment Show Status          ON
    Change Restricted Pen Status            OFF
    EEGPage.Close Video Modal

Test Reset EEG Setting
    Change EEG Montage Setting              Bipolar longitudinal A
    Change EEG Page Duration Time           10
    Change EEG Sensitivity Option           7
    Change EEG Artifact Reduction Status    ON
    Change EEG LFF Setting                  0.16
    Change EEG HFF Setting                  70
    Change Notch Filter Setting             60Hz
    Change EEG Page Font Size               2
    Change Channel Per Page Setting         All
    Change EEG Calibration Status           OFF
    Change Major Grid Status                ON
    Change Minor Grid Status                ON
    Change Comment Line Status              OFF
    Change EEG Comment Show Status          ON
    Change Restricted Pen Status            OFF

Reset the User Basic Settings
    PMCApp.Go To Settings Page
    PMCApp.Reset All User Settings


Set Range Input
    [Arguments]    ${locator}    ${value}
    Execute JavaScript    document.querySelector('${locator}').value = ${value}

Reset Shared Settings
    PMCApp.Navigate to Settings From Patient View
    PMCApp.Navigate to Shared Settings
    PMCApp.Navigate to 'Standard Comments Editor' in Shared Settings
    PMCApp.Delete Created Standard Comment From Shared Settings      New Moji Comment
    PMCApp.Navigate Back to Main Setting Menu From Setting Pages

Reset EEG Default Settings
    PMCApp.Navigate to EEG Default Settings
    Change EEG Montage Setting              Bipolar longitudinal A
    Change EEG Page Duration Time           10
    Change EEG Sensitivity Option           7
#    Change EEG Artifact Reduction Status    ON
    Change EEG LFF Setting                  0.16
    Change EEG HFF Setting                  70
    Change Notch Filter Setting             60Hz

Reset Trends Default Settings
    PMCApp.Navigate to Trends Default Settings
    PMCApp.Change Trends Default Panel and Duration From Settings        Comprehensive       4 hours

Reset Trends and EEG Default Settings
    PMCApp.Navigate to Patient View Using Keyboard Shortcut
    PMCApp.Navigate to Settings From Patient View
    Reset EEG Default Settings
    Reset Trends Default Settings
    PMCApp.Navigate From Setting to Patient View

#=============================================================================================
####                                          AES
#=============================================================================================
Login to PMC Production and Login
    [Arguments]    ${CORRECT_USERNAME}     ${CORRECT_PASSWORD}
    LoginPage.Navigate To Login Page                ${PMC_Prod_URL}
    PMCApp.Login Into PMC With Valid Credentials    ${CORRECT_USERNAME}     ${CORRECT_PASSWORD}

Find The Record And Navigate to EEG
    [Arguments]     ${RECORD_NAME}
    Navigate to Patient View By URL And Search For Patient Name        ${RECORD_NAME}
    PatientView.click on Patient Beginning of Record
    EEGPage.Verify EEG Page Loaded Successfully

