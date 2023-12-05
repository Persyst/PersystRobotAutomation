*** Settings ***
Library    SikuliLibrary    mode=NEW
Resource    ../../Resources/PO/Desktop/Common.robot
Suite Setup     Run Keywords    Start Sikuli Process    AND  Read All Images
Suite Teardown  Run Keywords    Close Application  ${OPEN_APP}  AND    Stop Remote Server

*** Variables ***
${ADD_IMAGE_PATH}       Persyst-Desktop.sikuli
${OPEN_APP}             "C:\Program Files (x86)\Persyst\Insight\Persyst.exe"
${OPEN_BTN}             open_file.png

*** Test Cases ***
Open the app and verify it opened
    Open Persyst App
    Wait Until Open File Shows

*** Keywords ***
Read All Images
    Add Image Path     ${ADD_IMAGE_PATH}

Open Persyst App
    Open Application    ${OPEN_APP}
    sleep               10s

Wait Until Open File Shows
   Wait until screen contains   ${OPEN_BTN}