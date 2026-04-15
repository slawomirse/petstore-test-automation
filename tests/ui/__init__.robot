*** Settings ***
Resource    ../../resources/ui/setup.resource
Resource    ../../resources/ui/teardown.resource

Suite Setup       Setup Browser
Suite Teardown    Teardown Browser Session
