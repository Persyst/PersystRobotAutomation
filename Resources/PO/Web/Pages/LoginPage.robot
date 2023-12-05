*** Settings ***
Library          SeleniumLibrary    timeout=0:00:15

*** Variables ***
${USER_NAME_LOCATOR} =    id=User Name
${PASSWORD_LOCATOR} =     id=Password
${LOGIN_BUTTON} =         css=body > app-root > div:nth-child(1) > app-login > div:nth-child(1) > div:nth-child(4) > mdl-button
${LOGIN_PAGE_URL} =       http://192.168.156.119/PersystMobile/login
*** Keywords ***
Navigate To Login Page
    Go to                   ${LOGIN_PAGE_URL}

Verify "Login" Page Loaded
    wait until page contains     Welcome To Persyst Mobile

Login With Valid Credentials
    [Arguments]             ${USERNAME}         ${PASSWORD}
    Fill "Username" field     ${USERNAME}
    Fill "Password" Field     ${PASSWORD}
    Click Login Button

Fill "Username" field
    [Arguments]             ${Username}
    input text              ${USER_NAME_LOCATOR}      ${Username}

Fill "Password" Field
    [Arguments]             ${Password}
    input text              ${PASSWORD_LOCATOR}       ${Password}


Click Login Button
    click element           ${LOGIN_BUTTON}
    sleep                   3s


