*** Test Cases ***
Walidacja Tekstu
    ${value}=    Set Variable    abc
    Should Be Equal    ${value}    abc

    ${text}=    Set Variable    Robot Framework jest prosty
    Should Contain    ${text}    prosty
