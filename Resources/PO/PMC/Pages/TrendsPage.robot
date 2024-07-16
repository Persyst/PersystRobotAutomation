*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30

*** Variables ***

${Trends_View}              body > app-root div > div:nth-child(1) > div.unselectable app-trends-page:nth-child(1)
${Trends_Canvas}            css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.scroll-view > div > div:nth-child(1) > div.unselectable > div > div > app-trends-page:nth-child(1) > canvas
${Comment_Button}           css=button[title="Comment Editor"]
${Comment_editor}           id=comment-editor
${Comment_name_input}       css=#comment-editor > input
${Comment_Add_Button}       css=app-comment-editor button:nth-child(3)
${Trends_Image}             css=body > app-root app-patient-views div.scroll-view > div > div:nth-child(2) > img
${Circle_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__left > div
${Second_Spinner}           css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.scroll-view > div > div:nth-child(1) > div.unselectable > div > div > app-trends-page:nth-child(1) > mdl-spinner > div.mdl-spinner__layer.mdl-spinner__layer-4 > div.mdl-spinner__circle-clipper.mdl-spinner__right > div
${Comment_Box_On_Trends}    css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(4) > div
${Single_Comment_Text}      id=Moji Comment@PersystTrends
${Comment_Delete_Button}    id=Moji Comment@PersystTrends-delete
${Comment_Edit_Button}      id=Moji Comment@PersystTrends-edit
${EEG_Link}                 id=EEG-link
${PROD_EEG_LINK}            css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.view-header > div:nth-child(3) > div.view-header-item
${Record_List}              css=body > app-root > div:nth-child(1) > app-patient-views > app-trends-view > div > div > div:nth-child(1) > div.view-header > div:nth-child(1) > div

*** Keywords ***
Verify Trends Page Loads Successfully
    wait until page contains element            css=${Trends_View}
    wait until page contains element            ${Trends_Image}
    wait until element is visible               ${Trends_Canvas}
    sleep    3s

Click On EEG
    click element  ${PROD_EEG_LINK}

Navigate to Record's Page
    click element    ${Record_List}
    sleep    2s


