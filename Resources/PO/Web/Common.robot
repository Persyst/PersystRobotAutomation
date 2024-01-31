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
${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_EEG_URL}     http://10.193.0.106/PersystMobile/record-views/eeg/679/0?readOnly=false
${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_Trends_URL}     http://10.193.0.106/PersystMobile/record-views/trends/679/0?readOnly=false
&{colors}       yellow=#dfca74       white=#ffffff
*** Keywords ***


Begin Web Suit With No Login
    set selenium timeout    15s
    imagehorizonlibrary.set reference folder            ${COMPARISON_IMAGES_PATH}
    open browser           sbout:blank  ${Browser}[0]
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
    set window size    1552  928
    #maximize browser window

End Web Suit
    close browser

Login With Credentials
      PersystWebApp.Go to "Login" page
      PersystWebApp.Login Into Persyst Web With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]

Compare the Images
    [Arguments]    ${IMAGE_NAME}
    set confidence    0.8
    sleep    3s
    imagehorizonlibrary.wait for    ${IMAGE_NAME}
    imagehorizonlibrary.does exist  ${IMAGE_NAME}

Reset the Trends Setting
    [Arguments]                         ${PATIENT_ID}
    PersystWebApp.Select Patient Record By Patient ID              ${PATIENT_ID}
    Change Trends Page Duration                   4hours
    Change Panel Setting From Trends Setting      Comprehensive
    PersystWebApp.Change Artifact Reduction Status On Trends   ON
    Close Setting Menu

Reset EEG Setting
    GO TO EEG PAGE BY URL                   ${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_EEG_URL}
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
    PersystWebApp.Go To Settings Page
    PersystWebApp.Reset All User Settings


Set Range Input
    [Arguments]    ${locator}    ${value}
    Execute JavaScript    document.querySelector('${locator}').value = ${value}

Reset Shared Settings
    PersystWebApp.Delete Previously Created Units From Shared Settings
    PersystWebApp.Navigate Back to Main Setting Menu From Setting Pages
    PersystWebApp.Navigate to 'Standard Comments Editor' in Shared Settings
    PersystWebApp.Delete Created Standard Comment From Shared Settings      New Moji Comment
    PersystWebApp.Navigate Back to Main Setting Menu From Setting Pages

Reset EEG Default Settings
    PersystWebApp.Navigate to EEG Default Settings
    Change EEG Montage Setting              Bipolar longitudinal A
    Change EEG Page Duration Time           10
    Change EEG Sensitivity Option           7
    Change EEG Artifact Reduction Status    ON
    Change EEG LFF Setting                  0.16
    Change EEG HFF Setting                  70
    Change Notch Filter Setting             60Hz

Reset Trends Default Settings
    PersystWebApp.Navigate to Trends Default Settings
    PersystWebApp.Change Trends Default Panel and Duration From Settings        Comprehensive       4 hours

Reset Trends and EEG Default Settings
    PersystWebApp.Navigate to Patient View Using Keyboard Shortcut
    PersystWebApp.Navigate to Settings From Patient View
    Reset EEG Default Settings
    Reset Trends Default Settings
    PersystWebApp.Navigate From Setting to Patient View