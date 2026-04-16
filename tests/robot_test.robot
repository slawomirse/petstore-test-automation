*** Variables ***
${KEYWORD_VAR}    ${EMPTY}

*** Test Cases ***
Zakres Zmiennej Lokalnej
    ${user_name}=    Set Variable    Alice
    Log    Local variable in test: ${user_name}

Zakres Zmiennej Testowej
    Do Something
    Log    Test variable in test: ${KEYWORD_VAR}

Ustawienie Zmiennej Suite
    Set Suite Variable    ${SUITE_NAME}    Robot Framework Basics
    Log    Suite variable set: ${SUITE_NAME}

Uzycie Zmiennej Suite
    Log    Suite variable used in another test: ${SUITE_NAME}


*** Keywords ***
Do Something
    VAR   ${KEYWORD_VAR}    Test Scope    scope=TEST