*** Settings ***
Resource         Pages/LoginPage.robot
Resource         Pages/Settings.robot
Resource         Pages/PatientView.robot
Resource         Pages/TrendsPage.robot
Resource         Pages/EEGPage.robot
Resource         Common.robot

*** Keywords ***
#==================================================NAVIGATIONS=========================================================
Navigate to Trends Page From EEG Page
    EEGPage.Click on "Trends" link
    TrendsPage.Verify Trends Page Loads Successfully

Navigate to EEG Page From Trends
    TrendsPage.Click On EEG
    EEGPage.Verify EEG Page Loaded Successfully
    sleep    2s

Navigate to EEG Page From Setting
    [Arguments]    ${PATIENT_ID}
    Settings.Click on Patient Link
    PatientView.Verify Patient View Page Loaded
    PersystWebApp.Select Patient Record By Patient ID    ${PATIENT_ID}
    Navigate to EEG Page From Trends

Navigate From Setting to Patient View
    Settings.Click on Patient Link
    PatientView.Verify Patient View Page Loaded

Navigate From Setting to Trends/EEG(Either trends or EEG depend on Setting)
    [Arguments]    ${PATIENT_ID}
    Settings.Click on Patient Link
    PatientView.Verify Patient View Page Loaded
    PERSYSTWEBAPP.SELECT PATIENT RECORD BY PATIENT ID    ${PATIENT_ID}

Navigate to Settings From Patient View
    Settings.Click On Settings Button
    Settings.Verify "Setting" page loaded

Navigate to Trends Page By URL
    [Arguments]    ${URL}
    TrendsPage.Navigate to Trends Page Using URL        ${URL}

Navigate to EEG Using Keyboard Shortcut
    press keys    None      e
    EEGPage.Verify EEG Page Loaded Successfully

Navigate to Trends Using Keyboard Shortcut
    press keys    None      t
    TrendsPage.Verify Trends Page Loads Successfully

Navigate to Patient View Using Keyboard Shortcut
    press keys    None      p
    PatientView.Verify Patient View Page Loaded

Navigate Back to Main Setting Menu From Setting Pages
    Settings.Click On User Settings From Inside Settings Pages
    wait until page contains    EEG Settings

Navigate to Shared Settings
    Settings.Click on Shared Setting Link

Navigate to Unit Definitions in Shared Settings
    Settings.Click on Unit Definition

Navigate to Patient View From Trends
    TrendsPage.Click on Patient To Go Back To Patient View
    PatientView.Verify Patient View Page Loaded

Navigate to Trends Default Settings
    Settings.Click on Trends Default Settings

Navigate to EEG Default Settings
    Settings.Click on EEG Default Settings

Navigate to 'Shared Comment Filters' Settings Under Shared Setting
    Settings.Click on Shared Comment Filters on Shared Settings

Navigate to 'Standard Comments Editor' in Shared Settings
    Settings.Click on Standard Comments Link

Navigate to Patient View By URL And Search For Patient Name
    [Arguments]     ${PATIENT_NAME}
    PatientView.Navigate to Patient View By URL
    PatientView.Click on 'Patient List' tab
    Search For Petient Name in Patient View Page        ${PATIENT_NAME}

Go To EEG Page By URL   # URL variable comes from the test file depending on which patiend record we need to have
    [Arguments]    ${URL}
    EEGPage.Go To EEG Page Through URL  ${URL}
    EEGPage.Verify EEG Page Loaded Successfully
    sleep    2s
#====================================================================================================================
Go to "Login" page
    LoginPage.Navigate To Login Page
    LoginPage.Verify "Login" Page Loaded

Login Into Persyst Web With Valid Credentials
    [Arguments]        ${USERNAME}         ${PASSWORD}
    LoginPage.Login With Valid Credentials  ${USERNAME}         ${PASSWORD}
    PatientView.Verify Patient View Page Loaded

Navigate to Login Page and Login
    [Arguments]        ${USERNAME}         ${PASSWORD}
    LoginPage.Navigate To Login Page
    LoginPage.Verify "Login" Page Loaded
    LoginPage.Login With Valid Credentials  ${USERNAME}         ${PASSWORD}
    PatientView.Verify Patient View Page Loaded

Logging Out From Persyst Web
    Settings.Logging out

Search For Petient in Patient List With Patient Name
    [Arguments]         ${PATIENT_NAME}
    PatientView.Enter Patient Name In The Patient Name Textfield    ${PATIENT_NAME}
    sleep   1s
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

Open Comment List from EEG Page
    EEGPage.Launch Comment List If Not Launched Already

Close Comment List from EEG Page
    EEGPage.Close Comment List If Launched Already

Create A Comment On EEG
    EEGPage.Click On Comment Button
    TrendsPage.Fill In "Comment Name" Input
    EEGPage.Click on "+" button To Add The Comment

Click on Created Comment On EEG and Get Comment Name
    EEGPage.Click On Created Comment On EEG
    ${Comment_name}    TrendsPage.Get Created Comment Text
    [Return]    ${Comment_name}

Search For The Comment/Spike/Seizure In The EEG Comment Box
    [Arguments]    ${COMMENT_NAME}
    Open Comment List from EEG Page
    EEGPage.Fill in the "Comment/Spike/Seizure Name" in Comment Box Filter    ${COMMENT_NAME}
    ${Comment_name}    EEGPage.Get First Row's Text When Searched For Comment
    [Return]    ${Comment_name}

Delete a Comment from EEG Page
    EEGPage.Click On Created Comment On EEG
    EEGPage.Click on Delete Comment Button

Go To Settings Page
    Settings.Go To Settings Page
    Settings.Verify "Setting" page loaded
    sleep    2s

Change "Include Spikes In Comment" Setting
    [Arguments]    ${STATUS}        # The status should be either "Enable" or "Disable"
    Go To Settings Page
    Settings.Change "Include Spikes In Comment" checkbox    ${STATUS}

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

Create Patient Montage in EEG Page
    EEGPage.Click the EEG Page Setting Button
    EEGPage.click on Edit Montage
    wait until page contains     Bipolar longitudinal A (Patient)
    # When you delete one of the system Montage channels you automatically creating a patient montage
    EEGPage.Delete one of the Montage Channels

Delete Created Montage From EEG Page
    EEGPage.Click the EEG Page Setting Button
    EEGPage.click on Edit Montage
    EEGPage.Delete Patient Montage

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

Open Quick Comment Modal on EEG
    EEGPage.Open Quick Comment Modal on EEG

Quit Quick Comment Modal
    EEGPage.Close Quick Comment Modal On EEG

Reset Quick Comment Modal
    Quit Quick Comment Modal
    Open Quick Comment Modal on EEG

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

Open 'User Guide' PDF From User Settings
    Go To Settings Page
    Settings.Click 'User Guide' Link
    Settings.Switch to User Guide Tab and Verify The URL

Add New Montage From User Settings
    Go To Settings Page
    Click On Montage Editor
    Settings.Delete Previouly Create Montage If Exist
    Settings.Create New Montage

Reset All User Settings
    Settings.Reset User Settings

Delete a Montage From Montage Editor
    Go To Settings Page
    Settings.Click On Montage Editor
    Settings.Click on Montage List Dropdown
    Settings.Select First Montage On Dropdown
    Settings.Select Delete Montage

Edit Montage From Montage Editor
    Go To Settings Page
    Settings.Click On Montage Editor
    Settings.Click on Montage List Dropdown
    Settings.Select First Montage On Dropdown
    Settings.Edit Created Montage

Add More Channels to Montage
    [Arguments]    ${CHANNEL_NAME}
    Settings.Add Channels to Montage    ${CHANNEL_NAME}

Delete Channels From a Montage
    Settings.Delete Channels From Created Montage

Change 'Show All' Montage Status In Favorite Montage Setting
    [Arguments]    ${ON/OFF}
    Go To Settings Page
    Settings.Click On 'Favorite Montage' Link
    Settings.Change Show All Favorite Montage Settings    ${ON/OFF}
    Settings.Click On User Settings From Inside Settings Pages

Change List of Favorite Montages From Settings
    [Arguments]    ${MONTAGE_NAME}
    Go To Settings Page
    Settings.Click On 'Favorite Montage' Link
    Settings.Select Montage From List Of Favorite Montages    ${MONTAGE_NAME}
    Settings.Click On User Settings From Inside Settings Pages

Create a New Comment Filter In Settings
    Go To Settings Page
    Settings.Click On 'Comment Filter' Button
    Settings.Delete Comment Filters Until None Exist
    Settings.Create New Comment Filter
    Settings.Click On User Settings From Inside Settings Pages

Select a Comment Filter On EEG Page
    [Arguments]    ${FILTER_NAME}
    EEGPage.Launch Comment List If Not Launched Already
    EEGPage.Click On Comment Filter Button
    EEGPage.Select a Comment Filter    ${FILTER_NAME}

Delete a Comment Filter
    Go To Settings Page
    Settings.Click On 'Comment Filter' Button
    Settings.Delete Comment Filter

Change Keyboard Shortcut Setting
    [Arguments]    ${ACTION}    ${KEY}
    Go To Settings Page
    Settings.Click on Keyboard Shortcut Settings
    Settings.Change Keyboard Shortcut Settings    ${ACTION}    ${KEY}
    Settings.Click On User Settings From Inside Settings Pages

Reset Keyboard Shortcut Settings
    Go To Settings Page
    Settings.Click on Keyboard Shortcut Settings
    Settings.Click On Reset Keyboard Shortcut Button

Change User Password From User Settings
    [Arguments]    ${OLD_PASSWORD}          ${NEW_PASSWORD}
    Settings.Click Change Password On Settings
    Settings.Enter Old and New Password         ${OLD_PASSWORD}          ${NEW_PASSWORD}

Add a New Unit in Shared Settings
    [Arguments]    ${UNIT_NAME}         ${UNIT_DESCRIPTION}
    Add a New Unit    ${UNIT_NAME}         ${UNIT_DESCRIPTION}
    Navigate Back to Main Setting Menu From Setting Pages
    sleep   1s

Delete Previously Created Units From Shared Settings
    PersystWebApp.Go To Settings Page
    PersystWebApp.Navigate to Shared Settings
    PersystWebApp.Navigate to Unit Definitions in Shared Settings
    Settings.Delete Previously Created Units

Assign a Patient to a Unit from Shared Setting
    [Arguments]    ${UNIT_NAME}                ${PATIENT_NAME}
    Settings.Click on Patient Unit Assignments Link
    Settings.Assign a Patient to a Unit     ${UNIT_NAME}                ${PATIENT_NAME}
    Navigate Back to Main Setting Menu From Setting Pages

Add a New Unit and Assign a Patient to it
    [Arguments]    ${UNIT_NAME}         ${UNIT_DESCRIPTION}         ${PATIENT_NAME}
    Go To Settings Page
    PersystWebApp.Navigate to Shared Settings
    Navigate to Unit Definitions in Shared Settings
    Add a New Unit in Shared Settings                   ${UNIT_NAME}         ${UNIT_DESCRIPTION}
    Assign a Patient to a Unit from Shared Setting      ${UNIT_NAME}         ${PATIENT_NAME}

Search For Petient Name in Patient View Page
    [Arguments]         ${PATIENT_NAME}
    PatientView.Enter Patient Name In The Patient Name Textfield    ${PATIENT_NAME}
    Click On First Patient In The List After Filtering
    Verify Patient Comments Appear
    sleep    3s

Add a New Standard Comment From Shared Setting
    Navigate to Shared Settings
    Navigate to 'Standard Comments Editor' in Shared Settings
    Settings.Add a New Standard Comment
    Navigate Back to Main Setting Menu From Setting Pages

Delete Created Standard Comment From Shared Settings
    [Arguments]    ${COMMENT_NAME}
    Settings.Delete Created Standard Comment          ${COMMENT_NAME}

Change Trends Default Panel and Duration From Settings
    [Arguments]    ${PANEL}         ${DURATION}
    Settings.Select a Panel From Trends Default Panel Dropdown    ${PANEL}
    Settings.Select a Duration From Trends Default Duration Dropdown    ${DURATION}

Mminimize and Maximize Unit In Patient View
    [Arguments]    ${UNIT_NAME}     ${PAGE}
    PatientView.Minimize Unit By Name Either in Patient View Or Monitoring      ${UNIT_NAME}        ${PAGE}
    sleep   2s

Get Comment Data From Records Event Density
    PatientView.Click On Wrench Button To Navigate to Event Density
    @{Values}        PatientView.Find Comment's Data From Event Density
    [Return]         @{Values}

Get Patient Record Info From Patient View Info Button
    ${Info}         PatientView.Get Patient Info From Info Button
    [Return]        ${Info}

Assign First Patient Name to A Unit In Shared Settings
    [Arguments]         ${UNIT_NAME}         ${UNIT_DESCRIPTION}
    ${Patient_Name}     PatientView.Get 'First Patient' Name in Monitoring Page
    Navigate to Settings From Patient View
    Navigate to Shared Settings
    Navigate to Unit Definitions in Shared Settings
    Add a New Unit in Shared Settings                   ${UNIT_NAME}         ${UNIT_DESCRIPTION}
    Settings.Click on Patient Unit Assignments Link
    Settings.Assign Patient to a Unit For Monitoring(4Backspace)      ${UNIT_NAME}         ${Patient_Name}
    Navigate Back to Main Setting Menu From Setting Pages



