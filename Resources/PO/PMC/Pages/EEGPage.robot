*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30
Library          Collections
Resource         Base.robot

*** Variables ***
${Circle_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__left > div
${Second_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.scroll-view > div > div:nth-child(1) > div.unselectable > div > div > app-trends-page:nth-child(1) > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__right > div
${EEG_Image}                id=image
${Comment_List_box}         css=app-patient-views app-eeg-view app-comment-list
${Comment_List_Button}      css=body > app-root button[title="Comment List"]
${Comment_Name_Textfield}   id=comment-filter-input
${First_Comment_Row}        css=body > app-root > div > app-patient-views > app-eeg-view > div > div > div:nth-child(2) > app-comment-list > div > mat-list > mat-list-item:nth-child(2) > span > span > div
${First_Row_In_Comments}    css=body > app-root > div > app-patient-views > app-eeg-view > div > div > div:nth-child(2) > app-comment-list > div > mat-list > mat-list-item:nth-child(2) > span > span > div
${Trends_Link}              xpath=//span[text()='Trends']
${Play_Button}              css=body button[title='Start Playing']
${Pause_Button}             css=body button[title='Pause Playing']
${Quick_Comment_modal}      css=div[mapname="QuickComment"]
${Patient_Name_Header}      css=body > app-root > div > app-patient-views > app-eeg-view div.view-header-title > div > div > div
${Comment_Filter_Button}    id=comment-filter-button
${Video_Modal}              xpath=//app-video
#==================================================EEG Setting===============================================================
${EEG_Setting_Button}       id=eeg-settings-button
${Back_Arrow}               css=body div.back-arrow-item.back-arrow mdl-icon
${EEG_Setting_Box}          css=body app-patient-views app-eeg-settings
${EEG_Font_Size_Setting}    body app-eeg-settings div.settingsText > input
${EEG_Channel_Per_Page_Select}      id=eeg-channel-per-page
${EEG_Calibration_On}       name=Calibration On
${EEG_Calibration_Off}      name=Calibration Off
${EEG_Major_Grid_On}        name=MajorGrid On
${EEG_Major_Grid_Off}       name=MajorGrid Off
${EEG_Minor_Grid_On}        name=MinorGrid On
${EEG_Minor_Grid_Off}       name=MinorGrid Off
${EEG_Comment_On}           name=CommentLines On
${EEG_Comment_Off}          name=CommentLines Off
${EEG_Show_Comment_On}      name=ShowComments On
${EEG_Show_Comment_Off}     name=ShowComments Off
${EEG_Restrict_Pen_On}      name=RestrictPenDeflection On
${EEG_Restrict_Pen_Off}     name=RestrictPenDeflection Off
${EEG_Montage_Setting}      css=div[title='Select Montage']
${EEG_Duration_Setting}     css=div [title="Select Duration"]
${EEG_Duration_Menu}        id=eeg-duration-setting
${EEG_Sensitivity_Setting}  css=div [title="Select Sensitivity"]
${EEG_Sensitivity_Menu}     xpath=//div[@id="eeg-sensitivity-menu"]/div[2]
${Artifacts_Reduction_On}   name=AR On
${Artifacts_Reduction_Off}  name=AR Off
${LFF_Setting}              css=div [title="Select LFF"]
${HFF_Setting}              css=div [title="Select HFF"]
&{Notch_Filter_Options}     60Hz=60       50Hz=50       OFF=Off
*** Keywords ***
Verify EEG Page Loaded Successfully
    wait until page does not contain element    ${Circle_Spinner}
    wait until page does not contain element    ${second_spinner}
    wait until page contains element            ${EEG_Image}                    1m

Launch Comment List If Not Launched Already
    ${comment_list_visibility}  get element count    ${Comment_List_box}
    IF    ${comment_list_visibility} == 0
        wait until page contains element             ${Comment_List_Button}
        click element                                ${Comment_List_Button}
        wait until page contains element             ${Comment_List_box}         40s
    END

Close Comment List If Launched Already
    ${comment_list_visibility}  get element count    ${Comment_List_box}
    IF    ${comment_list_visibility} != 0
        click element                                ${Comment_List_Button}
    END

Click on Comment List Button
    click element                                    ${Comment_List_Button}

Fill in the "Comment/Spike/Seizure Name" in Comment Box Filter
    [Arguments]   ${NAME}
    input text    ${Comment_Name_Textfield}     ${NAME}

Get First Row's Text When Searched For Comment
    wait until page contains element            ${First_Comment_Row}
    sleep    2s
    ${Comment_name}     get text                ${First_Comment_Row}
    [Return]    ${Comment_name}

Get First Row's Text in List Of Comments
    [Documentation]    This is getting the first row text without searching
    wait until page contains element            ${First_Comment_Row}
    ${Comment_name}     get text                ${First_Row_In_Comments}
    [Return]    ${Comment_name}


Click on "Trends" link
    click element    ${Trends_Link}

Go To EEG Page Through URL
    [Arguments]    ${URL}
    go to          ${URL}

Click on Play EEG
    click element    ${Play_Button}
    sleep    3s

Click on Pause Button
    click element    ${Pause_Button}
    sleep    3s

Get Patient Name From EEG Header
    ${Patient_Name}     get text    ${Patient_Name_Header}
    [Return]                        ${Patient_Name}

Click on Right Page Button
    Wait And Click Element          //button[@title="Page Right"]
    sleep    1s

Click on Left Page Button
    Wait And Click Element          //button[@title="Page Left"]
    sleep    1s

Click on Split Screen Button
    Wait And Click Element          //button[@title="Split Screen"]
    Verify EEG Page Loaded Successfully
    sleep    1s

Verify Trends Subview Displays
    wait until page contains element    //app-trends-subview        50s
    page should contain element         //app-trends-subview
#=================================================EEG Setting===============================================================
                     #===========================Display Setting=============================
Click the EEG Page Setting Button
    Navigate Back to Main Setting Menu
    ${eeg_setting_box_visibility}    get element count     ${EEG_Setting_Box}
    IF      ${eeg_setting_box_visibility} == 0
            Click Element Until Visible         ${EEG_Setting_Button}            ${EEG_Setting_Box}
#            Wait And Click Element                              ${EEG_Setting_Button}
#            wait until page contains element                    ${EEG_Setting_Box}          40s
    END
Navigate Back to Main Setting Menu
    ${Back_Arrow_visibility}   get element count                ${Back_Arrow}
    IF  ${Back_Arrow_visibility} != 0
        click element                                           ${Back_Arrow}
    END

Click on Display Setting Link
    ${Display_Settings_Tab}     set variable    xpath=//span[text()="Display"]
    Wait And Click Element      ${Display_Settings_Tab}

Change the EEG Page Font Size
    [Arguments]           ${FONT_SIZE}
    Execute JavaScript    document.querySelector('#eeg-font-setting').value = ${FONT_SIZE}

Change Channel Per Page Setting
    [Arguments]    ${NUMBER_OF_CHANNELS}
    SELECT FROM LIST BY VALUE    ${EEG_Channel_Per_Page_Select}     ${NUMBER_OF_CHANNELS}
    wait until page contains element    ${EEG_Setting_Box}

Change Calibrartion Status
    [Arguments]    ${ON/OFF}
    wait until page contains element    ${EEG_Calibration_Off}
    IF      '${ON/OFF}' == 'ON'
            Wait And Click Element    ${EEG_Calibration_On}
    ELSE
            Wait And Click Element    ${EEG_Calibration_Off}
    END

Change Major Grid Status
    [Arguments]    ${ON/OFF}
    wait until page contains element    ${EEG_Major_Grid_Off}
    IF      '${ON/OFF}' == 'ON'
            click element    ${EEG_Major_Grid_On}
    ELSE
            click element    ${EEG_Major_Grid_Off}
    END

Change Minor Grid Status
    [Arguments]    ${ON/OFF}
    wait until page contains element    ${EEG_Minor_Grid_On}
    IF      '${ON/OFF}' == 'ON'
            click element    ${EEG_Minor_Grid_On}
    ELSE
            click element    ${EEG_Minor_Grid_Off}
    END

Change Comment Line Status
    [Arguments]    ${ON/OFF}
    wait until page contains element    ${EEG_Comment_Off}
    IF      '${ON/OFF}' == 'ON'
            click element    ${EEG_Comment_On}
    ELSE
            click element    ${EEG_Comment_Off}
    END

Change Show Comment Status
    [Arguments]    ${ON/OFF}
    wait until page contains element    ${EEG_Show_Comment_Off}
    IF      '${ON/OFF}' == 'ON'
            click element    ${EEG_Show_Comment_On}
    ELSE
            click element    ${EEG_Show_Comment_Off}
    END

Change Restricted Pen Status
        [Arguments]    ${ON/OFF}
    wait until page contains element      ${EEG_Restrict_Pen_On}
    IF      '${ON/OFF}' == 'ON'
            click element     ${EEG_Restrict_Pen_On}
    ELSE
            click element     ${EEG_Restrict_Pen_Off}
    END

Click on Waveforms Setting Link
    wait until page contains element    ${EEG_Setting_Box}      50s
    ${Waveforms_Settings_Tab}   set variable    xpath=//span[text()="Waveforms"]
    Wait And Click Element    ${Waveforms_Settings_Tab}

Click on Montage Setting
    click element    ${EEG_Montage_Setting}

Select Montage Option
    [Arguments]         ${MONTAGE_NAME}
    click element       id=${MONTAGE_NAME}

Click on EEG Page Duration Setting
    Navigate back to main setting menu
    click element  ${EEG_Duration_Setting}
    wait until page contains element    ${EEG_Duration_Menu}

Select EEG Page Duration
    [Documentation]    The options are just numbers which are all in seconds like 10 or 20
    [Arguments]    ${DURATION}
    ${EEG_Duration_Options}     set variable    eeg-duration-${DURATION}
    click element       id=${EEG_Duration_Options}

Click on EEG Sensitivity Menu
    Navigate Back to Main Setting Menu
    click element    ${EEG_Sensitivity_Setting}
    wait until page contains element    ${EEG_Sensitivity_Menu}

Select EEG Page Sensitivity
    [Arguments]    ${SENSITIVITY_OPTION}
    ${EEG_Sensitivity_Options}      set variable    sensitivity${SENSITIVITY_OPTION}
    click element    id=${EEG_Sensitivity_Options}
    wait until page contains element                    ${EEG_Setting_Box}


Change Artifact Reduction Status
    [Arguments]    ${ON/OFF}
    Navigate Back to Main Setting Menu
    IF    '${ON/OFF}' == 'ON'
        click element       ${Artifacts_Reduction_On}
    ELSE
        click element       ${Artifacts_Reduction_Off}
    END

Click on LFF Setting Menu
    navigate back to main setting menu
    click element    ${LFF_Setting}

Select LFF Setting
    [Documentation]    The LFF options arguments sent should be only the numbers like 0.16
    [Arguments]    ${LFF}
    ${LFF_Options}    set variable      lff-${LFF}
    Wait And Click Element    id=${LFF_Options}

Click on HFF Setting Menu
    navigate back to main setting menu
    Wait And Click Element    ${HFF_Setting}

Select HFF Setting
    [Documentation]    The HFF options arguments sent should be only the numbers like 0.16
    [Arguments]    ${HFF}
    ${HFF_Options}    set variable      lff-${HFF}
    Wait And Click Element    id=${HFF_Options}

Select Notch Filter Option
    [Arguments]    ${NOTCH_OPTION}
    Wait And Click Element    name=${Notch_Filter_Options}[${NOTCH_OPTION}]

Open Quick Comment Modal on EEG
    ${modal_exist}    get element count    ${Quick_Comment_modal}
    IF   ${modal_exist} ==0
        press keys    None      q
        wait until page contains element    ${Quick_Comment_modal}
    END
    page should contain element    ${Quick_Comment_modal}

Close Quick Comment Modal On EEG
    ${modal_exist}    get element count    ${Quick_Comment_modal}
    IF   ${modal_exist} !=0
        press keys    None      q
        wait until page does not contain element    ${Quick_Comment_modal}
    END
    page should not contain element    ${Quick_Comment_modal}

Click On Comment Filter Button
    wait until page contains element    ${comment_list_box}
    wait until page contains element    ${Comment_Filter_Button}
    click element    ${Comment_Filter_Button}
    wait until page contains    Comment Filters

Select a Comment Filter
    [Arguments]    ${FILTER_NAME}
    click element    xpath=//div[text()=" ${FILTER_NAME} "]

Get EEG Waveforms Settings
    @{List_of_Waveform_Settings}    create list    ${EEG_Montage_Setting}    ${EEG_Duration_Setting}      ${EEG_Sensitivity_Setting}   ${Artifacts_Reduction_On}     ${Artifacts_Reduction_Off}     ${LFF_Setting}   ${HFF_Setting}
    @{Setting_Values}       create list
    @{Setting_Values}       Extract Text And Append     @{List_of_Waveform_Settings}        text_list=${Setting_Values}
    [Return]        @{Setting_Values}

Click on Video Button
    ${Video_Button}     set variable    xpath=//button[@title="Video"]
    Wait And Click Element    ${Video_Button}

Open Video Modal
    ${Is_Video_Modal_Present}    Wait and Get Element Presence    ${Video_Modal}
    Run Keyword If  not ${Is_Video_Modal_Present}  Click on Video Button
    wait until page contains element      ${Video_Modal}

Close Video Modal
    ${Is_Video_Modal_Present}    Wait and Get Element Presence    ${Video_Modal}
    Run Keyword If  ${Is_Video_Modal_Present}  Click on Video Button
    Wait Until Page Does Not Contain Element  ${Video_Modal}

