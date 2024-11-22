*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30
Resource         Base.robot

*** Variables ***
${Cell_Setting_Modal}           css=div mat-dialog-container
${Spike_Review_Modal}           xpath=//app-spike-review
${Spike_Review_Button}          xpath=//button[@title="Spike Review"]


*** Keywords ***
Open Spike Review
    Wait And Click Element           ${Spike_Review_Button}
    wait until element is visible    ${Spike_Review_Modal}

Select Option From View Filter
    [Arguments]                 ${VIEW_OPTION}      # These options could be "Overview", "All"  or "Final"
    ${Overview_Dropdown}        set variable    xpath=//mat-select[@mattooltip="Spike Group"]
    ${View_Option}              set variable    xpath=//mat-option[@value="${VIEW_OPTION}"]
    Select Option from Mat-Select       ${Overview_Dropdown}            ${View_Option}

Select Option From Sorting Filter
    [Arguments]                 ${SORT_OPTION}     # These Options could be "Show Confirmed First" and "Sorted by Count"
    ${Sort_Dropdown}            set variable    xpath=//mat-select[@mattooltip="Sort Order"]
    ${Sort_Option}              set variable    xpath=//mat-option//*[contains(text(), "${SORT_OPTION}")]
    Select Option from Mat-Select       ${Sort_Dropdown}                ${Sort_Option}

Select Detection Sensitivity
    [Arguments]                 ${DETECTION_SENSITIVITY}    # These options could be "Low", "Medium" and "High"
    ${Sensitivity_Dropdown}           set variable    xpath=//mat-select[@mattooltip="Detection Sensitivity"]
    ${Sensitivity_Option}             set variable    xpath=//mat-option//*[contains(text(), "${DETECTION_SENSITIVITY}")]
    Select Option from Mat-Select       ${Sensitivity_Dropdown}     ${Sensitivity_Option}

Select Option From Intercrenial Filter
    [Arguments]                 ${INTERCRENIAL_OPTION}     # These options could be "true" or "false"
    ${Intercrenial_Dropdown}    set variable    xpath=//mat-select[@mattooltip="Interictal/All"]
    ${Intercrenial_Option}      set variable    xpath=//mat-option[@value="${INTERCRENIAL_OPTION}"]
    Select Option from Mat-Select       ${Intercrenial_Dropdown}                ${Intercrenial_Option}

Launch Spike Review If Not Launched Already
    ${comment_list_visibility}  get element count    ${Spike_Review_Modal}
    IF    ${comment_list_visibility} == 0
        wait until page contains element             ${Spike_Review_Button}
        Wait And Click Element                       ${Spike_Review_Button}
        wait until page contains element             ${Spike_Review_Modal}         40s
    END
    wait until page does not contain element    xpath=//mat-progress-spinner        2m
    wait until page does not contain element    xpath=(//mat-spinner)[1]            2m

Close Spike Review If Launched Already
    ${Spike_Modal_visibility}  get element count    ${Spike_Review_Modal}
    IF    ${Spike_Modal_visibility} != 0
            Wait And Click Element                  ${Spike_Review_Button}
    END

Open First Spike Group
    ${Spike_Group}      set variable            xpath=(//app-patient-views//app-spike-image)[1]
    Wait And Click Element                      ${Spike_Group}
    wait until page does not contain element    xpath=(//mat-spinner)[1]

Click on First Spike Link
    ${First_Spike_Link}         set variable    xpath=(//*[contains(@class, "spike-container")])[2]//*[contains(@class, "spike-link")]
    Wait And Click Element      ${First_Spike_Link}

Click on Voltage Map's Timeseries buttons
    ${Top_Timeseries_Button}        set variable    xpath=(//button[@mattooltip="Time Series"])[1]
    ${Bottom_Timeseries_Button}     set variable    xpath=(//button[@mattooltip="Time Series"])[2]
    Wait And Click Element          ${Top_Timeseries_Button}
    Wait And Click Element          ${Bottom_Timeseries_Button}

Select Group Display Style
    [Arguments]                 ${GROUP_DISPLAY_OPTION}         # Options could be "Grand Average", "Selected Over Confirmed" and "Selected Over Each Confirmed"
    ${STYLE_DROPDOWN}           set variable    xpath=//mat-select[@mattooltip="Group Display Style"]
    ${Style_Option}             set variable    xpath=//mat-option//*[contains(text(), "${GROUP_DISPLAY_OPTION}")]

Get Spike's group Title
    [Arguments]    ${SPIKE_NUMBER}
    ${Spike_Title_Locator}      set variable    (//*[@class="spike-title"])[${SPIKE_NUMBER}]//*[@class="spike-text"]
    ${Spike_Group_Title}      Wait and Get Element Text        ${Spike_Title_Locator}
    log    ${Spike_Group_Title}
    RETURN    ${Spike_Group_Title}

Get Spike's Title
    [Arguments]    ${SPIKE_NUMBER}
    ${Spike_Title_Locator}      set variable    (//*[@class="spike-title"])[${SPIKE_NUMBER}]//*[@class='spike-link spike-text']
    ${Spike_Title}      Wait and Get Element Text        ${Spike_Title_Locator}
    log    ${Spike_Title}
    RETURN    ${Spike_Title}

Click on Spike's Image
    [Arguments]    ${SPIKE_NUMBER}
    ${Spike_Image}              set variable    (//app-spike-image)[${SPIKE_NUMBER}]
    Wait And Click Element          ${Spike_Image}