*** Settings ***
Library     SeleniumLibrary
Library     ImageHorizonLibrary
Resource    Pages/LoginPage.robot
Resource    Pages/TrendsPage.robot
Resource    PersystWebApp.robot
Resource    Pages/TrendsPage.robot

*** Variables ***
${COMPARISON_IMAGES_PATH}       C:\\Users\\mojgan.dadashi\\pycharmProjects\\PersystRobotAutomation\\ScreenShots
@{Browser}                      chrome      Edge        Firefox
&{Login_Credentials}            Username=mojgan     Password=mojgan
${ICU-SUBTLE_SZ_EEG_URL}   http://192.168.156.119/PersystMobile/record-views/eeg/2980/0?readOnly=false
&{colors}       yellow=#dfca74       white=#ffffff
*** Keywords ***


Begin Web Test
    set selenium timeout    15s
    open browser           sbout:blank  ${Browser}[0]
    PersystWebApp.Go to "Login" page
    PersystWebApp.Login Into Persyst Web With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]
    sleep                   3s

End Web Test
    close browser

Begin Web Suit
    set selenium timeout    15s
    imagehorizonlibrary.set reference folder            ${COMPARISON_IMAGES_PATH}
    open browser           sbout:blank  ${Browser}[0]
    PersystWebApp.Go to "Login" page
    ${window_size}      get window size
    PersystWebApp.Login Into Persyst Web With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]
#   set window size    1552  928
    maximize browser window

End Web Suit
    close browser

Login With Credentials
      PersystWebApp.Go to "Login" page
      PersystWebApp.Login Into Persyst Web With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]


Compare the Images
    [Arguments]    ${IMAGE_NAME}
    set confidence    0.2
    imagehorizonlibrary.wait for    ${IMAGE_NAME}
    imagehorizonlibrary.does exist  ${IMAGE_NAME}

Reset the Trends Setting
    [Arguments]                         ${PATIENT_ID}
    PersystWebApp.Select Patient Record By Patient ID              ${PATIENT_ID}
    maximize browser window
    Change Trends Page Duration                   4hours
    Change Panel Setting From Trends Setting      Comprehensive
    Close Setting Menu

Reset EEG Setting
    GO TO EEG PAGE BY URL                   ${ICU-SUBTLE_SZ_EEG_URL}
    Change EEG Montage Setting              Bipolar-longA
    Change EEG Page Duration Time           10Seconds
    Change EEG Sensitivity Option           7
    Change EEG Artifact Reduction Status    ON
    Change EEG LFF Setting                  0.16
    Change EEG HFF Setting                  70Hz
    Change Notch Filter Setting             60Hz
    Change EEG Page Font Size               2
    Change Channel Per Page Setting         All
    Change Calibrartion Status              OFF
    Change Major Grid Status                ON
    Change Minor Grid Status                ON
    Change Comment Line Status              OFF
    Change EEG Comment Show Status          ON
    Change Restricted Pen Status            OFF

Reset the User Basic Settings
    persystwebapp.select comment sort order in user settings                ASC
    PersystWebApp.Select Dispaly Options From User Settings                 Trends
    PersystWebApp.Change "Add Quick Comments" Setting From User Setting     Disable
    PersystWebApp.Change "Show Patient Name" setting                        Enable
    PERSYSTWEBAPP.CHANGE 'LFF TYPE' SETTING                                 Frequency
    PersystWebApp.Change 'Date Formats' for EEG and Trends                  mm-dd-yyyy
    PersystWebApp.Change 'Time Format' From User Setting                    Clock-Time
    PersystWebApp.Change 'Maximum Record Age' Setting                       0
    PersystWebApp.Change 'Maximum Record Duration' Setting                  0
    PersystWebApp.Change 'Segment By Day' Status From User Setting          Disable
    PersystWebApp.Enter "Refresh Interval" Time in Minues                   5
    PersystWebApp.Change 'Inactivity Timeout' Status From User Setting      Enable
    PersystWebApp.Enter "Inactivity Timeout" Time in Minues                 15
    PersystWebApp.Change 'Show Connection' Status From User Setting         Disable
    PersystWebApp.Change 'EEG High Resolution' Status From User Setting     Enable
    PersystWebApp.Set EEG Background Color From User Settings               ${colors}[white]
    PersystWebApp.Set Grid Background Color From User Settings              ${colors}[white]
    PersystWebApp.Navigate From Setting to Patient View

Set Range Input
    [Arguments]    ${locator}    ${value}
    Execute JavaScript    document.querySelector('${locator}').value = ${value}