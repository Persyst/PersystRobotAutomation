*** Settings ***
Resource         Pages/LoginPage.robot
Resource         Pages/PatientView.robot
Resource         Pages/TrendsPage.robot
Resource         Pages/EEGPage.robot
Resource         Pages/Settings.robot

*** Keywords ***
Go to "Login" page
    LoginPage.Navigate To Login Page
    LoginPage.Verify "Login" Page Loaded

Login Into Persyst Web With Valid Credentials
    [Arguments]        ${USERNAME}         ${PASSWORD}
    LoginPage.Login With Valid Credentials  ${USERNAME}         ${PASSWORD}
    PatientView.Verify Patient View Page Loaded

Select the first record and click beginning of the record
    PatientView.Click on First Patient On The List
    PatientView.Click Beginning of The Record
    TrendsPage.Verify Trends Page Loads Successfully

Select the first record and click beginning of the record - Students
    PatientView.Click on First Patient On The List - Students
    PatientView.Click Beginning of The Record
    TrendsPage.Verify Trends Page Loads Successfully

Navigate to EEG Page
    TrendsPage.Click On EEG
    sleep    3s

Play EEG
    EEGPage.Click on Play EEG
    sleep    5s

Navigate to Trends From EEG
    EEGPage.Navigate Back to Trends
    sleep    3s

Navigate to Next Page on EEG
    EEGPage.Click on Next Page Button
    sleep    2s

Logging Out From Persyst Web
    Settings.Logging out

Navigate to Records List Page From Trends Page
    TrendsPage.Navigate to Record's Page
    sleep    2s