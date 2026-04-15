*** Settings ***
Documentation    Testy dla zarzadzania uzytkownikiem.
Resource         ../../resources/api/user.resource


*** Test Cases ***
Logowanie Domyslnego Uzytkownika Powinno Zwracac Token
    [Documentation]    Sprawdza, czy logowanie domyslnego uzytkownika zwraca token.
    Login As Default Admin
    Should Not Be Empty    ${token}
    Logout