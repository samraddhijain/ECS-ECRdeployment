*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/Login/login_page_locators.py
Resource    ../Fixtures and Results/fixturesresults_keywords.robot
Variables   ../../PageObjects/Players/Players_loacator.py
Resource   ../../Resources/Stats/stats_keywords.robot
Variables   ../../PageObjects/Menu/Menu_locators.py

*** Variables ***
${india_name}       India

*** Keywords ***
Verify Applied Filter
    [Arguments]     ${page_verififctaion}
    Wait Until Element Is Visible    ${page_verififctaion}      timeout=10s

Verify Overseas Icon For Overseas Player
    Wait Until Element Is Visible    ${squad_page}  timeout=20s
    Wait For Five Seconds
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait For Five Seconds
    ${elements}=  Get WebElements    ${country_name}
    FOR    ${element}    IN    @{elements}
        ${text}=     Get Text    ${element}
        Run Keyword If    '${text}'!= '${india_name}'  Element Should Be Visible    ${overseas_player}
    END
    
Click On Support Staff And Verify
    Wait Until Element Is Visible    ${support_staff}   timeout=20s 
    Wait For Five Seconds
    Click Element    ${support_staff}
    Wait Until Element Is Visible    ${support_staff_text_page}  timeout=30s

Verify All Support Staff Profile Page
    ${staff_members}=  Get WebElements    ${support_staff_member_card}
    FOR    ${element}    IN    @{staff_members}
        ${text}    Get Text    ${element}
        Log    ${text}
          Scroll Element Into View    ${element}
          Click Element    ${view_profile_button_support_staff}
    END
