*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30

*** Variables ***
${Patient_Filter_Textfield}     body  mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > app-patient-list > div > div:nth-child(1) > mdl-textfield > div > input
${First_Row_Patient}            body app-patient-list > div > div:nth-child(1) mdl-list > mdl-list-item > div:nth-child(1) > div
${Comment_List}                 css=body > app-root > div:nth-child(1) > app-patient-views div > app-record-comments > div > mdl-list > mdl-list-item:nth-child(1)
${Beginning_Of_Recording}       id=Beginning\ of\ Record
${Setting_Button}               css=body  app-patient-views  div.view-header button[title="Settings"]
${Filter_List_Icon}             xpath=//mdl-icon[text()="filter_list"]
${Patient_View_Page_URL}        http://192.168.156.119/PersystMobile/record-views
*** Keywords ***
Verify Patient View Page Loaded
    wait until page contains    Patient Views       40s

Enter Patient Name In The Patient Name Textfield
    [Arguments]   ${PATIENT_NAME}
    input text    css=${Patient_Filter_Textfield}   ${PATIENT_NAME}  clear=True

Click On First Patient In The List After Filtering
    wait until page contains element    css=${First_Row_Patient}
    click element    css=${First_Row_Patient}
    sleep    3s

Click on Patient Record By ID
    [Arguments]    ${PATIENT_ID}
    ${current_url}      get location
    IF      $current_url == $Patient_View_Page_URL
            no operation
    ELSE
            go to    ${Patient_View_Page_URL}
            verify patient view page loaded

    END
    wait until element is visible    id=${PATIENT_ID}       50s
        click element                    id=${PATIENT_ID}
    verify patient comments appear

Verify Patient Comments Appear
    wait until page contains element    ${Beginning_Of_Recording}       50s

Click on Patient Beginning of Record
    wait until page contains    Beginning of Record
    wait until page contains element    ${Beginning_Of_Recording}
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

Click on Filter List Icon
    click element    ${Filter_List_Icon}

Minimize Unit By Name
    [Arguments]    ${UNIT_NAME}
    ${Minimize_icon}        set variable    //div[text()=' ${UNIT_NAME} ']/../div/button
    scroll element into view    ${Minimize_icon}
    click element    ${Minimize_icon}
