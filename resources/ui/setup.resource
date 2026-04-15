*** Settings ***
Library     Browser
Resource    ../variables.resource


*** Keywords ***
Setup Browser
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context
    ...    viewport={'width': 1920, 'height': 1200}
    Set Browser Timeout    10s
    New Page    ${BASE_FRONTEND_URL}