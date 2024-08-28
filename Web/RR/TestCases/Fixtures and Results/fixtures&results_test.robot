*** Settings ***
Library  SeleniumLibrary
Resource  ../../Resources/Membership/membership_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource    ../../Resources/Gaming/gaming_keywords.robot
Resource    ../../Resources/Fixtures and Results/fixturesresults_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables    ../../../../CommonBase/Web/PageObjects/web_common_loc.py

Test Setup      Launch Application
Test Teardown   Close Browser

*** Test Cases ***
Verify the filter functionality by year
    [Tags]      FixturesandResults
    Navigation Keyword    ${ipl_24_nav}    ${matches_page}  ${matches}
    Check Visibility And Click On Element    ${filter_iplpage}
    Filter By Categories    ${filter_year}    ${ipl_yeardropdownval}
    URL Change And Updated For Ipl Page
    Fixtures And Results 2023 Will Show With Recent lable

Verify the filter functionality by teams\
    [Tags]      FixturesandResults
    Navigation Keyword    ${ipl_24_nav}    ${matches_page}  ${matches}
    Check Visibility And Click On Element    ${filter_iplpage}
    Filter By Categories    ${filter_team}     ${filter_teamval}
    Check Visibility And Click On Element   ${apply_filteroption}
    View Only Team Fixtures     ${kkr_text}

Verify the filter functionlity by status
    [Tags]      FixturesandResults
    Navigation Keyword    ${ipl_24_nav}    ${matches_page}  ${matches}
    Check Visibility And Click On Element    ${filter_iplpage}
    Filter By Categories    ${filter_status}     ${filter_statusval}
    Check Visibility And Click On Element   ${apply_filteroption}
    View Only Upcoming Matches Of Rajasthan Royals

Verify reset filter functionality
    [Tags]      FixturesandResults
    Navigation Keyword    ${ipl_24_nav}    ${matches_page}  ${matches}
    Check Visibility And Click On Element    ${filter_iplpage}
    Filter By Categories    ${filter_status}     ${filter_statusval}
    Check Visibility And Click On Element   ${apply_filteroption}
    Capture Page Screenshot
    Reload Page
    Check Visibility And Click On Element    ${filter_iplpage}
    Click On Particular Element    ${filter_resetbtn}
    Capture Page Screenshot
    View Only Team Fixtures     ${filter_rrtxt}

TC77 Verify the filter functionality by year 2023
    [Tags]      FixturesandResults
    Navigation Keyword    ${ipl_24_nav}    ${matches_page}  ${matches}
    Check Visibility And Click On Element    ${filter_iplpage}
    Filter By Categories    ${filter_year}    ${ipl_yeardropdownval}
    URL Change And Updated For Ipl Page
