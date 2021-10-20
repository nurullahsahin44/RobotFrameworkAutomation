*** Settings ***
Library   SeleniumLibrary
Library   RequestLibrary
Library   XML
Resource  Resources/Config/Environments/dev.robot
Resource  Resources/Config/Pages/Home.robot
Resource  Resources/Config/Pages/Login.robot
Resource  Resources/Steps/Base.robot
Resource  Resources/Steps/MySteps.robot

Test Setup   Base.create session firefox
Test Teardown  Base.close session

*** Test Cases ***
Tomodvc_Sayfasi_001
    Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED ${what needs to be done inputText}


Yapilacak_is_Ekleme_002
    ${variable}    generate random string   5   [LOWER]
    Given Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED ${what needs to be done inputText}
    And MySteps.I write and press Key     ${variable}     ENTER
    Then Wait Until Page Contains Element   ${issue count}      timeout=15  error=DO NOT DISPLAYED ${issue count}
    Then Wait Until Page Contains Element   ${item left}      timeout=15  error=DO NOT DISPLAYED ${item left}
    Then Wait Until Page Contains Element   ${all button}      timeout=15  error=DO NOT DISPLAYED ${all button}
    Then MySteps.I should see variable  ${variable}


Yapilacak_is_Ekleme_SecilmedenSilme_003
    ${variable}    generate random string   5   [LOWER]
    Given Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED ${what needs to be done inputText}
    And MySteps.I write and press Key     ${variable}     ENTER
    Then Wait Until Page Contains Element   ${issue count}      timeout=15  error=DO NOT DISPLAYED ${issue count}
    Then Wait Until Page Contains Element   ${item left}      timeout=15  error=DO NOT DISPLAYED ${item left}
    Then Wait Until Page Contains Element   ${all button}      timeout=15  error=DO NOT DISPLAYED ${all button}
    Then MySteps.I should see variable  ${variable}
    And MySteps.I write and press Key     ${variable}     ENTER
    And MySteps.I write and press Key     ${variable}     ENTER
    And MySteps.I write and press Key     ${variable}     ENTER
    Then MySteps.I will delete one item and verification
