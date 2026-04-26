*** Settings ***
Resource    common.resource

*** Variables ***
${test_password}    Test1234
${test_username}    ${EMPTY}

*** Keywords ***
Login As Default Admin
    ${auth}=    Evaluate    ($DEFAULT_ADMIN_USERNAME, $DEFAULT_ADMIN_PASSWORD)
    ${response}=    Send GET Request    /user/login    auth=${auth}    expected_status_code=200
    ${token}=    Get Json Field    ${response}    message
    Should Not Be Empty    ${token}
    Set Suite Variable    ${token}    ${token}

Create Test User
    Create Test User With Password    password=${test_password}

Create Test User With Password
    [Arguments]    ${password}
    ${headers}=    Create Json Headers
    ${payload}=    Build User Payload    password=${password}
    VAR    ${test_username}    ${payload['username']}    scope=TEST
    VAR    ${test_user_id}    ${payload['id']}    scope=TEST
    ${body}=    Serialize To Json    ${payload}
    ${response}=    Send POST Request    /user    payload=${body}    headers=${headers}    expected_status_code=200
    RETURN    ${response}

Build User Json
   ${payload}=    Build User Payload    password=${test_password}
    VAR    ${test_username}    ${payload['username']}    scope=TEST
    VAR    ${test_user_id}    ${payload['id']}    scope=TEST
    ${body}=    Serialize To Json    ${payload}
    RETURN    ${body}

Delete Test User
    ${headers}=    Create Bearer Headers
    Send DELETE Request    /user/${TEST_USERNAME}   headers=${headers}  expected_status_code=200


Login As Test User
    ${auth}=    Evaluate   ($test_username, $test_password)
    ${response}=    Send GET Request    /user/login    auth=${auth}    expected_status_code=200
    ${token}=    Get Json Field    ${response}    message
    VAR    ${token}    ${token}    scope=TEST
    Should Not Be Empty    ${token}
    RETURN    ${token}

Create Authenticated Test User
    Create Test User
    ${token}=    Login As Test User
    RETURN    ${token}

Update Test User
    [Arguments]    ${username}=${TEST_USERNAME}    ${payload}=${EMPTY}
    ${headers}=    Create Bearer Headers
    ${response}=    Send PUT Request    /user/${username}    payload=${payload}    headers=${headers}    expected_status_code=200
    RETURN    ${response}

Logout
    ${headers}=    Create Json Headers
    VAR    ${logout_body}    {"token": "${token}"}
    Send POST Request    /user/logout    payload=${logout_body}    headers=${headers}    expected_status_code=200
