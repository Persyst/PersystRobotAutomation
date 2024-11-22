*** Settings ***
Resource            ../../../../Resources/PO/PMC/Common.robot
Resource            ../../../../Resources/PO/PMC/PMCApp.robot
Resource            ../Info.robot
Suite Setup          Run Keywords     Begin Web Suit With No Login      AND     Login to PMC Production and Login   ${USERS}[21]     ${PASSWORD}
Suite Teardown        End Web Suit

*** Variables ***

*** Test Cases ***
User should be able to go though 5 EEG Pages
    Find The Record And Navigate to EEG        ${Test1_Record_Name}
    sleep    3s
    EEGPage.Click on Right Page Button
    sleep    3s
#    Common.compare the images                   AES_EEG_Page1.png
    EEGPage.Click on Right Page Button
    sleep    3s
#    Common.compare the images                   AES_EEG_Page2.png
    EEGPage.Click on Right Page Button
    sleep    3s
#    Common.compare the images                   AES_EEG_Page3.png
    EEGPage.Click on Right Page Button
    sleep    3s
#    Common.compare the images                   AES_EEG_Page4.png
    EEGPage.Click on Right Page Button
    sleep    3s
#    Common.compare the images                   AES_EEG_Page5.png

Test Default Organization and Patient Montage
    Find The Record And Navigate to EEG        ${Test1_Record_Name}
    PMCApp.Change EEG Montage Setting           Bipolar longitudinal A (Patient)
    sleep     3s
#    Common.compare the images                   AES_EEG_patient_montage.png
    PMCApp.Change EEG Montage Setting           Bipolar LRLRTemp-Central (Organization)
    sleep     3s
#    Common.compare the images                   AES_EEG_Org_montage.png

Test EEG Annotations
    Find The Record And Navigate to EEG         ${Test2_Record_Name}
    PMCApp.Change EEG Montage Setting           Bipolar longitudinal A
    EEGPage.Click the EEG Page Setting Button
    sleep     3s
#    Common.compare the images                   AES_EEG_Anotation_1.png
    press keys    None      SPACE
    sleep     3s
#    Common.compare the images                   AES_EEG_Anotation_2.png
    press keys    None      SPACE
    sleep     3s
#    Common.compare the images                   AES_EEG_Anotation_3.png

#Test Annotations Scenes
#    Find The Record And Navigate to EEG         ${Test2_Record_Name}
#    Select Comment/Scene/Seizure In EEG Comment Box      Scene 2
#    sleep    3s
#    press keys    None      SPACE
#    press keys    None      SPACE
#    Common.compare the images                   AES_Scene2_Anotation_1.png
#    Select Comment/Scene/Seizure In EEG Comment Box      Scene 3
#    PMCApp.Change EEG Montage Setting           BP-Longitudinal
#    press keys    None      SPACE
#    press keys    None      SPACE
#    Common.compare the images                   AES_Scene3_Anotation_1.png
#    PMCApp.Change EEG Montage Setting           Bipolar longitudinal A
#    press keys    None      SPACE
#    press keys    None      SPACE
#    Common.compare the images                   AES_Scene3_Anotation_2.png

