*** Settings ***
Resource    common.resource

*** Variables ***
${pet_id}    ${EMPTY}

*** Keywords ***
Create Pet
    ${headers}=    Create Bearer Headers
    ${payload}=    Build Pet Payload
    ${pet_body}=    Serialize To Json    ${payload}
    VAR    ${pet_id}    ${payload['id']}    scope=TEST
    Send POST Request    endpoint=/pet    payload=${pet_body}    headers=${headers}    expected_status_code=200
    Send GET Request    /pet/${pet_id}    expected_status_code=200

Update Pet
    [Arguments]    ${payload}=${EMPTY}
    ${headers}=    Create Bearer Headers
    ${response}=    Send PUT Request    /pet/    payload=${payload}    headers=${headers}    expected_status_code=200
    RETURN    ${response}

Delete Pet
    ${headers}=    Create Bearer Headers
    ${response}=    Send DELETE Request    /pet/${pet_id}    headers=${headers}    expected_status_code=200
    Send GET Request    /pet/${pet_id}    expected_status_code=404
    RETURN    ${response}