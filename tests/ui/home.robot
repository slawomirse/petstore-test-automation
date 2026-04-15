*** Settings ***
Resource    ../../resources/ui/pages/home_page.resource

*** Test Cases ***
Weryfikacja trybu gościa
    Open Home Page
    Verify Home Page Is Loaded
    Verify User Is Logged In As Guest

Weryfikacja domyślnego zwierzęcia na stronie głównej
    Open Home Page
    Verify Home Page Is Loaded
    Verify Default Pet Is Displayed