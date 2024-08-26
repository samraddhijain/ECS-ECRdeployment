*** Settings ***
Library  SeleniumLibrary
Variables     ../../PageObjects/Fixtures and Results/fixturesresults_locators.py
Resource    ../../Resources/Fixtures and Results/fixturesresults_keywords.robot
Resource    ../../Resources/Players/Players_Keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables   ../../PageObjects/Players/Players_loacator.py
Variables   ../../PageObjects/Stats/stats_locator.py
Resource   ../../Resources/Stats/stats_keywords.robot
Variables   ../../PageObjects/Menu/Menu_locators.py

Test Setup      Launch Application
Test Teardown   Close Browser

*** Test Cases ***
TC95 Verify filter by skill as bowler
    [Tags]      Players
    Navigation Keyword    ${ipl_24_nav}  ${squad_page}  ${squad}
    Check Visibility And Click On Element   ${filter_name}
    Filter By Categories     ${filter_by_skills_player}    ${bowler_filter}
    Verify Applied Filter    ${bowler_text_page}

TC96 Verify filter by skill as allrounder
    [Tags]      Players         Sprint6
    Navigation Keyword    ${ipl_24_nav}  ${squad_page}  ${squad}
    Check Visibility And Click On Element   ${filter_name}
    Filter By Categories     ${filter_by_skills_player}     ${all_rounder_filter}
    Verify Applied Filter    ${all_rounders_text_page}

TC97 Verify filter by skill as wicketkeeper
    [Tags]      Players
    Navigation Keyword    ${ipl_24_nav}  ${squad_page}  ${squad}
    Check Visibility And Click On Element   ${filter_name}
    Filter By Categories     ${filter_by_skills_player}   ${wicket_keeper_filter}
    Verify Applied Filter    ${wicket_keeper_text_page}

TC98 Verify click on support staff tab
    [Tags]      Players
    Navigation Keyword    ${ipl_24_nav}  ${squad_page}  ${squad}
    Click On Support Staff And Verify

TC99 Verify redirection of all support staff to profile page
    [Tags]      Players     Demo
    Navigation Keyword    ${ipl_24_nav}  ${squad_page}  ${squad}
    Click On Support Staff And Verify
    Player profile Verification    ${support_staff_text_page}    ${player_card_support_staff}    ${player_name}     view_profile=${view_profile_support_staff}