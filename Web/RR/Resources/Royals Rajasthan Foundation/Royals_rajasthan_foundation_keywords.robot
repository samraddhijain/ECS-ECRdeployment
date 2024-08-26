*** Settings ***
Library      SeleniumLibrary
Library      OperatingSystem
Library      String
Resource    ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py
Variables   ../../PageObjects/Menu/Menu_locators.py
Variables   ../../PageObjects/Royals Rajasthan Foundation/Royals_rajasthan_foundation_locators.py
Resource    ../../Resources/Membership/Post_Payment_keywords.robot

*** Variables ***
${custom_amount}    700
${pan_number}   ABCTY1234D
${address}      baner,pune
${purposeofdonation}    General
${panoffoundation}      Received with thanks from
${test_data}    ${CURDIR}${/}..${/}..${/}TestData${/}RoyalFoundation.xlsx

*** Keywords ***
Verify Fields Are Autofilled
    Verify Fields Are Autofields In Donation Form    ${firstname_donation}
    Verify Fields Are Autofields In Donation Form    ${lastname_doantion}
    Verify Fields Are Autofields In Donation Form    ${email_donation}
    Verify Fields Are Autofields In Donation Form    ${mobile_number_donation}
    Verify Fields Are Autofields In Donation Form    ${dateofbirth_donation}
    Verify Fields Are Autofields In Donation Form    ${country_donation}
    Verify Fields Are Autofields In Donation Form    ${city_donation}

Verify Fields Are Autofields In Donation Form
    [Arguments]     ${input_fields_xpath}
    Wait Until Element Is Visible    ${input_fields_xpath}  timeout=20s
    ${value}    Get Value    ${input_fields_xpath}
    IF    '${value}' != ''
         Log    Field is autofilled
    END

Verify Mandatory Fields For Donation Form
    Wait Until Element Is Visible    ${foundation_error}    timeout=10s
    Wait Until Element Is Visible    ${pan_number_error}    timeout=10
    Wait Until Element Is Visible    ${address_error}   timeout=10

Enter Mandatory Field In Donation Form
    Wait Until Element Is Visible    ${state_donation}  timeout=10s
    Select From List By Label   ${state_donation}  Maharashtra
    Select From List By Label    ${foundation}      General
    Sleep    5s
    Wait Until Element Is Visible    ${pan_donation}    timeout=20s
    Element Should Be Enabled    ${pan_donation}
    Click Element    ${pan_donation}
    Sleep    2s
    Input Text    ${pan_donation}    ${pan_number}
    Sleep    5s
    Wait Until Element Is Visible    ${address_donation}    timeout=20
    Element Should Be Enabled    ${address_donation}
    Click Element    ${address_donation}
    Sleep    2s
    Input Text    ${address_donation}    ${address}

Verify Redirection to Donation Payment Page
    Scroll Element Into View    ${donate_now_button}
    Sleep    2s
    Click Element    ${donate_now_button}
    Wait Until Element Is Visible    ${doante_payment_page}  timeout=20s
    Scroll Element Into View    ${doante_payment_page}
    Page Should Contain Element    ${doante_payment_page}

Enter Manual Amount
   Scroll Element Into View    ${custom_amount_donation}
   Wait Until Element Is Visible    ${custom_amount_donation}   timeout=20s
   Input Text    ${custom_amount_donation}    ${custom_amount}

Check Total Amount On Payment Screen
    Wait Until Element Is Visible    ${total_amount}    timeout=20s
    ${value}    Get Text    ${total_amount}
    ${value1}   Split String    ${value}     ${SPACE}
    ${float_value}  Evaluate   ${value1}[1]
    ${value2}   Convert To Integer    ${float_value}
    Should Be Equal As Strings  ${custom_amount}    ${value2}

Verify Order Amount Is Equal To Enter Amount On Donation Form
    Wait Until Element Is Visible    ${order_amount}   timeout=20s
    ${value}    Get Text    ${order_amount}
    ${float_value}  Evaluate   ${value}
    ${value2}   Convert To Integer    ${float_value}
    Should Be Equal As Strings  ${custom_amount}    ${value2}

Make Donation payment
    Wait Until Element Is Visible    ${bank_loc}    timeout=20s
    Mouse Over    ${bank_loc}
    Click Element    ${bank_loc}
    Wait Until Element Is Visible    ${net_bank_dropdown}    30s
    Select From List By Label    ${net_bank_dropdown}     Avenues Test for New TC

Verify Sucessful Payment For Donation
    Wait Until Element Is Visible    ${make_payment}    timeout=20s
    Click Element    ${make_payment}
    Wait Until Element Is Visible    ${send_response}   timeout=20s
    Sleep    2s
    Click Element    ${send_response}
    Wait Until Element Is Visible    ${success_message}     timeout=20s

Fetching The Transatction Date
    Wait Until Element Is Visible    ${transaction_date}  timeout=20s
    ${reciptdate}   Get Text    ${transaction_date}
    ${formatted_date}=  Evaluate  '${reciptdate}'.replace('-', '', 1)
    Log  ${formatted_date}
    [Return]    ${formatted_date}

Split And Clean String
    [Arguments]     ${VALUE}
    ${parts}=    Split String    ${VALUE}    ${SPACE}    1
    ${first_part}=    Set Variable    ${parts[0]}
    ${second_part}=    Set Variable    ${parts[1]}
    ${first_string}=    Split String    ${first_part}    -    1
    ${cleaned_second_string}=    Replace String     ­    ${first_part[1]}    -
    Log    First String: ${first_string[0]}
    Log    Cleaned Second String: ${cleaned_second_string}
    [Return]     ${first_string[0]}      ${cleaned_second_string}

Invoice Should Consist Of Following Data
    [Documentation]     Invoice should consist of following data
    Verify Text In Latest PDF    ${purposeofdonation}     ${pan_number}
    Verify Text In Latest PDF    ${pan_number}       ${address}
    Verify Text In Latest PDF    Suman      Sharma
    Verify Text In Latest PDF    ${custom_amount}       ${EMPTY}
    
Verify The Date In Downloaded PDF
    [Arguments]     ${VALUE}
    Sleep    5
    ${latest_pdf}=    Get Latest Pdf    ${DOWNLOADS_DIR}
    ${pdf_text}=    Convert Pdf To Txt    ${latest_pdf}
    Log    Extracted PDF text: ${pdf_text}
    ${pdf_text} =    Replace String    ${pdf_text}    \u00A0    ${EMPTY}
    Log    Cleaned PDF text: ${pdf_text}
    ${pdftotxt}     Convert To String    ${pdf_text}
    ${parts}=    Split String    ${VALUE}    ${SPACE}    1
    ${first_part}=    Set Variable    ${parts[0]}
    ${time_part}=    Set Variable    ${parts[1]}
    ${first_string}=    Split String    ${first_part}    -    1
    ${cleaned_first_part}=    Set Variable    ${first_string[0]}
    ${cleaned_second_part}=    Set Variable    ${first_string[1]}
    ${first_part}=    Get Substring   ${cleaned_first_part}    0    2
    ${second_part}=   Get Substring   ${cleaned_first_part}    2    4
    Log    First Part: ${first_part}
    Log    Second Part: ${second_part}
    Log    First String: ${cleaned_first_part}
    Log    Cleaned Second String: ${cleaned_second_part}
    Log    Time Part: ${time_part}
    Should Contain  ${pdftotxt}    ${time_part}      ${cleaned_second_part}    ${first_part}     ${second_part}

    


