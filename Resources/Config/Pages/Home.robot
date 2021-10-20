*** Variables ***
${what needs to be done inputText}     //input[contains(@placeholder,'What needs to be done')]
${issue count}  //span[@class='todo-count']//*[contains(text(),'')]
${item left}  //span[@class='todo-count']/descendant-or-self::span[contains(text(),'items left') or contains(text(),'item left')]
${all button}   //a[.='All']
${active button}    //a[contains(@href,'active')]
${completed button}    //a[contains(@href,'completed')]
${first item}   (//*[@class='todo-list']//label)[1]
${first item checkbox}  (//*[@class='todo-list']//input[@type='checkbox'])[1]
${last item checkbox}  (//*[@class='todo-list']//input[@type='checkbox'])[last()]
${last item}    (//*[@class='todo-list']//label)[last()]
${first unselected remove button}     (//*[@class='todo-list']//button[@class='destroy'])[1]
${last unselected remove button}     (//*[@class='todo-list']//button[@class='destroy'])[last()]
${select all button}    //label[contains(@for,'toggle-all') and text()='Mark all as complete']
${first selected item}  //*[@class='todo completed']//label
${last selected item}  (//*[@class='todo completed']//label)[last()]
${clear all button}   //button[@class='clear-completed']
${all label in table}   //*[contains(@class,'todo-list')]//label
