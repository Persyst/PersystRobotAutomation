*** Settings ***
Documentation    This test is going to test EEG Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Suite Setup      Run Keywords   Begin Web Suit    AND    Reset EEG Setting
Suite Teardown   Run Keywords   Reset EEG Setting   AND    End Web Suit

*** Variables ***
<<<<<<< HEAD
${PATIENT_ID}       2980

*** Test Cases ***
Verify Display Font Size Functionality
    PersystWebApp.Change EEG Page Font Size     3
    sleep   1s
    PersystWebApp.Change EEG Page Font Size     1
    sleep   1s
=======

*** Test Cases ***
Verify Display Font Size Functionality
    [Tags]    testrun
    PersystWebApp.Change EEG Page Font Size     8
    Common.compare the images    eeg-font-size-1.png
    PersystWebApp.Change EEG Page Font Size     2
    Common.compare the images    eeg-font-size-2.png
>>>>>>> parent of d558983 (all)

Verify EEG Channel Per Page Functionality
    [Tags]    testrun
    PersystWebApp.Change EEG Channel Per Page Setting       6
<<<<<<< HEAD
    sleep   1s
    PersystWebApp.Change EEG Channel Per Page Setting       32
    sleep    1s
    PersystWebApp.Change EEG Channel Per Page Setting       All

Test EEG Califbration Functionality
    persystwebapp.change eeg calibration status     OFF
    sleep    1s
    persystwebapp.change eeg calibration status     ON
    sleep    1s

Test EEG Major Grid Functionality
    PersystWebApp.Change EEG Major Grid Status    OFF
    sleep    1s
    PersystWebApp.Change EEG Major Grid Status    ON
    sleep    1s

Test EEG Minor Grid Functionality
    PersystWebApp.Change EEG Minor Grid Status    OFF
    sleep    1s
    PersystWebApp.Change EEG Minor Grid Status    ON
    sleep    1s

Test EEG Comment Line Status
    PersystWebApp.Change EEG Comment Line Status    OFF
    sleep    1s
        PersystWebApp.Change EEG Comment Line Status    ON
    sleep    1s

Test EEG Comment Show Status
    PersystWebApp.Change EEG Comment Show Status    OFF
    sleep    1s
    PersystWebApp.Change EEG Comment Show Status    ON
    sleep    1s
=======
    Common.compare the images    eeg-channel-1.png
    PersystWebApp.Change EEG Channel Per Page Setting       16
    Common.compare the images    eeg-channel-2.png
    PersystWebApp.Change EEG Channel Per Page Setting       All
    Common.compare the images    eeg-channel-3.png

Test EEG Califbration Functionality
    persystwebapp.change eeg calibration status     OFF
    Common.compare the images    eeg-calibration-1.png
    persystwebapp.change eeg calibration status     ON
    Common.compare the images    eeg-calibration-2.png

Test EEG Major Grid Functionality
    PersystWebApp.Change EEG Major Grid Status    OFF
    Common.compare the images    eeg-major-grid-1.png
    PersystWebApp.Change EEG Major Grid Status    ON
    Common.compare the images    eeg-major-grid-2.png

Test EEG Minor Grid Functionality
    PersystWebApp.Change EEG Minor Grid Status    OFF
    Common.compare the images    eeg-minorr-grid-1.png
    PersystWebApp.Change EEG Minor Grid Status    ON
    Common.compare the images    eeg-minor-grid-2.png

Test EEG Comment Line Status
    PersystWebApp.Change EEG Comment Line Status    OFF
    Common.compare the images    eeg-comment-line-1.png
    PersystWebApp.Change EEG Comment Line Status    ON
    Common.compare the images    eeg-comment-line-2.png

Test EEG Comment Show Status
    PersystWebApp.Change EEG Comment Show Status    OFF
    Common.compare the images    eeg-comment-show-1.png
    PersystWebApp.Change EEG Comment Show Status    ON
    Common.compare the images    eeg-comment-show-2.png
>>>>>>> parent of d558983 (all)

Test EEG Pen Restriction Switch
    PersystWebApp.Change EEG Restricted Pen Status    ON
    sleep    1s
    PersystWebApp.Change EEG Restricted Pen Status    OFF
    sleep    1s

Test EEG Montage Setting
    PersystWebApp.Change EEG Montage Setting    ACNSNeoBP2
<<<<<<< HEAD
    sleep    1s
    PersystWebApp.Change EEG Montage Setting    Bipolar longitudinal A
    sleep    1s

Test EEG Page Duration Setting
    PersystWebApp.Change EEG Page Duration Time     20
    sleep    1s
    PersystWebApp.Change EEG Page Duration Time     10
    sleep    1s

Test EEG Sensitivity Setting
    PersystWebApp.Change EEG Sensitivity Option     30
    sleep    1s
    PersystWebApp.Change EEG Sensitivity Option     7
    sleep    1s

Test EEG Artifact Reduction
    PersystWebApp.Change EEG Artifact Reduction Status    ON
    sleep    1s
    PersystWebApp.Change EEG Artifact Reduction Status    OFF
    sleep    1s

Test EEG LFF Setting
    PersystWebApp.Change EEG LFF Setting        0.533
    sleep    1s
    PersystWebApp.Change EEG LFF Setting        0.16
    sleep    1s

Test EEG HFF Setting
    PersystWebApp.Change EEG HFF Setting        1
    sleep    1s
    PersystWebApp.Change EEG HFF Setting        70
    sleep    1s

Test Notch Filter Setting
    PersystWebApp.Change Notch Filter Setting    OFF
    sleep    1s
    PersystWebApp.Change Notch Filter Setting    50Hz
    sleep    1s
    PersystWebApp.Change Notch Filter Setting    60Hz
    sleep    1s
=======
    Common.compare the images    eeg-montage-1.png
    PersystWebApp.Change EEG Montage Setting    Bipolar longitudinal A
    Common.compare the images    eeg-montage-2.png

Test EEG Page Duration Setting
    PersystWebApp.Change EEG Page Duration Time     20
    Common.compare the images    eeg-duration-1.png
    PersystWebApp.Change EEG Page Duration Time     10
    Common.compare the images    eeg-duration-2.png

Test EEG Sensitivity Setting
    PersystWebApp.Change EEG Sensitivity Option     30
    Common.compare the images    eeg-sensitivity-1.png
    PersystWebApp.Change EEG Sensitivity Option     7
    Common.compare the images    eeg-sensitivity-2.png

Test EEG Artifact Reduction
    PersystWebApp.Change EEG Artifact Reduction Status    ON
    Common.compare the images    eeg-ar-1.png
    PersystWebApp.Change EEG Artifact Reduction Status    OFF
    Common.compare the images    eeg-ar-2.png

Test EEG LFF Setting
    PersystWebApp.Change EEG LFF Setting        0.533
    Common.compare the images    eeg-lff-1.png
    PersystWebApp.Change EEG LFF Setting        0.16
    Common.compare the images    eeg-lff-2.png

Test EEG HFF Setting
    PersystWebApp.Change EEG HFF Setting        1
    Common.compare the images    eeg-hff-1.png
    PersystWebApp.Change EEG HFF Setting        70
    Common.compare the images    eeg-hff-2.png

Test Notch Filter Setting
    PersystWebApp.Change Notch Filter Setting    OFF
    Common.compare the images    eeg-notch-1.png
    PersystWebApp.Change Notch Filter Setting    50Hz
    Common.compare the images    eeg-notch-2.png
    PersystWebApp.Change Notch Filter Setting    60Hz
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
    [Tags]    testrun
    EEGPage.Open Video Modal
    EEGPage.Close Video Modal

>>>>>>> parent of d558983 (all)
