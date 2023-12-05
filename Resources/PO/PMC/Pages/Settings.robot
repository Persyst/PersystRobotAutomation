*** Settings ***
Library    SeleniumLibrary  timeout=0:00:30

*** Variables ***
${Setting_Button_Locator}           css=button[title="Settings"]
${Logout_Button_Locator}            xpath=/html/body/app-root/div[1]/app-patient-views/app-user-settings/div/div[1]/div[3]
${Setting_Page_Last_Element}        css=body > app-root > div:nth-child(1) > app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(25) > mdl-switch
${Include_Spike_Checkbox}           id=include-spike-comments
${Setting_Page_URL}                 http://192.168.156.119/PersystMobile/record-views/user-settings
${Include_Spike_Checkbox_Bullet}    css=body app-patient-views > app-user-settings > div > mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > div > div:nth-child(1) > div:nth-child(8) > mdl-switch > div.mdl-switch__thumb
${Comment_Sort_Dropdown}            id=Comments Sort
&{Comment_Sort_Options}             ASC=div [id$='Sort'] mdl-option:nth-child(2)     DES=div [id$='Sort'] mdl-option:nth-child(1)


*** Keywords ***
Logging out
    Click On Settings Button
    sleep    2s
    Click On "Logout"
    sleep    2s

Click On Settings Button
    click element  ${Setting_Button_Locator}

Click On "Logout"
    click element  ${Logout_Button_Locator}
    sleep    3s

Verify "Setting" page loaded
    wait until page contains element    ${Setting_Page_Last_Element}

Verify User Successfully Logged Out
    wait until page contains     Welcome To Persyst Mobile

