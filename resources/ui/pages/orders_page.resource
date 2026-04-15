*** Settings ***
Library     Browser
Library     ../../../libraries/order_parser.py
Resource    pets_page.resource

*** Variables ***
${PET_DETAIL_ORDER_BUTTON}         xpath=//*[@id='detail-order-btn']
${ORDER_MODAL_QUANTITY_INPUT}      xpath=//*[@id='of-qty']
${ORDER_MODAL_STATUS_SELECT}       xpath=//*[@id='of-status']
${ORDER_MODAL_SUBMIT_BUTTON}       xpath=//*[@id='order-form']//button[@type='submit']
${ORDER_SUCCESS_TOAST}             xpath=//*[contains(@class,'toast') and contains(normalize-space(),'Order #') and contains(normalize-space(),'placed')]
${ORDERS_NAV_LINK}                 xpath=//*[@data-page='orders']
${ORDERS_PAGE_TITLE}               xpath=//*[@id='page-orders']//h1[normalize-space()='My Orders']
${ORDERS_LOOKUP_ID_INPUT}          xpath=//*[@id='lookup-order-id']
${ORDERS_LOOKUP_BUTTON}            xpath=//*[@id='btn-lookup-order']
${PET_DETAIL_ID_VALUE}             xpath=//*[@id='pet-detail-content']//dt[normalize-space()='ID']/following-sibling::dd[1]
${ORDERS_LIST_HEADING}             xpath=//*[@id='orders-list']//h3
${ORDERS_LIST_PET_ID_LINE}         xpath=//*[@id='orders-list']//span[contains(normalize-space(),'Pet ID:')]
${NEW_ORDER_ID}                    ${EMPTY}
${NEW_ORDER_PET_ID}                ${EMPTY}

*** Keywords ***
Place Order For Pet
	[Arguments]    ${pet_name}    ${quantity}=1    ${status}=placed
	Open Pet Details By Name    ${pet_name}
	${pet_id}=    Get Text    ${PET_DETAIL_ID_VALUE}
	VAR    ${NEW_ORDER_PET_ID}    ${pet_id}    scope=TEST
	Click    ${PET_DETAIL_ORDER_BUTTON}
	Fill Text    ${ORDER_MODAL_QUANTITY_INPUT}    ${quantity}
	Select Options By    ${ORDER_MODAL_STATUS_SELECT}    value    ${status}
	Click    ${ORDER_MODAL_SUBMIT_BUTTON}
	${toast_text}=    Get Text    ${ORDER_SUCCESS_TOAST}
	Should Contain    ${toast_text}    Order #
	${order_id}=    Parse Order Id From Toast    ${toast_text}
	VAR    ${NEW_ORDER_ID}    ${order_id}    scope=TEST
	Wait For Elements State    ${ORDERS_PAGE_TITLE}    visible

Open Orders Page
	Click    ${ORDERS_NAV_LINK}
	Wait For Elements State    ${ORDERS_PAGE_TITLE}    visible

Lookup Order By Id
	[Arguments]    ${order_id}
	Fill Text    ${ORDERS_LOOKUP_ID_INPUT}    ${order_id}
	Click    ${ORDERS_LOOKUP_BUTTON}

Verify Order Was Created
	[Arguments]    ${order_id}
	${order_heading}=    Get Text    ${ORDERS_LIST_HEADING}
	Should Be Equal    ${order_heading}    Order #${order_id}

Verify Order Is For Pet
	[Arguments]    ${pet_id}
	${pet_line}=    Get Text    ${ORDERS_LIST_PET_ID_LINE}
	Should Contain    ${pet_line}    ${pet_id}