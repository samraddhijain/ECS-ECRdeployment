*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    ${CURDIR}${/}..${/}..${/}Utilities${/}user_keywords.py
Library    OperatingSystem

*** Variables ***
${Mobile_num}   9800000001
${Mobile_numtwo}    9999999999
${MOBILE_NUM_FILE}       ${CURDIR}${/}..${/}TestData${/}mobile_num.xlsx
${expected_player_file}     ${CURDIR}${/}..${/}TestData${/}player_details.xlsx
${table_header_list}     ${CURDIR}${/}..${/}TestData${/}table_header.xlsx
${table_column_details_list}     ${CURDIR}${/}..${/}TestData${/}details.xlsx

*** Keywords ***
Login With Otp For Web
    [Arguments]     ${Login_button_xpath}   ${mobile_input_xpath}    ${excel_data}
    ${my_dict}=  Create Dictionary      &{excel_data}
    Wait Until Element Is Visible    ${Login_button_xpath}   timeout=20s
    Click Element    ${Login_button_xpath}
    Wait Until Element Is Visible    ${mobile_input_xpath}    timeout=30s
    Input Text    ${mobile_input_xpath}   ${my_dict['mobile_number']}

Squad Verification
    [Arguments]     ${player_card_xpath}     ${player_name_xpath}    ${Player_role_xpath}   ${excel_data}
    [Documentation]     Pass xpath of each elements div
    ${my_dict}=  Create Dictionary      &{excel_data}
    Wait Until Element Is Visible    ${player_name_xpath}     timeout=20s
    Wait For Five Seconds
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait For Five Seconds
    @{player_list}=     Get WebElements    ${player_name_xpath}
    ${count}=   Get Element Count    ${player_card_xpath}
    Log    ${count}
    ${Actual_list}=  Create List
    FOR    ${element}     IN    @{player_list}
        Wait Until Element Is Visible    ${player_name_xpath}     timeout=20s
        Element Should Be Visible    ${player_name_xpath}
        Element Should Be Visible    ${Player_role_xpath}
        ${details}=      Get Text    ${element}
        Log     ${details}
        @{split}=   Split String    ${details}      \n
        ${fullname}=   Evaluate    "${split}[0] ${split}[1]"
        Log    ${fullname}
        Append To List   ${Actual_list}   ${fullname}
        Log    ${Actual_list}
    END
       ${expected_player}  Get From Dictionary    ${my_dict}    players
       Lists Should Be Equal      ${expected_player}    ${Actual_list}

Player Profile Verification
    [Arguments]     ${squad_page_verification}   ${specific_player_card_xpath}      ${specific_player_name_xpath}  ${excel_data}=None  ${date_of_birth}=None    ${batting_style}=None    ${bowling_style}=None  ${view_profile}=None
    [Documentation]     Pass xpath of respective divisions without using its inner text
    Log    ${excel_data}
    Wait Until Element Is Visible    ${squad_page_verification}       timeout=20s
    Scroll Element Into View    ${specific_player_card_xpath}
#    Mouse Over    ${specific_player_card_xpath}
    ${view_profile_present}=    Run Keyword And Return Status    Element Should Be Visible    ${view_profile}
    IF   '${view_profile_present}' == 'True'
         Scroll Element Into View    ${view_profile}
         Click Element    ${view_profile}
    ELSE
         Click Element    ${specific_player_card_xpath}
    END
    Wait For Five Seconds
    ${date_of_birth_visible}=  Run Keyword And Return Status     Element Should Be Visible    ${date_of_birth}
    IF  '${date_of_birth_visible}'=='True'
         Wait Until Element Is Visible    ${date_of_birth}     timeout=30s
         Element Should Be Visible    ${date_of_birth}
         ${date_of_birth_value}  Get Text    ${date_of_birth}
         ${fulldate}=   Evaluate    "${excel_data['dob']}[0], ${excel_data['dob']}[1]"
         Should Be Equal   ${date_of_birth_value}   ${fulldate}

         Element Should Be Visible    ${batting_style}
         ${batting_style_value}  Get Text    ${batting_style}
         Should Be Equal As Strings    ${batting_style_value}    ${excel_data['batting_style']}

         Element Should Be Visible    ${bowling_style}
         ${bowling_style_value}  Get Text    ${bowling_style}
         Should Be Equal As Strings    ${bowling_style_value}    ${excel_data['bowling_style']}

         Element Should Be Visible    ${specific_player_name_xpath}
         ${player_name_value}  Get Text    ${specific_player_name_xpath}
         @{split}=   Split String    ${player_name_value}      \n
         ${fullname}=   Evaluate    "${split}[0] ${split}[1]"
         Should Be Equal As Strings    ${fullname}    ${excel_data['player_name']}
    END

Navigation Keyword
    [Arguments]     ${main_menu}    ${navigation_page}   ${dropdown_menu}=None
    [Documentation]     Navigate To Respective Page After Clicking On Nav Menu
    Wait Until Element Is Visible    ${main_menu}   timeout=30s
    Mouse Over    ${main_menu}
    ${dropdown_menu_present}=  Run Keyword And Return Status   Page Should Contain Element    ${dropdown_menu}
    Wait For Five Seconds
    Click Element    ${main_menu}
    Wait For Five Seconds
    Run Keyword If    '${dropdown_menu_present}'== 'True'     Click Element    ${dropdown_menu}
    Wait Until Element Is Visible    ${navigation_page}     timeout=30s

Scroll Page Down slowly
    [Arguments]    ${end_element}
    WHILE    True
        Wait For Five Seconds
        Scroll Down
        ${end_element_visible}=    Run Keyword And Return Status   Element Should Be Visible    ${end_element}
        Log    ${end_element_visible}
        Capture Page Screenshot
        Run Keyword If    '${end_element_visible}' == 'True'    Exit For Loop
    END

Scroll Page Down With Load More
    [Arguments]    ${load_more}=None    ${bottom_item}=None     ${element_xpath}=None
    WHILE    True
            ${status}   Run Keyword And Return Status       Wait Until Element Is Visible   ${load_more}
            IF    ${status} ==True
                Scroll Element Into View   ${bottom_item}
                Click Element    ${load_more}
                Sleep    2
                Get Count Of All Webelements    ${element_xpath}
            ELSE
                 BREAK
            END
    END

Share Icon On News And Photos
    [Arguments]      ${sharing_apps}   ${share_icon}=None    ${verification_link}=None    ${expected_link}=None
    ${share_icon_visible}   Run Keyword And Return Status    Element Should Be Visible    ${share_icon}
    ${sharing_apps_visible}     Run Keyword And Return Status    Element Should Be Visible    ${sharing_apps}
    Run Keyword If   ' ${share_icon_visible}' == 'True'  Mouse Over     ${share_icon}
    IF  ${share_icon_visible} !=True
        Click Element    ${sharing_apps}
        Sleep    5s
    ELSE
        Wait Until Element Is Visible    ${share_icon}  timeout=20s
        Click Element    ${share_icon}
        Wait Until Element Is Visible    ${sharing_apps}   timeout=20s
        Capture Page Screenshot
    END
    ${sharing_apps_visible1}     Run Keyword And Return Status    Element Should Be Visible    ${sharing_apps}
    Run Keyword If    '${sharing_apps_visible1}' == 'True'       Click Element    ${sharing_apps}

Scroll Down
    ${scroll_position}=    Execute JavaScript    return window.pageYOffset
    Log    ${scroll_position}
    ${previous_position}=    Set Variable    -1
    Log    ${previous_position}
    WHILE   True
        ${scroll_position}=    Evaluate    ${scroll_position} + 50
        Execute JavaScript    window.scrollTo(0, ${scroll_position})
        Sleep    0.5s
        ${current_position}=    Execute JavaScript    return window.pageYOffset
        Run Keyword If    '${current_position}' == '${previous_position}'    Exit For Loop
        ${previous_position}=    Set Variable    ${current_position}
    END

Verify After click Swiper Button Content Should Get Change
    [Arguments]     ${swiper_click}    ${card_Content}
    Wait Until Element Is Visible    ${card_content}    timeout=30s
    Click Element    ${swiper_click}

Verify Redirection Of Page On Pagination Click
    [Arguments]     ${page_number}     ${page1_content}    ${page2_content}
    Wait Until Element Is Visible    ${page1_content}   timeout=30s
    Scroll Element Into View    ${page_number}
    Click Element    ${page_number}
    Element Should Be Visible    ${page2_content}

Page Footer Links
    [Arguments]     ${footer_xpath}     ${page_Verfication}
    Scroll Element Into View    ${footer_xpath}
    Click Element    ${footer_xpath}
    Wait Until Element Is Visible    ${page_Verfication}    timeout=30s

Verify Navigation To Play Store
    [Arguments]    ${playstore}   ${expected_url}=None
    Wait Until Element Is Visible    ${playstore}    timeout=30s
    Click Element    ${playstore}
    Switch Window    NEW
    ${current_url}=    Get Location
    Should Be Equal As Strings    ${current_url}    ${expected_url}

Verify Table Header Details
   [Arguments]    ${header_text_list}    ${table_header_text_xpath}
   [Documentation]    Takes list of all table headers and common xpath of table header text elements
   ${headerdict}=  Create Dictionary      &{header_text_list}
   @{column_list}    Create List
    @{table_header}   Get Webelements    ${table_header_text_xpath}
   FOR   ${column_name}    IN    @{table_header}
       ${column_name}     Get Text    ${column_name}
       Append To List    ${column_list}    ${column_name}
       Log     ${column_list}
   END
   ${expected_table_header}  Get From Dictionary    ${headerdict}    HEADER
   Lists Should Be Equal    ${column_list}    ${expected_table_header}

Verify Table Column Details
   [Arguments]    ${column_content_list}    ${column_text_xpath}
   [Documentation]    Takes list of all column values and common xpath of column text elements
   ${columndict}=  Create Dictionary      &{column_content_list}
   @{column_value_list}    Create List
   Wait For Five Seconds
   @{column_values}   Get Webelements    ${column_text_xpath}
   FOR   ${column_value}    IN    @{column_values}
       ${column_value_text}     Get Text    ${column_value}
       Append To List    ${column_value_list}    ${column_value_text}
   END
     ${expected_column_details}  Get From Dictionary    ${columndict}    Details
   Lists Should Be Equal    ${column_value_list}    ${expected_column_details}

Click On The Social Media Icons
   [Arguments]    ${social_media_site}
   [Documentation]    Takes social media site name as argument and verifies the navigation to respective social site page
   Sleep    2
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
   ${social_media_site}    Convert To Upper Case    ${social_media_site}
   IF  '${social_media_site}' == 'TWITTER'
       Scroll Element Into View    //a[contains(@href,'https://twitter.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://twitter.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://twitter.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'FACEBOOK'
       Scroll Element Into View    //a[contains(@href,'https://www.facebook.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.facebook.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.facebook.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'INSTAGRAM'
       Scroll Element Into View    //a[contains(@href,'https://www.instagram.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.instagram.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.instagram.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'YOUTUBE'
       Scroll Element Into View    //a[contains(@href,'https://www.youtube.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.youtube.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.youtube.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'LINKEDIN'
       Scroll Element Into View    //a[contains(@href,'https://www.linkedin.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.linkedin.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.linkedin.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   END

Click On The Footer Links
   [Arguments]    ${xpath_of_footerlink}
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
   Scroll Element Into View    ${xpath_of_footerlink}
   ${footer_text}   Get Text    ${xpath_of_footerlink}
   Log To Console    ${footer_text}
   Click Element    ${xpath_of_footerlink}
   Page Should Contain    ${footer_text}

Verify Cell Value Verification
   [Arguments]    ${xpath_of_table_shell}    ${cell_value}
   ${cell_value_text}    Get Text    ${xpath_of_table_shell}
   Should Be Equal    ${cell_value_text}    ${cell_value}

Sign Up Details Web
    [Arguments]   ${firstname}  ${lastname}   ${excel_data}   ${mail}=None     ${mobile_number}=None
    ${my_dict}=  Create Dictionary      &{excel_data}
    Wait Until Element Is Visible    ${firstname}   timeout=30s
    Input Text    ${firstname}    ${my_dict.firstname}
    Wait Until Element Is Visible    ${lastname}    timeout=30s
    Input Text    ${lastname}    ${my_dict.lastname}
    ${mail_present}=  Run Keyword And Return Status    Element Should Be Visible    ${mail}
    ${mobile_number_present}=  Run Keyword And Return Status    Element Should Be Visible    ${mobile_number}
    Run Keyword If    '${mail_present}'== 'True'  Input Text    ${mail}    abc@gmail.com
    Run Keyword If    '${mobile_number_present}'== 'True'  Input Text    ${mobile_num}    ${Mobile_numtwo}

#added later
Verify Navigation Link
    [Arguments]     ${expected_url}
    ${current_url}=  Get Location
    Should Be Equal As Strings    ${current_url}    ${expected_url}

Get Count Of All Webelements
    [Arguments]     ${element_xpath}
    ${element}=  Get WebElements    ${element_xpath}
    ${present_count}=   Get Length    ${element}
    Log    ${present_count}

Check Visibility And Click On Element
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}    timeout=30
    Wait For Five Seconds
    Click Element    ${element}

Verify Downloaded PDF
    ${now}  Get Time  epoch
    Sleep    10
    ${res}  Check Download And Return Filepath   ${now}
    Log    ${res}
    Should Contain    ${res}    .pdf
    File Should Exist    ${res}
    RETURN  ${res}

Filter By Categories
    [Arguments]      ${filter_by_skills}  ${filter_by_dropdown}
    Wait Until Element Is Visible    ${filter_by_skills}     timeout=20s
    Click Element    ${filter_by_skills}
    Wait Until Element Is Visible    ${filter_by_dropdown}    timeout=20s
    Click Element    ${filter_by_dropdown}

Wait For Five Seconds
    Sleep    5s