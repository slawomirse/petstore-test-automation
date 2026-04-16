*** Settings ***
Library    custom_module.py

*** Test Cases ***
Dodawanie Liczb
    ${result}=    Add Two Numbers    2    3
    ${expected_result}=    Evaluate    5
    Should Be Equal    ${result}    ${expected_result}