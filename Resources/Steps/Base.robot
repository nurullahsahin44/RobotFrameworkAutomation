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
close session
    close all browsers
create session firefox
    Open Browser   ${todom_url}  firefox  options=add_argument("--ignore-certificate-errors");
    maximize browser window
create session firefox ichannel
    Open Browser   ${URLichannel}  firefox  options=add_argument("--ignore-certificate-errors");
    maximize browser window
