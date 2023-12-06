*** Settings ***
Documentation    This test is going to test Basic User Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Suite Setup      Run Keywords       Begin Web Suit
Suite Teardown   Run Keywords       End Web Suit

*** Variables ***
${PATIENT_ID}       2980

*** Test Cases ***
Test 'Reset User Settings'
    PersystWebApp.Reset User Interface Settings From User Settings

Test Opening User Guide
    PersystWebApp.Open 'User Guid' PDF From User Settings

