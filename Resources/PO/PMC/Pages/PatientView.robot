*** Settings ***
Library          SeleniumLibrary    timeout=0:00:30

*** Variables ***
${Patient_Filter_Textfield}     body  mdl-tabs > mdl-tab-panel.mdl-tabs__panel.is-active > app-patient-list > div > div:nth-child(1) > mdl-textfield > div > input
${First_Row_Patient}            body app-patient-list > div > div:nth-child(1) mdl-list > mdl-list-item > div:nth-child(1) > div
${Comment_List}                 css=body > app-root > div:nth-child(1) > app-patient-views div > app-record-comments > div > mdl-list > mdl-list-item:nth-child(1)
${Beginning_Of_Recording}       id=Beginning\ of\ Record
${Setting_Button}               css=body  app-patient-views  div.view-header button[title="Settings"]
${Patient_Link}                 css=body  app-patient-views > app-user-settings > div > div.unselectable.view-header > div:nth-child(1) > div > div
*** Keywords ***
Verify Patient View Page Loaded
    wait until page contains    Record List

Click on First Patient On The List
#    click element    xpath=/html/body/app-root/div[1]/app-patient-views/div[1]/div[2]/div/app-cloud-record/div/div[1]/div[2]/tree-root/tree-viewport/div/div/tree-node-collection/div/tree-node/div/tree-node-wrapper/div/tree-node-expander/span/span
#    sleep    3s
    click element    css=body > app-root > div:nth-child(1) > app-patient-views > div.page-container > div.noprint.safe-area > div > app-cloud-record > div > div:nth-child(2) > div:nth-child(2) > tree-root > tree-viewport > div > div > tree-node-collection > div > tree-node > div > tree-node-children > div > tree-node-collection > div > tree-node:nth-child(1)
    sleep    3s

Click on First Patient On The List - Students
#    click element    xpath=/html/body/app-root/div[1]/app-patient-views/div[1]/div[2]/div/app-cloud-record/div/div[1]/div[2]/tree-root/tree-viewport/div/div/tree-node-collection/div/tree-node/div/tree-node-wrapper/div/tree-node-expander/span/span
#    sleep    3s
    sleep    1s
    click element    css=body > app-root > div:nth-child(1) > app-patient-views > div.page-container > div.noprint.safe-area > div > app-cloud-record > div > div:nth-child(2) > div:nth-child(2) > tree-root > tree-viewport > div > div > tree-node-collection > div > tree-node > div > tree-node-children > div > tree-node-collection > div > tree-node:nth-child(2) > div > tree-node-wrapper > div > tree-node-expander > span > span
    sleep    1s
    click element    css=body > app-root > div:nth-child(1) > app-patient-views > div.page-container > div.noprint.safe-area > div > app-cloud-record > div > div:nth-child(2) > div:nth-child(2) > tree-root > tree-viewport > div > div > tree-node-collection > div > tree-node > div > tree-node-children > div > tree-node-collection > div > tree-node:nth-child(2) > div > tree-node-children > div > tree-node-collection > div > tree-node:nth-child(1) > div > tree-node-wrapper > div > tree-node-expander > span > span
    sleep    1s
    click element    css=body > app-root > div:nth-child(1) > app-patient-views > div.page-container > div.noprint.safe-area > div > app-cloud-record > div > div:nth-child(2) > div:nth-child(2) > tree-root > tree-viewport > div > div > tree-node-collection > div > tree-node > div > tree-node-children > div > tree-node-collection > div > tree-node:nth-child(2) > div > tree-node-children > div > tree-node-collection > div > tree-node:nth-child(1) > div > tree-node-children > div > tree-node-collection > div > tree-node > div > tree-node-wrapper > div > div > tree-node-content
    sleep    3s

Click Beginning of The Record
    click element    ${Beginning_Of_Recording}