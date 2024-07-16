*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30

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
<<<<<<< HEAD
${EEG_PAGE_URL}             http://192.168.156.119/PersystMobile/record-views/eeg/325/0?readOnly=false
=======
${EEG_PAGE_URL}             http://10.193.0.106/PersystMobile/record-views/eeg/325/0?readOnly=false
>>>>>>> parent of d558983 (all)
${PLAY_BUTTON}              css=body button[title='Start Playing']
${Next_Page_Button}         css=button[title="Page Right"]
*** Keywords ***
Verify EEG Page Is Loaded
    wait until page contains    EEG for LE_A01.lay

Click on Play EEG
    click element    ${PLAY_BUTTON}
    sleep    40s


Navigate Back to Trends
    click element       ${Trends_Link}

Click on Next Page Button
    ${Index}  set variable    1
    FOR     ${Index}    IN RANGE    5
        click element    ${Next_Page_Button}
        sleep    1s
    END
