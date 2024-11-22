*** Settings ***
Documentation    This test is going to test Persyst Trends Setting
Resource        ../../Resources/PO/Web/PersystWebApp.robot
Resource        ../../Resources/PO/Web/Common.robot
Suite Setup      Run Keywords   Begin Web Suit    AND       Reset the User Basic Settings     AND     Reset the Trends Setting        ${PATIENT_ID}
Suite Teardown   Run Keywords   Reset the Trends Setting        ${PATIENT_ID}   AND      End Web Suit

# Command line to run this test: robot -d results Tests/Web/Trends.robot
*** Variables ***
${COMMENT_NAME}            Moji Comment
${SPIKE_NAME}              Spike
${SEIZURE_NAME}            @SeizureDetected
${PATIENT_ID}              225

*** Test Cases ***
Add Comment On Trends and Verify the comment on Trends Page and List of Comments in EEG Page(record)
    [Documentation]    This test is going to add a comment on trends and then delete it after verifying it
    PersystWebApp.Create A Comment On Trends
    ${Comment_text}    PersystWebApp.Click on Created Comment On Trends and Get Comment Name
    should contain     ${Comment_text}      ${COMMENT_NAME}
    PersystWebApp.Navigate to EEG Page From Trends
    ${Comment_name}     PersystWebApp.Search For The Comment/Spike/Seizure In The EEG Comment Box   ${COMMENT_NAME}
    should contain     ${Comment_name}      ${COMMENT_NAME}
    Navigate to Trends Page From EEG Page
    PersystWebApp.Delete A Comment On Trends

Check Spikes list of Comments based on Spike Inclusion Setting
    PersystWebApp.Change "Include Spikes In Comment" Setting    Enable
    PersystWebApp.Navigate to EEG Page From Setting         ${PATIENT_ID}
    ${Returned_Spike_Name}       PersystWebApp.Search For The Comment/Spike/Seizure In The EEG Comment Box    ${SPIKE_NAME}
    should contain          ${Returned_Spike_Name}          ${SPIKE_NAME}
    PersystWebApp.Change "Include Spikes In Comment" Setting    Disable
    PersystWebApp.Navigate to EEG Page From Setting         ${PATIENT_ID}
    ${Returned_Spike_Name}       PersystWebApp.Search For The Comment/Spike/Seizure In The EEG Comment Box    ${SPIKE_NAME}
    should not contain      ${Returned_Spike_Name}          ${SPIKE_NAME}
    ${Returned_Seizure_Name}     PersystWebApp.Search For The Comment/Spike/Seizure In The EEG Comment Box    ${SEIZURE_NAME}
    should contain          ${Returned_Seizure_Name}      ${SEIZURE_NAME}

Change Page Duration
    PersystWebApp.Navigate to Trends Page By URL    ${LnP14D3Nw10ICU, FnLnP14D3Nw10ICU_Trends_URL}
    PersystWebApp.Change Trends Page Duration    5min
    sleep   3s
    Common.Compare the Images  Trends-5min-rightcorner.png
    PersystWebApp.Change Trends Page Duration    4hours
    sleep    3s
    Common.Compare the Images            Trends-4hour-bottomleftcorner.png

Verify Artifact Reduction Functionality
    PersystWebApp.Change Trends Page Duration       4hours
    PersystWebApp.Change Artifact Reduction Status On Trends    OFF
    sleep    3s
    Common.Compare the Images            Trends-ar-off.png
    PersystWebApp.Change Artifact Reduction Status On Trends    ON
    sleep    3s
    common.compare the images            Trends-ar-on.png

Verify the Trends Panel Setting Functionality
    [Tags]    testrun
    PersystWebApp.Change Panel Setting From Trends Setting      Asymmetry
    sleep    3s
    Common.Compare the Images             Trends-asymmetry.png
    PersystWebApp.Change Panel Setting From Trends Setting      SpikeDetails
    sleep    3s
    Common.Compare the Images             Trends-spikedetails.png
    PersystWebApp.Change Panel Setting From Trends Setting      Comprehensive
    sleep    3s
    Common.Compare the Images             Trends-comprehensive.png
