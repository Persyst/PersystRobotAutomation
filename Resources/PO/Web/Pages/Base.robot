*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${Wait_Time}            40s
${Interval}             30s
${Timeout_Message}      Element not clickable within timeout

*** Keywords ***

Wait And Click Element
    [Arguments]    ${LOCATOR}
    Wait Until Element Is Visible    ${locator}    timeout=${Wait_Time}   error=${Timeout_Message}
    ${element_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${LOCATOR}
    Run Keyword If    not ${element_enabled}    Log    Element is not enabled
    ...    AND    ${LOCATOR}
    ...    AND    ${Wait_Time}    AND    ${Timeout_Message}
    ...    ELSE    Click Element    ${LOCATOR}

Delete Items Until None Exist
    [Arguments]    ${LOCATOR}
    FOR    ${index}    IN RANGE    10    # a limit to avoid an infinite loop
        ${element_exists}=    Run Keyword And Return Status    Element Should Be Visible    ${LOCATOR}
        Exit For Loop If    not ${element_exists}
        Click Element    ${LOCATOR}
        Sleep    2s
        Log    Clicked the button
    END
    Log    Button does not exist anymore



