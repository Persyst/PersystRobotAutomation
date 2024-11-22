*** Settings ***
Documentation    This test is going to test Multi Patient Monitoring
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Resource         ../../Resources/PO/Web/Pages/TrendsPage.robot
Resource         ../../Resources/PO/Web/Pages/Base.robot
Resource         ../../Resources/PO/Web/Pages/MPMPage.robot
Suite Setup      Run Keywords       Begin Web Suit      AND     Reset User Settings(Common)
Suite Teardown   Run Keywords       Reset User Settings(Common)    AND      End Web Suit

*** Variables ***
${Patient_Name}                  LnP14D3Nw10ICU
${MPM_Tab}                      xpath=//span[text()='MPM']


*** Test Cases ***
Test MPM not Avaialble When Toggled Off
    Navigate to Patient View By URL
    page should not contain element    ${MPM_Tab}

Test MPM Available When Toggled On
    PersystWebApp.Turn on MPM From User Settings
    Navigate to Patient View By URL
    Navigate to MPM tab

Test Manually Set Patient To First Cell
    Select a Manual Patient for MPM
    ${Status}=    Verify Cell's Canvas        1       1
    Should Be True    ${Status}    The element should exist but it does not.

Test Automatically Set Patient To Second Cell
    Select a Automatic Patient for MPM
    ${Status}=    Verify Cell's Canvas        1       2
    Should Be True    ${Status}    The element should exist but it does not.

Test Closing the Station
    Close One Of MPM Stations
    ${Status}=    Verify Cell's Canvas        1       2
    should not be true      ${Status}    The element should not exist but exist.

Test Selecting Station For Second Station
    Select Station For MPM Station
    ${Status}=    Verify Cell's Canvas        1       2
    Should Be True    ${Status}    The element should exist but it does not.

Test Navigating to Trends From MPM
    MPMPage.Click On Canvas To Navigate To Trends    1      1
    ${Current_URL}=     get location
    should contain    ${Current_URL}            trends