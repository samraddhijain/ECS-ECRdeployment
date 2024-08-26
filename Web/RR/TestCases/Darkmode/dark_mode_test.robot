*** Settings ***
Library  SeleniumLibrary
Library    DocTest.VisualTest
Resource    ../../Resources/Membership/membership_keywords.robot
Resource    ../../Resources/Membership/membership_page_navigation.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Resource   ../../Resources/Membership/Post_Payment_keywords.robot

Test Setup      Launch Application
Test Teardown   Close Browser

*** Test Cases ***
TC91 Verify Homepage UI in dark mode
    [Tags]      DarkMode        Sprint6
    Check Visibility And Click On Element    ${darkmode_toggle}
    Theme Should Get Change To Dark