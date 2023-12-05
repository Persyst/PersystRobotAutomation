*** Settings ***
Library          SeleniumLibrary    timeout=0:00:20

*** Variables ***
${Circle_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__left > div
${Second_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.scroll-view > div > div:nth-child(1) > div.unselectable > div > div > app-trends-page:nth-child(1) > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__right > div
${EEG_Image}                id=image
${Comment_List_box}         css=body > app-root app-patient-views > app-eeg-view  div:nth-child(2) > app-comment-list > div
${Comment_List_Button}      css=body > app-root button[title="Comment List"]
${Comment_Name_Textfield}   css=#comment-filter-input:nth-child(1)
${First_Comment_Row}        css=body  app-eeg-view app-comment-list div:nth-child(4) > mdl-list > mdl-list-item:nth-child(2) > div
${First_Row_In_Comments}    css=body  app-eeg-view app-comment-list div:nth-child(4) > mdl-list > mdl-list-item:nth-child(1) > div
${Trends_Link}              css=body > app-root app-eeg-view div.view-header > div:nth-child(1) > div > span
${EEG_PAGE_URL}             http://192.168.156.119/PersystMobile/record-views/eeg/325/0?readOnly=false
${Play_Button}              css=body button[title='Start Playing']
${Pause_Button}             css=body button[title='Pause Playing']
${Quick_Comment_modal}      css=div[mapname="QuickComment"]
${Patient_Name_Header}      css=div.view-header-title > div > div > div:nth-child(2)
#==================================================EEG Setting===============================================================
${EEG_Setting_Button}       id=eeg-settings-button
${Back_Arrow}               css=body div.back-arrow-item.back-arrow mdl-icon
${EEG_Setting_Box}          css=body app-patient-views app-eeg-settings
${EEG_Font_Size_Setting}    body app-eeg-settings div.settingsText > input
${EEG_Channel_Per_Page_Select}      css=body app-eeg-view > div > div > div:nth-child(1) > div:nth-child(2) > div > div:nth-child(2) > div.eegSettings > app-eeg-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(3) > div:nth-child(2) > select
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
${EEG_Montage_Setting}      css=body div.eegSettings > app-eeg-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div.settingsText
&{EEG_Montage_Options}      ACNSNeoBP2=div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(3)   ReferencialTransverse=body div:nth-child(2) > div > div:nth-child(2) > div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(21)  Bipolar-longA=body div:nth-child(2) > div > div:nth-child(2) > div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(7)
&{EEG_Montage_Options}      NeonatalBipolar=body div:nth-child(2) > div > div:nth-child(2) > div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(12)
${EEG_Duration_Setting}     css=div.eegSettings > app-eeg-settings div [title="Select Duration"]
${EEG_Duration_Menu}        css= div.eegSettings > app-eeg-settings > div > div:nth-child(2)
&{EEG_Duration_Options}     10Seconds=div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(8)    20Seconds=div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(8)
${EEG_Sensitivity_Setting}  css=div.eegSettings > app-eeg-settings div [title="Select Sensitivity"]
${EEG_Sensitivity_Menu}     css= div.eegSettings > app-eeg-settings > div > div:nth-child(2)
&{EEG_Sensitivity_Options}  7=app-eeg-settings > div > div:nth-child(2) > div:nth-child(5)  30=app-eeg-settings > div > div:nth-child(2) > div:nth-child(9)
${Artifacts_Reduction_On}   name=AR On
${Artifacts_Reduction_Off}  name=AR Off
${LFF_Setting}              css=div.eegSettings > app-eeg-settings div [title="Select LFF"]
&{LFF_Options}              0.16=div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(4)     0.533=div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(2)
${HFF_Setting}              css=div.eegSettings > app-eeg-settings div [title="Select HFF"]
&{HFF_Options}              70Hz=div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(5)     1Hz=div.eegSettings > app-eeg-settings > div > div:nth-child(2) > div:nth-child(15)
&{Notch_Filter_Options}     60Hz=60       50Hz=50       OFF=Off
*** Keywords ***
Verify EEG Page Loaded Successfully
    wait until page does not contain element    ${Circle_Spinner}
    wait until page does not contain element    ${second_spinner}
    wait until page contains element    ${EEG_Image}

Launch Comment List If Not Launched Already
    ${comment_list_visibility}  get element count    ${Comment_List_box}
    IF    ${comment_list_visibility} == 0
        click element    ${Comment_List_Button}
    END

Close Comment List If Launched Already
    ${comment_list_visibility}  get element count    ${Comment_List_box}
    IF    ${comment_list_visibility} != 0
        click element    ${Comment_List_Button}
    END

Click on Comment List Button
    click element    ${Comment_List_Button}

Fill in the "Comment/Spike/Seizure Name" in Comment Box Filter
    [Arguments]   ${NAME}
    input text    ${Comment_Name_Textfield}     ${NAME}

Get First Row's Text When Searched For Comment
    wait until page contains element    ${First_Comment_Row}
    sleep    2s
    ${Comment_name}     get text    ${First_Comment_Row}
    [Return]    ${Comment_name}

Get First Row's Text in List Of Comments
    [Documentation]    This is getting the first row text without searching
    wait until page contains element    ${First_Comment_Row}
    ${Comment_name}     get text    ${First_Row_In_Comments}
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
    [Return]        ${Patient_Name}

#=================================================EEG Setting===============================================================
                     #===========================Display Setting=============================
Click the EEG Page Setting Button
    Navigate Back to Main Setting Menu
    ${eeg_setting_button_visibility}    get element count       ${EEG_Setting_Box}
    IF      ${eeg_setting_button_visibility} == 0
            click element                       ${EEG_Setting_Button}
            wait until page contains element    ${EEG_Setting_Box}
    END
Navigate Back to Main Setting Menu
    ${Back_Arrow_visibility}   get element count    ${Back_Arrow}
    IF  ${Back_Arrow_visibility} != 0
        click element        ${Back_Arrow}
    END

Click on Display Setting Link
    click link    Display

Change the EEG Page Font Size
    [Arguments]           ${FONT_SIZE}
    Execute JavaScript    document.querySelector('${EEG_Font_Size_Setting}').value = ${FONT_SIZE}

Change Channel Per Page Setting
    [Arguments]    ${NUMBER_OF_CHANNELS}
    SELECT FROM LIST BY VALUE    ${EEG_Channel_Per_Page_Select}     ${NUMBER_OF_CHANNELS}

Change Calibrartion Status
    [Arguments]    ${ON/OFF}
    wait until page contains element    ${EEG_Calibration_Off}
    IF      '${ON/OFF}' == 'ON'
            click element    ${EEG_Calibration_On}
    ELSE
            click element    ${EEG_Calibration_Off}
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
    click link    Waveforms

Click on Montage Setting
    click element    ${EEG_Montage_Setting}

Select Montage Option
    [Arguments]         ${MONTAGE_NAME}
    click element       css=${EEG_Montage_Options}[${MONTAGE_NAME}]

Click on EEG Page Duration Setting
    Navigate back to main setting menu
    click element  ${EEG_Duration_Setting}
    wait until page contains element    ${EEG_Duration_Menu}

Select EEG Page Duration
    [Arguments]    ${DURATION}
    click element    css=${EEG_Duration_Options}[${DURATION}]

Click on EEG Sensitivity Menu
    Navigate Back to Main Setting Menu
    click element    ${EEG_Sensitivity_Setting}
    wait until page contains element    ${EEG_Sensitivity_Menu}

Select EEG Page Sensitivity
    [Arguments]    ${SENSITIVITY_OPTION}
    click element    css=${EEG_Sensitivity_Options}[${SENSITIVITY_OPTION}]

Change Artifact Reduction Status
    [Arguments]    ${ON/OFF}
    Navigate Back to Main Setting Menu
    IF    '${ON/OFF}' == 'ON'
        click element       ${Artifacts_Reduction_On}
        verify eeg page loaded successfully
    ELSE
        click element       ${Artifacts_Reduction_Off}
        verify eeg page loaded successfully
    END

Click on LFF Setting Menu
    navigate back to main setting menu
    click element    ${LFF_Setting}

Select LFF Setting
    [Arguments]    ${LFF}
    click element    css=${LFF_Options}[${LFF}]

Click on HFF Setting Menu
    navigate back to main setting menu
    click element    ${HFF_Setting}

Select HFF Setting
    [Arguments]    ${HFF}
    click element    css=${HFF_Options}[${HFF}]

Select Notch Filter Option
    [Arguments]    ${NOTCH_OPTION}
    click element    name=${Notch_Filter_Options}[${NOTCH_OPTION}]

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









