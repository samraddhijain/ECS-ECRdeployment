*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/Standings/standings_locators.py
Resource    ../Fixtures and Results/fixturesresults_keywords.robot

*** Keywords ***
Click On Accordion
    Wait For Five Seconds
    Wait Until Element Is Visible     ${accordin_location}   timeout=20s
    Wait Until Keyword Succeeds    5    5    Press Keys     ${accordin_location}     Enter
    Wait Until Page Contains Element    (//p[contains(text()," Previous Match")])[1]    timeout=20s

Able To See Latest 3 Matches For Team Stands And Scorecard Text
    ${COUNT}    Get Element Count    ${matchscoretest}
    Should Be Equal As Integers    ${COUNT}    3

Click On First Match Card
    ${text1}     Get Text    ${matchcard_location_first}
    Click On Particular Element   ${matchcard_location_first}
    RETURN  ${text1}

Redirect To Rescpective Match Center Screen
    ${text2}     Get Text    ${matchcenter_text}
    Element Should Contain   ${matchcenter_text}    ${text2}


