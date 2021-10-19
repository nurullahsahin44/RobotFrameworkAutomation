*** Settings ***
Library   RequestsLibrary
Library   SeleniumLibrary
Library   String
Library   FakerLibrary
Library   JSONLibrary
Resource  Resources/Config/Environments/dev.robot

*** Keywords ***
create session chrome
    open browser  about:blank  chrome
    maximize browser window

I write and press Key
    [Arguments]  ${variable}    ${key}
    Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED inputText
    input text  ${what needs to be done inputText}    ${variable}
    Press Keys  ${what needs to be done inputText}    ${key}
