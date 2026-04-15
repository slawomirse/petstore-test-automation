*** Settings ***
Library     Browser
Resource    ../../variables.resource

*** Variables ***
${HOME_PAGE_HERO_TITLE}             xpath=//*[contains(@class,'hero-text')]//h1
${HOME_PAGE_USER_LABEL}             xpath=//*[@id='user-badge']
${HOME_PAGE_LOGIN_BUTTON}           xpath=//*[@id='btn-auth']
${HOME_PAGE_DEFAULT_PET_CARD}       xpath=//*[@id='featured-pets']//*[@data-id='${DEFAULT_PET_ID}']
${HOME_PAGE_DEFAULT_PET_NAME}       xpath=//*[@id='featured-pets']//*[@data-id='${DEFAULT_PET_ID}']//h3

*** Keywords ***
Open Home Page
	Go To    ${BASE_FRONTEND_URL}

Verify Page Is Loaded
    Wait For Load State    load

Verify Home Page Is Loaded
	Verify Page Is Loaded
	Wait For Elements State    ${HOME_PAGE_HERO_TITLE}    visible
	Wait For Elements State    ${HOME_PAGE_LOGIN_BUTTON}    visible
	${page_title}=    Get Title
	Should Be Equal    ${page_title}    Petstore

Verify User Is Logged In As Guest
    ${user_label}=    Get Text    ${HOME_PAGE_USER_LABEL}
    Should Be Equal    ${user_label}    Guest

Verify User Is Logged In
    [Arguments]    ${username}
    ${user_label}=    Get Text    ${HOME_PAGE_USER_LABEL}
    Should Be Equal    ${user_label}    ${username}
    ${login_button_text}=    Get Text    ${HOME_PAGE_LOGIN_BUTTON}
    Should Be Equal    ${login_button_text}    Sign Out

Logout
    Click    ${HOME_PAGE_LOGIN_BUTTON}

Logout If Needed
    ${user_label}=    Get Text    ${HOME_PAGE_USER_LABEL}
    IF    '${user_label}' != 'Guest'
        Logout
    END

Verify Default Pet Is Displayed
	${pet_name}=    Get Text    ${HOME_PAGE_DEFAULT_PET_NAME}
	Should Be Equal    ${pet_name}    ${DEFAULT_PET_NAME}