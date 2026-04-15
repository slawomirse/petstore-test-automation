*** Settings ***
Resource    common.resource

*** Variables ***
${TEST_PET_ID}    ${EMPTY}

*** Keywords ***
Create Pet
    ${headers}=    Create Bearer Headers
    ${payload}=    Build Pet Payload
    ${pet_body}=    Serialize To Json    ${payload}
    VAR    ${pet_id}    ${payload['id']}    scope=TEST
    Send POST Request    endpoint=/pet    payload=${pet_body}    headers=${headers}    expected_status_code=200
    Send GET Request    /pet/${pet_id}    expected_status_code=200