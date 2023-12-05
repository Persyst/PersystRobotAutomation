*** Settings ***
Documentation       This test is going to test persyst login
Resource            ../../Resources/PO/PMC/Common.robot
Resource            ../../Resources/PO/PMC/PMCApp.robot
Test Setup          Begin Web Suit
Test Teardown       End Web Suit

*** Variables ***
${CORRECT_USERNAME} =  student1@persyst.com
${CORRECT_PASSWORD} =  AESRes2023!
${index}                1
*** Test Cases ***
User should be able to login with valid credentials
    [Documentation]         Login is happening in this test with incorrect credentials
    [Tags]                  Login
    FOR  ${index}  IN RANGE  100
        Log  Iteration: ${index + 1}
        PMCApp.Login Into Persyst Web With Valid Credentials    ${CORRECT_USERNAME}     ${CORRECT_PASSWORD}
        PMCApp.Select the first record and click beginning of the record - Students
        PMCApp.Navigate to EEG Page
        PMCApp.Navigate to Next Page on EEG
#        PMCApp.Play EEG
        PMCApp.Navigate to Trends From EEG
        PMCApp.Navigate to Records List Page From Trends Page
        PMCApp.Logging Out From Persyst Web
    END

