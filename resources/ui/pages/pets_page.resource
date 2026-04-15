*** Settings ***
Library    Browser
Library    ../../../libraries/payload_builders.py

*** Variables ***
${BROWSE_PETS_NAV_LINK}          xpath=//*[@data-page='pets']
${BROWSE_PETS_PAGE_TITLE}        xpath=//*[@id='page-pets']//h1[normalize-space()='Browse Pets']
${ADD_NEW_PET_BUTTON}            xpath=//*[@id='btn-add-pet']
${PET_FORM_NAME_INPUT}           xpath=//*[@id='pf-name']
${PET_FORM_STATUS_SELECT}        xpath=//*[@id='pf-status']
${PET_FORM_CATEGORY_ID_INPUT}    xpath=//*[@id='pf-cat-id']
${PET_FORM_CATEGORY_NAME_INPUT}  xpath=//*[@id='pf-cat-name']
${PET_FORM_PHOTO_URL_INPUT}      xpath=//*[@id='pf-photo']
${PET_FORM_TAG_INPUT}            xpath=//*[@id='pf-tag']
${PET_FORM_SAVE_BUTTON}          xpath=//*[@id='pet-form']//button[@type='submit']
${PET_CREATE_SUCCESS_TOAST}      xpath=//*[contains(@class,'toast') and contains(normalize-space(),'Pet created')]

*** Keywords ***
Open Browse Pets Page
	Click    ${BROWSE_PETS_NAV_LINK}
	Wait For Elements State    ${BROWSE_PETS_PAGE_TITLE}    visible

Open Add New Pet Form
	Click    ${ADD_NEW_PET_BUTTON}
	Wait For Elements State    ${PET_FORM_SAVE_BUTTON}    visible

Generate New Pet Data
	${pet_name}=         Generate Random Dog Name    UiPet
	${photo_url}=        Set Variable    https://example.com/${pet_name}.jpg
	VAR    ${NEW_PET_NAME}             ${pet_name}      scope=TEST
	VAR    ${NEW_PET_STATUS}           available        scope=TEST
	VAR    ${NEW_PET_CATEGORY_ID}      1                scope=TEST
	VAR    ${NEW_PET_CATEGORY_NAME}    dog              scope=TEST
	VAR    ${NEW_PET_PHOTO_URL}        ${photo_url}     scope=TEST
	VAR    ${NEW_PET_TAG}              ui-test          scope=TEST

Fill New Pet Form
	[Arguments]    ${name}    ${status}    ${category_id}    ${category_name}    ${photo_url}    ${tag}
	Fill Text    ${PET_FORM_NAME_INPUT}           ${name}
	Select Options By    ${PET_FORM_STATUS_SELECT}    value    ${status}
	Fill Text    ${PET_FORM_CATEGORY_ID_INPUT}    ${category_id}
	Fill Text    ${PET_FORM_CATEGORY_NAME_INPUT}  ${category_name}
	Fill Text    ${PET_FORM_PHOTO_URL_INPUT}      ${photo_url}
	Fill Text    ${PET_FORM_TAG_INPUT}            ${tag}

Submit New Pet Form
	Click    ${PET_FORM_SAVE_BUTTON}

Verify New Pet Was Added
	[Arguments]    ${pet_name}
	${toast_text}=    Get Text    ${PET_CREATE_SUCCESS_TOAST}
	Should Contain    ${toast_text}    Pet created
	${new_pet_card}=    Set Variable    xpath=//*[@id='pets-grid']//h3[normalize-space()='${pet_name}']
	Wait For Elements State    ${new_pet_card}    visible