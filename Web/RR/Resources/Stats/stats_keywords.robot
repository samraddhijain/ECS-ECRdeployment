*** Settings ***
Library     SeleniumLibrary
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables       ../../PageObjects/Stats/stats_locator.py


*** Keywords ***
Check Decresing Order Of Column After Filter
    [Arguments]     ${column_xpath}
    ${elements}=  Get WebElements    ${column_xpath}
    ${actual_list}=  Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${actual_list}    ${text}
    END
    Log    ${actual_list}
    ${expected_list}=   Copy List    ${actual_list}
    Sort List    ${expected_list}
    Reverse List    ${expected_list}
    Log    ${expected_list}
    Lists Should Be Equal    ${actual_list}    ${expected_list}

Verify Background Color
    [Arguments]     ${element_xpath}    ${expected_colour}  ${navigataion_page}
    Wait Until Element Is Visible    ${navigataion_page}    timeout=5s
    ${elements}=  Get WebElements    ${element_xpath}
    FOR    ${element}    IN    @{elements}
          ${background_color} =    Get Background Color    ${element}
          Should Be Equal As Strings   ${background_color}    ${expected_colour}
    END

Get Background Color
    [Arguments]    ${element}
    ${background_color} =    Call Method    ${element}    value_of_css_property    background-color
    [Return]    ${background_color}

