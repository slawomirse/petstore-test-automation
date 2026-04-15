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