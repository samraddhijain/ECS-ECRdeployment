*** Settings ***
Library      SeleniumLibrary
Library    OperatingSystem
Resource    ../../Resources/Login/login_keywords.robot
Variables     ../../PageObjects/Hindi_homescreen/hindi_homescreen_locators.py
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py

*** Variables ***
${SWIPE_LIMIT}      100

*** Keywords ***
Click On Hindi Menu
    Wait Until Element Is Visible    ${hindi_menu}
    Click Element    ${hindi_menu}

Click On Aur Dekhe Link
    [Arguments]     ${Aur_dekhe_link}
    Wait Until Element Is Visible    ${Aur_dekhe_link}      timeout=15
    Click Element    ${Aur_dekhe_link}

Apply Filter
    Wait Until Element Is Visible    ${filter_button}   timeout=15
    Sleep    5s
    Click Element    ${filter_button}
    Wait Until Element Is Visible    ${filter_by_year_dropdown}  timeout=30
    Click Element    ${filter_by_year_dropdown}
    Wait Until Element Is Visible    ${filter_by_year_2023}    timeout=15
    Click Element    ${filter_by_year_2023}
    Wait Until Element Is Visible    ${apply_filter_button}    timeout=1
    Click Element    ${apply_filter_button}

Verify That The Data Is Displayed For The Year 2023
    Sleep   2s
    Wait Until Element Is Visible    ${MATCHES_2023}    timeout=30
    ${elements}=    Get WebElements    ${MATCHES_2023}
    Log    ${elements}
    FOR    ${element}    IN  @{elements}
        ${text}=    Get Text    ${element}
        Should Contain    ${text}    2023
    END

Verify Card Status
    Sleep   2s
    Wait Until Element Is Visible    ${parinam_text}    timeout=30
    ${elements}=    Get WebElements    ${parinam_text}
    Log    ${elements}
    FOR    ${element}    IN  @{elements}
        ${text}=    Get Text    ${element}
        Should Contain    ${text}    परिणाम
    END

Verify Match Data With Correct Match Number
    Sleep   2s
    Wait Until Element Is Visible    ${match_card}
    ${elements}=    Get WebElements    ${match_card}
     FOR    ${element}    IN RANGE  @{elements}
        ${text}=    Get Text    ${element}
        Log    ${text}
        Click Element    (${matchcenter_button})[${element}]
        Sleep    5
    END

Verify Redirection Of Points Table
    Wait Until Element Is Visible    ${point_table_title}
    Element Should Be Visible    ${point_table_title}

Verify Quilified Q For Top Four Teams
    FOR    ${i}    IN RANGE    1    5
        ${count}  Set Variable  1
        ${qualifier_locator}=  Replace String    ${qualifier_text}    index    ${count}
        Element Should Be Visible    ${qualifier_locator}
        ${count}=  Evaluate    ${count}+1
    END

Verify Quilified Q On Point Table For Top Four Teams
    Wait Until Element Is Visible    ${point_table_aur_dekhe_link}
    Click Element    ${point_table_aur_dekhe_link}
    Wait Until Element Is Visible    ${point_table_title}
    FOR    ${i}    IN RANGE    1    5
        ${count}  Set Variable  1
        ${qualifier_locator}=  Replace String    ${point_table_qualifier_text}    index    ${count}
        Element Should Be Visible    ${qualifier_locator}
        ${count}=   Evaluate    ${count}+1
    END

Verify Membership Banner Redirection
    Sleep    5
    Execute Javascript  window.scrollTo(0,600)
    Sleep    2
    Wait Until Element Is Visible   ${yaha_click_kare_button}     timeout=30s
    Press Keys    ${yaha_click_kare_button}      Enter
    Wait Until Element Is Visible    ${join_now_button}
    Element Should Be Visible   ${join_now_button}

Verify Hindi Video Redirection
    Sleep    2
    Scroll Element Into View    ${video_aur_dekhe_link}
    Wait Until Element Is Visible    ${video_aur_dekhe_link}
    Click On Aur Dekhe Link    ${video_aur_dekhe_link}

Verify Swiper Functionality
    Sleep    5
    ${count}  Set Variable  1
    Scroll Element Into View    (${squad_player_name})[${count}]
    ${player1_text}=  Get Text    (${squad_player_name})[${count}]
    Log    ${player1_text}
    Click Element    ${squad_right_arrow}
    Sleep    2
    ${count}=   Evaluate    ${count}+1
    ${player2_text}=   Get Text    (${squad_player_name})[${count}]
    Log    ${player2_text}
    Should Not Be Equal As Strings    ${player1_text}    ${player2_text}

Verify Swiper Functionality For Previous Player
    Sleep    5
    ${count}  Set Variable  1
    Scroll Element Into View    (${squad_player_name})[${count}]
    ${player1_text}=  Get Text    (${squad_player_name})[${count}]
    Log    ${player1_text}
    Click Element    ${squad_right_arrow}
    Sleep    2
    ${count}=   Evaluate    ${count}+1
    ${player2_text}=   Get Text    (${squad_player_name})[${count}]
    Log    ${player2_text}
    Should Not Be Equal As Strings    ${player1_text}    ${player2_text}
    Click Element    ${squad_left_arrow}
    Sleep    2
    ${count}=   Evaluate    ${count}-1
    ${player1_text_new}=    Get Text    (${squad_player_name})[${count}]
    Log    ${player1_text_new}
    Should Be Equal As Strings    ${player1_text}    ${player1_text_new}

Get Count Of Photo Cards And Compare It With Expected Count
    [Arguments]     ${photo_button_card}
    Wait Until Element Is Visible    ${total_photo_count}
    ${photo_count_present}  Get Text    ${total_photo_count}
    ${photo_buttons_cards}       Get WebElements    ${photo_button_card}
    ${count}=  Get Count Of All Webelements    ${photo_buttons}
    Should Be Equal As Integers   ${photo_count_present}    ${count}

Verify Hindi Photo Redirection
    Sleep    2
    Scroll Element Into View    ${aur_dekhe_photos_link}
    Click On Aur Dekhe Link    ${aur_dekhe_photos_link}
    Wait Until Element Is Visible    ${photos_page_verification}    timeout=20s

Click On Photo Card
    Wait Until Element Is Visible    ${photos_page_verification}    timeout=20s
    Click Element    ${photo_card}
    Wait Until Element Is Visible    ${photo_buttons}   timeout=20s

Click On Photo Buttons
    Wait Until Element Is Visible    ${photo_buttons}   timeout=20s
    Sleep    5s
    Click Element    ${photo_buttons}
    Wait Until Element Is Visible    ${photo_article1}  timeout=20s

get count of slider cards
    ${first_visible}=    Set Variable    True
     ${card_count}=    Set Variable    1
    FOR    ${index}    IN   ${SWIPE_LIMIT}
        Verify After click Swiper Button Content Should Get Change    ${swipe_right}    ${photo_article1}
        Sleep    2s
        ${card_count}=    Evaluate    ${card_count} + 1
        Sleep    1s
        Log    ${card_count}
        Verify After click Swiper Button Content Should Get Change    ${swipe_left}    ${photo_article2}
        Sleep    2s
        ${card_count}=    Evaluate    ${card_count} - 1
        Sleep    1s
        Log    ${card_count}
    END
    [Return]     ${card_count}

Download Photo
    Wait Until Element Is Visible    ${download_btn}     timeout=20s
    Click Element    ${download_btn}

Verify downloaded Photo
    ${now}  Get Time  epoch
    Sleep    2
    ${res}  Check Download And Return Filepath   ${now}
    Log    ${res}
    Should Contain    ${res}    .jpg
    File Should Exist    ${res}
    RETURN  ${res}