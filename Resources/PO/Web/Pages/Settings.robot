*** Settings ***
Library    SeleniumLibrary  timeout=0:00:15
Resource    Base.robot

*** Variables ***
${Setting_Button_Locator}           css=button[title="Settings"]
${Logout_Button_Locator}            xpath=//div[text()=' Logout ']
${Setting_Page_Last_Element}        id=EEG-high-resolution
${Include_Spike_Checkbox}           id=include-spike-comments
${Setting_Page_URL}                 http://10.193.0.106/PersystMobile/record-views/user-settings
${Patient_Link}                     xpath=//div[text()='Patients']
${Include_Spike_Checkbox_Bullet}    css=#include-spike-comments-button > div.mdc-switch__handle-track
${Comment_Sort_Dropdown}            id=Comments Sort
&{Comment_Sort_Options}             ASC=#mat-option-1 > span     DES=#mat-option-0 > span
${Quick_Comment_Switch}             id=quick-comment-checkbox
${Quick_Comment_Bullet}             css=#quick-comment-checkbox-button > div.mdc-switch__handle-track > div > div.mdc-switch__icons.ng-star-inserted
${Patient_Name_Switch}              id=patient-name-display
${Patient_Name_Bullet}              css=#patient-name-display-button > div.mdc-switch__handle-track > div > div.mdc-switch__icons.ng-star-inserted
${EEG_BackgroundColor_Button}       xpath=//ngx-colors[1]
${EEG_BackColor_Input}              css=#ngx-colors-overlay input
${Grid_BackColor_Label}             xpath=//label[text()='Show Patient Names on EEG and Trends:']
${Grid_BackColor_Button}            xpath=//ngx-colors[2]
${Grid_BackColor_Input}             css=#ngx-colors-overlay > ngx-colors-panel input
&{LFF_Type}                         Time-Constant=LFF-time     Frequency=LFF-frequency
&{Date_Format_Options}              mm-dd-yyyy=date-mm-dd-yyyy    D1D2=date-D1D2    None=date-None
&{Time_Formats}                     Clock-Time=time-clock   Elapsed-Time=time-elapsed     Seconds=time-seconds
${Time_Decimal_Input}               id=Time Decimals
${Max_Record_Age_Input}             id=Maximum Record Age
${Max_Record_Duration_Input}        id=Maximum Record Duration
${Segment_Record_Day_switch}        id=segment-by-day
${Segment_Record_Day_Bullet}        css=#segment-by-day-button > div.mdc-switch__handle-track > div > div.mdc-switch__icons.ng-star-inserted
${Segment_Specific_Time_Switch}     id=segment-specific-time
${Segment_Specific_Time_Bullet}     css=#segment-specific-time-button > div.mdc-switch__handle-track > div > div.mdc-switch__icons.ng-star-inserted
${Refresh_Interval}                 id=Refresh Interval
${Inactivity_Timeout}               id=Inactivity Timeout
${Turnoff_On_Inactivity_Switch}     id=inactivity-on-off
${Turnoff_On_Inactivity_Bullet}     css=#inactivity-on-off-button > div.mdc-switch__handle-track > div > div.mdc-switch__icons.ng-star-inserted
${Show_Connection_Speed_Switch}     id=mat-mdc-slide-toggle-3
${Show_Connection_Speed_Bullet}     css=#mat-mdc-slide-toggle-3-button svg.mdc-switch__icon.mdc-switch__icon--off
${High_Resolution_EEG_Switch}       id=EEG-high-resolution
${High_Resolution_EEG_Bullet}       css=#EEG-high-resolution-button svg.mdc-switch__icon.mdc-switch__icon--off
${Escape}                           \\35
${Reset_User_Interface}             id=ui-reset-button
${Montage_Editor_New_Button}        name=New-Montage
${New_Montage_Modal}                xpath=//mat-dialog-container
${New_Montage_Name_Textfield}       name=New-Montage-Input
${New_Montage_Modal_Ok_Button}      name=Name-Ok
${Select_Montage_Dropdown}          xpath=//mat-select[@placeholder="Click New to create a Montage."]
${Reset_All_User_Settings_Button}   id=reset-button
${Reset_Modal_Title}                xpath=//app-alert-confirm-dialog/h1
${Reset_Modal_RESET_Button}         id=Reset Settings-Reset
${Reset-Modal_OK_Button}            id=Reset Complete-OK
${First_Montage_In_Dropdown}        css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-montage-editor-page > div > div:nth-child(2) > app-montage-editor > div > div:nth-child(1) > div > div:nth-child(1) > div > mdl-select > div > mdl-popover > div > mdl-option:nth-child(1) > div > div
${Save_New_Montage_Button}          xpath=//mdl-button[text()="Save"]
${Montage_Editor_More_Actins_Button}   xpath=//button[@title="More Actions"]
${Delete_Montage_Option}            xpath=//mdl-menu-item[text()="Delete"]
${Edit_Montage_Channel_Modal}       xpath=//mdl-dialog-host-component[contains(@class, 'mdl-dialog') and contains(@class, 'open')]
${Edit_Mtg_Modal_Cancel}            xpath=//mdl-button[text()="Cancel"]
${Show_All_Montage_Switch}          xpath=//*[@label="ShowAllMontages"]
${Show_All_Montage_Bullet}          xpath=//mat-slide-toggle[@label="ShowAllMontages"]/div//div[@class="mdc-switch__icons ng-star-inserted"]
&{Favorite_Montage_Options}         Laplacian=/html/body/app-root/div[1]/app-patient-views/app-user-settings/div/app-montage-favorites/div/div[2]/div/div/div/mdl-list/mdl-list-item[8]/div[1]/mdl-switch/div[2]   Neo AvRef=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-montage-favorites > div > div:nth-child(2) > div > div > div > mdl-list > mdl-list-item:nth-child(10) > div:nth-child(1) > mdl-switch > div.mdl-switch__thumb
${User_Settings_Link}               xpath=//div[text()="User Settings"]
${Add_Comment_Record_Filter}        xpath=//div[text()=" Add "]
${New_Comment_Filter_Name_Input}    xpath=//mdl-textfield[@label="Filter Name"]//input[@type="text"]
${New_Comment_Filter_String_Input}  xpath=//mdl-textfield[@label="Search String"]//input[@type="text"]
${Regular_String_Switch}            xpath=//mat-slide-toggle[@label="Regular-Toggle"]
${Regular_String_Bullet}            xpath=//mat-slide-toggle[@label="Regular-Toggle"]/div/button/div[2]/div
${Ignore_String_Switch}             xpath=//mat-slide-toggle[@label="Seizure-Toggle"]
${Ignore_String_Bullet}             xpath=//mat-slide-toggle[@label="Seizure-Toggle"]/div/button/div[2]/div
${Include_Notification_Switch}      xpath=//mat-slide-toggle[@label="Notification-Toggle"]
${Include_Notification_Bullet}      xpath=//mat-slide-toggle[@label="Notification-Toggle"]/div/button/div[2]/div
${New_Comment_Done_Button}          xpath=//div[text()=" Done "]
${Delete_Button}                    xpath=//button[@class='btn btn-xs btn-danger ng-star-inserted']
*** Keywords ***
Reset User Settings
    Wait And Click Element    ${Reset_All_User_Settings_Button}
    wait until page contains element    ${Reset_Modal_Title}
    click button     Reset
    wait until page contains element       ${Reset-Modal_OK_Button}
    click button    OK
    wait until page does not contain element    ${Reset-Modal_OK_Button}

Logging out
    Click On Settings Button
    verify "setting" page loaded
    Click On "Logout"
    Verify User Successfully Logged Out

Click On Settings Button
    ${current_url}      get location
    IF      $current_url == $Setting_Page_URL
            no operation
    ELSE
            wait until page contains element    ${Setting_Button_Locator}
            Wait And Click Element                       ${Setting_Button_Locator}
            Verify "Setting" page loaded
    END

Click On "Logout"
    wait until page contains element    ${Logout_Button_Locator}
    Wait And Click Element                               ${Logout_Button_Locator}
    sleep    3s

Verify "Setting" page loaded
    wait until page contains element            ${Setting_Page_Last_Element}

Click on Patient Link
    Wait And Click Element    ${PATIENT_LINK}
    sleep    1s

Verify User Successfully Logged Out
    wait until page contains     Welcome To Persyst Mobile

Change "Include Spikes In Comment" checkbox
    [Arguments]      ${STATUS}
    ${class_attribute}    get element attribute    ${Include_Spike_Checkbox}    class
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-valid mat-mdc-slide-toggle-checked ng-dirty ng-touched'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${STATUS}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element    ${Include_Spike_Checkbox_Bullet}
            END
    ELSE IF    '${STATUS}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element   ${Include_Spike_Checkbox_Bullet}
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
    Wait And Click Element                       ${comment_sort_dropdown}
    wait until page contains element    css=${Comment_Sort_Options}[${ASC/DES}]
    IF            '${ASC/DES}' == 'ASC'
        Wait And Click Element               css=${Comment_Sort_Options}[${ASC/DES}]
    ELSE
        Wait And Click Element               css=${Comment_Sort_Options}[${ASC/DES}]
    END

Change "Add Quick Comments" checkbox
    [Arguments]      ${STATUS}
    ${class_attribute}    get element attribute    ${Quick_Comment_Switch}    class
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-untouched ng-pristine ng-valid mat-mdc-slide-toggle-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${STATUS}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element    ${Quick_Comment_Bullet}
            END
    ELSE IF    '${STATUS}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element   ${Quick_Comment_Bullet}
            ELSE
                no operation
            END
    END

Select Display Options
    [Arguments]    ${TRENDS/EEG/EEGONLY}
    Wait And Click Element    xpath=//*[text()="${TRENDS/EEG/EEGONLY}"]/../div

Change "Show Patient Name" setting
    [Arguments]      ${STATUS}
    ${class_attribute}    get element attribute    ${Patient_Name_Switch}    class
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-untouched ng-pristine ng-valid mat-mdc-slide-toggle-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${STATUS}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element    ${Patient_NAme_Bullet}
            END
    ELSE IF    '${STATUS}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element   ${Patient_NAme_Bullet}
            ELSE
                no operation
            END
    END

Enter EEG Background Color
    [Arguments]      ${COLOR-CODE}
    Wait And Click Element    ${EEG_BackgroundColor_Button}
    input text       ${EEG_BackColor_Input}     ${COLOR-CODE}
    Press Keys       ${EEG_BackColor_Input}     RETURN

Enter Grid Background Color
    [Arguments]      ${COLOR-CODE}
    Wait And Click Element    ${Grid_BackColor_Button}
    input text       ${Grid_BackColor_Input}    ${COLOR-CODE}
    Press Keys       ${EEG_BackColor_Input}     RETURN

Change LFF Type Setting
    [Documentation]             The options are 'Time-Constant' and 'Frequency'
    [Arguments]                 ${TIME/FREQUENCY}
    scroll element into view    id=${LFF_Type}[${TIME/FREQUENCY}]
    Wait And Click Element               id=${LFF_Type}[${TIME/FREQUENCY}]

Change Date Formats for EEG and Trends
    [Documentation]             The Options are 'mm-dd-yyyy', 'D1D2' and 'None'
    [Arguments]                 ${MM-DD-YYY/D1D2/NONE}
    Wait And Click Element               xpath=//*[text()="${MM-DD-YYY/D1D2/NONE}"]/../div

Change Time Format Setting
    [Documentation]             The options are 'Clock-Time', 'Elapsed-Time', 'Seconds-Recorded'
    [Arguments]                 ${CLOCK/ELAPSED/SECONDS}
    Wait And Click Element               xpath=//*[text()="${CLOCK/ELAPSED/SECONDS}"]/../div

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
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-valid ng-dirty ng-touched mat-mdc-slide-toggle-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element    ${Segment_Record_Day_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element   ${Segment_Record_Day_Bullet}
            ELSE
                no operation
            END
    END

Change Segment By Specific Time Switch Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${Segment_Specific_Time_Switch}    class
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-valid ng-dirty mat-mdc-slide-toggle-checked ng-touched'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element    ${Segment_Specific_Time_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element   ${Segment_Specific_Time_Bullet}
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
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-pristine ng-valid mat-mdc-slide-toggle-checked ng-touched'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element      ${Turnoff_On_Inactivity_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element    ${Turnoff_On_Inactivity_Bullet}
            ELSE
                  no operation
            END
    END

Change 'Show Connection Speed' Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${Show_Connection_Speed_Switch}    class
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-valid ng-touched mat-mdc-slide-toggle-checked ng-dirty'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element      ${Show_Connection_Speed_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element    ${Show_Connection_Speed_Bullet}
            ELSE
                no operation
            END
    END

Change 'EEG High Resolution' Status
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${High_Resolution_EEG_Switch}   class
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-valid mat-mdc-slide-toggle-checked ng-dirty ng-touched'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                Wait And Click Element      ${High_Resolution_EEG_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element    ${High_Resolution_EEG_Bullet}
            ELSE
                no operation
            END
    END

Click on 'Reset User Interface'
    Wait And Click Element                 ${Reset_User_Interface}
    wait until page contains element       ${Reset_Modal_Title}
    click button         Reset
    wait until page contains                User interface settings have been reset.
    click button         OK
    wait until page does not contain        User interface settings have been reset.

Click 'User Guide' Link
    click link    User Guide

Switch to User Guide Tab and Verify The URL
    ${open_tabs}=   get window handles
    switch window    ${open_tabs}[1]
    ${url}=     get location
    should be equal    ${url}       https://www.persyst.com/PersystMobile/WebUserGuide.pdf
    switch window    ${open_tabs}[0]

Click On Montage Editor
    click link    Montage Editor
    wait until page contains    Other Channels

Create New Montage
    Wait And Click Element    ${Montage_Editor_New_Button}
    click button              New
    wait until page contains element    ${New_Montage_Modal}
    input text                ${New_Montage_Name_Textfield}         Moji Montage
    Wait And Click Element    ${New_Montage_Modal_Ok_Button}
    sleep    5s
    Add Channels to Montage    F7
    Add Channels to Montage    F3
    Add Channels to Montage    P4
    Add Channels to Montage    T6
    sleep    5s
    Click 'Save' Montage Button

Add Channels to Montage
    [Arguments]    ${CHANNEL_NAME}
    click button    ${CHANNEL_NAME}

Click 'Save' Montage Button
    Wait And Click Element      ${Save_New_Montage_Button}

Click on Montage List Dropdown
    click element      ${Select_Montage_Dropdown}

Select First Montage On Dropdown
    Click Element      ${First_Montage_In_Dropdown}

Select Delete Montage
    click button                ${Montage_Editor_More_Actins_Button}
    click element                ${Delete_Montage_Option}
    click button     OK

Edit Created Montage
    click button     Edit
    wait until element is visible  ${Edit_Montage_Channel_Modal}
    Wait And Click Element         ${Edit_Mtg_Modal_Cancel}
    wait until page does not contain element    ${Edit_Montage_Channel_Modal}

Delete Channels From Created Montage
    click button    Delete

Click On 'Favorite Montage' Link
    click link    Montage Favorites
    wait until page contains    Montage Favorites

Change Show All Favorite Montage Settings
    [Arguments]    ${ON/OFF}
    ${class_attribute}    get element attribute    ${Show_All_Montage_Switch}    class
    IF      '${class_attribute}' == 'mat-mdc-slide-toggle mat-accent ng-untouched ng-pristine ng-valid mat-mdc-slide-toggle-checked'
             ${checkbox_status}    set variable    True
    ELSE
             ${checkbox_status}    set variable    False
    END
    IF      '${ON/OFF}' == 'Enable'
            IF  '${checkbox_status}' == 'False'
                click element    ${Show_All_Montage_Bullet}
            END
    ELSE IF    '${ON/OFF}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  click element   ${Show_All_Montage_Bullet}
            ELSE
                no operation
            END
    END

Select Montage From List Of Favorite Montages
    [Arguments]      ${MONTAGE_NAME}
    wait until page contains element     xpath=${Favorite_Montage_Options}[${MONTAGE_NAME}]
    Wait And Click Element               xpath=${Favorite_Montage_Options}[${MONTAGE_NAME}]

Delete Previouly Create Montage If Exist
    ${First_Montage}    set variable    xpath=//app-montage-editor//mat-select[@placeholder="Click New to create a Montage."]/div/div/span/span
    Click on Montage List Dropdown
    ${First_Montage_Name}       get text    ${First_Montage}
    IF    '${First_Montage_Name}' == 'Moji Montage (User)'
            Settings.Select First Montage On Dropdown
            Settings.Select Delete Montage
            sleep   5s
    END

Click On User Settings From Inside Settings Pages
    Wait And Click Element       ${User_Settings_Link}

Click On 'Comment Filter' Button
    click link                   Comment Filters
    wait until page contains     User Comment Filters

click on 'Add' New Comment Filter
    Wait And Click Element               ${Add_Comment_Record_Filter}
    wait until page contains             Include Notifications

Create New Comment Filter
    click on 'Add' New Comment Filter
    input text    ${New_Comment_Filter_Name_Input}      Moji Filter
    input text    ${New_Comment_Filter_String_Input}    Moji Comment
    Wait And Click Element    ${Regular_String_Bullet}
    Wait And Click Element    ${Ignore_String_Bullet}
    Wait And Click Element    ${Include_Notification_Bullet}
    Wait And Click Element    ${New_Comment_Done_Button}
    page should contain    Moji Filter

Delete Comment Filter
    Wait And Click Element                     xpath=//button[text()="- "]

Click on Keyboard Shortcut Settings
    click link                  Keyboard Settings
    wait until page contains    To change a key binding click on the command and then press the key combination you want to use.

Change Keyboard Shortcut Settings
    [Arguments]    ${ACTION}        ${KEY}
    ${Action_Row}               set variable    //div[text()=' ${ACTION} ']
    click element                               ${Action_Row}
    press keys    None      ${KEY}

Click On Reset Keyboard Shortcut Button
    ${Reset_Default}            set variable    id=Reset-Defaults-Button
    click element                               ${Reset_Default}
    ${Reset_Modal_Text}         set variable    xpath=//div[text()='Are you sure you want to reset to the default values?']
    wait until page contains element            ${Reset_Modal_Text}
    click button     Reset
    wait until page does not contain element    ${Reset_Modal_RESET_Button}

Click Change Password On Settings
    click link                  Change Password
    wait until page contains    Passwords must match.


Enter Old and New Password
    [Arguments]    ${OLD_PASSWORD}          ${NEW_PASSWORD}
    wait until page contains element        id=Old Password
    wait until page contains element        id=New Password
    wait until page contains element        id=Retype New Password
    sleep    1s
    input text    id=Old Password           ${OLD_PASSWORD}
    input text    id=New Password           ${NEW_PASSWORD}
    input text    id=Retype New Password    ${NEW_PASSWORD}
    ${Update_Password}    set variable    id=Update-Password-Button
    click element    ${Update_Password}
    wait until page contains              Your password has been successfully changed
    wait until page contains              Ok
    click button                          Ok

Delete Filter If Exist
    ${Delete_Button_Exist}          get element count    ${Delete_Button}
    IF      ${Delete_Button_Exist} != 0
            delete comment filter
     END

Delete Comment Filters Until None Exist
    FOR    ${index}    IN RANGE    10    # a limit to avoid an infinite loop
        ${element_exists}=    Run Keyword And Return Status    Element Should Be Visible    ${Delete_Button}
        Exit For Loop If    not ${element_exists}
        Click Element    ${Delete_Button}
        Sleep    2s
        Log    Clicked the button
    END
    Log    Button does not exist anymore

Click on Shared Setting Link
    ${Shared_Settings}      set variable    xpath=//span[text()="Shared Settings"]
    Wait And Click Element      ${Shared_Settings}
    wait until page contains    Standard Comments

Click on Unit Definition
    click link    Unit Definitions
    wait until page contains    Edit Unit Definitions
    sleep    2s

Add a New Unit
    [Arguments]                    ${UNIT_NAME}    ${UNIT_DESCRIPTION}
    ${Add_Unit_Button}             set variable    xpath=//div[text()=' Add Unit ']
    Base.Wait And Click Element                    ${Add_Unit_Button}
    ${Unit_Name_Input}             set variable    xpath=//input[@label="Unit-Name"]
    input text    ${Unit_Name_Input}               ${UNIT_NAME}
    ${Unit_Description_Input}      set variable    xpath=//input[@label="Unit-Description"]
    input text    ${Unit_Description_Input}        ${UNIT_DESCRIPTION}
    sleep    2s
    ${Done_Button}                 set variable    xpath=//div[text()=' Done ']
    Wait And Click Element                         ${Done_Button}
    ${Created_Unit}                set variable    xpath=//div[text()=' ${UNIT_NAME} ']
    wait until page contains element               ${Created_Unit}
    sleep    2s

Delete Previously Created Units
    Delete Items Until None Exist                  ${Delete_Button}

Click on Patient Unit Assignments Link
    click link                                     Patient Unit Assignments
    wait until page contains                       Only Show Unassigned Patients
    sleep    3s

Assign a Patient to a Unit
    [Arguments]                     ${UNIT_NAME}                ${PATIENT_NAME}
    ${Search_Input}                 set variable    xpath=//input[@label="String-Text-Input"]
    input text                      ${Search_Input}             ${PATIENT_NAME}
    ${Unit_Dropdown}                set variable    xpath=//mat-select[@placeholder='Unit']/div
    wait until page contains element                            ${Unit_Dropdown}        40s
    sleep    3s
    Wait And Click Element                                      ${Unit_Dropdown}
    ${Unit_Option}                  set variable    xpath=//span[text()='${UNIT_NAME}']
    Wait And Click Element                                      ${Unit_Option}

Click on Standard Comments Link
    click link                                      Standard Comments
    wait until page contains                        Rhythmic Delta
    wait until page contains                        Select Shared List:

Add a New Standard Comment
    ${Add_Button}                   set variable    xpath=//mat-icon[@label="Add-Button"]/following-sibling::span[2]
    wait until page contains element                                       ${Add_Button}
    Wait And Click Element                                                 ${Add_Button}
    ${Save_Button}                  set variable    xpath=//button[@id="Save-Button"]
    wait until page contains element                              ${Save_Button}
    ${Comment_Text_Input}           set variable    xpath=//input[@label="Comment-Text-Input"]
    input text                      ${Comment_Text_Input}         New Moji Comment
    Wait And Click Element                   ${Save_Button}

Click on Shared Comment Filters on Shared Settings
    click link                                      Shared Comment Filters
    wait until page contains                        Shared Comment Filters

Delete Created Standard Comment
    [Arguments]     ${COMMENT_NAME}
    ${Delete_Button}                set variable        xpath=//div[text()=' ${COMMENT_NAME} ']/../button
    Base.Delete Items Until None Exist                             ${Delete_Button}

Click on Trends Default Settings
    ${Trends_Settings}      set variable    xpath=//span[text()="Trends Settings"]
    Wait And Click Element      ${Trends_Settings}
    wait until page contains    Default Trends Duration:


Click on EEG Default Settings
    ${EEG_Settings}      set variable    xpath=//span[text()="EEG Settings"]
    Wait And Click Element      ${EEG_Settings}
    wait until page contains    Off

Select a Panel From Trends Default Panel Dropdown
    [Arguments]    ${DEFAULT_PANEL}
    ${Panel_Dropdown}               set variable    xpath=//mat-select[@id="Default Panel"]/div
    Wait And Click Element                          ${Panel_Dropdown}
    ${Panel_Menu}                   set variable    xpath=//div[@id="Default Panel-panel"]
    wait until element is visible                   ${Panel_Menu}       40s
    ${Panel_Option}                 set variable    xpath=//mat-option/span[text()='${DEFAULT_PANEL}']
    click element                                   ${Panel_Option}

Select a Duration From Trends Default Duration Dropdown
    [Arguments]    ${DEFAULT_DURATION}
    ${Duration_Dropdown}               set variable    id=Default Duration
    Wait And Click Element                          ${Duration_Dropdown}
    ${Duration_Option}                 set variable    xpath=//mat-option/span[text()='${DEFAULT_DURATION}']
    Wait And Click Element                          ${Duration_Option}

Assign Patient to a Unit For Monitoring(4Backspace)
    [Arguments]                     ${UNIT_NAME}                ${PATIENT_NAME}
    ${Search_Input}                 set variable    xpath=//input[@label="String-Text-Input"]
    input text                      ${Search_Input}             ${PATIENT_NAME}
    Press Keys    ${Search_Input}    CTRL+END   BACKSPACE   BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE   BACKSPACE   BACKSPACE   BACKSPACE   BACKSPACE
    ${Unit_Dropdown}                set variable    xpath=//mat-select[@placeholder='Unit']/div
    wait until page contains element                            ${Unit_Dropdown}        40s
    sleep    3s
    Wait And Click Element                                      ${Unit_Dropdown}
    ${Unit_Option}                  set variable    xpath=//span[text()='${UNIT_NAME}']
    Wait And Click Element                                      ${Unit_Option}

Select Patient Record For Default Settings
    [Arguments]         ${PATIENT_NAME}
    ${Patient_Dropdown}         set variable    xpath=//label[text()='Selected Record:']/following-sibling::div
    Wait And Click Element      ${Patient_Dropdown}
    wait until page contains    Select Record
    wait until page contains element            id=Cancel_Button      # Cancel Button on the modal
    ${Patient_Record_Textfield}         set variable        xpath=//input[@label="Modal Patient Name Filter"]
    input text          ${Patient_Record_Textfield}         ${PATIENT_NAME}
    ${Patient_Item}     set variable        xpath=//mat-list-item/span/span[text()=' ${PATIENT_NAME} ']
    Wait And Click Element          ${Patient_Item}
