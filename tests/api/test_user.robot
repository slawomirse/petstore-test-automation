*** Settings ***
Documentation    Testy dla zarzadzania uzytkownikiem.
Resource         ../../resources/api/user.resource


*** Test Cases ***
Domyslny Admin Powinien Istniec
    [Documentation]    Sprawdza, czy domyslny uzytkownik admin istnieje w systemie.
    ${response}=    Send GET Request    /user/${DEFAULT_ADMIN_USERNAME}    expected_status_code=200
    ${username}=    Get Json Field    ${response}    username
    Should Be Equal    ${username}    ${DEFAULT_ADMIN_USERNAME}

Logowanie Domyslnego Uzytkownika Powinno Zwracac Token
    [Documentation]    Sprawdza, czy logowanie domyslnego uzytkownika zwraca token.
    [Teardown]    Logout
    Login As Default Admin
    Should Not Be Empty    ${token}