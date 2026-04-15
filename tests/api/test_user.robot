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

Utworzenie Oraz Logowanie Testowego Uzytkownika
    [Documentation]    Sprawdza, czy mozna utworzyc testowego uzytkownika i zalogowac sie na niego.
    [Teardown]    Logout
    Create Authenticated Test User
    Should Not Be Empty    ${token}

Aktualizacja emaila Testowego Uzytkownika
    [Documentation]    Sprawdza, czy mozna zaktualizowac email testowego uzytkownika.
    [Setup]    Create Authenticated Test User
    [Teardown]    Logout
    VAR    ${update_payload}    {"email": "janusz@xxx.com"}
    ${response}=    Update Test User    payload=${update_payload}
    ${user_response}=    Send GET Request    /user/${TEST_USERNAME}    expected_status_code=200
    ${email}=    Get Json Field    ${user_response}    email
    Should Be Equal    ${email}    janusz@xxx.com