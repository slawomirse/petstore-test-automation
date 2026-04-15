*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource   variables.resource

*** Keywords ***
Send GET Request
    [Arguments]    ${endpoint}    ${expected_status_code}=200
    ${response}=    GET    ${BASE_URL}${endpoint}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status_code}
    RETURN    ${response}

Send POST Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}=&{empty}    ${expected_status_code}=200
    ${response}=    POST    ${BASE_URL}${endpoint}    data=${payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status_code}
    RETURN    ${response}

Create Json Headers
    &{headers}=    Create Dictionary    Content-Type=application/json
    RETURN    ${headers}

Get Json Field
    [Arguments]    ${response}    ${field_name}
    RETURN    ${response.json()['${field_name}']}