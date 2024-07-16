*** Settings ***
Documentation       This test is going to test persyst login
Resource            ../../Resources/PO/Web/Common.robot
Resource            ../../Resources/PO/Web/PersystWebApp.robot
<<<<<<< HEAD
Test Setup          Begin Web Test    ${BROWSER}
Test Teardown       End Web Test
=======
Suite Setup         Begin Web Suit With No Login
Test Setup          Run Keywords            PersystWebApp.Go to "Login" page
Suite Teardown      End Web Suit
>>>>>>> parent of d558983 (all)

*** Variables ***
${BROWSER} =    chrome
${CORRECT_USERNAME} =  mojgan
${CORRECT_PASSWORD} =  mojgan

*** Test Cases ***
User should be able to login with valid credentials
    [Documentation]         Login is happening in this test with incorrect credentials
    [Tags]                  Login
    PersystWebApp.Go to "Login" page
    PersystWebApp.Login Into Persyst Web With Valid Credentials    ${CORRECT_USERNAME}     ${CORRECT_PASSWORD}
    PersystWebApp.Logging Out From Persyst Web

*** Keywords ***
