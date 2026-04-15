*** Settings ***
Library    Browser
Resource    home_page.resource

*** Variables ***
${LOGIN_MODAL_USERNAME_INPUT}      xpath=//*[@id='auth-username']
${LOGIN_MODAL_PASSWORD_INPUT}      xpath=//*[@id='auth-password']
${LOGIN_MODAL_SIGN_IN_BUTTON}      xpath=//*[@id='login-form']//button[@type='submit']
${LOGIN_MODAL_ERROR_TOAST}         xpath=//*[contains(@class,'toast')]

*** Keywords ***
Open Login Form
	Click    ${HOME_PAGE_SIGN_IN_BUTTON}

Submit Login Form With Credentials
	[Arguments]    ${username}    ${password}
	Fill Text    ${LOGIN_MODAL_USERNAME_INPUT}    ${username}
	Fill Text    ${LOGIN_MODAL_PASSWORD_INPUT}    ${password}
	Click    ${LOGIN_MODAL_SIGN_IN_BUTTON}

Verify Login Error Is Displayed
	Wait For Elements State    ${LOGIN_MODAL_ERROR_TOAST}    visible
	${error_text}=    Get Text    ${LOGIN_MODAL_ERROR_TOAST}
	Should Contain    ${error_text}    Login failed
