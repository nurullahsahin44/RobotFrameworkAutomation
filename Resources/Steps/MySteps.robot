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
    [Arguments]  ${variable}    ${key}
    Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED inputText
    input text  ${what needs to be done inputText}    ${variable}
    Press Keys  ${what needs to be done inputText}    ${key}
    Sleep  5s

I should see variable
    [Arguments]  ${variable}
    ${value}=   Get Text    ${last item}
    BuiltIn.Should be Equal As Strings   ${variable}  ${value}   msg=${variable} == ${value} does not Match


I will delete one item and verification
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == ''      I write and press Key   test    ENTER
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == '1'      If exist 1 item do not see item left
    ...  ELSE   If exist items Delete and Verify item left Counts


If exist 1 item do not see item left
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Page should not contain element     ${item left}
    Sleep  5s


If exist items Delete and Verify item left Counts
    ${firstIssueCount}=   Get Text    ${issue count}
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Sleep  3s
    ${firstIssueCount}=   Evaluate    ${firstIssueCount}-1
    ${lastIssueCount}=   Get Text    ${issue count}
    BuiltIn.Should be Equal As Strings   ${firstIssueCount}  ${lastIssueCount}   msg=${firstIssueCount} == ${lastIssueCount} does not Match