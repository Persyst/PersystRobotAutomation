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

Get Montage Definitions
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/EEG/MontageDefinitions
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    log     ${Response.json()}
#    dump json to file    Tests/Web/API-Tests/Montage_Dedinitions.json         ${Response.json()}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Montage_Definitions.json
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}[0]     ${Response.json()}[0]

Get EEG Video Frame
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/VideoFrame?time=180.02556237218815&width=291.953125&height=245.9375
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
#    dump json to file    Tests/Web/API-Tests/EEG_Video_Frame.json        ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/EEG_Video_Frame.json
    should be equal          ${Response.text}         ${Expected_Json}

Add a New Montage Definition(PUT)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/EEG/MontageDefinitions/User/Moji-Montage
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/New_Montage_Definition.json
    ${Response}=    PUT     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=200
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Delete Created New Montage Definition(DELETE)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/EEG/MontageDefinitions/User/Moji-Montage
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/New_Montage_Definition.json
    ${Response}=    DELETE     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=204
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=500

Get User Documents
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Documents
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    dump json to file    Tests/Web/API-Tests/User_Document.json       ${Response.text}
    ${Expected_Json}=        load json from file    Tests/Web/API-Tests/User_Document.json
    should be equal          ${Response.text}         ${Expected_Json}

Get User's Specific Document
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Documents/test2.CSV
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
#    dump json to file    Tests/Web/API-Tests/User_Specific_Document.json       ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/User_Specific_Document.json
    should be equal         ${Expected_Json}    ${Response.text}

Upload a Document
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Documents/Sample_Data.txt?Overwrite=False
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${File_Path}    set variable    Tests/Web/API-Tests/Sample_Data.txt
    ${File}     create dictionary    file=${File_Path}
    ${Response}=    POST         ${URL}     files=${File}    headers=${With_Bearer_token_header}      expected_status=204

Delete User's Specific Document
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Documents/Sample_Data.txt
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Response}=    DELETE         ${URL}      headers=${With_Bearer_token_header}      expected_status=204
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=404
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/User_Document.json

Add a New Montage Definition Under System Group(PUT)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/EEG/MontageDefinitions/System/Moji-Montage
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/New_Montage_Definition.json
    ${Response}=    PUT     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=200
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Update Newly Created Montage Under System Group(PUT)
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/EEG/MontageDefinitions/System/Moji-Montage
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/New_Montage_Update.json
    ${Response}=    PUT     ${URL}    json=${Expected_Json}   headers=${With_Bearer_token_header}      expected_status=200
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/EEG/MontageDefinitions/System/Moji-Montage-Updated
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Delete Created New Montage Under System(DELETE)
    [Documentation]    Updating the montage doesn't actually rename the montage, so we need to use original montage name to delete
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/EEG/MontageDefinitions/System/Moji-Montage
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=200
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/New_Montage_Update.json
    ${Response}=    DELETE      ${URL}     headers=${With_Bearer_token_header}      expected_status=204
    ${Response}=    GET         ${URL}      headers=${With_Bearer_token_header}      expected_status=404

Get List Of Patient's Spikes
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/Spikes
    ${Response}=    GET         ${URL}        headers=${With_Bearer_token_header}      expected_status=200
#    dump json to file    Tests/Web/API-Tests/list_of_spikes.json       ${Response.json()}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/list_of_spikes.json
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}[0]     ${Response.json()}[0]

Get Spike Voltage Image
    [Tags]    testrun
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/VoltageMap?Sensitivity=7&Notch=60%20Hz&HFF=70%20Hz&LFF=0.16Hz&AR=false
    ${Request_Payload}     load json from file    Tests/Web/API-Tests/Spike_VoltageMap_payload.json
    ${Response}=    PUT         ${URL}    json=${Request_Payload}        headers=${With_Bearer_token_header}      expected_status=200
#    dump json to file    Tests/Web/API-Tests/Patient_Spike_VoltageMap.json      ${Response.text}
    log     ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Patient_Spike_VoltageMap.json
    should be equal         ${Expected_Json}    ${Response.text}

Get Spike Image
    [Tags]    testrun
    ${With_Bearer_token_header}    Create Dictionary     Content-Type=application/json    Authorization=Bearer+ ${Bearer_token}
    ${URL}=     set variable    http://10.193.0.106/PersystAPI/Patients/225/SpikeImage/Bipolar%20longitudinal%20A?MontageGroup=System&Duration=1&Sensitivity=7&TimeFormat=0&DateFormat=2&Decimal=0&Notch=60%20Hz&HFF=70%20Hz&LFF=0.16Hz&AR=false&PointsX=95&PointsY=427&ShowComments=False&ShowTimes=False&ShowCommentLines=False&MinorGrid=False&MajorGrid=False
    ${Request_Payload}     load json from file    Tests/Web/API-Tests/SpikeImage_PayloadRequest.json
    ${Response}=    PUT         ${URL}    json=${Request_Payload}        headers=${With_Bearer_token_header}      expected_status=200
#    dump json to file    Tests/Web/API-Tests/Returned_SpikeImage.json      ${Response.text}
    ${Expected_Json}=   load json from file    Tests/Web/API-Tests/Returned_SpikeImage.json
    should be equal         ${Expected_Json}    ${Response.text}