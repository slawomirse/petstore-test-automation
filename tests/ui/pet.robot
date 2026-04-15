*** Settings ***
Resource    ../../resources/ui/pages/home_page.resource
Resource    ../../resources/ui/pages/login_page.resource
Resource    ../../resources/ui/pages/pets_page.resource

*** Variables ***
${NEW_PET_NAME}             ${EMPTY}
${NEW_PET_STATUS}           ${EMPTY}
${NEW_PET_CATEGORY_ID}      ${EMPTY}
${NEW_PET_CATEGORY_NAME}    ${EMPTY}
${NEW_PET_PHOTO_URL}        ${EMPTY}
${NEW_PET_TAG}              ${EMPTY}

*** Test Cases ***
Dodanie nowego zwierzęcia
    [Teardown]    Logout If Needed
    Open Home Page
    Verify Home Page Is Loaded
    Login As Default User
    Open Browse Pets Page
    Open Add New Pet Form
    Generate New Pet Data
    Fill New Pet Form    ${NEW_PET_NAME}    ${NEW_PET_STATUS}    ${NEW_PET_CATEGORY_ID}    ${NEW_PET_CATEGORY_NAME}    ${NEW_PET_PHOTO_URL}    ${NEW_PET_TAG}
    Submit New Pet Form
    Verify New Pet Was Added    ${NEW_PET_NAME}
