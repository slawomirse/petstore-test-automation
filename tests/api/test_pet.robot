*** Settings ***
Resource    ../../resources/api/user.resource
Resource    ../../resources/api/pet.resource

Suite Setup       Login As Default Admin
Suite Teardown    Logout

*** Test Cases ***
Domyslne Zwierze Powinno Istniec
    [Tags]    smoke
    [Documentation]    Sprawdza, czy domyslne zwierze o id=${DEFAULT_PET_ID} istnieje.
    Send GET Request    /pet/${DEFAULT_PET_ID}    expected_status_code=200

Pobranie Zwierzecia Po ID Powinno Zwrocic Poprawna Nazwe
    [Documentation]    Sprawdza, czy pobranie zwierzecia o id=${DEFAULT_PET_ID} zwraca poprawna nazwe.
    ${response}=    Send GET Request    /pet/${DEFAULT_PET_ID}    expected_status_code=200
    ${pet_name}=    Get Json Field    ${response}    name
    Should Be Equal    ${pet_name}    ${DEFAULT_PET_NAME}

Pobranie Zwierzedzie Po Statusie Powinno Zwracac Liste Zwierzat
    [Documentation]    Sprawdza, czy pobranie zwierzat o statusie "available" zwraca liste zwierzat.
    ${response}=    Send GET Request    /pet/findByStatus    params=?status=available    expected_status_code=200
    Should Be True    len(${response.json()}) > 0

Tworzenie Zwierzecia Przez Niezalogowanego Uzytkownika
    [Documentation]    Proba utworzenia zwierzecia przez niezalogowanego uzytkownika
    ${headers}=    Create Json Headers
    ${payload}=    Build Pet Payload
    ${pet_body}=    Serialize To Json    ${payload}
    Send POST Request    endpoint=/pet    payload=${pet_body}    headers=${headers}    expected_status_code=401

Tworzenie Zwierzecia Przez Zalogowanego Uzytkownika
    [Documentation]    Proba utworzenia zwierzecia przez zalogowanego uzytkownika
    [Tags]    regression
    Create Pet

Aktualizacja Zwierzecia Przez Zalogowanego Uzytkownika
    [Documentation]    Proba aktualizacji zwierzecia przez zalogowanego uzytkownika
    [Setup]    Create Pet
    Update Pet    payload={"id": ${pet_id}, "status": "sold", "name": "UpdatedName"}
    ${updated}=    Send GET Request    /pet/${pet_id}    expected_status_code=200
    ${status}=    Get Json Field    ${updated}    status
    Should Be Equal    ${status}    sold

Usuwanie Zwierzecia Przez Zalogowanego Uzytkownika
    [Documentation]    Proba usuniecia zwierzecia przez zalogowanego uzytkownika
    [Setup]    Create Pet
    Delete Pet
    Send GET Request    /pet/${pet_id}    expected_status_code=404