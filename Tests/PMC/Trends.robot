*** Settings ***
Documentation    This test is going to test Persyst Trends Setting
Resource        ../../Resources/PO/PMC/PMCApp.robot
Resource        ../../Resources/PO/PMC/Common.robot
Suite Setup      Run Keywords   Begin Web Suit    AND       Reset the Trends Setting        ${PATIENT_NAME}
Suite Teardown   Run Keywords   Reset the Trends Setting        ${PATIENT_NAME}   AND      End Web Suit

# Command line to run this test: robot -d results Tests/PMC/Trends.robot
*** Variables ***
${COMMENT_NAME}            Moji Comment
${SPIKE_NAME}              Spike T6
${SEIZURE_NAME}            Seizure
${PATIENT_NAME}            A2_24

*** Test Cases ***
Add Comment On Trends and Verify the comment on Trends Page and List of Comments in EEG Page(record)
    PMCApp.Create A Comment On Trends
    ${Comment_text}    PMCApp.Click on Created Comment On Trends and Get Comment Name
    should contain     ${Comment_text}      ${COMMENT_NAME}
    PMCApp.Navigate to EEG Page From Trends
    ${Comment_name}     PMCApp.Search For The Comment/Spike/Seizure In The EEG Comment Box   ${COMMENT_NAME}
    should contain     ${Comment_name}      ${COMMENT_NAME}
    Navigate to Trends Page From EEG Page
    PMCApp.Delete A Comment On Trends

Check Spikes list of Comments based on Spike Inclusion Setting
    PMCApp.Change "Include Spikes In Comment" Setting    Enable
    PMCApp.Navigate to EEG Page From Setting             ${PATIENT_NAME}
    ${Returned_Spike_Name}       PMCApp.Search For The Comment/Spike/Seizure In The EEG Comment Box    ${SPIKE_NAME}
    should contain          ${Returned_Spike_Name}          ${SPIKE_NAME}
    PMCApp.Change "Include Spikes In Comment" Setting    Disable
    PMCApp.Navigate to EEG Page From Setting             ${PATIENT_NAME}
    ${Returned_Spike_Name}       PMCApp.Search For The Comment/Spike/Seizure In The EEG Comment Box    ${SPIKE_NAME}
    should not contain      ${Returned_Spike_Name}          ${SPIKE_NAME}
    ${Returned_Seizure_Name}     PMCApp.Search For The Comment/Spike/Seizure In The EEG Comment Box    ${SEIZURE_NAME}
    should contain          ${Returned_Seizure_Name}      ${SEIZURE_NAME}

Change Page Duration
    PMCApp.Navigate to Trends Page By URL
    PMCApp.Change Trends Page Duration    5min
    sleep    5s
    Common.Compare the Images  Trends-5min-rightcorner.png
    PMCApp.Change Trends Page Duration    4hours
    sleep    5s
    Common.Compare the Images            Trends-4hour-bottomleftcorner.png

Verify Artifact Reduction Functionality
    PMCApp.Change Trends Page Duration       4hours
    PMCApp.Change Artifact Reduction Status On Trends    OFF
    sleep    3s
    Common.Compare the Images            Trends-ar-off.png
    PMCApp.Change Artifact Reduction Status On Trends    ON
    sleep    3s
    common.compare the images            Trends-ar-on.png

Verify the Trends Panel Setting Functionality
    [Tags]    testrun
    PMCApp.Change Panel Setting From Trends Setting      Asymmetry
    sleep    3s
    Common.Compare the Images             Trends-asymmetry.png
    PMCApp.Change Panel Setting From Trends Setting      SpikeDetails
    sleep    3s
    Common.Compare the Images             Trends-spikedetails.png
    PMCApp.Change Panel Setting From Trends Setting      Comprehensive
    sleep    3s
    Common.Compare the Images             Trends-comprehensive.png
    PMCApp.Navigate to Patient View Using Keyboard Shortcut