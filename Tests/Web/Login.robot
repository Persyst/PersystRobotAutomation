*** Settings ***
Documentation       This test is going to test persyst login
Resource            ../../Resources/PO/Web/Common.robot
Resource            ../../Resources/PO/Web/PersystWebApp.robot
Suite Setup         Begin Web Suit With No Login
Test Setup          Run Keyword            PersystWebApp.Go to "Login" page
Suite Teardown      End Web Suit

*** Variables ***
${CORRECT_USERNAME} =  mojgan
${CORRECT_PASSWORD} =  mojgan

*** Test Cases ***
User should be able to login with valid credentials
    [Documentation]         Login is happening in this test with incorrect credentials
    [Tags]                  Login
    PersystWebApp.Login Into Persyst Web With Valid Credentials    ${CORRECT_USERNAME}     ${CORRECT_PASSWORD}
    PersystWebApp.Logging Out From Persyst Web

Test About Persyst Mobile Contents
    LoginPage.Click on 'About' Button
    Common.Compare the Images       about_page.png

Test About Persyst Mobile User Guide Link
    LoginPage.Click on 'About' Button
    LoginPage.Click on 'User Guide' link
    LoginPage.Switch to User Guide Tab and Verify The URL

