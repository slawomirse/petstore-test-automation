*** Settings ***
Resource    ../../resources/ui/pages/home_page.resource
Resource    ../../resources/ui/pages/login_page.resource

*** Test Cases ***
Logowanie użytkownika przy użyciu błędnego hasła
    [Tags]    known_bug
	Open Home Page
	Verify Home Page Is Loaded
	Open Login Form
	Submit Login Form With Credentials    ${DEFAULT_ADMIN_USERNAME}    wrong-password
	Verify Login Error Is Displayed
	Verify User Is Logged In As Guest

Logowanie użytkownika przy użyciu prawidłowego hasła
	Open Home Page
	Verify Home Page Is Loaded
	Open Login Form
	Submit Login Form With Credentials    ${DEFAULT_ADMIN_USERNAME}    ${DEFAULT_ADMIN_PASSWORD}
	Verify Login Success Is Displayed
	Verify User Is Logged In    ${DEFAULT_ADMIN_USERNAME}
