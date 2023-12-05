*** Settings ***
Library          SeleniumLibrary    timeout=0:00:15

*** Variables ***
${Patient_Filter_Textfield}     body  mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > app-patient-list > div > div:nth-child(1) > mdl-textfield > div > input
${First_Row_Patient}            body app-patient-list > div > div:nth-child(1) mdl-list > mdl-list-item > div:nth-child(1) > div
${Comment_List}                 css=body > app-root > div:nth-child(1) > app-patient-views div > app-record-comments > div > mdl-list > mdl-list-item:nth-child(1)
${Beginning_Of_Recording}       id=Beginning\ of\ Record
${Setting_Button}               css=body  app-patient-views  div.view-header button[title="Settings"]
*** Keywords ***
Verify Patient View Page Loaded
    wait until page contains    Patient Views

Enter Patient Name In The Patient Name Textfield
    [Arguments]   ${PATIENT_NAME}
    input text    css=${Patient_Filter_Textfield}   ${PATIENT_NAME}  clear=True

Click On First Patient In The List After Filtering
    wait until page contains element    css=${First_Row_Patient}
    click element    css=${First_Row_Patient}
    sleep    3s

Click on Patient Record By ID
    [Arguments]    ${PATIENT_ID}
    ${Patient_Record_Visibility}    get element count    id=${PATIENT_ID}
    IF  ${Patient_Record_Visibility} == 0
        Click on Monitoring tab
        Click on 'Patient List' tab
        wait until element is visible    id=${PATIENT_ID}
        click element                    id=${PATIENT_ID}
    ELSE
        click element                    id=${PATIENT_ID}
    END
    verify patient comments appear
    sleep   2s

Verify Patient Comments Appear
    wait until page contains element    ${Beginning_Of_Recording}

Click on Patient Beginning of Record
    click element    ${Beginning_Of_Recording}

Click on Monitoring tab
    click link    Monitoring

Click on 'Patient List' tab
    click link    Patient List

Check If Patient Record Exist
    [Arguments]    ${PATIENT_ID}
    ${Patient_Record_Visibility}   Get Element Count    id=${PATIENT_ID}
    ${result}=    Run Keyword If    ${Patient_Record_Visibility} != 0    Set Variable    True    ELSE    Set Variable    False
    Return From Keyword    ${result}
