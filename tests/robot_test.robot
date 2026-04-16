*** Test Cases ***
Powitanie
    Przywitaj Uzytkownika    Alice

*** Keywords ***
Przywitaj Uzytkownika
    [Arguments]    ${name}
    Log    Hello ${name}
