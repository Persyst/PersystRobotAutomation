*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30

*** Variables ***
${USER_NAME_LOCATOR} =    name=username
${PASSWORD_LOCATOR} =     name=password
${LOGIN_BUTTON} =         css=amplify-sign-in > form > fieldset > button
${LOGIN_PAGE_URL} =       https://pmc.persyst.com/
*** Keywords ***
Navigate To Login Page
    Go to                   ${LOGIN_PAGE_URL}

Verify "Login" Page Loaded
    wait until page contains     Welcome To Persyst Mobile Cloud

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

