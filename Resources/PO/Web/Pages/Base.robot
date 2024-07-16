*** Settings ***
Library     SeleniumLibrary
Library     Collections

*** Variables ***
${Wait_Time}            40s
${Interval}             30s
${Timeout_Message}      Element not clickable within timeout

*** Keywords ***
Click Element Until Visible
    [Arguments]  ${locator_to_click}  ${locator_to_check}  ${timeout}=30
    FOR  ${i}  IN RANGE  ${timeout}
        Click Element  ${locator_to_click}
        ${visible}=  Run Keyword And Return Status  Element Should Be Visible  ${locator_to_check}
        Exit For Loop If  ${visible}  # Exit loop if the element is visible
        Sleep  1s  # Wait for 1 second before trying again
    END
    Run Keyword Unless  ${visible}  Fail  Element not visible after ${timeout} seconds


Wait And Click Element
    [Arguments]    ${LOCATOR}
    Wait Until Element Is Visible    ${LOCATOR}    timeout=${Wait_Time}   error=${Timeout_Message}
    ${element_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${LOCATOR}
    IF      $element_enabled
          Click Element    ${LOCATOR}
    ELSE
          Log    Element is not enabled, ${LOCATOR}, ${Wait_Time}, ${Timeout_Message}
    END

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

Extract Text And Append
    [Arguments]     @{locator_list}         ${text_list}
    FOR    ${locator}    IN    @{locator_list}
        ${element}=         Get WebElement    ${locator}
        ${element_text}=    Get Text          ${element}
        Append To List    ${text_list}    ${element_text}
    END
    [Return]    @{text_list}

Wait and Get Element Presence
    [Arguments]    ${LOCATOR}       ${timeout}=30
    ${result}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${locator}  timeout=${timeout}s
    [Return]    ${result}
