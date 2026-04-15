*** Settings ***
Resource    ../../resources/api/common.resource

*** Test Cases ***
Domyslne Zwierze Powinno Istniec
    ${response}=    Send GET Request    /pet/${DEFAULT_PET_ID}    expected_status_code=200