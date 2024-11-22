*** Settings ***
Documentation    This test is going to test EEG Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Resource         ../../Resources/PO/Web/Pages/EEGPage.robot
Suite Setup      Run Keywords   Begin Web Suit  AND    Reset EEG Setting
Suite Teardown   Run Keywords   End Web Suit

# Command line to run this test: robot -d results Tests/Web/EEG_Montage_Edit.robot
*** Variables ***
${COMMENT_NAME}            Moji Comment

*** Test Cases ***
Test Create Patient Montage
    PersystWebApp.Create Patient Montage in EEG Page
    sleep    3s
    ${EEG_Montage_Name}      EEGPage.Get EEG Selected Montage
    wait until page contains element     xpath=//button/span[text()=' F3-C3 ']          30s
    page should not contain element      xpath=//button/span[text()=' Fp1-F3 ']
    page should contain element          xpath=//button/span[text()=' Fp1-F7 ']
    should be equal     ${EEG_Montage_Name}          Bipolar longitudinal A (Patient)\n>

Test Delete Created Patient Montage
    PersystWebApp.Delete Created Montage From EEG Page
    sleep    3s
    ${EEG_Montage_Name}      EEGPage.Get EEG Selected Montage
    wait until page contains element     xpath=//button//span[text()=' F3-C3 ']          30s
    page should contain element          xpath=//button//span[text()=' Fp1-F3 ']
    page should contain element          xpath=//button//span[text()=' Fp1-F7 ']
    should be equal     ${EEG_Montage_Name}          Bipolar longitudinal A\n>

Add Comment On EGG Page Verify On Patient
    [Tags]      testrun
    PersystWebApp.Create A Comment On EEG
    ${Comment_text}    PersystWebApp.Click on Created Comment On EEG and Get Comment Name
    should contain     ${Comment_text}      ${COMMENT_NAME}
    ${List_Comment_name}     PersystWebApp.Search For The Comment/Spike/Seizure In The EEG Comment Box   ${COMMENT_NAME}
    should contain     ${List_Comment_name}      ${COMMENT_NAME}
    click element at coordinates      ${EEG_Image}    xoffset=-100     yoffset=250
    PersystWebApp.Navigate to Patient View Using Keyboard Shortcut
    PatientView.Click on Patient Record By ID    ${PATIENT_ID}
    wait until page contains element    id=${COMMENT_NAME}
    PersystWebApp.Go To EEG Page By URL    ${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_EEG_URL}
    PersystWebApp.Delete a Comment from EEG Page


