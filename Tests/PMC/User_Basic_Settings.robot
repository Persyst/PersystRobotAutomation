*** Settings ***
Documentation    This test is going to test Basic User Settings in PMC
Resource         ../../Resources/PO/PMC/Common.robot
Resource         ../../Resources/PO/PMC/PMCApp.robot
Suite Setup      Run Keywords       Begin Web Suit                         Reset the User Basic Settings
Suite Teardown   Run Keywords       Reset the User Basic Settings          End Web Suit

# Command line to run this test: robot -d results Tests/PMC/User_Basic_Settings.robot

*** Variables ***
${Patient_Name}     A2_24
&{fcolor}           yellow=#dfca74       white=#ffffff
${Trends_Patient_Name}      css=div.view-header-title > div > div > div:nth-child(2)

*** Test Cases ***
Check Spikes list of Comments based on Spike Inclusion Setting
    PMCApp.select comment sort order in user settings        ASC
    PMCApp.Navigate to EEG Page From Setting         ${Patient_Name}
    PMCApp.Open Comment List from EEG Page
    ${Comment_name}    EEGPage.Get First Row's Text in List Of Comments
    should contain    ${Comment_name}       Beginning of Record
    PMCApp.select comment sort order in user settings        DES
    PMCApp.Navigate to EEG Page From Setting         ${Patient_Name}
    PMCApp.Open Comment List from EEG Page
    ${Comment_name}    EEGPage.Get First Row's Text in List Of Comments
    should contain     ${Comment_name}       Current End of Record
    PMCApp.Close Comment List from EEG Page

Test Display Options-Quick Commands-Patient Name-Background and Grid Color
    PMCApp.Select Dispaly Options From User Settings                 EEG
    PMCApp.Change "Add Quick Comments" Setting From User Setting     Enable
    PMCApp.Change "Show Patient Name" setting                        Enable
    PMCApp.Set EEG Background Color From User Settings               ${fcolor}[yellow]
    PMCApp.Set Grid Background Color From User Settings              ${fcolor}[white]
    PMCApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${Patient_Name}
    PMCApp.Verify EEG Page Loaded Successfully
    Common.Compare the Images      user-setting-second-test.png
    ${Returned_Patient_Name}    PMCApp.Get Patient Name on EEG Page
    should contain    ${Returned_Patient_Name}     A2_24
    PMCApp.Open Quick Comment Modal on EEG
    PMCApp.Quit Quick Comment Modal

Test Display Options-Quick Commands-Patient Name-Background and Grid Color(other-settings)
    PMCApp.Select Dispaly Options From User Settings                 Trends
    PMCApp.Change "Add Quick Comments" Setting From User Setting     Disable
    PMCApp.Change "Show Patient Name" setting                        Disable
    PMCApp.Set EEG Background Color From User Settings               ${fcolor}[white]
    PMCApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${Patient_Name}
    PMCApp.Verify Trends Page Loaded Successfully
    Common.Compare the Images      user-setting-third-test.png
    page should not contain element       ${Trends_Patient_Name}
    run keyword and expect error    STARTS: Element 'css=div[mapname="QuickComment"]' did not appear       PMCApp.Open Quick Comment Modal on EEG

Test Date Format-Time Format
    PMCApp.Change 'Date Formats' for EEG and Trends                  YYYYMMDD
    PMCApp.Change 'Time Format' From User Setting                    Clock Time
    PMCApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${Patient_Name}
    Common.Compare the Images             user-setting-forth-test.png
    PMCApp.Change 'Date Formats' for EEG and Trends                  D1D2...
    PMCApp.Change 'Time Format' From User Setting                    Elapsed Time
    PMCApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${Patient_Name}
    Common.Compare the Images             user-setting-fifth-test.png

Test Inactivity Timeout
    [Tags]    testrun
     PMCApp.Change 'Inactivity Timeout' Status From User Setting      Disable
     sleep    2s
     PMCApp.Enter "Inactivity Timeout" Time in Minues                 1.5
     sleep    2s
     PMCApp.Navigate From Setting to Patient View
     sleep    92s
     page should contain    Session Timed Out.
     Common.Login With Credentials
     PMCApp.Change 'Inactivity Timeout' Status From User Setting      Enable
     PMCApp.Navigate From Setting to Patient View
