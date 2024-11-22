*** Settings ***
Documentation    This test is going to test EEG Settings
Resource         ../../Resources/PO/PMC/Common.robot
Resource         ../../Resources/PO/PMC/PMCApp.robot
Resource         ../../Resources/PO/PMC/Pages/EEGPage.robot
Suite Setup      Run Keywords   Begin Web Suit    AND    Reset EEG Setting    ${PATIENT_NAME}
Test Setup       Test Reset EEG Setting
Suite Teardown   Run Keywords   Reset EEG Setting   ${PATIENT_NAME}     AND    End Web Suit

# Command line to run this test: robot -d results Tests/PMC/EEG.robot
*** Variables ***
${PATIENT_NAME}            A2_24

*** Test Cases ***
Verify Display Font Size Functionality
    PMCApp.Change EEG Page Font Size     6
    PMCApp.Change EEG Page Font Size     8
    sleep     3s
    Common.compare the images    eeg-font-size-1.png
    PMCApp.Change EEG Page Font Size     2
    sleep     3s
    Common.compare the images    eeg-font-size-2.png

Verify EEG Channel Per Page Functionality
    PMCApp.Change EEG Channel Per Page Setting       6
    sleep     3s
    Common.compare the images    eeg-channel-1.png
    PMCApp.Change EEG Channel Per Page Setting       16
    sleep    3s
    Common.compare the images    eeg-channel-2.png
    PMCApp.Change EEG Channel Per Page Setting       All
    sleep    3s
    Common.compare the images    eeg-channel-3.png

Test EEG Califbration Functionality
    PMCApp.change eeg calibration status     OFF
    sleep     3s
    Common.compare the images    eeg-calibration-1.png
    PMCApp.change eeg calibration status     ON
    sleep     3s
    Common.compare the images    eeg-calibration-2.png

Test EEG Major Grid Functionality
    PMCApp.Change EEG Major Grid Status    OFF
    sleep     3s
    Common.compare the images    eeg-major-grid-1.png
    PMCApp.Change EEG Major Grid Status    ON
    sleep     3s
    Common.compare the images    eeg-major-grid-2.png

Test EEG Minor Grid Functionality
    PMCApp.Change EEG Minor Grid Status    OFF
    sleep     3s
    Common.compare the images    eeg-minor-grid-1.png
    PMCApp.Change EEG Minor Grid Status    ON
    sleep     3s
    Common.compare the images    eeg-minor-grid-2.png

Test EEG Comment Line Status
    PMCApp.Change EEG Comment Line Status    OFF
    sleep     3s
    Common.compare the images    eeg-comment-line-1.png
    PMCApp.Change EEG Comment Line Status    ON
    sleep     3s
    Common.compare the images    eeg-comment-line-2.png

Test EEG Comment Show Status
    PMCApp.Change EEG Comment Show Status    OFF
    sleep     3s
    Common.compare the images    eeg-comment-show-1.png
    PMCApp.Change EEG Comment Show Status    ON
    sleep     3s
    Common.compare the images    eeg-comment-show-2.png

Test EEG Pen Restriction Switch
    PMCApp.Change EEG Restricted Pen Status    ON
    sleep    1s
    PMCApp.Change EEG Restricted Pen Status    OFF
    sleep    1s

Test EEG Montage Setting
    PMCApp.Change EEG Montage Setting    ACNSNeoBP2
    sleep     3s
    Common.compare the images    eeg-montage-1.png
    PMCApp.Change EEG Montage Setting    Bipolar longitudinal A
    sleep     3s
    Common.compare the images    eeg-montage-2.png

Test EEG Page Duration Setting
    PMCApp.Change EEG Page Duration Time     20
    sleep   3s
    Common.compare the images    eeg-duration-1.png
    PMCApp.Change EEG Page Duration Time     10
    sleep   3s
    Common.compare the images    eeg-duration-2.png

Test EEG Sensitivity Setting
    PMCApp.Change EEG Sensitivity Option     30
    sleep     3s
    Common.compare the images    eeg-sensitivity-1.png
    PMCApp.Change EEG Sensitivity Option     7
    sleep     3s
    Common.compare the images    eeg-sensitivity-2.png

Test EEG Artifact Reduction
    PMCApp.Change EEG Artifact Reduction Status    ON
    sleep   3s
    Common.compare the images    eeg-ar-1.png
    PMCApp.Change EEG Artifact Reduction Status    OFF
    sleep   3s
    Common.compare the images    eeg-ar-2.png

Test EEG LFF Setting
    PMCApp.Change EEG LFF Setting        0.533
    sleep     3s
    Common.compare the images    eeg-lff-1.png
    PMCApp.Change EEG LFF Setting        0.16
    sleep     3s
    Common.compare the images    eeg-lff-2.png

Test EEG HFF Setting
    PMCApp.Change EEG HFF Setting        1
    sleep     3s
    Common.compare the images    eeg-hff-1.png
    PMCApp.Change EEG HFF Setting        70
    sleep     3s
    Common.compare the images    eeg-hff-2.png

Test Notch Filter Setting
    PMCApp.Change Notch Filter Setting    OFF
    sleep     3s
    Common.compare the images    eeg-notch-1.png
    PMCApp.Change Notch Filter Setting    50Hz
    sleep     3s
    Common.compare the images    eeg-notch-2.png
    PMCApp.Change Notch Filter Setting    60Hz
    sleep    1s

Test Next and Previous Page
    EEGPage.Click on Right Page Button
    sleep    1s
    EEGPage.Click on Left Page Button
    sleep    1s

Test Split Screen
    EEGPage.Click on Split Screen Button
    sleep    1s
    EEGPage.Verify Trends Subview Displays
    EEGPage.Click on Split Screen Button
    sleep    1s
    run keyword and warn on failure    EEGPage.Verify Trends Subview Displays

Test Video Modal Appearance
    EEGPage.Open Video Modal
    EEGPage.Close Video Modal

