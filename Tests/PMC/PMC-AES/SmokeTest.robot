*** Settings ***
Documentation       This test is going to test persyst login
Resource            ../../../Resources/PO/PMC/Common.robot
Resource            ../../../Resources/PO/PMC/PMCApp.robot
Test Setup          Begin Web Suit With No Login
Test Teardown       End Web Suit

*** Variables ***
&{Credentials}          Username=astonstudent1@persyst.com      Password=AstonUni2024!
${CORRECT_USERNAME} =  astonstudent1@persyst.com
${CORRECT_PASSWORD} =  AstonUni2024!
${index}                1
${Record_Name}          A2_24-clip-sz
*** Test Cases ***
User should be able to login with valid credentials

    [Documentation]         Login is happening in this test with incorrect credentials
    [Tags]                  Login
    LoginPage.Navigate To Login Page                ${PMC_Prod_URL}
    PMCApp.Login Into PMC With Valid Credentials    ${CORRECT_USERNAME}     ${CORRECT_PASSWORD}
    FOR  ${index}  IN RANGE  3
        Log  Iteration: ${index + 1}
        PatientView.Enter Patient Name In The Patient Name Textfield        ${Record_Name}
        PatientView.Click On Record By Name     ${Record_Name}
        PatientView.click on Patient Beginning of Record
        sleep    2s
        EEGPage.Click on Right Page Button
        EEGPage.Click on Right Page Button
        EEGPage.Click on Play EEG
        sleep  15s
        Navigate to Trends Page From EEG Page
        Navigate to Patient View From Trends
    END
    PMCApp.Logging Out From PMC

