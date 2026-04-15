*** Settings ***
Resource    ../../resources/ui/pages/home_page.resource
Resource    ../../resources/ui/pages/login_page.resource
Resource    ../../resources/ui/pages/register_page.resource

*** Variables ***
${NEW_USER_USERNAME}      ${EMPTY}
${NEW_USER_EMAIL}         ${EMPTY}
${NEW_USER_FIRST_NAME}    ${EMPTY}
${NEW_USER_LAST_NAME}     ${EMPTY}
${NEW_USER_PHONE}         ${EMPTY}
${NEW_USER_PASSWORD}      ${EMPTY}

*** Test Cases ***
Logowanie użytkownika przy użyciu błędnego hasła
    [Tags]    known_bug
	Open Home Page
	Verify Home Page Is Loaded
	Open Login Form
	Submit Login Form With Credentials    ${DEFAULT_ADMIN_USERNAME}    wrong-password
	Verify Login Error Is Displayed
	Verify User Is Logged In As Guest

Logowanie użytkownika dommyslnego
    [Teardown]    Logout If Needed
	Open Home Page
	Verify Home Page Is Loaded
	Open Login Form
	Submit Login Form With Credentials    ${DEFAULT_ADMIN_USERNAME}    ${DEFAULT_ADMIN_PASSWORD}
	Verify Login Success Is Displayed
	Verify User Is Logged In    ${DEFAULT_ADMIN_USERNAME}

Utworzenie nowego konta oraz jego zalogowanie
    [Teardown]    Logout If Needed
    Generate New User Data
    Open Home Page
    Verify Home Page Is Loaded
    Open Register Form
    Fill Register Form    ${NEW_USER_USERNAME}    ${NEW_USER_EMAIL}    ${NEW_USER_FIRST_NAME}    ${NEW_USER_LAST_NAME}    ${NEW_USER_PASSWORD}    ${NEW_USER_PHONE}
    Submit Register Form
    Verify Registration Success
    Submit Login Form With Credentials    ${NEW_USER_USERNAME}    ${NEW_USER_PASSWORD}
    Verify Login Success Is Displayed
    Verify User Is Logged In    ${NEW_USER_USERNAME}
