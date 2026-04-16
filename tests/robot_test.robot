*** Test Cases ***
Praca Z Lista i Slownikiem
    @{my_list}=    Create List    1    2    3
    Log    ${my_list}
    &{my_dict}=    Create Dictionary    klucz1=wartosc1    klucz2=wartosc2
    Log    ${my_dict}

    Log   First item: ${my_list}[0]
    Log    Key value: ${my_dict['klucz1']}

    Should Be True    isinstance($my_list, list)
    Should Be True    isinstance($my_dict, dict)
