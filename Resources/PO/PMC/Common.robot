*** Settings ***
Library     SeleniumLibrary
Library     ImageHorizonLibrary
Resource    Pages/LoginPage.robot
Resource    Pages/TrendsPage.robot
Resource    PMCApp.robot
Resource    Pages/TrendsPage.robot

*** Variables ***
${COMPARISON_IMAGES_PATH}       C:\\Users\\mojgan.dadashi\\pycharmProjects\\PersystRobotAutomation\\ScreenShots
@{Browser}                      chrome      Edge        Firefox
&{Login_Credentials}            Username=mojgan.dadashi@persyst.com     Password=NpNl582.
${ICU-SUBTLE_SZ_EEG_URL}   http://192.168.156.119/PersystMobile/record-views/eeg/325/0?readOnly=false
*** Keywords ***


Begin Web Test
    set selenium timeout    30s
    open browser           sbout:blank  ${Browser}[0]
    PMCApp.Go to "Login" page
    PMCApp.Login Into Persyst Web With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]
    sleep                   3s

End Web Test
    close browser

Begin Web Suit
    set selenium timeout    30s
    imagehorizonlibrary.set reference folder            ${COMPARISON_IMAGES_PATH}
    open browser           sbout:blank  ${Browser}[0]
    PMCApp.Go to "Login" page
    ${window_size}      get window size
#    PMCApp.Login Into Persyst Web With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]
    sleep    5s
#    set window size    1552  928







End Web Suit
    close browser