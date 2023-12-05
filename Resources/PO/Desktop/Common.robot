*** Settings ***
Library     SeleniumLibrary
Resource    /Pages/LoginPage.robot
Resource    PersystWebApp.robot
Library     ImageHorizonLibrary
Resource    TrendsPage.robot

*** Variables ***
${COMPARISON_IMAGES_PATH}       C:\\Users\\mojgan.dadashi\\pycharmProjects\\PersystRobotAutomation\\ScreenShots
@{Browser}                      chrome      Edge        Firefox
&{Login_Credentials}            Username=mojgan     Password=mojgan
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

    [Arguments]                         ${PATIENT_ID}
    open browser           sbout:blank  ${Browser}[0]
    maximize browser window
    PersystWebApp.Go to "Login" page
    PersystWebApp.Login Into Persyst Web With Valid Credentials    ${Login_Credentials}[Username]     ${Login_Credentials}[Password]
    PersystWebApp.Select Patient Record By Patient ID              ${PATIENT_ID}
#    Reset the Trends Setting

End Web Suit
    close browser

Compare the Images
    [Arguments]    ${IMAGE_NAME}
    set confidence    0.9
    imagehorizonlibrary.wait for    ${IMAGE_NAME}
    imagehorizonlibrary.does exist  ${IMAGE_NAME}

If Element Visible
    [Arguments]    ${ELEMENT}
    ${Element_Visibility}  get element count    ${ELEMENT}
    IF    ${Element_Visibility} == 0
          return from keyword    'True'
    ELSE
          return from keyword    'False'
    END

Reset the Trends Setting
    TrendsPage.Change Trends Page Duration    4hours
    Change Artifact Reduction Status On Trends    ON
    Change Panel Setting From Trends Setting      Comprehensive
    Close Setting Menu

Set Range Input
    [Arguments]    ${locator}    ${value}
    Execute JavaScript    document.querySelector('${locator}').value = ${value}


