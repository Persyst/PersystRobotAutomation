*** Settings ***
Documentation    This test is going to test Basic User Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Suite Setup      Run Keywords       Begin Web Suit                         Reset the User Basic Settings
Suite Teardown   Run Keywords       Reset the User Basic Settings          End Web Suit

# Command line to run this test: robot -d results Tests/Web/User_Basic_Settings.robot

*** Variables ***
${PATIENT_ID}       225
${Patient_Name}
&{fcolor}       yellow=#dfca74       white=#ffffff
${Trends_Patient_Name}              xpath=//app-trends-view/div/div/div/div/div[@class="view-header-title"]
${Patient_Record_With_Segments}     xpath=//*[@id="${PATIENT_ID}"]/../../../following-sibling::div[1]/div[1]

*** Test Cases ***
Check Spikes list of Comments based on Spike Inclusion Setting
    persystWebApp.select comment sort order in user settings        ASC
    PersystWebApp.Navigate to EEG Page From Setting         ${PATIENT_ID}
    Test Reset EEG Setting
    PersystWebApp.Open Comment List from EEG Page
    ${Comment_name}    EEGPage.Get First Row's Text in List Of Comments
    should contain    ${Comment_name}       Beginning of Record
    persystWebApp.select comment sort order in user settings        DES
    PersystWebApp.Navigate to EEG Page From Setting         ${PATIENT_ID}
    PersystWebApp.Open Comment List from EEG Page
    ${Comment_name}    EEGPage.Get First Row's Text in List Of Comments
    should contain     ${Comment_name}       Current End of Record
    PersystWebApp.Close Comment List from EEG Page

Test Display Options-Quick Commands-Patient Name-Background and Grid Color
    [Tags]    testrun
    PersystWebApp.Select Dispaly Options From User Settings                 EEG
    PersystWebApp.Change "Add Quick Comments" Setting From User Setting     Enable
    PersystWebApp.Change "Show Patient Name" setting                        Enable
    PersystWebApp.Set EEG Background Color From User Settings               ${fcolor}[yellow]
    PersystWebApp.Set Grid Background Color From User Settings              ${fcolor}[white]
    PersystWebApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${PATIENT_ID}
    Test Reset EEG Setting
    PersystWebApp.Verify EEG Page Loaded Successfully
    Common.Compare the Images      user-setting-second-test.png
    ${Returned_Patient_Name}    PersystWebApp.Get Patient Name on EEG Page
    should contain    ${Returned_Patient_Name}     LnP14D3Nw10ICU, FnLnP14D3Nw10ICU
    PersystWebApp.Open Quick Comment Modal on EEG
    PersystWebApp.Quit Quick Comment Modal

Test Display Options-Quick Commands-Patient Name-Background and Grid Color(other-settings)
    [Tags]    testrun
    PersystWebApp.Select Dispaly Options From User Settings                 Trends
    PersystWebApp.Change "Add Quick Comments" Setting From User Setting     Disable
    PersystWebApp.Change "Show Patient Name" setting                        Disable
    PersystWebApp.Set EEG Background Color From User Settings               ${fcolor}[white]
    PersystWebApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${PATIENT_ID}
    PersystWebApp.Verify Trends Page Loaded Successfully
   Common.Compare the Images      user-setting-third-test.png
    ${Patient_Name}   get text    ${Trends_Patient_Name}
    should not contain    ${Patient_Name}           "LnP14D3"
    run keyword and expect error    STARTS: Element 'css=div[mapname="QuickComment"]' did not appear       PersystWebApp.Open Quick Comment Modal on EEG

Test Date Format-Time Format
    PersystWebApp.Change 'Date Formats' for EEG and Trends                  YYYYMMDD
    PersystWebApp.Change 'Time Format' From User Setting                    Clock Time
    PersystWebApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${PATIENT_ID}
    PersystWebApp.Verify Trends Page Loaded Successfully
    Common.Compare the Images             user-setting-forth-test.png
    PersystWebApp.Change 'Date Formats' for EEG and Trends                  D1D2...
    PersystWebApp.Change 'Time Format' From User Setting                    Elapsed Time
    PersystWebApp.Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)   ${PATIENT_ID}
    Common.Compare the Images             user-setting-fifth-test.png

Test Maximum Record Age
    PersystWebApp.Change 'Maximum Record Age' Setting                       1
    sleep    1s
    PersystWebApp.Navigate From Setting to Patient View
    sleep    20s
    ${Visisbility}      PersystWebApp.Verify If Patient Record Exist in Patient View      ${PATIENT_ID}
    should be equal     ${Visisbility}        False
    PersystWebApp.Change 'Maximum Record Age' Setting                       0
    sleep    1s
    PersystWebApp.Navigate From Setting to Patient View
    sleep   1s
    ${Visisbility}      PersystWebApp.Verify If Patient Record Exist in Patient View      ${PATIENT_ID}
    should be equal     ${Visisbility}        True


Test Maximum Record Duration-Segment by Day
    PersystWebApp.Change 'Maximum Record Duration' Setting                  1
    PersystWebApp.Change 'Segment By Day' Status From User Setting          Enable
    PersystWebApp.Navigate From Setting to Patient View
    wait until page contains element    ${Patient_Record_With_Segments}     30s
    scroll element into view    ${Patient_Record_With_Segments}
    sleep    6s
    ${segment_text}   get text        ${Patient_Record_With_Segments}
    should contain    ${segment_text}                                       2023 10/15 05:06:29
    PersystWebApp.Change 'Segment By Day' Status From User Setting          Disable
    PersystWebApp.Navigate From Setting to Patient View
    wait until page does not contain element    ${Patient_Record_With_Segments}
    page should not contain element    ${Patient_Record_With_Segments}

Test Inactivity Timeout
     PersystWebApp.Change 'Inactivity Timeout' Status From User Setting      Disable
     sleep    2s
     PersystWebApp.Enter "Inactivity Timeout" Time in Minues                 1.5
     sleep    2s
     PersystWebApp.Navigate From Setting to Patient View
     sleep    92
     run keyword and warn on failure    page should contain    Session Timed Out.
     Common.Login With Credentials
     PersystWebApp.Change 'Inactivity Timeout' Status From User Setting      Enable
     PersystWebApp.Navigate From Setting to Patient View
