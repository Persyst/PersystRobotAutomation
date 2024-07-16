*** Settings ***
Documentation    This test is going to test User Shared Settings
Resource         ../../Resources/PO/Web/Common.robot
Resource         ../../Resources/PO/Web/PersystWebApp.robot
Resource         ../../Resources/PO/Web/Pages/TrendsPage.robot
Resource         ../../Resources/PO/Web/Pages/Base.robot
Suite Setup      Run Keywords       Begin Web Suit
Suite Teardown   Run Keywords       End Web Suit

*** Variables ***
${Patient_Name}                  LnP14D3Nw10ICU
${First_Patient_Canvas}          xpath=/html/body/app-root/div[1]/app-patient-views/div[1]/div[2]/div/mdl-tabs/mdl-tab-panel[2]/app-patient-monitoring/div/div/mdl-list/mdl-list-item[1]/div/div[2]/div[1]/div/div/div[2]/app-patient-monitoring-page/div/canvas
${Slide_First_Patient}           xpath=//div[text()='Pilling, Willa (4 hours)']/../following-sibling::div/app-patient-monitoring-page

*** Test Cases ***
#Test Patient View Event Density
#    Search For Petient Name in Patient View Page            LnP14D3Nw10ICU
#    @{Comments_Values}          PersystWebApp.Get Comment Data From Records Event Density
#    @{Expected_Comments_Data}    create list    a        b           c
#    lists should be equal       ${Comments_Values}         ${Expected_Comments_Data}

Test Patient Record Info
    PersystWebApp.Navigate to Patient View By URL And Search For Patient Name           ${Patient_Name}
    ${Info}     PersystWebApp.Get Patient Record Info From Patient View Info Button
    should contain      ${Info}         LnP14D3Nw10ICU, FnLnP14D3Nw10ICU

Test Monitoring Records
    PatientView.Navigate to Patient View By URL
    PatientView.Click on Monitoring tab
    ${Patient_Name}     PatientView.Get 'First Patient' Name in Monitoring Page
    ${Monitoring_Patient_Canvas}        set variable    //div[text()='${Patient_Name}']/../following-sibling::div/app-patient-monitoring-page/div/canvas
    page should contain element        xpath=${Monitoring_Patient_Canvas}            50s

Test Units in Monitoring Tab
    ${Patient_Name}     PatientView.Get 'First Patient' Name in Monitoring Page
    ${Monitoring_Patient_Canvas}        set variable    //div[text()=' ${Patient_Name} ']/../following-sibling::div/app-patient-monitoring-page/div/canvas
    PersystWebApp.Assign First Patient Name to A Unit In Shared Settings           Moji Unit        it's a unit
    PersystWebApp.Navigate From Setting to Patient View
    PatientView.Click on Monitoring tab
    sleep       3s
    PersystWebApp.Mminimize and Maximize Unit In Patient View                      Moji Unit        Monitoring
    wait until page does not contain element                xpath=${Monitoring_Patient_Canvas}            50s
    PersystWebApp.Mminimize and Maximize Unit In Patient View                      Moji Unit        Monitoring
    wait until page contains element                        xpath=${Monitoring_Patient_Canvas}            50s
    PersystWebApp.Delete Previously Created Units From Shared Settings
    PersystWebApp.Navigate Back to Main Setting Menu From Setting Pages

Test Navigating to Trend by Clicking on Patients In Monitoring
     PatientView.Navigate to Patient View By URL
     Wait And Click Element    xpath=/html/body/app-root/div[1]/app-patient-views/div[1]/div[2]/div/mdl-tabs/mdl-tab-panel[2]/app-patient-monitoring/div/div/mdl-list/mdl-list-item/div/div/div[1]/div/div/div[1]/div[2]
     TrendsPage.Verify Trends Page Loads Successfully
     PersystWebApp.Navigate to Patient View Using Keyboard Shortcut

Test Slide Show Records
     PatientView.Navigate to Patient View By URL
     PatientView.Navigate to Slide Show Tab
     scroll element into view    ${Slide_First_Patient}
     click element               ${Slide_First_Patient}
     TrendsPage.Verify Trends Page Loads Successfully
     ${Patient_Name}        TrendsPage.Get Patient Name
     should contain    ${Patient_Name}      Pilling, Willa
     PersystWebApp.Navigate to Patient View Using Keyboard Shortcut



