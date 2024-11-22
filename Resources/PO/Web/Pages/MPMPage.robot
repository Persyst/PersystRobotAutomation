*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30
Resource         Base.robot

*** Variables ***
${Cell_Setting_Modal}           css=div mat-dialog-container


*** Keywords ***
Navigate to MPM tab
    Wait And Click Element            xpath=//span[text()='MPM']
    ${Stations_Grid}            set variable    xpath=/html/body/app-root/div/app-patient-views/div/div[2]/div/mat-tab-group/div
    wait until element is visible     ${Stations_Grid}
    sleep    2s

Open Cell Setting Modal
    [Arguments]    ${Row}       ${Column}
    ${Setting_Button}       set variable     css=app-mpm > div > div:nth-child(${Row}) > div:nth-child(${Column}) button
    wait until element is visible    ${Setting_Button}
    Wait And Click Element           ${Setting_Button}
    wait until page contains element        ${Cell_Setting_Modal}
    sleep    1s

Select Patient on MPM Setting Modal
    ${Select_Patient_Dropdown}      set variable    xpath=//mat-select[@placeholder="Select patient"]
    wait until page contains element        ${Select_Patient_Dropdown}
    Wait And Click Element                  ${Select_Patient_Dropdown}
    Wait And Click Element                  css=mat-option:nth-child(1)
    click button    OK

Verify Cell's Canvas
    [Arguments]    ${Row}       ${Column}
    ${Cell_Canvas}       set variable     css=app-mpm > div > div:nth-child(${row}) > div:nth-child(${Column}) canvas
    ${element_exists}=    Run Keyword And Return Status    Element Should Be Visible    ${Cell_Canvas}
    [Return]    ${element_exists}

Select Type Of Manual Selection
    [Arguments]    ${Type}      #Types could be: Manual, Automatic, Station, Close
    ${Select_Type_Dropdown}     set variable    css=div > mat-dialog-content > mat-select
    ${Select_Type_Option}       set variable    xpath=//*[text()="${Type}"]
    Wait And Click Element      ${Select_Type_Dropdown}
    Wait And Click Element      ${Select_Type_Option}

Select Station For Cell
    [Arguments]    ${Station_Number}
    ${Station_Option}       set variable    css=mat-dialog-content mat-list > mat-list-item:nth-child(${Station_Number}) span span
    Wait And Click Element    ${Station_Option}

Click On Canvas To Navigate To Trends
    [Arguments]    ${Row}       ${Column}
    ${Station_Canvas}      set variable     css=app-mpm > div > div:nth-child(${row}) > div:nth-child(${Column}) canvas
    Wait And Click Element      ${Station_Canvas}