*** Test Cases ***
Petla Po Imionach
    @{users}=    Create List    Alice    Bob    Charlie
    FOR    ${user}    IN    @{users}
        Log    ${user}
    END
