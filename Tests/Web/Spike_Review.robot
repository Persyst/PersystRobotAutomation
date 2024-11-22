*** Settings ***
Documentation    This test is going to test EEG Spike Review Feature
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Resource         ../../Resources/PO/Web/Pages/EEGPage.robot
Suite Setup      Run Keywords   Begin Web Suit  AND    Spike Review Setup    AND    Test Reset EEG Setting
Test Setup       Reset Spike Review Settings
Suite Teardown   Run Keywords   End Web Suit

# Command line to run this test: robot -d results Tests/Web/spike_review.robot
*** Variables ***

*** Test Cases ***
Test Spike Review View Filters
    SpikeReviewPage.Launch Spike Review If Not Launched Already
    Set Spike Review Preview Filter     Overview
    ${Spike_Group_Title}      Get Spike's Group Title     1
    Should Be Equal As Strings       ${Spike_Group_Title}      F3 n=1691
    Set Spike Review Preview Filter     All
    ${Spike_Tiltle}           get spike's title     1
    should be equal as strings      ${Spike_Tiltle}            10/13 12:20:20

Test Spike Sort Filter
    Set Spike Review Sort Filter        Sorted by Count
    ${Spike_Group_Title}      Get Spike's Group Title     1
    Should Be Equal As Strings       ${Spike_Group_Title}      F3 n=1691
    Set Spike Review Sort Filter        Show Confirmed First
    ${Spike_Group_Title}      Get Spike's Group Title     1
    Should Be Equal As Strings       ${Spike_Group_Title}      F3 n=1691

Test Sensitivity Detection
    Set Spike Detection Sensitivity Filter      High
    ${Spike_Group_Title}      Get Spike's Title     1
    Should Be Equal As Strings       ${Spike_Group_Title}    F3 n=2057
    Set Spike Detection Sensitivity Filter      Low
    ${Spike_Group_Title}      Get Spike's Title     1
    Should Be Equal As Strings       ${Spike_Group_Title}    F3 n=1388

Test Spike Intercrenial Filter
    Set Spike Intercrenial Preview Filter           false
    ${Spike_Group_Title}      Get Spike's Group Title     1
    Should Be Equal As Strings       ${Spike_Group_Title}       F3 n=1935
    Set Spike Intercrenial Preview Filter           true
    ${Spike_Group_Title}      Get Spike's Group Title     1
    Should Be Equal As Strings       ${Spike_Group_Title}       F3 n=1691

Test Spike Group Overview
    SpikeReviewPage.Open First Spike Group
    ${Spike_Tiltle}           get spike's title     1
    should be equal as strings      ${Spike_Tiltle}             10/13 12:20:22
    ${Spike_Tiltle}           get spike's title     2
    should be equal as strings      ${Spike_Tiltle}             10/13 12:20:22
    ${Spike_Tiltle}           get spike's title     2
    should be equal as strings      ${Spike_Tiltle}             10/13 12:20:25
    Click on Spike's Image      2
    sleep    25
    Click on Voltage Map's Timeseries buttons
    sleep    25s
    Select Group Display Style                      Selected Over Confirmed
    sleep    25s
    Select Group Display Style                      Selected over Each Confirmed
    sleep    25s


*** Keywords ***
Spike Review Setup
#    PersystWebApp.Change 'Segment By Day' Status From User Setting          Enable
#    PersystWebApp.Navigate From Setting to Patient View
    ${LN_First_Day_EEG_Page}        set variable    http://10.193.0.106/PersystMobile/record-views/eeg/225/0?segmentStart=0&segmentEnd=70353.82617211342
    Go To EEG Page By URL           ${LN_First_Day_EEG_Page}

