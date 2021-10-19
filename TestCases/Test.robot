*** Settings ***
Library   SeleniumLibrary
Library   RequestLibrary
Resource  Resources/Config/Environments/dev.robot
Resource  Resources/Config/Pages/Home.robot
Resource  Resources/Config/Pages/Login.robot
Resource  Resources/Steps/Base.robot
Resource  Resources/Steps/steps.robot

Test Setup   Base.create session firefox
Test Teardown  Base.close session

*** Test Cases ***
Tomodvc_Sayfasi_001
    Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED inputText


Yapilacak_is_Ekleme_002
deneme
    Given Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED inputText
    And steps.I write and press Key     deneme     ENTER
    Then sleep  5s

