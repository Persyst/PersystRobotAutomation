*** Settings ***
Library             Collections
Library             RequestsLibrary
Resource            ../../../Resources/PO/Web/Pages/Base.robot
Library             JSONLibrary
Library             JsonValidator

*** Variables ***
${Base_URL}=    http://10.193.0.106/PersystAPI
${Expected_Jsons}       Tests/Web/API-Tests

*** Test Cases ***
Get Bearer Token
    [Tags]    testrun
    ${headers}    Create Dictionary     Content-Type=application/json    Authorization=Basic bW9qZ2FuOm1vamdhbg==
    ${Response}=    GET    ${Base_URL}/Token          headers=${headers}
    set global variable     ${Bearer_token}          ${Response.text}

Get User Account
    &{Mojgan_Account_Info}     create dictionary        Username=mojgan     Admin=True     AppendReaderNameInComments=False    AllowSavingSettings=True    AllowCommenting=True    PushNotificationURL=https://apn.data.persyst.com/APN
    &{With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET    ${Base_URL}/User         headers=${With_Bearer_token_header}
    Base.Verify smaller dictionary in bigger dictionary    ${Mojgan_Account_Info}    ${Response.json()}

Get List Of Patients
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${Base_URL}/Patients        headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
#    dump json to file       Tests/Web/API-Tests/List_Of_Patients.json       ${Response.json()}
    ${Expected_Json}=   Base.Read expected JSON Directly    Tests/Web/API-Tests/List_Of_Patients.json
    log     ${Expected_Json}
    Verify smaller dictionary in bigger dictionary      ${Expected_Json}[0]     ${Response.json()}[0]

Get Last Update Status
    &{Update_Info}          create dictionary           timeLastChecked=17089     intervalSinceLastChecked=1.0000002384185791
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${Base_URL}/patients/Updatestatus        headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
    validate json by schema    ${Response.json()}       ${Update_Info}

Get Specific Patient's Montage
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${Base_URL}/Patients/225/MontageDefinitions     headers=${With_Bearer_token_header}      expected_status=200
#    dump json to file           Tests/Web/API-Tests/Patient_Montage.json        ${Response.json()}
    ${Expected_Json}=    Read expected JSON    Tests/Web/API-Tests/Patient_Montage.json
    log    ${Response.json()}
    log     ${Expected_Json}[0]
    Compare Dictionaries And Report Key Differences      ${Response.json()}[0]        ${Expected_Json}[0]

Get EEG Panels Image
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    ${Base_URL}/Patients/225/Panels/Comprehensive/Labels?PointsX=21.078125&PointsY=601&FontScale=2&PixelsPerPoint=1
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
#    dump json to file           Tests/Web/API-Tests/Patient_EEG_Panel_Image.json        ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_EEG_Panel_Image.json
    should be equal    ${Response.text}             ${Expected_Json}

Get EEG Panels Image With Bad UserID
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    ${Base_URL}/Patients/45888/Panels/Comprehensive/Labels?PointsX=21.078125&PointsY=601&FontScale=2&PixelsPerPoint=1
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=404
    should contain      ${Response.reason}        Not Found

Get EEG Image
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/EEG/Bipolar%20longitudinal%20A?Start=90&MontageGroup=System&Duration=10&Sensitivity=7&TimeFormat=0&DateFormat=2&Decimal0&Notch=60%20Hz&HFF=70%20Hz&LFF=0.16Hz&AR=true&PointsX=667&PointsY=587&PixelsPerPoint=1&FontScale=2.2&ShowComments=true&ShowCommentLines=false&MinorGrid=true&MajorGrid=true&RestrictPenDeflection=false&Randomizer=447&CacheRandomizer=1709064833660
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
#    dump json to file           Tests/Web/API-Tests/Patient_EEG_Image.json        ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_EEG_Image.json
    should be equal    ${Response.text}             ${Expected_Json}

Get EEG Image 2(delete after test)
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    ${Base_URL}/Patients/225/EEG/Referential%20(Cz)%20Longitudinal/Montage?MontageGroup=System&ShowComments=true&ShowTimes=true&PointsY=707&FontScale=2.9&PixelsPerPoint=1
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}

Get EEG Image With Bad UserID
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    ${Base_URL}/Patients/45888/EEG/Bipolar%20longitudinal%20A?Start=90&MontageGroup=System&Duration=10&Sensitivity=7&TimeFormat=0&DateFormat=2&Decimal0&Notch=60%20Hz&HFF=70%20Hz&LFF=0.16Hz&AR=true&PointsX=667&PointsY=587&PixelsPerPoint=1&FontScale=2.2&ShowComments=true&ShowCommentLines=false&MinorGrid=true&MajorGrid=true&RestrictPenDeflection=false&Randomizer=447&CacheRandomizer=1709064833660
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=404
    should contain      ${Response.reason}        Not Found

Get Specific Patient Info
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${Base_URL}/Patients/225     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
#    dump json to file           Tests/Web/API-Tests/Patient_225_info.json        ${Response.json()}
    ${Expected_Json}=       Read expected JSON Directly    Tests/Web/API-Tests/Patient_225_info.json
    Verify smaller dictionary in bigger dictionary      ${Expected_Json}        ${Response.json()}

Get Specific Patient Info With Bad Patient ID
    [Tags]    testrun
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${Base_URL}/Patients/679978     headers=${With_Bearer_token_header}      expected_status=404
    should contain      ${Response.reason}        Not Found

Get Specifict Patients Panel List
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${Base_URL}/Patients/225/Panels     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
#   dump json to file           Tests/Web/API-Tests/Patient_Panels.json        ${Response.json()}
    ${Expected_Json}=       Read expected JSON Directly    Tests/Web/API-Tests/Patient_Panels.json
    should be equal    ${Response.json()}               ${Expected_Json}

Get Specific Patient Panel Labels Image
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Panels/Comprehensive/Labels?PointsX=25.109375&PointsY=601&FontScale=2&PixelsPerPoint=1
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
#    dump json to file           Tests/Web/API-Tests/Patient_Panel_Label_Image.json        ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_Panel_Label_Image.json
    should be equal    ${Response.text}               ${Expected_Json}

Get Specific Patient Panel Labels Image With Wrong Panel Name
    [Documentation]    Expecting 404 to not found the Image for this unknown Panel Name
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Panels/Asymmetry2/Labels?PointsX=25.109375&PointsY=601&FontScale=2&PixelsPerPoint=1
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=404
    should contain    ${Response.reason}        Not Found

Get Specific Patient Panel Title Image
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Panels/Comprehensive/Titles?PointsX=567.40625&PointsY=601&FontScale=2&PixelsPerPoint=1
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
#    dump json to file    Tests/Web/API-Tests/Patient_Panel_Title_Image.json         ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_Panel_Title_Image.json
    should be equal    ${Response.text}         ${Expected_Json}

Get Specific Patient Panel Title Image With Wrong Record/Patient
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/6799/Panels/Comprehensive/Titles?PointsX=567.40625&PointsY=601&FontScale=2&PixelsPerPoint=1
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=404
    should contain    ${Response.reason}        Not Found

Get Specific Patient Panel Title Image With Wrong Panel Name
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/679/Panels/Asymmetry2/Titles?PointsX=567.40625&PointsY=601&FontScale=2&PixelsPerPoint=1
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=404
    should contain    ${Response.reason}        Not Found

Get Spedific Patient Trends Image
    [Tags]      testrun
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Trends?Panel=Peak%20Envelope&Start=86400&Duration=14400&AR=true&Pointsx=989&Pointsy=803.125&FontScale=2&TimeFormat=0&DateFormat=2&Decimal0&PixelsPerPoint=1&Randomizer=254&CacheRandomizer=1719001769651
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
    dump json to file    Tests/Web/API-Tests/Patient_Trends_Image.json         ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_Trends_Image.json
    should be equal    ${Response.text}         ${Expected_Json}

Get Spedific Patient Trends Image Without Optional All Params
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Trends?Panel=Peak%20Envelope&Start=43200
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.text}
    should contain      ${Response.text}            PNG

Get Spedific Patient Trends Image With Bad PatientID
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/2255/Trends?Panel=Peak%20Envelope&Start=43200
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}     headers=${With_Bearer_token_header}      expected_status=404
    should be equal      ${Response.reason}            Not Found

Get Patient Comments Including Spikes Without Start/End Time
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Comments?&IncludeSpikes=True
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
#    dump json to file    Tests/Web/API-Tests/Patient_Comments_Include_Spikes.json         ${Response.json()}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_Comments_Include_Spikes.json
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}[0]     ${Response.json()}[0]

Get Patient Comments Including Spikes With Start/End Time
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Comments?StartTime=0&EndTime=228775.46875200002&IncludeSpikes=True
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
#    dump json to file    Tests/Web/API-Tests/Patient_Comment_Include_Spike_With_Time.json         ${Response.json()}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_Comment_Include_Spike_With_Time.json
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}[0]     ${Response.json()}[0]

Get Patient Comments Excluding Spikes With Start/End Time
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Comments?StartTime=0&EndTime=228775.46875200002
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
#    dump json to file    Tests/Web/API-Tests/Patient_Comment_Exclude_Spike_With_Time.json         ${Response.json()}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_Comment_Exclude_Spike_With_Time.json
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}[0]     ${Response.json()}[0]

Get Patient Comments With Wrong PatientID
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/2255/Comments?&IncludeSpikes=True
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=404
    should be equal      ${Response.reason}            Not Found

Get Patient Comments Excluding Spikes With Start/End Time With Filter
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Comments?StartTime=0&EndTime=228775.46875200002&Filter=Alex
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}

Add a Comment For Patient
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Comments
    &{Comment}=     create dictionary    time=7272.670589610693     duration=0   text=API Test Comment@PersystTrends
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    POST      ${URL}       json=${Comment}       headers=${With_Bearer_token_header}      expected_status=204
    log     ${Response.text}

Update The Added Comment with Wrong UserID
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/6799/Comments/7272.67059/API%20Test%20Comment%40PersystTrends
    &{Comment}=     create dictionary    color=0    creationTime=      duration=0     id=     isDeletable=true    isEditable=true     isSeizure=false     isSpike=false   modificationTime=    priority=1      text="API Test Comment Updated@PersystTrends"       time=11757.088728363091
    ${Comment_json}=   load json from file    Tests/Web/API-Tests/Comment_update.json
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    PUT      ${URL}       json=${Comment_json}       headers=${With_Bearer_token_header}      expected_status=404
    should be equal      ${Response.reason}            Not Found

Update The Added Comment
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Comments/7272.67059/API%20Test%20Comment%40PersystTrends
    &{Comment}=     create dictionary    color=0    creationTime=      duration=0     id=     isDeletable=true    isEditable=true     isSeizure=false     isSpike=false   modificationTime=    priority=1      text="API Test Comment Updated@PersystTrends"       time=11757.088728363091
    ${Comment_json}=   load json from file    Tests/Web/API-Tests/Comment_update.json
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    PUT      ${URL}       json=${Comment_json}       headers=${With_Bearer_token_header}      expected_status=204
    log     ${Response.text}

Delete the Added Comment With Wrong PatientID
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/6799/Comments/7267.248507/API%20Test%20Comment%20Updated%40PersystTrends
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    DELETE      ${URL}       headers=${With_Bearer_token_header}      expected_status=404
    should be equal      ${Response.reason}            Not Found

Get List Of Videos
        ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/video?
    ${Video}=    create dictionary
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log    ${Response.text}
    ${Expected_Video} =        set variable    '#EXTM3U\n\n#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=558122,RESOLUTION=320x240,CODECS="avc1.4d401e,mp4a.40.5"\nVideo?width=320&height=240\n'
    should be equal    ${Expected_Video}       '${Response.text}'

Delete the Added Comment
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Comments?&IncludeSpikes=True
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
    ${URL}=     set variable   http://10.193.0.106/PersystAPI/Patients/225/Comments/7268.523654/API%20Test%20Comment%20Updated%40PersystTrends
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    DELETE      ${URL}       headers=${With_Bearer_token_header}      expected_status=204
    log     ${Response.text}

Get List of Server Versions
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/ServerVersion?WebClientVersion=2.1.2(15)
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
#    dump json to file    Tests/Web/API-Tests/Server_Versions.json         ${Response.json()}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Server_Versions.json
    jsonlibrary.validate json by schema             ${Expected_Json}     ${Response.json()}

Get Data Settings
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Data/Settings
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
    validate json by schema file    ${Response.json()}          Tests/Web/API-Tests/Settings_Data.json

Create New Data File Using Data(POST)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Data/PostTest
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Settings_Data.json
    ${Response}=    POST     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=204
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Update Created New File Using Data(PUT)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Data/PostTest
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/New_Data_File_Update.json
    ${Response}=    PUT     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=204
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Delete New Data File Using Data(DELETE)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Data/PostTest
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    DELETE     ${URL}       headers=${With_Bearer_token_header}      expected_status=204

Get Unit Definition Shared Data
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/SharedData/UnitDefinitions
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    should be equal    ${Response.text}       []

Create New Data File Using SharedData(POST)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/SharedData/PostTest
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Settings_Data.json
    ${Response}=    POST     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=204
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Update Created New File Using SharedData(PUT)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/SharedData/PostTest
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/New_Data_File_Update.json
    ${Response}=    PUT     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=204
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Delete New Data File Using SharedData(DELETE)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/SharedData/PostTest
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    DELETE     ${URL}       headers=${With_Bearer_token_header}      expected_status=204

Get Servers Password Requirements
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/PasswordRequirements
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Password_Requirements.json
    should be equal     ${Response.json()}      ${Expected_Json}

Change User's Password
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Users/mojgan
    &{New_Password}     create dictionary    password=mojganm     oldPassword=mojgan
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    PUT         ${URL}     json=${New_Password}    headers=${With_Bearer_token_header}      expected_status=200
    set global variable     ${Bearer_token}          ${Response.text}
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    &{New_Password}     create dictionary    password=mojgan     oldPassword=mojganm
    ${Response}=    PUT         ${URL}     json=${New_Password}    headers=${With_Bearer_token_header}      expected_status=200

