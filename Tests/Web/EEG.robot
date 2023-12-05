*** Settings ***
Documentation    This test is going to test EEG Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Suite Setup      Run Keywords   Begin Web Suit    AND    Reset EEG Setting
Suite Teardown   Run Keywords   Reset EEG Setting   AND    End Web Suit

*** Variables ***
${PATIENT_ID}       2980

*** Test Cases ***
Verify Display Font Size Functionality
    PersystWebApp.Change EEG Page Font Size     3
    sleep   1s
    PersystWebApp.Change EEG Page Font Size     1
    sleep   1s

Verify EEG Channel Per Page Functionality
    PersystWebApp.Change EEG Channel Per Page Setting       6
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

Test EEG Pen Restriction Switch
    PersystWebApp.Change EEG Restricted Pen Status    ON
    sleep    1s
    PersystWebApp.Change EEG Restricted Pen Status    OFF
    sleep    1s

Test EEG Montage Setting
    PersystWebApp.Change EEG Montage Setting    ACNSNeoBP2
    sleep    1s
    PersystWebApp.Change EEG Montage Setting    Bipolar-longA
    sleep    1s

Test EEG Page Duration Setting
    PersystWebApp.Change EEG Page Duration Time     20Seconds
    sleep    1s
    PersystWebApp.Change EEG Page Duration Time     10Seconds
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
    PersystWebApp.Change EEG HFF Setting        1Hz
    sleep    1s
    PersystWebApp.Change EEG HFF Setting        70Hz
    sleep    1s

Test Notch Filter Setting
    PersystWebApp.Change Notch Filter Setting    OFF
    sleep    1s
    PersystWebApp.Change Notch Filter Setting    50Hz
    sleep    1s
    PersystWebApp.Change Notch Filter Setting    60Hz
    sleep    1s
