*** Settings ***
Library          SeleniumLibrary    timeout=0:00:20
Resource         Base.robot

*** Variables ***

${Trends_View}              css=body > app-root div > div:nth-child(1) > div.unselectable app-trends-page:nth-child(1)
${Trends_Canvas}            css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.scroll-view > div > div:nth-child(1) > div.unselectable > div > div > app-trends-page:nth-child(1) > canvas
${Comment_Button}           css=button[title="Comment Editor"]
${Comment_editor}           id=comment-editor
${Comment_name_input}       id=comment-editor-input
${Comment_Add_Button}       xpath=//*[@id="comment-editor"]/div[2]/button[3]
${Trends_Image}             css=body > app-root app-patient-views div.scroll-view > div > div:nth-child(2) > img
${Circle_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__left > div
${Second_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.scroll-view > div > div:nth-child(1) > div.unselectable > div > div > app-trends-page:nth-child(1) > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__right > div
${Comment_Box_On_Trends}    css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(4) > div
${Single_Comment_Text}      id=Moji Comment@PersystTrends
${Comment_Delete_Button}    id=Moji Comment@PersystTrends-delete
${Comment_Edit_Button}      id=Moji Comment@PersystTrends-edit
${EEG_Link}                 id=EEG-link
################################################################################################################
##############################TRENDS SETTING############################TRENDS SETTING#########################

${Trends_Setting_button}    id=trends-settings-button
${Trends_Setting_Box}       id=trends-settings
${Page_Duration_Menu}       id=duration-settings
&{Page_Duration_Options}    4hours=duration-4 hours       5min=duration-5 minutes
${Artifacts_Reduction_On}   name=AR On
${Artifacts_Reduction_Off}  name=AR Off
${Back_Arrow}               css=body div.back-arrow-item.back-arrow mat-icon
${Panel_menu}               id=panel-settings

*** Keywords ***

Verify Trends Page Loads Successfully
    wait until page contains element            ${Trends_View}
    wait until page contains element            ${Trends_Image}         timeout=40s
    wait until page does not contain element    ${Circle_Spinner}
    wait until page does not contain element    ${second_spinner}
    wait until element is visible               ${Trends_Canvas}
    sleep    1s

Click On Comment Button
    click element at coordinates       ${Trends_Image}    xoffset=-165   yoffset=100
    click button    ${Comment_Button}
    wait until page contains element    ${Comment_editor}

Fill In "Comment Name" Input
    input text    ${Comment_name_input}     Moji Comment

Click on "+" button To Add The Comment
    click button    ${comment_add_button}
    sleep    1s
    click element at coordinates       ${Trends_Image}    xoffset=-50   yoffset=250

Click On Created Comment On Trends
     click element at coordinates       ${Trends_Image}    xoffset=-165     yoffset=281
     sleep    1s
     wait until page contains element   ${Comment_Box_On_Trends}


Get Created Comment Text
    ${Comment_name}     get text    ${Single_Comment_Text}
    [Return]    ${Comment_name}

Click On "Delete" Button
    click element    ${Comment_Delete_Button}

Click On Edit Button
    click element    ${Comment_Edit_Button}

Click On EEG
    click element  ${EEG_Link}

Navigate to Patient View Page from Trends
    click on record list on trends page
    wait until page contains    Record List       40s

#######################################################################################################
############### TRENDS SETTING ########################################################################

click on Setting Button
    Navigate Back to Main Setting Menu
    ${Trens_Setting_Box_Visibility}  get element count    ${Trends_Setting_Box}
    IF    ${Trens_Setting_Box_Visibility} == 0
        click element    ${Trends_Setting_button}
    END

Close Setting Menu
    Navigate Back to Main Setting Menu
    ${Trens_Setting_Box_Visibility}  get element count    ${Trends_Setting_Box}
    IF    ${Trens_Setting_Box_Visibility} != 0
        click element    ${Trends_Setting_button}
    END

click on Page Duration Setting
    ${Trens_Page_Duration_menu_Visibility}  get element count    id=${Page_Duration_Options}[5min]
    IF    ${Trens_Page_Duration_menu_Visibility} == 0
        click element    ${PAGE_DURATION_MENU}
        wait until page contains element    id=${Page_Duration_Options}[5min]
    END

Change Page Duration Value
    [Arguments]     ${DURATION}
    click element   id=${Page_Duration_Options}[${DURATION}]

Navigate Back to Main Setting Menu
    ${Back_Arrow_visibility}   get element count    ${Back_Arrow}
    IF  ${Back_Arrow_visibility} != 0
        click element        ${Back_Arrow}
    END

Change Artifact Reduction Status
    [Arguments]    ${ON/OFF}
    Navigate Back to Main Setting Menu
    IF    '${ON/OFF}' == 'ON'
        click element       ${Artifacts_Reduction_On}
        verify trends page loads successfully
    ELSE
        click element       ${Artifacts_Reduction_Off}
        verify trends page loads successfully
    END

Open Panel Menu From Trends Setting
    Navigate Back to Main Setting Menu
    click element    ${Panel_menu}

Select an Option From Trends Panel Setting
    [Arguments]    ${PANEL_OPTION}
    ${Panel_Options}     set variable    panel-${PANEL_OPTION}
    wait until page contains element    id=${Panel_Options}
    click element       id=${Panel_Options}

Navigate to Trends Page Using URL
    [Arguments]    ${URL}
    ${current_url}=    Get Location
    ${contains_trends}=    Run Keyword And Return Status    Should Contain    ${current_url}    trends
    IF    ${contains_trends}
        Log    Current URL already contains "trends". Doing nothing.
    ELSE
        Go To    ${URL}
        verify trends page loads successfully
        sleep    2s
        Log    Navigated to the specified URL.
    END

Click on Record List On Trends Page
    ${Record_List_Button}           set variable    xpath=//mat-icon[text()='arrow_back_ios']/following-sibling::div
    Wait And Click Element          ${Record_List_Button}

Get Patient Name
    ${Patient_Name_Locator}      set variable    //app-trends-view//div[@class="view-header-title"]/div/div/div
    ${Patient_Name}     get text    ${Patient_Name_Locator}
    [Return]            ${Patient_Name}
