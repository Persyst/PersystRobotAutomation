*** Settings ***
Documentation       This test is going to test persyst login
Resource            ../../Resources/PO/PMC/Common.robot
Resource            ../../Resources/PO/PMC/PMCApp.robot
Suite Setup         Begin Web Suit With No Login
Test Setup          Run Keyword       PMCApp.Go to "Login" page    ${PMC_LOGIN_PAGE_URL}[Test]
Suite Teardown      End Web Suit

*** Variables ***
${CORRECT_USERNAME} =    mojgan.dadashi@persyst.com
${CORRECT_PASSWORD} =    NpNl582.

*** Test Cases ***
User should be able to login with valid credentials
    [Documentation]         Login is happening in this test with incorrect credentials
    [Tags]                  Login
    PMCApp.Login Into PMC With Valid Credentials    ${CORRECT_USERNAME}     ${CORRECT_PASSWORD}
#    ${token}=    Execute Javascript    return window.memory.getItem('token');
#    log    ${token}
#    ${token} =    Get Element Attribute    access_token_element    value
#    log    ${token}
    sleep    3s
    PMCApp.Logging Out From PMC

Test About Persyst Mobile Contents
    LoginPage.Click on 'About' Button
    Common.Compare the Images       about_page.png

