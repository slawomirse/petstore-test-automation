*** Settings ***
Library    Browser
Library     ../../../libraries/payload_builders.py
Resource    home_page.resource

*** Variables ***
${REGISTER_TAB_BUTTON}         xpath=//*[@data-tab='register']
${REGISTER_USERNAME_INPUT}     xpath=//*[@id='reg-username']
${REGISTER_EMAIL_INPUT}        xpath=//*[@id='reg-email']
${REGISTER_FIRSTNAME_INPUT}    xpath=//*[@id='reg-firstname']
${REGISTER_LASTNAME_INPUT}     xpath=//*[@id='reg-lastname']
${REGISTER_PASSWORD_INPUT}     xpath=//*[@id='reg-password']
${REGISTER_PHONE_INPUT}        xpath=//*[@id='reg-phone']
${REGISTER_SUBMIT_BUTTON}      xpath=//*[@id='register-form']//button[@type='submit']
${REGISTER_SUCCESS_TOAST}      xpath=//*[contains(@class,'toast') and contains(normalize-space(),'Account created')]

*** Keywords ***
Open Register Form
    Click    ${HOME_PAGE_LOGIN_BUTTON}
    Click    ${REGISTER_TAB_BUTTON}

Fill Register Form
    [Arguments]    ${username}    ${email}    ${first_name}    ${last_name}    ${password}    ${phone}
    Fill Text    ${REGISTER_USERNAME_INPUT}    ${username}
    Fill Text    ${REGISTER_EMAIL_INPUT}       ${email}
    Fill Text    ${REGISTER_FIRSTNAME_INPUT}   ${first_name}
    Fill Text    ${REGISTER_LASTNAME_INPUT}    ${last_name}
    Fill Text    ${REGISTER_PASSWORD_INPUT}    ${password}
    Fill Text    ${REGISTER_PHONE_INPUT}       ${phone}

Submit Register Form
    Click    ${REGISTER_SUBMIT_BUTTON}

Verify Registration Success
    ${toast_text}=    Get Text    ${REGISTER_SUCCESS_TOAST}
    Should Contain    ${toast_text}    Account created

Generate New User Data
    ${username}=      Generate Random Username
    ${first_name}=    Generate Random First Name
    ${last_name}=     Generate Random Last Name
    ${phone}=         Generate Random Phone
    VAR    ${NEW_USER_USERNAME}     ${username}       scope=TEST
    VAR    ${NEW_USER_FIRST_NAME}   ${first_name}     scope=TEST
    VAR    ${NEW_USER_LAST_NAME}    ${last_name}      scope=TEST
    VAR    ${NEW_USER_EMAIL}        ${username}@example.com    scope=TEST
    VAR    ${NEW_USER_PHONE}        ${phone}          scope=TEST
    VAR    ${NEW_USER_PASSWORD}     Test1234          scope=TEST
