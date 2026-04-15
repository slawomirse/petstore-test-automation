*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Test Cases ***
Domyslne Zwierze Powinno Istniec
    ${response}=    GET    http://127.0.0.1:8000/pet/1
    Should Be Equal As Strings    ${response.status_code}    200