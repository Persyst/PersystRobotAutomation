*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     RequestsLibrary
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

Get Directory List
    [Arguments]    ${Response}          ${key1}      ${value}
    # Parse JSON response and find the new directory by name
    ${directories} =    Evaluate    json.loads('${response.content}')
    FOR    ${directory}    IN    @{directories}
        IF    ${directory}.get('name') ==  ${value}   # Replace with actual name comparison
            # Directory found, return its ID
            [Return]    ${directory['directoryID']}  # Adjust path based on response structure
        END
    END
    # Directory not found, handle error (optional)
    Log To Console    Error: Directory not found in list

Get Directory Id From JSON File
    [Arguments]    ${json_file}    ${directory_n}
    ${directories} =    load json from file    ${json_file}
    FOR     ${Content}      IN  ${directories}[contents]
            FOR     ${item}        IN      ${Content}[0]
                    ${Directory_Name}   set variable    ${item}[name]
                    IF  $Directory_Name==$directory_n
                        ${Directory_ID}     set variable    ${item}[directoryID]
                        RETURN    ${Directory_ID}  # Return directly before the value
                    END
            END
    END
    # Optionally handle cases where the directory name is not found
    RETURN    ${None}  # Or potentially raise an exception
    # Directory found, return its ID

Get New Directory Property
    [Arguments]    ${json_file}    ${Directory_ID}      ${Property}
    ${directories} =    load json from file    ${json_file}
    FOR     ${Content}      IN  ${directories}[contents]
            FOR     ${item}        IN      ${Content}[0]
                ${DirectoryID}   set variable    ${Content}[directoryID]
                IF  $DirectoryID==$directory_ID
                    ${Directory_Name}     set variable    ${item}[${Property}]
                        RETURN    ${Directory_ID}  # Return directly before the value
                    END
            END
    END
    # Optionally handle cases where the directory name is not found
    RETURN    ${None}  # Or potentially raise an exception
    # Directory found, return its ID

Get Child DirectoryID
    [Arguments]    ${json}
    ${Directory_ID}    set variable    ${json}[contents][0][contents][0][directoryID]
    RETURN     ${Directory_ID}