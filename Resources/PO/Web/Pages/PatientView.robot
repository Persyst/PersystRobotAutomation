*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30
Resource         Base.robot

*** Variables ***
${Patient_Filter_Textfield}     xpath=//input[@label="Patient Name Filter"]
${First_Row_Patient}            css=app-patient-list > div > div:nth-child(1) > div > div > div > div > div:nth-child(1) > div > div
${Beginning_Of_Recording}       id=Beginning\ of\ Record
${Setting_Button}               css=body  app-patient-views  div.view-header button[title="Settings"]
${Filter_List_Icon}             xpath=//mat-icon[text()="filter_list"]
${Patient_View_Page_URL}        http://10.193.0.106/PersystMobile/record-views

*** Keywords ***
Verify Patient View Page Loaded
    wait until page contains    Patient Views       40s

Enter Patient Name In The Patient Name Textfield
    [Arguments]   ${PATIENT_NAME}
    input text    ${Patient_Filter_Textfield}   ${PATIENT_NAME}  clear=True

Click On First Patient In The List After Filtering
    Wait And Click Element    ${First_Row_Patient}
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
    Wait And Click Element                    id=${PATIENT_ID}
    verify patient comments appear

Navigate to Patient View By URL
    ${current_url}      get location
    IF      $current_url == $Patient_View_Page_URL
            no operation
    ELSE
            go to    ${Patient_View_Page_URL}
            verify patient view page loaded
    END

Verify Patient Comments Appear
    wait until page contains element    ${Beginning_Of_Recording}       50s

Click on Patient Beginning of Record
    wait until page contains    Beginning of Record
    wait until page contains element    ${Beginning_Of_Recording}
    click element    ${Beginning_Of_Recording}

Click on Monitoring tab
    ${Monitoring}         set variable    xpath=//span[text()="Monitoring"]
    Wait And Click Element    ${Monitoring}
    sleep       2s

Click on 'Patient List' tab
    ${Patient_List}         set variable    xpath=//span[text()="Patient List"]
    Wait And Click Element    ${Patient_List}
    wait until page contains element        ${Patient_Filter_Textfield}

Check If Patient Record Exist
    [Arguments]    ${PATIENT_ID}
    ${Patient_Record_Visibility}   Get Element Count    id=${PATIENT_ID}
    ${result}=    Run Keyword If    ${Patient_Record_Visibility} != 0    Set Variable    True    ELSE    Set Variable    False
    Return From Keyword    ${result}

Click on Filter List Icon
    click element    ${Filter_List_Icon}

Minimize Unit By Name Either in Patient View Or Monitoring
    [Arguments]    ${UNIT_NAME}         ${PAGE}
    IF      '${PAGE}' == 'Monitoring'
            ${Minimize_icon}        set variable    //app-patient-monitoring//div[text()=' ${UNIT_NAME} ']/../div/button
    ELSE
            ${Minimize_icon}        set variable    //app-patient-list//div[text()=' ${UNIT_NAME} ']/../div/button
    END
    scroll element into view    xpath=${Minimize_icon}
    sleep    1s
    Wait And Click Element      xpath=${Minimize_icon}

Click on 'Monitoring' tab
    ${Monitoring}         set variable    xpath=//span[text()="Monitoring"]
    Wait And Click Element    ${Monitoring}
    wait until page contains     Unassigned

Click On Wrench Button To Navigate to Event Density
    ${Wrench_Button}            set variable    xpath=//mat-icon[text()='build']/..
    Wait And Click Element      ${Wrench_Button}
    ${Event_Density_Option}     set variable    xpath=//span[text()='Event Density']
    Wait And Click Element      ${Event_Density_Option}
    wait until page contains    Select Comment to specify the time range.       40s

Find Comment's Data From Event Density
    ${Comment_Time}             set variable    xpath=//mdl-select[@id='Time Range']/div/input
    click element               ${Comment_Time}
    ${Use_Entire_Record}        set variable    xpath=//div[text()='[Use entire record]']
    click element               ${Use_Entire_Record}
    ${Comment_Events}           set variable    xpath=//mdl-select[@id='Event Comment']/div/input
    click element               ${Comment_Events}
    ${Comment_Option}           set variable    xpath=//div[text()='@SeizureDetected(Persyst)']
    click element               ${Comment_Option}
    click button                Calculate
    sleep       5s
    @{Comment_Inputs}      create list    id="Time Span Start"     id="Time Span End"      id="Total Time Span Duration"   id="Total Events"   id="Total Events Duration"  id="Mean Event Duration"    id="Events Percent"
    @{Comment_Datas}       create list
    Extract Text And Append     @{Comment_Inputs}           text_list=${Comment_Datas}
    [Return]              @{Comment_Datas}

Get Patient Info From Info Button
    ${Info_Button}      set variable        xpath=//mat-icon[text()='info']/..
    click element       ${Info_Button}
    ${Info_Modal}       set variable        xpath=//mat-dialog-container
    wait until page contains element        ${Info_Modal}
    sleep    1s
    ${Patient_Info}     set variable        xpath=//app-patient-information
    ${Info}             get text            ${Patient_Info}
    click button        OK
    wait until page does not contain element       ${Info_Modal}
    [Return]            ${Info}

Get 'First Patient' Name in Monitoring Page
    ${Fisrt_Patient_Name}       set variable    xpath=//app-patient-monitoring/div/div/div[1]/div/div[2]/div[1]/div/div[1]/div[2]
    wait until page contains element        ${Fisrt_Patient_Name}
    ${Name}         get text    ${Fisrt_Patient_Name}
    [Return]    ${Name}

Navigate to Slide Show Tab
    ${Slide_Show}         set variable    xpath=//span[text()="Slide Show"]
    Wait And Click Element    ${Slide_Show}
    wait until page contains    Speed:

Navigate to MPM tab
    Wait And Click Element            xpath=//span[text()='MPM']
    ${Stations_Grid}            set variable    xpath=/html/body/app-root/div/app-patient-views/div/div[2]/div/mat-tab-group/div
    wait until element is visible     ${Stations_Grid}



