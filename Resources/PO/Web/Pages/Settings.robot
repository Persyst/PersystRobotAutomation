*** Settings ***
Library    SeleniumLibrary  timeout=0:00:15

*** Variables ***
${Setting_Button_Locator}           css=button[title="Settings"]
${Logout_Button_Locator}            xpath=/html/body/app-root/div[1]/app-patient-views/app-user-settings/div/div[1]/div[3]
${Setting_Page_Last_Element}        css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(25) > mdl-switch
${Include_Spike_Checkbox}           id=include-spike-comments
${Setting_Page_URL}                 http://192.168.156.119/PersystMobile/record-views/user-settings
${Patient_Link}                     css=body  app-patient-views > app-user-settings > div > div.unselectable.view-header > div:nth-child(1) > div > div
${Include_Spike_Checkbox_Bullet}    css=body app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(8) > mdl-switch > div.mdl-switch__thumb
${Comment_Sort_Dropdown}            id=Comments Sort
&{Comment_Sort_Options}             ASC=div [id$='Sort'] mdl-option:nth-child(2)     DES=div [id$='Sort'] mdl-option:nth-child(1)
${Quick_Comment_Switch}             css= app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(7) > mdl-switch
${Quick_Comment_Bullet}             css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(7) > mdl-switch > div.mdl-switch__thumb
&{Display_Options}                  EEG=display-eeg     Trends=display-trends     Only-EEG=display-only-eeg
${Patient_Name_Switch}              id=patient-name-display
${Patient_Name_Bullet}              id=patient-name-display
${EEG_BackgroundColor_Button}       id=EEG Background Color
${EEG_BackColor_Input}              css=mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(11) > color-picker > div > div.hex-text > div:nth-child(1) > input
${Grid_BackColor_Label}             xpath=/html/body/app-root/div[1]/app-patient-views/app-user-settings/div/mdl-tabs/mdl-tab-panel[1]/div/div[1]/div[6]/label
${Grid_BackColor_Button}            id=EEG Grid Color
${Grid_BackColor_Input}             css=app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(12) > color-picker > div > div.hex-text > div:nth-child(1) > input
&{LFF_Type}                         Time-Constant=LFF-time     Frequency=LFF-frequency
&{Date_Format_Options}              mm-dd-yyyy=date-mm-dd-yyyy    D1D2=date-D1D2    None=date-None
&{Time_Formats}                     Clock-Time=time-clock   Elapsed-Time=time-elapsed     Seconds=time-seconds
${Time_Decimal_Input}               id=Time Decimals
${Max_Record_Age_Input}             id=Maximum Record Age
${Max_Record_Duration_Input}        id=Maximum Record Duration
${Segment_Record_Day_switch}        id=segment-by-day
${Segment_Record_Day_Bullet}        css=mdl-switch[id="segment-by-day"] div:nth-child(4)
${Segment_Specific_Time_Switch}     id=segment-specific-time
${Segment_Specific_Time_Bullet}     css=mdl-switch[id="segment-specific-time"] div:nth-child(4)
${Refresh_Interval}                 id=Refresh Interval
${Inactivity_Timeout}               id=Inactivity Timeout
${Turnoff_On_Inactivity_Switch}     id=inactivity-on-off
${Turnoff_On_Inactivity_Bullet}     css=mdl-switch[id="inactivity-on-off"] div:nth-child(4)
${Show_Connection_Speed_Switch}     css=mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(24) > div > mdl-switch
${Show_Connection_Speed_Bullet}     css=mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(24) > div > mdl-switch > div.mdl-switch__thumb
${High_Resolution_EEG_Switch}       id=EEG-high-resolution
${High_Resolution_EEG_Bullet}       css=mdl-switch[id='EEG-high-resolution'] div:nth-child(4)
${Escape}                           \\35
${Reset_User_Interface}             css=app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(2) > mdl-button
*** Keywords ***
Logging out
    Click On Settings Button
    verify "setting" page loaded
    Click On "Logout"

Click On Settings Button
    click element  ${Setting_Button_Locator}

Click On "Logout"
    click element  ${Logout_Button_Locator}
    sleep    3s

Verify "Setting" page loaded
    wait until page contains element    ${Setting_Page_Last_Element}

Click on Patient Link
    click element    ${PATIENT_LINK}

Verify User Successfully Logged Out
    wait until page contains     Welcome To Persyst Mobile

Change "Include Spikes In Comment" checkbox
    [Arguments]      ${STATUS}
    ${class_attribute}    get element attribute    ${Include_Spike_Checkbox}    class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${STATUS}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${Include_Spike_Checkbox_Bullet}
            END
    ELSE IF    '${STATUS}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Include_Spike_Checkbox_Bullet}
            ELSE
                no operation
            END
    END

Go To Settings Page
    ${current_url}      get location
    IF      $current_url == $Setting_Page_URL
            no operation
    ELSE
            go to    ${Setting_Page_URL}
    END

Select Comment Sort Order
    [Arguments]    ${ASC/DES}
    click element                       ${comment_sort_dropdown}
    wait until page contains element    css=${Comment_Sort_Options}[${ASC/DES}]
    IF            '${ASC/DES}' == 'ASC'
        click element               css=${Comment_Sort_Options}[${ASC/DES}]
    ELSE
        click element               css=${Comment_Sort_Options}[${ASC/DES}]
    END

Change "Add Quick Comments" checkbox
    [Arguments]      ${STATUS}
    ${class_attribute}    get element attribute    ${Quick_Comment_Switch}    class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${STATUS}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${Quick_Comment_Bullet}
            END
    ELSE IF    '${STATUS}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Quick_Comment_Bullet}
            ELSE
                no operation
            END
    END

Select Display Options
    [Arguments]    ${TRENDS/EEG/EEGONLY}
    click element    id=${Display_options}[${TRENDS/EEG/EEGONLY}]

Change "Show Patient Name" setting
    [Arguments]      ${STATUS}
    ${class_attribute}    get element attribute    ${Patient_Name_Switch}    class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${STATUS}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${Patient_NAme_Bullet}
            END
    ELSE IF    '${STATUS}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Patient_NAme_Bullet}
            ELSE
                no operation
            END
    END

Enter EEG Background Color
    [Arguments]      ${COLOR-CODE}
    click element    ${EEG_BackgroundColor_Button}
    input text       ${EEG_BackColor_Input}     ${COLOR-CODE}

Enter Grid Background Color
    [Arguments]      ${COLOR-CODE}
    click element    ${Grid_BackColor_Button}
    input text       ${Grid_BackColor_Input}    ${COLOR-CODE}
    Press Keys       None        ESC

Change LFF Type Setting
    [Documentation]             The options are 'Time-Constant' and 'Frequency'
    [Arguments]                 ${TIME/FREQUENCY}
    scroll element into view    id=${LFF_Type}[${TIME/FREQUENCY}]
    click element               id=${LFF_Type}[${TIME/FREQUENCY}]

Change Date Formats for EEG and Trends
    [Documentation]             The Options are 'mm-dd-yyyy', 'D1D2' and 'None'
    [Arguments]                 ${MM-DD-YYY/D1D2/NONE}
    click element               id=${Date_Format_Options}[${MM-DD-YYY/D1D2/NONE}]

Change Time Format Setting
    [Documentation]             The options are 'Clock-Time', 'Elapsed-Time', 'Seconds-Recorded'
    [Arguments]                 ${CLOCK/ELAPSED/SECONDS}
    click element               id=${Time_Formats}[${CLOCK/ELAPSED/SECONDS}]

Change Time Decimal Numbers
    [Documentation]             There is no predefined numbers, user can enter any number
    [Arguments]                 ${DECIMAL_NUMBER}
    input text                  ${Time_Decimal_Input}       ${DECIMAL_NUMBER}

Change Maximum Record Age
    [Documentation]             There is no predefined numbers, user can enter any number
    [Arguments]                 ${MAX_RECORD_AGE}
    input text                  ${Max_Record_Age_Input}     ${MAX_RECORD_AGE}

Change Maximum Record Duration
    [Documentation]             There is no predefined numbers, user can enter any number
    [Arguments]                 ${MAX_RECORD_DURATION}
    input text                  ${Max_Record_Duration_Input}     ${MAX_RECORD_DURATION}

Change Segment By Day Switch Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${Segment_Record_Day_switch}    class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${Segment_Record_Day_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Segment_Record_Day_Bullet}
            ELSE
                no operation
            END
    END

Change Segment By Specific Time Switch Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${Segment_Specific_Time_Switch}    class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${Segment_Specific_Time_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Segment_Specific_Time_Bullet}
            ELSE
                no operation
            END
    END

Enter 'Refresh Interval' Into Textbox
    [Documentation]    The number will be in minutes and 0 means no refresh
    [Arguments]    ${TIME}
    input text    ${Refresh_Interval}       ${TIME}

Enter 'Inactivity Timeout' Into Textbox
    [Documentation]    The number will be in minutes
    [Arguments]    ${TIME}
    input text    ${Inactivity_Timeout}     ${TIME}

Change 'Inactivity Timeout' Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${Turnoff_On_Inactivity_Switch}    class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element   ${Turnoff_On_Inactivity_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Turnoff_On_Inactivity_Bullet}
            ELSE
                  no operation
            END
    END

Change 'Show Connection Speed' Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${Show_Connection_Speed_Switch}    class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${Show_Connection_Speed_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Show_Connection_Speed_Bullet}
            ELSE
                no operation
            END
    END

Change 'EEG High Resolution' Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${High_Resolution_EEG_Switch}   class
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${High_Resolution_EEG_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${High_Resolution_EEG_Bullet}
            ELSE
                no operation
            END
    END

Click on 'Reset User Interface'
    click element       ${Reset_User_Interface}
    click element    css=mdl-dialog-component > div.mdl-dialog__actions > button:nth-child(1)
    click element    css=mdl-dialog-host-component > mdl-dialog-component > div.mdl-dialog__actions > button

Click 'User Guide' Link
    click link    User Guide

Switch to User Guide Tab and Verify The URL
    ${open_tabs}=   get window handles
    switch window    ${open_tabs}[1]
    ${url}=     get location
    should be equal    ${url}       https://www.persyst.com/PersystMobile/WebUserGuide.pdf



