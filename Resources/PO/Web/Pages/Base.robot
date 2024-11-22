*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     OperatingSystem
Library     JSONLibrary


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

Wait and Get Element Text
    [Arguments]    ${LOCATOR}
    Wait Until Element Is Visible    ${LOCATOR}    timeout=${Wait_Time}   error=${Timeout_Message}
    ${element_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${LOCATOR}
    IF      $element_enabled
            ${Spike_Title}      get text    ${LOCATOR}
    ELSE
          Log    Element is not enabled, ${LOCATOR}, ${Wait_Time}, ${Timeout_Message}
    END
    [Return]    ${Spike_Title}


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

Verify smaller dictionary in bigger dictionary
    [Arguments]    ${smaller_dict}    ${bigger_dict}
    FOR    ${key}    ${value}    IN ZIP    ${smaller_dict.keys()}    ${smaller_dict.values()}
        ${actual_value} =    Evaluate    ${bigger_dict}.get("${key}")
        Should Be Equal As Strings    ${actual_value}    ${value}
    END

Verify smaller dictionary in bigger dictionary with tolerance
    [Arguments]    ${smaller_dict}    ${bigger_dict}
    ${tolerance} =    Set Variable    10  # Adjust tolerance as needed
    FOR    ${key}    ${value}    IN ZIP    ${smaller_dict.keys()}    ${smaller_dict.values()}
        ${actual_value} =    Evaluate    ${bigger_dict}.get("${key}")
        ${key_type} =    Evaluate    type("${value}")

        # Check if the key exists in the bigger dictionary
        Should Be True    ${actual_value} is not None    Key '${key}' not found in bigger dictionary
       IF     isinstance($value, (int, float))
        # Use comparison with tolerance for numerical values
            ${delta} =    Evaluate    abs(${actual_value} - ${value})
            Should Be True    ${delta} <= ${tolerance}    Values for key '${key}' differ by more than ${tolerance}
        ELSE
            # Use strict comparison for other data types
            Should Be Equal As Strings    ${actual_value}    ${value}
        END
    END

Compare Dictionaries And Report Key Differences
    [Arguments]    ${smaller_dict}    ${bigger_dict}

    ${different_keys} =    Create List

    FOR    ${key}    ${value}    IN ZIP    ${smaller_dict.keys()}    ${smaller_dict.values()}
        ${actual_value} =    Evaluate    ${bigger_dict}.get("${key}")
        IF    $actual_value != $value
            append to list    ${different_keys}     ${key}
        END
    END

    IF    $different_keys != []
        Fail    Dictionaries differ in values for keys: ${different_keys}
    ELSE
        Log    Dictionaries are equal.
    END

Read expected JSON
    [Arguments]    ${file_path}
    ${expected_json}=    OperatingSystem.get file    ${file_path}
    ${expected_dict}=    Evaluate    json.loads($expected_json)
    log    ${expected_dict}
    [Return]    ${expected_dict}

Read expected JSON Directly
    [Arguments]    ${file_path}
    ${expected_dict}=    load json from file    ${file_path}
    log    ${expected_dict}
    [Return]    ${expected_dict}

Check if URLS match
    [Arguments]    ${URL}
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${URL}

Wait Until Page Is Fully Loaded
    [Documentation]    Wait until the web page's ready state is 'complete'.
    Wait Until Keyword Succeeds    30s    1s    Execute JavaScript    return document.readyState == 'complete';

Check Toggle Status
    [Documentation]    Check if the "toggle-checked" class is present in the mat-slide-toggle element's class attribute.
    [Arguments]    ${TOGGLE_ID}
    ${EXPECTED_CLASS}   set variable    toggle-checked
    Wait Until Element Is Visible    ${TOGGLE_ID}    10s
    # Get the class attribute of the mat-slide-toggle element
    ${class_attr}=    Get Element Attribute    ${TOGGLE_ID}    class

    # Check if the expected class "toggle-checked" is present
    ${Toggle_Status}        set variable    unknown
    IF     '${EXPECTED_CLASS}' in '${class_attr}'
            ${Toggle_Status}    Set Variable        checked
    ELSE
            ${Toggle_Status}    Set Variable        unchecked
    END
    [Return]    ${Toggle_Status}
    
[Sample] Assign Patient to a Unit For Monitoring(4Backspace)
    [Arguments]                     ${UNIT_NAME}                ${PATIENT_NAME}
    ${Search_Input}                 set variable    xpath=//input[@label="String-Text-Input"]
    input text                      ${Search_Input}             ${PATIENT_NAME}
    Press Keys    ${Search_Input}    CTRL+END   BACKSPACE   BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE   BACKSPACE   BACKSPACE   BACKSPACE   BACKSPACE
    ${Unit_Dropdown}                set variable    xpath=//mat-select[@placeholder='Unit']/div
    ${Units_Dropdowns}=      get webelements    ${Unit_Dropdown}
    ${Dropdowns_Count}=    get length    ${Units_Dropdowns}
    FOR     ${Each}  IN RANGE    ${Dropdowns_Count}
            ${Index}=                Evaluate          ${Each} + 1
            ${Unit_Dropdown}            set variable        css=app-user-settings div:nth-child(3) div:nth-child(${Index}) mat-select
            wait until page contains element                            ${Unit_Dropdown}       40s
            Wait And Click Element                                      ${Unit_Dropdown}
            ${Unit_Option}                  set variable    xpath=//mat-option/span[text()='${UNIT_NAME}']
            wait until element is visible                   ${Unit_Option}
            Wait And Click Element                           ${Unit_Option}
            sleep    2s
    END

Select Option from Mat-Select
    [Arguments]         ${SELECT_LOCATOR}       ${OPTION_LOCATOR}
    Wait And Click Element              ${SELECT_LOCATOR}
    wait until page contains element    ${OPTION_LOCATOR}
    Wait And Click Element              ${OPTION_LOCATOR}