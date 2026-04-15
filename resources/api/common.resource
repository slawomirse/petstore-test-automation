*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource   variables.resource
Library    ../../libraries/payload_builders.py

*** Keywords ***
Send GET Request
    [Arguments]    ${endpoint}    ${auth}=@{EMPTY}    ${params}=${EMPTY}    ${expected_status_code}=200
    ${response}=    GET    ${BASE_URL}${endpoint}${params}    auth=${auth}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${expected_status_code}
    RETURN    ${response}

Send POST Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}=&{empty}    ${expected_status_code}=200
    ${response}=    POST    ${BASE_URL}${endpoint}    data=${payload}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${expected_status_code}
    RETURN    ${response}

Send PUT Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}=&{empty}    ${expected_status_code}=200
    ${response}=    PUT    ${BASE_URL}${endpoint}    data=${payload}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${expected_status_code}
    RETURN    ${response}

Send DELETE Request
    [Arguments]    ${endpoint}   ${headers}=&{EMPTY}    ${expected_status_code}=200
    ${response}=    DELETE    ${BASE_URL}${endpoint}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${expected_status_code}
    RETURN    ${response}

Create Json Headers
    &{headers}=    Create Dictionary    Content-Type=application/json
    RETURN    ${headers}

Create Bearer Headers
    &{headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    RETURN    ${headers}

Get Json Field
    [Arguments]    ${response}    ${field_name}
    RETURN    ${response.json()['${field_name}']}