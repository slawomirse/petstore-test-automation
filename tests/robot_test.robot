*** Settings ***
Suite Setup       Przygotuj Suite
Suite Teardown    Posprzataj Suite

*** Test Cases ***
Pierwszy Test W Suite
    Log    Wykonuje pierwszy test

Drugi Test W Suite
    Log    Wykonuje drugi test

*** Keywords ***
Przygotuj Suite
    Log    Start calej suite

Posprzataj Suite
    Log    Koniec calej suite