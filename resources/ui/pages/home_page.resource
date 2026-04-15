*** Settings ***
Library    Browser
Resource    ../../variables.resource

*** Variables ***
${HOME_PAGE_HERO_TITLE}             xpath=//*[contains(@class,'hero-text')]//h1
${HOME_PAGE_USER_LABEL}             xpath=//*[@id='user-badge']
${HOME_PAGE_SIGN_IN_BUTTON}         xpath=//*[@id='btn-auth']
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
	Wait For Elements State    ${HOME_PAGE_SIGN_IN_BUTTON}    visible
	${page_title}=    Get Title
	Should Be Equal    ${page_title}    Petstore

Verify User Is Logged In As Guest
	Wait For Elements State    ${HOME_PAGE_USER_LABEL}    visible
    ${user_label}=    Get Text    ${HOME_PAGE_USER_LABEL}
    Should Be Equal    ${user_label}    Guest
	Wait For Elements State    ${HOME_PAGE_SIGN_IN_BUTTON}    visible

Verify Default Pet Is Displayed
	Wait For Elements State    ${HOME_PAGE_DEFAULT_PET_CARD}    visible
	${pet_name}=    Get Text    ${HOME_PAGE_DEFAULT_PET_NAME}
	Should Be Equal    ${pet_name}    ${DEFAULT_PET_NAME}