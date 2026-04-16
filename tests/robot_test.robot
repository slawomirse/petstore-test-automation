*** Test Cases ***
Przyklad Try Except Finally
    TRY
        Log    Start
        Fail    Blad w trakcie testu
    EXCEPT
        Log    Obsluga bledu
    FINALLY
        Log    Ten krok wykona sie zawsze
    END
