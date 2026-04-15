*** Settings ***
Resource    common.resource

*** Keywords ***
Login As Default Admin
    ${auth}=    Evaluate    ($DEFAULT_ADMIN_USERNAME, $DEFAULT_ADMIN_PASSWORD)
    ${response}=    Send GET Request    /user/login    auth=${auth}    expected_status_code=200
    ${token}=    Get Json Field    ${response}    message
    Should Not Be Empty    ${token}
    Set Suite Variable    ${token}    ${token}

Logout
    ${headers}=    Create Json Headers
    VAR    ${logout_body}    {"token": "${token}"}
    Send POST Request    /user/logout    payload=${logout_body}    headers=${headers}    expected_status_code=200