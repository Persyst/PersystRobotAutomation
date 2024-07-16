*** Settings ***
Library    SeleniumLibrary  timeout=0:00:15
Resource    Base.robot

*** Variables ***
${Setting_Button_Locator}           css=button[title="Settings"]
${Logout_Button_Locator}            xpath=//div[text()=' Logout ']
${Setting_Page_Last_Element}        id=EEG-high-resolution
${Include_Spike_Checkbox}           id=include-spike-comments
${Setting_Page_URL}                 http://192.168.156.119/PersystMobile/record-views/user-settings
${Patient_Link}                     xpath=//div[text()='Patients']
${Include_Spike_Checkbox_Bullet}    css=mdl-switch[id='include-spike-comments'] div[class='mdl-switch__thumb']
${Comment_Sort_Dropdown}            id=Comments Sort
&{Comment_Sort_Options}             ASC=div [id$='Sort'] mdl-option:nth-child(2)     DES=div [id$='Sort'] mdl-option:nth-child(1)
${Quick_Comment_Switch}             id=quick-comment-checkbox
${Quick_Comment_Bullet}             css=mdl-switch[id='quick-comment-checkbox'] div[class='mdl-switch__thumb']
&{Display_Options}                  EEG=display-eeg     Trends=display-trends     Only-EEG=display-only-eeg
${Patient_Name_Switch}              id=patient-name-display
${Patient_Name_Bullet}              css=mdl-switch[id='patient-name-display'] div[class='mdl-switch__thumb']
${EEG_BackgroundColor_Button}       id=EEG Background Color
${EEG_BackColor_Input}              css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(8) > color-picker > div > div.hex-text > div:nth-child(1) > input
${Grid_BackColor_Label}             xpath=//label[text()='Show Patient Names on EEG and Trends:']
${Grid_BackColor_Button}            id=EEG Grid Color
${Grid_BackColor_Input}             css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(9) > color-picker > div > div.hex-text > div:nth-child(1) > input
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
${Reset_User_Interface}             id=ui-reset-button
${Montage_Editor_New_Button}        xpath=//mdl-button[text()='New']
${New_Montage_Modal}                xpath=//mdl-dialog-host-component[@class='mdl-dialog open']
${New_Montage_Name_Textfield}       id=mdl-textfield-3
${New_Montage_Modal_Ok_Button}      xpath=//mdl-button[text()='Ok']
${Select_Montage_Dropdown}          css=input[placeholder="Click New to create a Montage."]
${Reset_All_User_Settings_Button}   id=reset-button
${Reset_Modal_Title}                xpath=//h3[text()=" Confirm Reset "]
${Reset_Modal_RESET_Button}         xpath=//button[text()=' Reset ']
${Reset-Modal_OK_Button}            xpath=//button[text()=' Ok ']
${First_Montage_In_Dropdown}        css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-montage-editor-page > div > div:nth-child(2) > app-montage-editor > div > div:nth-child(1) > div > div:nth-child(1) > div > mdl-select > div > mdl-popover > div > mdl-option:nth-child(1) > div > div
${Save_New_Montage_Button}          xpath=//mdl-button[text()="Save"]
${Montage_Editor_More_Actins_Button}   xpath=//button[@title="More Actions"]
${Delete_Montage_Option}            xpath=//mdl-menu-item[text()="Delete"]
${Edit_Montage_Channel_Modal}       xpath=//mdl-dialog-host-component[contains(@class, 'mdl-dialog') and contains(@class, 'open')]
${Edit_Mtg_Modal_Cancel}            xpath=//mdl-button[text()="Cancel"]
${Show_All_Montage_Switch}          css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-montage-favorites > div > div:nth-child(2) > div > div > mdl-switch
${Show_All_Montage_Bullet}          css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-montage-favorites > div > div:nth-child(2) > div > div > mdl-switch > div.mdl-switch__thumb
&{Favorite_Montage_Options}         Laplacian=/html/body/app-root/div[1]/app-patient-views/app-user-settings/div/app-montage-favorites/div/div[2]/div/div/div/mdl-list/mdl-list-item[8]/div[1]/mdl-switch/div[2]   Neo AvRef=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-montage-favorites > div > div:nth-child(2) > div > div > div > mdl-list > mdl-list-item:nth-child(10) > div:nth-child(1) > mdl-switch > div.mdl-switch__thumb
${User_Settings_Link}               xpath=//div[text()="User Settings"]
${Add_Comment_Record_Filter}        xpath=//div[text()=" Add "]
${New_Comment_Filter_Name_Input}    xpath=//mdl-textfield[@label="Filter Name"]//input[@type="text"]
${New_Comment_Filter_String_Input}  xpath=//mdl-textfield[@label="Search String"]//input[@type="text"]
${Regular_String_Switch}            css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-filters-editor > div > div:nth-child(2) > div > div:nth-child(1) > div > mdl-switch
${Regular_String_Bullet}            xpath=//span[text()='Use Regular Expressions For the Search and Ignore String']/following-sibling::div[@class='mdl-switch__thumb']
${Ignore_String_Switch}             css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-filters-editor > div > div:nth-child(2) > div > div:nth-child(1) > mdl-switch:nth-child(7)
${Ignore_String_Bullet}             xpath=//span[text()='Include Seizure Detections']/following-sibling::div[@class='mdl-switch__thumb']
${Include_Notification_Switch}      css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > app-filters-editor > div > div:nth-child(2) > div > div:nth-child(1) > mdl-switch:nth-child(8)
${Include_Notification_Bullet}      xpath=//span[text()='Include Notifications']/following-sibling::div[@class='mdl-switch__thumb']
${New_Record_Filter_String_Input}   xpath=//mdl-textfield[@label="User Short Name (empty matches all)"]//input[@type="text"]
${New_Comment_Done_Button}          xpath=//div[text()=" Done "]
${Delete_Button}                    xpath=//button[@class='btn btn-xs btn-danger']
*** Keywords ***
Reset User Settings
    Wait And Click Element    ${Reset_All_User_Settings_Button}
    wait until page contains element    ${Reset_Modal_Title}
    click button     Reset
    wait until page does not contain element    ${Reset_Modal_Title}
    wait until page contains element       ${Reset-Modal_OK_Button}
    click button    Ok
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
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
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
    Wait And Click Element    id=${Display_options}[${TRENDS/EEG/EEGONLY}]

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
                Wait And Click Element    ${Patient_NAme_Bullet}
            END
    ELSE IF    '${STATUS}' == 'Disable'
            IF    '${checkbox_status}' == 'True'
                  Wait And Click Element   ${Patient_NAme_Bullet}
            ELSE
                no operation
            END
    ENDgit

Enter EEG Background Color
    [Arguments]      ${COLOR-CODE}
    Wait And Click Element    ${EEG_BackgroundColor_Button}
    input text       ${EEG_BackColor_Input}     ${COLOR-CODE}

Enter Grid Background Color
    [Arguments]      ${COLOR-CODE}
    Wait And Click Element    ${Grid_BackColor_Button}
    input text       ${Grid_BackColor_Input}    ${COLOR-CODE}
    Press Keys       None        ESC

Change LFF Type Setting
    [Documentation]             The options are 'Time-Constant' and 'Frequency'
    [Arguments]                 ${TIME/FREQUENCY}
    scroll element into view    id=${LFF_Type}[${TIME/FREQUENCY}]
    Wait And Click Element               id=${LFF_Type}[${TIME/FREQUENCY}]

Change Date Formats for EEG and Trends
    [Documentation]             The Options are 'mm-dd-yyyy', 'D1D2' and 'None'
    [Arguments]                 ${MM-DD-YYY/D1D2/NONE}
    Wait And Click Element               id=${Date_Format_Options}[${MM-DD-YYY/D1D2/NONE}]

Change Time Format Setting
    [Documentation]             The options are 'Clock-Time', 'Elapsed-Time', 'Seconds-Recorded'
    [Arguments]                 ${CLOCK/ELAPSED/SECONDS}
    Wait And Click Element               id=${Time_Formats}[${CLOCK/ELAPSED/SECONDS}]

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
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
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
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
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
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
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
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
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
    click button         Reset
    wait until page contains                User interface settings have been reset.
    click button         Ok
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
    click element      ${Delete_Montage_Option}
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
    IF      '${class_attribute}' == 'is-upgraded mdl-switch ng-untouched ng-pristine ng-valid is-checked'
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
    ${Reset_Default}            set variable    xpath=//mdl-button[text()='Reset to Defaults']
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
    ${Update_Password}    set variable    xpath=//mdl-button[text()='Update Password']
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
    click link                  Shared Settings
    wait until page contains    Standard Comments

Click on Unit Definition
    click link    Unit Definitions
    wait until page contains    Edit Unit Definitions
    sleep    2s

Add a New Unit
    [Arguments]                    ${UNIT_NAME}    ${UNIT_DESCRIPTION}
    ${Add_Unit_Button}             set variable    xpath=//div[text()=' Add Unit ']
    Base.Wait And Click Element                    ${Add_Unit_Button}
    ${Unit_Name_Input}             set variable    xpath=//mdl-textfield[@label="Unit Name"]/div/input
    input text    ${Unit_Name_Input}               ${UNIT_NAME}
    ${Unit_Description_Input}      set variable    xpath=//mdl-textfield[@label="Unit Description"]/div/input
    input text    ${Unit_Description_Input}        ${UNIT_DESCRIPTION}
    ${Done_Button}                 set variable    xpath=//div[text()=' Done ']
    Wait And Click Element                         ${Done_Button}
    ${Created_Unit}                set variable    xpath=//div[text()=' ${UNIT_DESCRIPTION} ']
    wait until page contains element               ${Created_Unit}

Delete Previously Created Units
    Delete Items Until None Exist                  ${Delete_Button}

Click on Patient Unit Assignments Link
    click link                                     Patient Unit Assignments
    wait until page contains                       Only Show Unassigned Patients

Assign a Patient to a Unit
    [Arguments]                     ${UNIT_NAME}                ${PATIENT_NAME}
    ${Search_Input}                 set variable    xpath=//mdl-textfield[@label="Search String"]/div/input
    input text                      ${Search_Input}             ${PATIENT_NAME}
    ${Unit_Dropdown}                set variable    xpath=//mdl-select[@placeholder='Unit']/div
    wait until page contains element                            ${Unit_Dropdown}
    sleep    3s
    Wait And Click Element                                      ${Unit_Dropdown}
    ${Unit_Option}                  set variable    xpath=//div[text()='${UNIT_NAME}']
    Wait And Click Element                                      ${Unit_Option}

Click on Standard Comments Link
    click link                                      Standard Comments
    wait until page contains                        Rhythmic Delta

Add a New Standard Comment
    ${Add_Button}                   set variable    xpath=//mdl-button/mdl-icon[text()='add']
    click element                                                 ${Add_Button}
    ${Done_Button}                  set variable    xpath=//mdl-button[text()=' Done ']
    wait until page contains element                              ${Done_Button}
    ${Comment_Text_Input}           set variable    xpath=//mdl-textfield[@label="Comment Text"]/div/input
    input text                      ${Comment_Text_Input}         New Moji Comment
    click element                   ${Done_Button}

Click on Shared Comment Filters on Shared Settings
    click link                                      Shared Comment Filters
    wait until page contains                        Shared Comment Filters

Delete Created Standard Comment
    [Arguments]     ${COMMENT_NAME}
    ${Delete_Button}                set variable        xpath=//div[text()=' ${COMMENT_NAME} ']/../button
    Base.Delete Items Until None Exist                             ${Delete_Button}

Click on Trends Default Settings
    click link    Trends Settings
    wait until page contains    Default Trends Duration:


Click on EEG Default Settings
    click link                  EEG Settings
    wait until page contains    Off

Select a Panel From Trends Default Panel Dropdown
    [Arguments]    ${DEFAULT_PANEL}
    ${Panel_Dropdown}               set variable    xpath=//mdl-select[@id='Default Panel']/div
    Wait And Click Element                          ${Panel_Dropdown}
    ${Panel_Menu}                   set variable    xpath=//mdl-select[@id="Default Panel"]/div/mdl-popover
    wait until element is visible                   ${Panel_Menu}       40s
    ${Panel_Option}                 set variable    xpath=//div[text()='${DEFAULT_PANEL}']/..
    click element                                   ${Panel_Option}

Select a Duration From Trends Default Duration Dropdown
    [Arguments]    ${DEFAULT_DURATION}
    ${Duration_Dropdown}               set variable    id=Default Duration
    Wait And Click Element                          ${Duration_Dropdown}
    ${Duration_Option}                 set variable    xpath=//div[text()='${DEFAULT_DURATION}']/..
    Wait And Click Element                          ${Duration_Option}
