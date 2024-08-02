*** Settings ***
Library          SeleniumLibrary    timeout=0:00:15
Resource         Base.robot

*** Variables ***
${USER_NAME_LOCATOR} =    name=username
${PASSWORD_LOCATOR} =     name=password
${LOGIN_BUTTON} =         id=login-button
${About_Button}           id=about-button
*** Keywords ***
Navigate To Login Page
    [Arguments]         ${URL}
    ${current_url}      get location
    IF      $current_url == $URL
            no operation
    ELSE
            go to    ${URL}
    END

Verify "Login" Page Loaded
    wait until page contains     Welcome To Persyst Mobile Cloud
    wait until page contains element    ${About_Button}
    wait until page contains element    ${USER_NAME_LOCATOR}        50s

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
    click button            Sign in
    sleep                   3s

Click on 'About' Button
    Wait And Click Element          ${About_Button}

Click on 'User Guide' link
    ${UserGuide_Link}   set variable    //a[@href="https://www.persyst.com/PersystMobile/UserGuide.pdf"]
    click element       ${UserGuide_Link}

Switch to User Guide Tab and Verify The URL
    ${open_tabs}=   get window handles
    switch window    ${open_tabs}[1]
    ${url}=     get location
    should be equal    ${url}       https://www.persyst.com/PersystMobile/UserGuide.pdf
    switch window    ${open_tabs}[0]


