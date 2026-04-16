*** Test Cases ***
Powitania Szablonem
    [Template]    Przywitaj Uzytkownika
    Alice
    Bob
    Charlie

*** Keywords ***
Przywitaj Uzytkownika
    [Arguments]    ${name}
    Log    Witaj, ${name}!
