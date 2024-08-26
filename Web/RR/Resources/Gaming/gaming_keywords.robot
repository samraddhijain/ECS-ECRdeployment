*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/Membership/membership_locators.py
Variables  ../../PageObjects/Login/login_page_locators.py
Variables  ../../PageObjects/Gaming/gaming_locators.py
Resource    ../Fixtures and Results/fixturesresults_keywords.robot

*** Keywords ***
Click On Quizzer From Menu
    Wait For Five Seconds
    Wait Until Element Is Not Visible    ${playnow_btn}    20s
    ${SELENIUM_SPEED}   Get Selenium Speed
    Set Selenium Speed    ${SELENIUM_SPEED}
    Wait Until Element Is Not Visible    ${playnow_btn}    20s
    Click On Particular Element    ${fanzone_dropdown}
    Wait Until Element Is Enabled   ${fanzone_val}     10s
    Click Element    ${fanzone_val}

User Shouldn't Ask For Login Again Will Able To View Play Now Button
    Page Should Not Contain Element    ${first_name_field}
    Wait Until Element Is Visible    ${playnow_btn}      10s

Getting Login Screen And Play Now Button
    Wait Until Element Is Not Visible    ${first_name_field}    30s
    Page Should Not Contain Element    ${last_name_field}
    Wait Until Element Is Visible    ${playnow_btn}      30s