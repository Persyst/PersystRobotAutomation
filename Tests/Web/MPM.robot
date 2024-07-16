*** Settings ***
Documentation    This test is going to test Multi Patient Monitoring
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Resource         ../../Resources/PO/Web/Pages/TrendsPage.robot
Resource         ../../Resources/PO/Web/Pages/Base.robot
Suite Setup      Run Keywords       Begin Web Suit
Suite Teardown   Run Keywords       End Web Suit

*** Variables ***
${Patient_Name}                  LnP14D3Nw10ICU


*** Test Cases ***
Test Patient Record Info
    PatientView.Navigate to MPM tab