*** Settings ***
Library   SeleniumLibrary
Library   RequestLibrary
Library   XML
Resource  Resources/Config/Environments/dev.robot
Resource  Resources/Config/Pages/Home.robot
Resource  Resources/Config/Pages/Login.robot
Resource  Resources/Steps/Base.robot
Resource  Resources/Steps/MySteps.robot

Test Setup   Base.create session chrome
Test Teardown  Base.close session

*** Test Cases ***
Todomvc_Page_Display
    Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED ${what needs to be done inputText}


Todo_Add_Issue_002
    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    Then MySteps.I should see last variable in table  ${variable}


Todo_Add_Issue_Unselect_Remove_003
    Then MySteps.I will delete one item and verification with status  unselect
    Then List Should be empty


Todo_Add_Issue_Select_004
    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}


Todo_Add_Issue_Select_Remove_005
deneme
    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}
    Then I will delete one item and verification with status   select



Todo_Add_MoreIssues_ClearCompleted button_006
    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}

    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}

    ${variable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    And MySteps.I should see last variable in table  ${variable}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}

    When click element  ${clear all button}
    Then List Should be empty


Todo_Add_Issue_All-Active-Completed buttons_007
    ${firstVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${firstVariable}     ENTER
    And I should see VARIABLE in ELEMENTKEY  ${firstVariable}   ${last item}
    Then I click on any checkbox and see as a DONE   ${last item checkbox}

    ${secondVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${secondVariable}     ENTER
    And I should see VARIABLE in ELEMENTKEY  ${secondVariable}   ${last item}

    ${thirdVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${thirdVariable}     ENTER
    And I should see VARIABLE in ELEMENTKEY  ${thirdVariable}   ${last item}

    ${fourthVariable}    generate random string   5   [LOWER]
    And MySteps.I write and press Key   ${what needs to be done inputText}    ${fourthVariable}     ENTER
    And I should see VARIABLE in ELEMENTKEY  ${fourthVariable}   ${last item}

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