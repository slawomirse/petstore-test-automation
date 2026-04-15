*** Settings ***
Resource    ../../resources/ui/pages/home_page.resource
Resource    ../../resources/ui/pages/login_page.resource
Resource    ../../resources/ui/pages/pets_page.resource
Resource    ../../resources/ui/pages/orders_page.resource

*** Variables ***
${NEW_ORDER_ID}        ${EMPTY}
${NEW_ORDER_PET_ID}    ${EMPTY}

*** Test Cases ***
E2E: Logowanie, utworzenie zwierzęcia, zamówienie i weryfikacja zamówienia
    [Teardown]    Logout If Needed
    Open Home Page
    Verify Home Page Is Loaded
    Login As Default User
    Verify User Is Logged In    ${DEFAULT_ADMIN_USERNAME}
    Open Browse Pets Page
    Create New Pet For Update Test
    Place Order For Pet    ${NEW_PET_NAME}
    Open Orders Page
    Lookup Order By Id    ${NEW_ORDER_ID}
    Verify Order Was Created    ${NEW_ORDER_ID}
    Verify Order Is For Pet    ${NEW_ORDER_PET_ID}
