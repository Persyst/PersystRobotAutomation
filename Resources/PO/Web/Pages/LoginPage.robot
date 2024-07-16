*** Settings ***
Library          SeleniumLibrary    timeout=0:00:15
Resource         Base.robot

*** Variables ***
${USER_NAME_LOCATOR} =    id=User Name
${PASSWORD_LOCATOR} =     id=Password
${LOGIN_BUTTON} =         xpath=//mdl-button[text()='Login']
${LOGIN_PAGE_URL} =       http://10.193.0.106/PersystMobile/login
${About_Button}           xpath=//mdl-button[text()='About']
*** Keywords ***
Navigate To Login Page
    ${current_url}      get location
    IF      $current_url == $LOGIN_PAGE_URL
            no operation
    ELSE
            go to    ${LOGIN_PAGE_URL}
    END

Verify "Login" Page Loaded
    wait until page contains     Welcome To Persyst Mobile
    wait until page contains element    ${About_Button}

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

Click on 'About' Button
    Wait And Click Element          ${About_Button}
    wait until page contains    Client Version:

Click on 'User Guide' link
    ${UserGuide_Link}   set variable    //a[@href="https://www.persyst.com/PersystMobile/UserGuide.pdf"]
    click element       ${UserGuide_Link}

Switch to User Guide Tab and Verify The URL
    ${open_tabs}=   get window handles
    switch window    ${open_tabs}[1]
    ${url}=     get location
    should be equal    ${url}       https://www.persyst.com/PersystMobile/UserGuide.pdf
    switch window    ${open_tabs}[0]
