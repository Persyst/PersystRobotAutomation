*** Settings ***
Library         Collections
Library         RequestsLibrary
Resource        ../../../Resources/PO/PMC/Pages/Base.robot
Library         JSONLibrary
Library         JsonValidator

*** Variables ***
${BaseURL}       https://apitest.pmc.ninja

#   Command lines to run the tests:
# ==> To run all the tests ===>   robot -d results --exclude skip Tests/PMC/api_tests/PMC_API_Tests.robot
# ==> To run only with run tags ===>  robot -d results --exclude skip --include run Tests/PMC/api_tests/PMC_API_Tests.robot

*** Test Cases ***
Get the Token
    [Tags]      run
    &{headers}       create dictionary    Authorization=Basic N3U4bjZiMjlvcW1odW9qNnM3MHNwbmkwdms6MXBycDlpbXR1ZWEyZGRxcWMyMHA3NjM4MHA3MzIzOG03a25mMGJ2cG5hc3NpdWxwc2xkZw==      Content-Type=application/x-amz-json-1.1     X-Amz-Target=AWSCognitoIdentityProviderService.InitiateAuth
    ${Payload_Json}=        load json from file    Tests/PMC/API_Tests/Token_Jsons/Token_Json.json
    ${Response}=        POST        https://cognito-idp.us-west-2.amazonaws.com/    json=${Payload_Json}   headers=${headers}       expected_status=200
    log     ${Response.json()}
    &{Token_dict}        set to dictionary    ${Response.json()}[AuthenticationResult]
    ${Token}        set variable    ${Token_dict}[IdToken]
    log         ${Token}
    set global variable       &{headers}       Content-Type=application/json    Authorization=Bearer ${Token}


Login
    &{Login_Data}=      create dictionary         username=mojgan.dadashi@persyst.com     password=NpNl582.
    ${Response}=        POST        ${BaseURL}/login      json=${Login_Data}       headers=${headers}       expected_status=200

Get List of Organizations
    ${Organization_List}    set variable    	[{'organizationID': 25, 'organizationName': 'Organization 1', 'admin': True, 'roles': ['Owner', 'Users']}]
    ${Response}=        GET        ${BaseURL}/organizations      headers=${headers}       expected_status=200
    should be equal as strings    ${Response.json()}        ${Organization_List}

Get Organization Id
    ${Organization_25}      set variable    	{'organizationID': 25, 'organizationName': 'Organization 1', 'usage': {'storage': {'used': 2975763, 'max': 0}, 'maxDocFileSize': 0, 'maxDocsPerRecord': 0, 'pdfDocsOnly': True}}
    ${Response}=        GET        ${BaseURL}/organizations/25      headers=${headers}       expected_status=200
    should be equal as strings    ${Organization_25}            ${Response.json()}

Update Existing Organization(PUT)
    &{Update1_Org}=     create dictionary    organizationName=Organization 2
    ${Put_Response}=    PUT      ${BaseURL}/organizations/25       json=${Update1_Org}       headers=${headers}      expected_status=204
    ${Response}=        GET        ${BaseURL}/organizations/25      headers=${headers}       expected_status=200
    should be equal as strings  ${Response.json()}[organizationName]        Organization 2
    &{Update2_Org}=     create dictionary    organizationName=Organization 1
    ${Put_Response}=    PUT      ${BaseURL}/organizations/25       json=${Update2_Org}       headers=${headers}      expected_status=204

Add Directory(POST)
    ${Response}=        GET        ${BaseURL}/Organizations/25/Directories      headers=${headers}       expected_status=200
    dump json to file           Tests/PMC/API_Tests/List_Of_Directories_Before_Adding_Directory.json            ${Response.json()}
    ${Post_Json}=   load json from file    Tests/PMC/API_Tests/Add_Directory.json
    ${Response}=    POST      ${BaseURL}/Organizations/25/Directories      json=${Post_json}       headers=${headers}      expected_status=200
    log     ${Response.text}

Get List of Directories
    ${Response}=        GET        ${BaseURL}/Organizations/25/Directories      headers=${headers}       expected_status=200
    dump json to file           Tests/PMC/API_Tests/List_of_Directories.json        ${Response.json()}
    ${Directory_ID}=         Get Directory Id From JSON File      Tests/PMC/API_Tests/List_of_Directories.json     Added Directory
    log     ${Directory_ID}
    set global variable     ${New_Directory_ID}          ${Directory_ID}
    ${Expected_Json}        load json from file    Tests/PMC/API_Tests/List_of_Directories.json
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Rename a Directory(PUT)
    &{Renamed_Directory}=     create dictionary    parentDirectoryID=110    name=Renamed Directory
    ${Put_Response}=    PUT      ${BaseURL}/organizations/25/Directories/${New_Directory_ID}       json=${Renamed_Directory}       headers=${headers}      expected_status=200
    ${Response}=        GET        ${BaseURL}/organizations/25/Directories     headers=${headers}       expected_status=200
    ${Directory_Name}      set variable    ${Response.json()}[contents][0][name]
    should be equal as strings              ${Directory_Name}               Renamed Directory

Delete Newly Created Direvctory
    ${Response}=    Delete      ${BaseURL}/Organizations/25/Directories/${New_Directory_ID}     headers=${headers}      expected_status=204
    ${Response}=        GET        ${BaseURL}/Organizations/25/Directories      headers=${headers}       expected_status=200
    ${Expected_Json}    load json from file    Tests/PMC/API_Tests/List_Of_Directories_Before_Adding_Directory.json
    Verify smaller dictionary in bigger dictionary             ${Expected_Json}     ${Response.json()}

Add a Directory and Update Directory ParentID
    &{First_Directory}     create dictionary    parentDirectoryID=110    name=ParentIDTest
    ${Response}=    POST      ${BaseURL}/Organizations/25/Directories      json=${First_Directory}       headers=${headers}      expected_status=200
    ${Response}=        GET        ${BaseURL}/Organizations/25/Directories      headers=${headers}       expected_status=200
    ${Directory_ID}        set variable    ${Response.json()}[contents][0][directoryID]
    &{Second_Directory}     create dictionary    parentDirectoryID=${Directory_ID}      name=SecondParentIDTest
    ${Response}=    POST      ${BaseURL}/Organizations/25/Directories      json=${Second_Directory}       headers=${headers}      expected_status=200
    ${Response}=        GET        ${BaseURL}/Organizations/25/Directories      headers=${headers}       expected_status=200
    ${Second_Directory_Id}      set variable    ${Response.json()}[contents][0][contents][0][directoryID]
    &{Change_Parent_Directory}=     create dictionary    parentDirectoryID=110
    ${Put_Response}=    PUT      ${BaseURL}/organizations/25/Directories/${Second_Directory_Id}      json=${Change_Parent_Directory}       headers=${headers}      expected_status=200
    ${Response}=        GET        ${BaseURL}/Organizations/25/Directories      headers=${headers}       expected_status=200
    ${Second_Directory_Name}    set variable    ${Response.json()}[contents][1][name]
    should be equal as strings          ${Second_Directory_Name}        SecondParentIDTest
    Delete      ${BaseURL}/Organizations/25/Directories/${Directory_ID}     headers=${headers}      expected_status=204
    Delete      ${BaseURL}/Organizations/25/Directories/${Second_Directory_Id}     headers=${headers}      expected_status=204

Get Directory Lay File
    ${Response} =       GET    url=${BaseURL}/binaries/Organizations/25/Directories/110/LayFiles?dummy=dummy         headers=${headers}       expected_status=200
    Should Not Be Empty    $Response

Get Patient's Lay File
    ${Response} =       GET    url=${BaseURL}/Patients/581/lay          headers=${headers}       expected_status=200
#    dump json to file    Tests/PMC/API_Tests/Patient_Lay_file.json          ${Response.text}
    ${Expected_Json}=       load json from file     Tests/PMC/API_Tests/Patient_Lay_file.json
    should be equal     ${Expected_Json}            ${Response.text}

Post a New Lay File For Patient(POST)
    ${lay_content}    get file        Tests/PMC/API_Tests/LE_A01.lay
    ${body}=    set variable        ${lay_content}
    ${Response}=    POST        url=${BaseURL}/Patients/581/lay     data=${body}    headers=${headers}      expected_status=200

Get Patient's Details
    ${Response} =       GET      url=${BaseURL}/Patients/581          headers=${headers}       expected_status=200
#    dump json to file    Tests/PMC/API_Tests/Patient_Details.json         ${Response.json()}
    ${Expected_Json}=       load json from file     Tests/PMC/API_Tests/Patient_Details.json
    Compare Dictionaries And Report Key Differences     ${Expected_Json}            ${Response.json()}

Update Patient Lay File(PUT)
    ${lay_content}    get file        Tests/PMC/API_Tests/LE_A01.lay
    ${body}=    set variable        ${lay_content}
    ${Response}=    PUT         url=${BaseURL}/Patients/581/lay     data=${body}    headers=${headers}      expected_status=200

Update Patient's Details
    ${PUT_Json}=    load json from file    Tests/PMC/API_Tests/Update_Record_Name.json
    ${Response} =        PUT    url=${BaseURL}/Patients/581       json=${PUT_Json}     headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Patients/581          headers=${headers}       expected_status=200
#    dump json to file    Tests/PMC/API_Tests/Patient_Details.json         ${Response.json()}
    should be equal as strings     ${Response.json()}[recordName]       LE_A01_Renamed.lay
    ${PUT_Json}=    load json from file    Tests/PMC/API_Tests/Patient_Details.json
    ${Response} =        PUT    url=${BaseURL}/Patients/581       json=${PUT_Json}     headers=${headers}       expected_status=200

Post to Patient's Details
    [Tags]    skip
    ${File_Path}    set variable    Tests/PMC/API-Tests/LE_A01_APITest.lay
    ${File}     create dictionary    file=${File_Path}
    ${Response} =        POST    url=${BaseURL}/Patients/581       files=${File}     headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Patients/581          headers=${headers}       expected_status=200
#    dump json to file    Tests/PMC/API_Tests/Patient_Details.json         ${Response.json()}
    ${Expected_Json}=       load json from file     Tests/PMC/API_Tests/Update_Record_Name.json
    should be equal     ${Expected_Json}            ${Response.json()}

Move Patient's Record To Different Directory
    &{First_Directory}     create dictionary    parentDirectoryID=110    name=Added Directory
    ${Response}=        POST      ${BaseURL}/Organizations/25/Directories      json=${First_Directory}       headers=${headers}      expected_status=200
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Directories         headers=${headers}       expected_status=200
    ${Directory_ID}     set variable    ${Response.json()}[contents][0][directoryID]
    ${PUT_Json}         create dictionary       toDirectoryID=${Directory_ID}
    ${Response} =       PUT    url=${BaseURL}/Patients/581/move       json=${PUT_Json}     headers=${headers}       expected_status=204
    ${Response} =       GET    url=${BaseURL}/Patients/581          headers=${headers}       expected_status=200
    ${New_Parent_DirectoryID}       set variable    ${Response.json()}[dbData][DirectoryID]
    should be equal as strings      ${New_Parent_DirectoryID}           ${Directory_ID}
    ${PUT_Json}         create dictionary       toDirectoryID=110
    ${Response} =        PUT    url=${BaseURL}/Patients/581/move       json=${PUT_Json}     headers=${headers}       expected_status=204
    Delete      ${BaseURL}/Organizations/25/Directories/${Directory_ID}     headers=${headers}      expected_status=204

Copy Patient's Record To Different Directory
    &{First_Directory}     create dictionary    parentDirectoryID=110    name=Added Directory
    ${Response}=        POST      ${BaseURL}/Organizations/25/Directories      json=${First_Directory}       headers=${headers}      expected_status=200
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Directories         headers=${headers}       expected_status=200
    ${Directory_ID}     set variable    ${Response.json()}[contents][0][directoryID]
    ${PUT_Json}         create dictionary       toDirectoryID=${Directory_ID}
    ${Response} =       PUT    url=${BaseURL}/Patients/581/copy       json=${PUT_Json}     headers=${headers}       expected_status=200
    ${New_Patient_ID}       set variable        ${Response.json()}[patient][id]
    ${Response} =       GET    url=${BaseURL}/Patients/${New_Patient_ID}          headers=${headers}       expected_status=200
    should be equal as strings      ${Response.json()}[recordName]           LE_A01.lay
    Delete      ${BaseURL}/Organizations/25/Directories/${Directory_ID}     headers=${headers}      expected_status=204

Get Organization Roles
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Roles           headers=${headers}       expected_status=200
#    dump json to file    Tests/PMC/API_Tests/Organization_roles.json       ${Response.json()}
    ${Expected_Json}=       load json from file     Tests/PMC/API_Tests/Organization_roles.json
    should be equal     ${Expected_Json}            ${Response.json()}

Add an Orgnization Roles
    ${New_Role}     create dictionary      name=new role
    ${Response}=     POST       url=${BaseURL}/Organizations/25/Roles       json=${New_Role}        headers=${headers}       expected_status=200
    should be equal as strings         ${Response.json()}[roleName]          new role

Delete Organization Role
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Roles           headers=${headers}       expected_status=200
    ${New_Directory_Id}         set variable    ${Response.json()}[2][roleID]
    ${Response}=     Delete       url=${BaseURL}/Organizations/25/Roles/${New_Directory_Id}       headers=${headers}       expected_status=204
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Roles           headers=${headers}       expected_status=200
    ${Expected_Json}=       load json from file     Tests/PMC/API_Tests/Organization_roles.json
    should be equal     ${Expected_Json}            ${Response.json()}

Update Organization's Role
    ${New_Role}     create dictionary      usernames=["mojgan.dadashi@persyst.com"]
    ${Response}=     PUT       url=${BaseURL}/Organizations/25/Roles/79       json=${New_Role}        headers=${headers}       expected_status=204
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Roles           headers=${headers}       expected_status=200

Update User Role's Permissions(POST)
    ${Put_Json}         load json from file    Tests/PMC/API_Tests/Update_Permission_Edit.json
    ${Response} =       POST    url=${BaseURL}/Organizations/25/Directories/110/Permissions       json=${Put_Json}     headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Organizations/25/directories           headers=${headers}       expected_status=200
    should be equal as strings      ${Response.json()}[rolePermissions][1][permissions][addRecord]     False
    ${Put_Json}         load json from file    Tests/PMC/API_Tests/Update_Permission_Revert.json
    ${Response} =       POST    url=${BaseURL}/Organizations/25/Directories/110/Permissions       json=${Put_Json}     headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Organizations/25/directories           headers=${headers}       expected_status=200
    should be equal as strings      ${Response.json()}[rolePermissions][1][permissions][addRecord]     True

Update User Role's Permissions(PUT)
    ${Put_Json}         load json from file    Tests/PMC/API_Tests/Update_Permission_Edit.json
    ${Response} =       PUT    url=${BaseURL}/Organizations/25/Directories/110/Permissions       json=${Put_Json}     headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Organizations/25/directories           headers=${headers}       expected_status=200
    should be equal as strings      ${Response.json()}[rolePermissions][1][permissions][addRecord]     False
    ${Put_Json}         load json from file    Tests/PMC/API_Tests/Update_Permission_Revert.json
    ${Response} =       PUT    url=${BaseURL}/Organizations/25/Directories/110/Permissions       json=${Put_Json}     headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Organizations/25/directories           headers=${headers}       expected_status=200
    should be equal as strings      ${Response.json()}[rolePermissions][1][permissions][addRecord]     True

Get Organization Users
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Users          headers=${headers}       expected_status=200
    ${Expected_Json}=       set variable   [{'userName': 'mojgan.dadashi@persyst.com', 'nickName': None, 'roleIDs': [79, 80], 'shortUserName': 'Moji'}, {'userName': 'mojgan.dd@gmail.com', 'nickName': None, 'roleIDs': [79, 80], 'shortUserName': None}]
    should be equal as strings        ${Expected_Json}            ${Response.json()}

Update User's Shortname(PUT)
     [Tags]     run
     ${User}    load json from file    Tests/PMC/API_Tests/PUT_USER_ShortName.json
     ${Response}=        PUT     url=https://apitest.pmc.ninja/Organizations/25/Users/mojgan.dadashi@persyst.com        json=${User}    headers=${headers}    expected_status=200
     should be equal as strings             ${Response.json()}[shortUserName]              Mojii
     ${Response} =       DELETE     url=${BaseURL}/Organizations/25/Users/mojgan.dd@gmail.com   headers=${headers}       expected_status=200
     ${Response} =       GET     url=${BaseURL}/Organizations/25/Users/mojgan.dd@gmail.com         headers=${headers}       expected_status=200
     should be equal as strings            ${Response.json()}[shortUserName]           None
     ${User}    load json from file    Tests/PMC/API_Tests/PUT_USER_ShortName_Revert.json
     ${Response}=        PUT     url=https://apitest.pmc.ninja/Organizations/25/Users/mojgan.dadashi@persyst.com        json=${User}    headers=${headers}    expected_status=200
     should be equal as strings             ${Response.json()}[shortUserName]              Moji

Get Organization User's Data
    ${Response} =       GET    url=${BaseURL}/Organizations/25/Users/mojgan.dadashi@persyst.com          headers=${headers}       expected_status=200
    ${Expected_Json}=       set variable   {'userName': 'mojgan.dadashi@persyst.com', 'nickName': None, 'roleIDs': [79, 80], 'shortUserName': 'Moji'}
    should be equal as strings        ${Expected_Json}            ${Response.json()}

Get Organization Data
    [Tags]    skip
    [Documentation]    Incomplete data - What is the dataid API 7.17, NEED TO ADD Put and Delete
    ${Response} =       GET    url=${BaseURL}/Organizations/25/{dataid}          headers=${headers}       expected_status=200
    ${Expected_Json}=       set variable
    should be equal as strings        ${Expected_Json}            ${Response.json()}

Add a Montage Definitions to Organization
    ${Montage_File}    get file        Tests/PMC/API_Tests/BP-Longitudinal FP1-FP2.pjm
    ${body}=    set variable        ${Montage_File}
    ${Response} =       POST    url=${BaseURL}/Organizations/25/MontageDefinitions/BP-Longitudinal FP1-FP2        data=${body}       headers=${headers}       expected_status=200

Get Montage Definitions
    ${Response} =       GET    url=${BaseURL}/Organizations/25/MontageDefinitions         headers=${headers}       expected_status=200
    log    ${Response.json()}
#    dump json to file              Tests/PMC/API_Tests/BP-Longitudinal FP1-FP2.pjm          ${Response.json()}
    ${Expected_Montage}     load json from file    Tests/PMC/API_Tests/BP-Longitudinal FP1-FP2.pjm
    should be equal            ${Expected_Montage}            ${Response.json()}[0]

Update Montage Definition
    ${Montage_File}    get file        Tests/PMC/API_Tests/PUT-BP-Longitudinal FP1-FP2.pjm
    ${body}=    set variable        ${Montage_File}
    ${Response} =       PUT    url=${BaseURL}/Organizations/25/MontageDefinitions/BP-Longitudinal FP1-FP2        data=${body}      headers=${headers}       expected_status=200
    ${Expected_Montage}     load json from file    Tests/PMC/API_Tests/PUT-BP-Longitudinal FP1-FP2.pjm
    should be equal            ${Expected_Montage}            ${Response.json()}

Delete Montage Definition
    ${Response} =       DELETE    url=${BaseURL}/Organizations/25/MontageDefinitions/BP-Longitudinal FP1-FP2       headers=${headers}       expected_status=200

Upload Patient Record(PUT)
    [Tags]    skip
    ${lay_content}    get file    Tests/PMC/API_Tests/ICU/icu_1.lay
    ${body}     create dictionary    directoryID=110      totalSize=848190430
    ${Response} =       PUT    url=${BaseURL}/PatientUpload       json=${body}     headers=${headers}       expected_status=200
    ${upload_body}     set to dictionary        ${Response.json()}
    ${Response} =       PUT    url=${BaseURL}/PatientUploadComplete        data=${Response.json()} ${lay_content}       headers=${headers}       expected_status=200

Get Server Versions
    ${Response} =       GET    url=${BaseURL}/ServerVersion         headers=${headers}       expected_status=200
    dump json to file              Tests/PMC/API_Tests/Server_Versions.json          ${Response.json()}
    ${Expected_Montage}     load json from file    Tests/PMC/API_Tests/Server_Versions.json
    should be equal            ${Expected_Montage}            ${Response.json()}

Get EEG Montages
    ${Response} =       GET    url=${BaseURL}/EEG/Montages         headers=${headers}       expected_status=200
#    dump json to file               Tests/PMC/API_Tests/EEG_Montages.json           ${Response.json()}
    ${Expected_Montage}     load json from file    Tests/PMC/API_Tests/EEG_Montages.json
    should be equal            ${Expected_Montage}            ${Response.json()}

Get EEG Montage Definitions
    ${Response} =       GET    url=${BaseURL}/EEG/MontageDefinitions         headers=${headers}       expected_status=200
    dump json to file       Tests/PMC/API_Tests/EEG_Montage_Definitions.json        ${Response.json()}
    ${Expected_Montages}         load json from file    Tests/PMC/API_Tests/EEG_Montage_Definitions.json
    should be equal            ${Expected_Montages}            ${Response.json()}

Add an EEG Montage Definitions
    ${Montage_File}    get file        Tests/PMC/API_Tests/Bipolar longitudinal A.pjm
    ${body}=    set variable        ${Montage_File}
    ${Response} =       POST    url=${BaseURL}/EEG/MontageDefinitions/User/Bipolar longitudinal AA       data=${body}       headers=${headers}       expected_status=200
    set global variable         ${New_Montage_Id}           ${Response.json()}[id]
    dump json to file       Tests/PMC/API_Tests/New_EEG_Montage_Response.json           ${Response.json()}
    jsonvalidator.update json    ${Response.json()}         $.id  ${New_Montage_Id}
    dump json to file    Tests/PMC/API_Tests/test.json              ${Response.json()}
    ${test_json}=    load json from file    Tests/PMC/API_Tests/test.json
    log     ${test_json}
    set global variable    ${test_json}

Update EEG Montage Definition
    ${Montage_File}    get file        Tests/PMC/API_Tests/PUT_Bipolar longitudinal A.pjm
    ${body}=    set variable        ${Montage_File}
    ${Put_Body}=          jsonvalidator.update json       ${test_json}         $.name   Bipolar longitudinal A2
    log         ${Put_Body}
    ${Put_Response} =       PUT    url=${BaseURL}/EEG/MontageDefinitions/ID/${New_Montage_Id}        json=${Put_Body}     headers=${headers}       expected_status=200
     set global variable         ${Updated_Montage_Id}           ${Put_Response.json()}[id]

Delete EEG Montage Definition
    ${Response} =       DELETE    url=${BaseURL}/EEG/MontageDefinitions/ID/${Updated_Montage_Id}       headers=${headers}       expected_status=204
    ${duplicate_montage_id}=    evaluate    int(${Updated_Montage_Id}) + 1
    ${Response} =       DELETE    url=${BaseURL}/EEG/MontageDefinitions/ID/${duplicate_montage_id}      headers=${headers}      expected_status=204

Create and Delete a Comment for Patient
    ${Comment}=     create dictionary       time=3494.6817587167966     duration=0    text=123@PersystTrends
    ${Response}=     POST       url=${BaseURL}/Patients/596/Comments                json=${Comment}     headers=${headers}      expected_status=204
    ${Response}=     GET        url=${BaseURL}/Patients/596/Comments?StartTime=0&EndTime=3599.79296875      headers=${headers}      expected_status=200
    ${Number_Of_Comments}=   get length    ${Response.json()}
    ${Number_Of_Comments}=   evaluate    ${Number_Of_Comments}-1
    ${Comment_ID}=     set variable    ${Response.json()}[${Number_Of_Comments}][id]
    ${Update_Comment}=     create dictionary       time=3494.6817587167966     duration=0    text=1234@PersystTrends
    ${Response}=     PUT       url=${BaseURL}/Patients/596/Comments/${Comment_ID}                json=${Update_Comment}     headers=${headers}      expected_status=204
    ${Response}=     GET        url=${BaseURL}/Patients/596/Comments?StartTime=0&EndTime=3599.79296875      headers=${headers}      expected_status=200
    log     ${Response.json()}[${Number_Of_Comments}][text]
    should be equal as strings    ${Response.json()}[${Number_Of_Comments}][text]           1234@PersystTrends
    ${Response}=     DELETE     url=${BaseURL}/Patients/596/Comments/${Comment_ID}      headers=${headers}      expected_status=204

Get Password Requirements
    ${Password_Requirements}=       set variable    {'minimumLength': 8, 'mustHaveUpperLower': True, 'mustHaveDigit': True, 'mustHaveSpecial': False}
    ${Response}=    GET    url=${BaseURL}/PasswordRequirements      headers=${headers}      expected_status=200
    should be equal as strings    ${Response.json()}            ${Password_Requirements}

Get List Of Studies
    ${Response}=    GET    url=${BaseURL}/Patients      headers=${headers}      expected_status=200
    dump json to file    Tests/PMC/API_Tests/List_Of_Studies.json           ${Response.json()}
    ${Expected_Studies}=        load json from file    Tests/PMC/API_Tests/List_Of_Studies.json
    log     ${Response.json()}
    log       ${Expected_Studies}
    should be equal         ${Expected_Studies}         ${Response.json()}

Get Patients List Of Panels
    ${Response}=    GET         url=${BaseURL}/Patients/596/Panels      headers=${headers}      expected_status=200
#    dump json to file    Tests/PMC/API_Tests/Patients_Panels.json           ${Response.json()}
    ${Expected_Studies}=        load json from file    Tests/PMC/API_Tests/Patients_Panels.json
    should be equal         ${Expected_Studies}         ${Response.json()}

Get Patient Trends Panel
    ${Response}=    GET         url=${BaseURL}/Patients/642/Trends?Panel=Comprehensive&Start=0&Duration=14400&AR=false&Pointsx=824&Pointsy=804.015625&FontScale=2&TimeFormat=0&DateFormat=2&Decimal0&PixelsPerPoint=1&Randomizer=81&CacheRandomizer=1712187681199     headers=${headers}      expected_status=200
#    dump json to file    Tests/PMC/API_Tests/Patients_Trends_Panel.json           ${Response.text}
    ${Expected_Studies}=        load json from file    Tests/PMC/API_Tests/Patients_Trends_Panel.json
    should be equal         ${Expected_Studies}         ${Response.text}

Upload and Delete a Patient Document
    ${File}=    create dictionary    file=Tests/PMC/API_Tests/Sample_Data.txt
    ${Response} =       POST    url=${BaseURL}/Patients/596/documents/sample_data.txt      files=${File}      headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Patients/596/documents           headers=${headers}       expected_status=200
    should be equal as strings    ${Response.json()}[0][fileName]          sample_data.txt
    ${Response} =       DELETE    url=${BaseURL}/Patients/596/documents/sample_data.txt       headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Patients/596/documents           headers=${headers}       expected_status=200
    should be empty     ${Response.json()}
    ${Response} =       PUT    url=${BaseURL}/Patients/596/documents/sample_data.txt      files=${File}      headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/Patients/596/documents           headers=${headers}       expected_status=200
    should be equal as strings    ${Response.json()}[0][fileName]          sample_data.txt
    ${Response} =       DELETE    url=${BaseURL}/Patients/596/documents/sample_data.txt       headers=${headers}       expected_status=200

Upload a Document To a Directory and Delete
    ${File}=    create dictionary    file=Tests/PMC/API_Tests/Sample_Data.txt
    ${Response} =       POST    url=${BaseURL}/organizations/25/directories/110/documents/sample_data.txt      files=${File}      headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/organizations/25/directories/110/documents           headers=${headers}       expected_status=200
    should be equal as strings    ${Response.json()}[0][fileName]          sample_data.txt
    ${Response} =       DELETE    url=${BaseURL}/organizations/25/directories/110/documents/sample_data.txt       headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/organizations/25/directories/110/documents           headers=${headers}       expected_status=200
    ${Response} =       PUT    url=${BaseURL}/organizations/25/directories/110/documents/sample_data.txt      files=${File}      headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/organizations/25/directories/110/documents           headers=${headers}       expected_status=200
    should be equal as strings    ${Response.json()}[0][fileName]          sample_data.txt
    ${Response} =       DELETE    url=${BaseURL}/organizations/25/directories/110/documents/sample_data.txt       headers=${headers}       expected_status=200

Update and Get Data's DataSet
    [Tags]      skip
    [Documentation]    Not Complete Need More Data
    ${DataSet}     set variable    	{}
    ${Response} =       PUT    url=${BaseURL}/data/dataset       json=${DataSet}   headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/data/dataset          headers=${headers}       expected_status=200
    ${DataSet}     set variable    	{}
    ${Response} =       PUT    url=${BaseURL}/data/dataset       json=${DataSet}   headers=${headers}       expected_status=200
    ${Response} =       GET    url=${BaseURL}/data/dataset          headers=${headers}       expected_status=200

Get Log on User
    ${User}     set variable    	{'Username': 'mojgan.dadashi@persyst.com', 'Admin': False, 'BlindMarkerMode': 0, 'BlindMarkerName': '', 'AppendReaderNameInComments': False, 'AllowSavingSettings': True, 'AllowCommenting': True, 'LastLoginTime': 0, 'LastLoginIP': '0.0.0.0', 'PushNotificationURL': 'https://apn.data.persyst.com/APN'}
    ${Response} =       GET    url=${BaseURL}/User          headers=${headers}       expected_status=200
    should be equal as strings    ${Response.json()}            ${User}

Check Users Status
    ${Response} =       GET    url=${BaseURL}/Users/mojgan.dadashi@persyst.com          headers=${headers}       expected_status=200
    should be equal as strings            ${Response.json()}            {'cognitoStatus': 'CONFIRMED'}

Update User Full Name
    ${User_Name}    create dictionary       fullName=Mojgan Dadashi
    ${Response} =       PUT    url=${BaseURL}/Users/mojgan.dadashi@persyst.com        json=${User_Name}  headers=${headers}       expected_status=200

Resend Invitation
    [Tags]    skip
    [Documentation]    there is no payload content and the POST request is failing
    ${body}         set variable    {}
    ${Response} =       POST    url=${BaseURL}/Users/mojgan.dd@gmail.com/resend-invitation      json=${body}     headers=${headers}       expected_status=200

