*** Settings ***
Library   RequestsLibrary
Library   SeleniumLibrary
Library   String
Library   BuiltIn
Library   FakerLibrary
Library   JSONLibrary
Library   Collections
Resource  Resources/Config/Environments/dev.robot

*** Keywords ***

#elementKey = değerin girileceği input'a ait Locator (WebElement)
#variable = input'a yazılacak olan deger
#işlem bittikten sonra tıklanacak olan Key , (Enter-Backspace-Space...)
I write and press Key
    [Arguments]  ${elementKey}  ${variable}    ${key}
    Wait Until Page Contains Element   ${elementKey}    timeout=15    error=DO NOT DISPLAYED inputText=${elementKey}
    input text  ${what needs to be done inputText}    ${variable}
    Press Keys  ${what needs to be done inputText}    ${key}
    Sleep  3s

#uygulama bazlı bir fonksiyondur , what needs to be done inputText ' xpath'inin oldugu input'a variable degiskenini yazıp enter butonuna basılacaktır
I write press Key and Select item
    [Arguments]  ${variable}    ${key}
    Wait Until Page Contains Element   ${what needs to be done inputText}    timeout=15    error=DO NOT DISPLAYED inputText
    input text  ${what needs to be done inputText}    ${variable}
    Press Keys  ${what needs to be done inputText}    ${key}
    click element  ${first item checkbox}
    Sleep  5s


#ilgili sayfada birden fazla issue olusturmak için yazılmıstır,
#loop count : döngü sayisi, issue sayisi
#random üretilen isimleri liste olarak döndürmektedir,
Create Issue RANDOM and loop count
    [Arguments]  ${loop count}
    ${list}  Create List
    FOR  ${index}   IN RANGE   ${loop count}
    ${variable}    generate random string   5   [LOWER]
    MySteps.I write and press Key   ${what needs to be done inputText}    ${variable}     ENTER
    Collections.Append To List  ${list}   ${variable}
    END
    [Return]  ${list}



#uygulama bazlı bir fonksiyondur, tüm listenin içerisinde bulunan degerlerden text'ine göre ekranda arama yapmaktadır
I should see variable in table
    [Arguments]  ${variable}
    ${elementKey}=  Set Variable   //*[contains(@class,'todo-list')]//label[text()='${variable}']
    Element Should Contain  ${elementKey}   ${variable}


#uygulama bazlı bir fonksiyon olup, uygulamaya eklenen son degerin ekranda oldugunun kontrolü yapılmaktadır
I should see last variable in table
    [Arguments]  ${variable}
    ${value}=   Get Text    ${last item}
    BuiltIn.Should be Equal As Strings   ${variable}  ${value}   msg=${variable} == ${value} does not Match
    Wait Until Page Contains Element   ${issue count}      timeout=15  error=DO NOT DISPLAYED ${issue count}
    Wait Until Page Contains Element   ${item left}      timeout=15  error=DO NOT DISPLAYED ${item left}
    Wait Until Page Contains Element   ${all button}      timeout=15  error=DO NOT DISPLAYED ${all button}

#parametrik olarak gelen bir WebElement ekranda kontrolünü yapmaktadır, daha anlasılır olması için eklenmiştir
I should not see variable in table
    [Arguments]  ${variable}
    Page should not contain element  ${variable}

#parametrik olarak gelen Web element içerisinde variable degerini aramaktadır
I should see VARIABLE in ELEMENTKEY
    [Arguments]  ${variable}    ${elementKey}
    Element Should Contain   ${elementKey}  ${variable}

#uygulama bazlı olup, ekrandan deger silme islemi yapılmaktadır,
#default olarak unselect parametresine göre ayarlanmıstır
#ayrı ayrı olmasının sebebi ekranda bulunan 0 item left - 1 item left içerisinde deger kontrolü için eklenmiştir,
I will delete one item and verification with status
    [Arguments]  ${status}=unselect
    Run Keyword if  '${status}' == 'unselect'   unselectedDelete_S
    ...  ELSE IF  '${status}' == 'select'   selectedDelete_S
    ...  ELSE   BuiltIn.Fail  msg=HAVE TO CHOOSE selected or unselected

#Üstteki fonksiyon için yazılmıstır,
#eger hiç data yoksa ekleyip silme islemi yapılacaktır
#eger 1 tane varsa onu silecektir
#eger 1+ tane varsa içlerinden 1 tane silecektir
unselectedDelete_S
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == ''          And MySteps.I write and press Key   ${what needs to be done inputText}    test     ENTER
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == '1'      If exist 1 item do not see item left
    ...  ELSE   If exist items Delete and Verify item left Counts


#Üstteki fonksiyon için yazılmıstır,
#eger hiç data yoksa ekleyip silme islemi yapılacaktır
#eger 1 tane varsa onu silecektir
#eger 1+ tane varsa içlerinden 1 tane silecektir
selectedDelete_S
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == ''          And MySteps.I write and press Key   ${what needs to be done inputText}    test     ENTER
    ${firstIssueCount}=   Get Text    ${issue count}
    Run Keyword if  '${firstIssueCount}' == '0'      If exist 0 item do not see item left
    ...  ELSE   If exist items Delete and Verify item left Counts


#Ekranda bulunan remove elementi üzerine gelindiğinde tıklanılabilir durumda oldugu için, javascript komutları ile tıklanabilmektedir,
If exist 0 item do not see item left
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Page should not contain element     ${last item}
    Sleep  5s

#Ekranda bulunan remove elementi üzerine gelindiğinde tıklanılabilir durumda oldugu için, javascript komutları ile tıklanabilmektedir,
If exist 1 item do not see item left
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Page should not contain element     ${last item}
    Sleep  5s

#eğer ekranda 1 den fazla item varsa, bunlardan 1 tanesini silip  1 item left yazisi içerisinde değerin kontrol edilmesi için eklenmiştir,
If exist items Delete and Verify item left Counts
    ${firstIssueCount}=   Get Text    ${issue count}
    ${ele}    Get WebElement    (//*[@class='todo-list']//button[@class='destroy'])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    Sleep  3s
    ${firstIssueCount}=   Evaluate    ${firstIssueCount}-1
    ${lastIssueCount}=   Get Text    ${issue count}
    BuiltIn.Should be Equal As Strings   ${firstIssueCount}  ${lastIssueCount}   msg=${firstIssueCount} == ${lastIssueCount} does not Match


#parametrik olarak gelen degeri done'a alınması için yazılmıstır,
I click on any checkbox and see as a DONE
    [Arguments]  ${elementKey}
    ${firstIssueCountBefore}=   Get Text    ${issue count}
    ${firstIssueCountResponse}=   Evaluate    ${firstIssueCountBefore}-1
    click element    ${elementKey}
    ${firstIssueCountAfter}=   Get Text    ${issue count}
    Then BuiltIn.Should be Equal As Strings   ${firstIssueCountResponse}  ${firstIssueCountAfter}   msg=${firstIssueCountResponse} == ${firstIssueCountAfter} does not Match
    sleep  5s


#uygulama bazlı olup, ekranda herhangi bir item olmadıgını kontrol eder,
List Should be empty
    Page should not contain element     ${last item}


#parametrik olarak gelen elementKey eğer ekranda var ise TIKLA, yoksa herhangi birşey yapma
If exist ELEMENT click to
    [Arguments]  ${elementKey}
    ${status}=  Run Keyword and return status
    ...  Page should contain element   ${elementKey}
    Run Keyword if  ${status}   click element  ${elementKey}


#parametrik olarak gelen Text sayfada DONE olarak görünme kontrolü yapilmaktadir,
Should See DONE in List
    [Arguments]  ${elementText}
    Page should contain element     //*[@class='todo completed']//label[text()='${elementText}']

