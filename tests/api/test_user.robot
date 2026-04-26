*** Settings ***
Documentation    Testy dla zarzadzania uzytkownikiem.
Resource         ../../resources/api/user.resource


*** Test Cases ***
Domyslny Admin Powinien Istniec
    [Tags]    smoke
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
    [Tags]    regression
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

Proba Logowania Zlym Haslem
    [Documentation]    Praca domowa - Próba logowania złym hasłem użytkownika powinna zakończyć się niepowodzeniem.
    Create Test User With Password    password=user123
    ${auth}=    Evaluate   ($test_username, "654321")
    Send GET Request    /user/login    auth=${auth}    expected_status_code=401

Usuwanie Urzytkownika
    [Documentation]    Praca domowa - Usunięcie użytkownika i potwierdzenie, że został on usunięty.
    Create Authenticated Test User
    VAR    ${test_user_URL}    /user/${TEST_USERNAME}
    Send GET Request    ${test_user_URL}    expected_status_code=200    #Upewnienie się, że istnieje
    Delete Test User
    Send GET Request    ${test_user_URL}    expected_status_code=404

Utworzenie Dwoch Takich Samych Uzytkownikow Nie Jest Mozliwe
    [Documentation]    Praca domowa - Sprawdzenie, czy nie jest możliwe utworzenie dwóch identycznych użytkowników
    ${headers}=    Create Json Headers
    ${body}=    Build User Json
    Send POST Request    /user    payload=${body}    headers=${headers}    expected_status_code=200
    ${response}=    Send POST Request    /user    payload=${body}    headers=${headers}    expected_status_code=400
    ${error_message}=    Get Json Field    ${response}    message
    Should Be Equal    ${error_message}    Username already exists
