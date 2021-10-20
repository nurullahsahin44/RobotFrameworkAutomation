*** Settings ***
Library   RequestsLibrary
Library   SeleniumLibrary
Library   String
Library   BuiltIn
Library   FakerLibrary
Library   JSONLibrary
Resource  Resources/Config/Environments/dev.robot

*** Keywords ***
create session chrome
    open browser  about:blank  chrome
    maximize browser window

I write and press Key
    [Arguments]  ${elementKey}  ${variable}    ${key}
    Wait Until Page Contains Element   ${elementKey}    timeout=15    error=DO NOT DISPLAYED inputText=${elementKey}
    input text  ${what needs to be done inputText}    ${variable}
    Press Keys  ${what needs to be done inputText}    ${key}
    Sleep  3s

I write press Key and Select item
    [Arguments]  ${variable}    ${key}
    Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED inputText
    input text  ${what needs to be done inputText}    ${variable}
    Press Keys  ${what needs to be done inputText}    ${key}
    click element  ${first item checkbox}
    Sleep  5s

I should see variable in table
    [Arguments]  ${variable}
    ${value}=   Get Text    ${last item}
    BuiltIn.Should be Equal As Strings   ${variable}  ${value}   msg=${variable} == ${value} does not Match
    Wait Until Page Contains Element   ${issue count}      timeout=15  error=DO NOT DISPLAYED ${issue count}
    Wait Until Page Contains Element   ${item left}      timeout=15  error=DO NOT DISPLAYED ${item left}
    Wait Until Page Contains Element   ${all button}      timeout=15  error=DO NOT DISPLAYED ${all button}


I will delete one item and verification with status
    [Arguments]  ${status}=unselect
    Run Keyword if  '${status}' == 'unselect'   unselectedDelete_S
    Run Keyword if  '${status}' == 'select'   selectedDelete_S
    ...  ELSE   BuiltIn.Fail  msg=HAVE TO CHOOSE selected or unselected


unselectedDelete_S
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == ''          And MySteps.I write and press Key   ${what needs to be done inputText}    test     ENTER
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == '1'      If exist 1 item do not see item left
    ...  ELSE   If exist items Delete and Verify item left Counts


selectedDelete_S
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == ''          And MySteps.I write and press Key   ${what needs to be done inputText}    test     ENTER
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == '0'      If exist 0 item do not see item left
    ...  ELSE   If exist items Delete and Verify item left Counts



If exist 0 item do not see item left
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Page should not contain element     ${last item}
    Sleep  5s


If exist 1 item do not see item left
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Page should not contain element     ${last item}
    Sleep  5s


If exist items Delete and Verify item left Counts
    ${firstIssueCount}=   Get Text    ${issue count}
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Sleep  3s
    ${firstIssueCount}=   Evaluate    ${firstIssueCount}-1
    ${lastIssueCount}=   Get Text    ${issue count}
    BuiltIn.Should be Equal As Strings   ${firstIssueCount}  ${lastIssueCount}   msg=${firstIssueCount} == ${lastIssueCount} does not Match


I click on any checkbox and see as a DONE
    [Arguments]  ${elementKey}  ${variable}
    ${firstIssueCountBefore}=   Get Text    ${issue count}
    ${firstIssueCountResponse}=   Evaluate    ${firstIssueCountBefore}-1
    click element    ${elementKey}
    ${firstIssueCountAfter}=   Get Text    ${issue count}
    Then BuiltIn.Should be Equal As Strings   ${firstIssueCountResponse}  ${firstIssueCountAfter}   msg=${firstIssueCountResponse} == ${firstIssueCountAfter} does not Match
    sleep  5s

List Should be empty
    Page should not contain element     ${last item}