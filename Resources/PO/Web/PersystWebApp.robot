*** Settings ***
Resource         Pages/LoginPage.robot
Resource         Pages/Settings.robot
Resource         Pages/PatientView.robot
Resource         Pages/TrendsPage.robot
Resource         Pages/EEGPage.robot
Resource         Common.robot

*** Keywords ***
Go to "Login" page
    LoginPage.Navigate To Login Page
    LoginPage.Verify "Login" Page Loaded

Login Into Persyst Web With Valid Credentials
    [Arguments]        ${USERNAME}         ${PASSWORD}
    LoginPage.Login With Valid Credentials  ${USERNAME}         ${PASSWORD}
    PatientView.Verify Patient View Page Loaded

Logging Out From Persyst Web
    Settings.Logging out

Search For Petient in Patient List With Patient Name
    [Arguments]         ${PATIENT_NAME}
    PatientView.Enter Patient Name In The Patient Name Textfield    ${PATIENT_NAME}
    Click On First Patient In The List After Filtering
    Verify Patient Comments Appear
    sleep    3s
    PatientView.click on Patient Beginning of Record
    TrendsPage.Verify Trends Page Loads Successfully

Select Patient Record By Patient ID
    [Arguments]    ${PATIENT_ID}
    PatientView.Click on Patient Record By ID    ${PATIENT_ID}
    sleep   1s
    PatientView.click on Patient Beginning of Record
    sleep    2s

Create A Comment On Trends
    TrendsPage.Click On Comment Button
    TrendsPage.Fill In "Comment Name" Input
    TrendsPage.Click on "+" button To Add The Comment

Click on Created Comment On Trends and Get Comment Name
    TrendsPage.Click On Created Comment On Trends
    ${Comment_name}    TrendsPage.Get Created Comment Text
    [Return]    ${Comment_name}

Delete A Comment On Trends
    TrendsPage.Click On Created Comment On Trends
    TrendsPage.Click On "Delete" Button

Navigate to EEG Page
    TrendsPage.Click On EEG
    EEGPage.Verify EEG Page Loaded Successfully
    sleep    2s

Open Comment List from EEG Page
    EEGPage.Launch Comment List If Not Launched Already

Close Comment List from EEG Page
    EEGPage.Close Comment List If Launched Already

Search For The Comment/Spike/Seizure In The EEG Comment Box
    [Arguments]    ${COMMENT_NAME}
    Open Comment List from EEG Page
    EEGPage.Fill in the "Comment/Spike/Seizure Name" in Comment Box Filter    ${COMMENT_NAME}
    ${Comment_name}    EEGPage.Get First Row's Text When Searched For Comment
    [Return]    ${Comment_name}

Navigate to Trends Page From EEG Page
    EEGPage.Click on "Trends" link
    TrendsPage.Verify Trends Page Loads Successfully

Go To Settings Page
    Settings.Go To Settings Page
    Settings.Verify "Setting" page loaded
    sleep    2s

Change "Include Spikes In Comment" Setting
    [Arguments]    ${STATUS}        # The status should be either "Enable" or "Disable"
    Go To Settings Page
    Settings.Change "Include Spikes In Comment" checkbox    ${STATUS}

Go To EEG Page By URL   # URL variable comes from the test file depending on which patiend record we need to have
    [Arguments]    ${URL}
    EEGPage.Go To EEG Page Through URL  ${URL}
    EEGPage.Verify EEG Page Loaded Successfully

Navigate to EEG Page From Setting
    [Arguments]    ${PATIENT_ID}
    Settings.Click on Patient Link
    PatientView.Verify Patient View Page Loaded
    PERSYSTWEBAPP.SELECT PATIENT RECORD BY PATIENT ID    ${PATIENT_ID}
    Navigate to EEG Page

Navigate From Setting to Patient View
    Settings.Click on Patient Link
    PatientView.Verify Patient View Page Loaded

Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)
    [Arguments]    ${PATIENT_ID}
    Settings.Click on Patient Link
    PatientView.Verify Patient View Page Loaded
    PERSYSTWEBAPP.SELECT PATIENT RECORD BY PATIENT ID    ${PATIENT_ID}

Verify EEG Page Loaded Successfully
    EEGPage.Verify EEG Page Loaded Successfully

Verify Trends Page Loaded Successfully
    TrendsPage.Verify Trends Page Loads Successfully

Change Trends Page Duration
    [Arguments]    ${DURATION}          # Current variables are 4hour and 5min
    TrendsPage.click on Setting Button
    TrendsPage.click on Page Duration Setting
    TrendsPage.Change Page Duration Value    ${DURATION}

Change Artifact Reduction Status On Trends
    [Arguments]    ${ON/OFF}
    TrendsPage.click on Setting Button
    TrendsPage.Change Artifact Reduction Status    ${ON/OFF}

Change Panel Setting From Trends Setting
    [Arguments]    ${PANEL_OPTION}
    TrendsPage.click on Setting Button
    TrendsPage.Open Panel Menu From Trends Setting
    TrendsPage.Select an Option From Trends Panel Setting    ${PANEL_OPTION}
    TrendsPage.Verify Trends Page Loads Successfully

Change EEG Page Font Size
    [Arguments]     ${FONT_SIZE}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    EEGPage.Change the EEG Page Font Size       ${FONT_SIZE}

Change EEG Channel Per Page Setting
    [Arguments]    ${NUMBER_OF_CHANNELS}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    sleep    1s
    EEGPage.Change channel Per Page Setting     ${NUMBER_OF_CHANNELS}
    EEGPage.Verify EEG Page Loaded Successfully

Change EEG Calibration Status
    [Arguments]    ${ON/OFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    sleep    1s
    EEGPage.Change Calibrartion Status         ${ON/OFF}

Change EEG Major Grid Status
    [Arguments]    ${ON/OFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    sleep    1s
    EEGPage.Change Major Grid Status         ${ON/OFF}

Change EEG Minor Grid Status
    [Arguments]    ${ON/OFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    sleep    1s
    EEGPage.Change Minor Grid Status         ${ON/OFF}

Change EEG Comment Line Status
    [Arguments]    ${ON/OFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    sleep    1s
    EEGPage.Change Comment Line Status         ${ON/OFF}

Change EEG Comment Show Status
    [Arguments]    ${ON/OFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    sleep    1s
    EEGPage.Change Show Comment Status         ${ON/OFF}

Change EEG Restricted Pen Status
    [Arguments]    ${ON/OFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Display Setting Link
    sleep    1s
    EEGPage.Change Restricted Pen Status         ${ON/OFF}

Change EEG Montage Setting
    [Arguments]    ${MONTAGE_OPTIONS}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Waveforms Setting Link
    EEGPage.Click on Montage Setting
    EEGPage.Select Montage Option    ${MONTAGE_OPTIONS}

Change EEG Page Duration Time
    [Arguments]    ${DURATION}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Waveforms Setting Link
    EEGPage.Click on EEG Page Duration Setting
    EEGPage.Select EEG Page Duration    ${DURATION}

Change EEG Sensitivity Option
    [Arguments]    ${SENSITIVITY}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Waveforms Setting Link
    EEGPage.Click on EEG Sensitivity Menu
    EEGPage.Select EEG Page Sensitivity    ${SENSITIVITY}

Change EEG Artifact Reduction Status
    [Arguments]    ${ON/OFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Waveforms Setting Link
    EEGPage.Change Artifact Reduction Status    ${ON/OFF}

Change EEG LFF Setting
    [Arguments]    ${LFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Waveforms Setting Link
    EEGPage.Click on LFF Setting Menu
    EEGPage.Select LFF Setting    ${LFF}

Change EEG HFF Setting
    [Arguments]    ${HFF}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Waveforms Setting Link
    EEGPage.Click on HFF Setting Menu
    EEGPage.Select HFF Setting    ${HFF}

Change Notch Filter Setting
    [Arguments]    ${NOTCH_OPTION}
    EEGPage.Click the EEG Page Setting Button
    EEGPage.Click on Waveforms Setting Link
    EEGPage.Select Notch Filter Option    ${NOTCH_OPTION}

Select Comment Sort Order in User Settings
    [Arguments]             ${ASC/DES}
    Go To Settings Page
    Settings.Select Comment Sort Order    ${ASC/DES}

Change "Add Quick Comments" Setting From User Setting
    [Arguments]    ${ON/OFF}
    Go To Settings Page
    settings.change "add quick comments" checkbox       ${ON/OFF}

Select Dispaly Options From User Settings
    [Arguments]    ${TRENDS/EEG/EEGONLY}
    Go To Settings Page
    Settings.Select Display Options    ${TRENDS/EEG/EEGONLY}

Change "Show Patient Name" setting
    [Arguments]    ${ON/OFF}
    Go To Settings Page
    Settings.Change "Show Patient Name" setting    ${ON/OFF}

Set EEG Background Color From User Settings
    [Arguments]    ${COLOR_CODE}
    Go To Settings Page
    Settings.Enter EEG Background Color    ${COLOR_CODE}

Set Grid Background Color From User Settings
    [Arguments]    ${COLOR_CODE}
    Go To Settings Page
    Settings.Enter Grid Background Color    ${COLOR_CODE}

Change 'LFF Type' Setting
    [Arguments]    ${CONSTANT_TIME/FREQUENCY}
    Go To Settings Page
    settings.change lff type setting    ${CONSTANT_TIME/FREQUENCY}

Change 'Date Formats' for EEG and Trends
    [Arguments]     ${MM-DD-YYY/D1D2/NONE}
    Go To Settings Page
    Settings.Change Date Formats for EEG and Trends    ${MM-DD-YYY/D1D2/NONE}

Change 'Time Format' From User Setting
    [Arguments]     ${CLOCK/ELAPSED/SECONDS}
    Go To Settings Page
    Settings.Change Time Format Setting    ${CLOCK/ELAPSED/SECONDS}

Change 'Maximum Record Age' Setting
    [Arguments]     ${MAX_RECORD_AGE}
    Go To Settings Page
    Settings.Change Maximum Record Age                        ${MAX_RECORD_AGE}

Change 'Maximum Record Duration' Setting
    [Arguments]     ${MAX_RECORD_DURATION}
    Go To Settings Page
    Settings.Change Maximum Record Duration                   ${MAX_RECORD_DURATION}

Change 'Segment By Day' Status From User Setting
    [Arguments]     ${ON/OFF}
    Go To Settings Page
    Settings.Change Segment By Day Switch Status              ${ON/OFF}

Change 'Segment By Specific Time' Status From User Setting
    [Arguments]     ${ON/OFF}
    Go To Settings Page
    Settings.Change Segment By Specific Time Switch Status    ${ON/OFF}

Enter "Refresh Interval" Time in Minues
    [Arguments]     ${TIME}
    Go To Settings Page
    Settings.Enter 'Refresh Interval' Into Textbox            ${TIME}

Enter "Inactivity Timeout" Time in Minues
    [Arguments]     ${TIME}
    Go To Settings Page
    Settings.Enter 'Inactivity Timeout' Into Textbox          ${TIME}

Change 'Inactivity Timeout' Status From User Setting
    [Arguments]     ${ON/OFF}
    Go To Settings Page
    Settings.Change 'Inactivity Timeout' Status               ${ON/OFF}

Change 'Show Connection' Status From User Setting
    [Arguments]     ${ON/OFF}
    Go To Settings Page
    Settings.Change 'Show Connection Speed' Status            ${ON/OFF}

Change 'EEG High Resolution' Status From User Setting
    [Arguments]     ${ON/OFF}
    Go To Settings Page
    Settings.Change 'EEG High Resolution' Status              ${ON/OFF}

Add Quick Comment on EEG
    EEGPage.Open Quick Comment Modal on EEG

Quit Quick Comment Modal
    EEGPage.Close Quick Comment Modal On EEG

Compare the Images
    [Arguments]    ${SCREENSHOT_NAME}
    Common.Compare the Images      ${SCREENSHOT_NAME}

Get Patient Name on EEG Page
    ${Patient_Name}    EEGPage.Get Patient Name From EEG Header
    [Return]        ${Patient_Name}

Verify If Patient Record Exist in Patient View
    [Arguments]    ${PATIENT_ID}
    ${Visibility}       PatientView.Check If Patient Record Exist        ${PATIENT_ID}
    [Return]     ${Visibility}

Reset User Interface Settings From User Settings
    Go To Settings Page
    Settings.Click on 'Reset User Interface'

Open 'User Guid' PDF From User Settings
    Go To Settings Page
    Settings.Click 'User Guide' Link
    Settings.Switch to User Guide Tab and Verify The URL