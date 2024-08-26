*** Settings ***
Library      SeleniumLibrary
Resource    ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Utilities/user_keywords.py
Resource    ../../Resources/Hindi_homescreen/hindi_homescreen_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Library     ../../../../CommonBase/Utilities/user_keywords.py

Test Setup  Launch Application
Test Teardown  Close Browser

*** Variables ***
${hindi_menu_url}  https://stg-rr.sportz.io/hi/home
${aur_dekhe_url}    https://stg-rr.sportz.io/hi/schedule-fixtures-results
${filter_by_year_2023_url}   https://stg-rr.sportz.io/hi/schedule-fixtures-results-2023
${video_url}    https://stg-rr.sportz.io/hi/videos
${photos_url}   https://stg-rr.sportz.io/hi/photos

*** Test Cases ***
TC207 Verify membership banner redirection on non hindi membership page
    [Tags]      HindiHomescreen
    Click On Hindi Menu
    Verify Membership Banner Redirection

TC208 Verify hindi video widget's aur dekhe link rediection
    [Tags]      HindiHomescreen
    Click On Hindi Menu
    Verify Hindi Video Redirection
    Verify Navigation Link    ${video_url}

TC205 Verify filter by 2023 year
    [Tags]      HindiFixture
    Click On Hindi Menu
    Click On Aur Dekhe Link    ${view_more_link}
    Apply Filter
    Verify Navigation Link    ${filter_by_year_2023_url}
    Verify That The Data Is Displayed For The Year 2023

TC206 Verify the filyer by year 2022 to 2021
    [Tags]      HindiFixture        DemoSprint7
    Click On Hindi Menu
    Click On Aur Dekhe Link    ${view_more_link}
    Apply Filter
    Verify Navigation Link    ${filter_by_year_2023_url}
    Verify That The Data Is Displayed For The Year 2023

TC204 Verify the redirections of fixtures view more link
    [Tags]      HindiHomescreennew      DemoSprint7
    Click On Hindi Menu
    Click On Aur Dekhe Link    ${view_more_link}
    Verify Navigation Link    ${aur_dekhe_url}