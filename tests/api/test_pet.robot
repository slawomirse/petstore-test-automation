*** Settings ***
Resource    ../../resources/api/common.resource
Resource    ../../resources/api/user.resource


*** Test Cases ***
Domyslne Zwierze Powinno Istniec
    [Documentation]    Sprawdza, czy domyslne zwierze o id=${DEFAULT_PET_ID} istnieje.
    Send GET Request    /pet/${DEFAULT_PET_ID}    expected_status_code=200

Pobranie Zwierzecia Po ID Powinno Zwrocic Poprawna Nazwe
    [Documentation]    Sprawdza, czy pobranie zwierzecia o id=${DEFAULT_PET_ID} zwraca poprawna nazwe.
    ${response}=    Send GET Request    /pet/${DEFAULT_PET_ID}    expected_status_code=200
    ${pet_name}=    Get Json Field    ${response}    name
    Should Be Equal    ${pet_name}    ${DEFAULT_PET_NAME}

Tworzenie Zwierzecia Przez Niezalogowanego Uzytkownika
    [Documentation]    Proba utworzenia zwierzecia przez niezalogowanego uzytkownika
    ${headers}=    Create Json Headers
    ${payload}=    Build Pet Payload
    ${pet_body}=    Serialize To Json    ${payload}
    Send POST Request    endpoint=/pet    payload=${pet_body}    headers=${headers}    expected_status_code=401

Tworzenie Zwierzecia Przez Zalogowanego Uzytkownika
    [Documentation]    Proba utworzenia zwierzecia przez zalogowanego uzytkownika
    Login As Default Admin
    ${headers}=    Create Bearer Headers
    ${payload}=    Build Pet Payload
    ${pet_body}=    Serialize To Json    ${payload}
    VAR    ${pet_id}    ${payload['id']}
    Send POST Request    endpoint=/pet    payload=${pet_body}    headers=${headers}    expected_status_code=200
    Send GET Request    /pet/${pet_id}    expected_status_code=200
    Logout