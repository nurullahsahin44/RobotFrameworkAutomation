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
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    Then MySteps.I should see last variable in table  ${variable}


Yapilacak_is_Ekleme_SecilmedenSilme_003
    Then MySteps.I will delete one item and verification with status  unselect
    Then List Should be empty


Yapilacak_is_Eklenilmesi_Secilmesi_004
    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}   ${variable}


Yapilacak_is_Ekleme_SecilerekSilme_005
    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}   ${variable}
    Then I will delete one item and verification with status   select



Yapilacak_is_BirdenFazla_Ekleme_ClearCompleted_006
    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}   ${variable}

    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}   ${variable}

    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}   ${variable}

    When click element  ${clear all button}
    Then List Should be empty


Yapilacak_is_Ekleme_All_Active_Completed_007
    ${firstVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${firstVariable}     ENTER
    And I should see VARIABLE in ELEMENTKEY  ${firstVariable}   ${last item}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}   ${firstVariable}

    ${secondVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${secondVariable}     ENTER

    ${thirdVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${thirdVariable}     ENTER

    ${fourthVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${fourthVariable}     ENTER

    click element   ${all button}
    And MySteps.I should see variable in table  ${firstVariable}
    And MySteps.I should see variable in table  ${secondVariable}
    And MySteps.I should see variable in table  ${thirdVariable}
    And MySteps.I should see variable in table  ${fourthVariable}

    click element  ${active button}
    And MySteps.I should not see variable in table  ${firstVariable}
    And MySteps.I should see variable in table  ${secondVariable}
    And MySteps.I should see variable in table  ${thirdVariable}
    And MySteps.I should see variable in table  ${fourthVariable}

    click element  ${completed button}
    And MySteps.I should see variable in table  ${firstVariable}
    And MySteps.I should not see variable in table  ${secondVariable}
    And MySteps.I should not see variable in table  ${thirdVariable}
    And MySteps.I should not see variable in table  ${fourthVariable}