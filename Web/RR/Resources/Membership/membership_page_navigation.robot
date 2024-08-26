*** Settings ***
Library  SeleniumLibrary
Library   ImapLibrary2
Library    Collections
Library    robot.libraries.DateTime
Library    String
Variables  ../../PageObjects/Membership/membership_locators.py
Resource  ../../Resources/Membership/membership_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Library   ../../../../CommonBase/Utilities/user_keywords.py
Resource  ../../Resources/Gaming/gaming_keywords.robot
Variables   ../../PageObjects/Membership/membership_page_navigation_locators.py

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}postpayment_testdata.xlsx
${pro_membership}   Pro
${juinor_membership}    Junior
${elite_membership}     Elite

*** Keywords ***
Verify Next Button To Congratulations Screen
    Wait Until Element Is Visible    ${next_btn_congrats_screen}
    Click Element    ${next_btn_congrats_screen}

Verify 3 Membership Plan Are Display On Screen
    Wait Until Element Is Visible    ${Pro_membership_title}    timeout=20s
    Mouse Down    ${Pro_membership_title}
    Wait For Five Seconds
    Wait Until Element Is Visible    ${Elite_membership_title}  timeout=20s
    Mouse Down    ${Elite_membership_title}
    Wait For Five Seconds
    Wait Until Element Is Visible        ${junior_membership_title}     timeout=20s
    Mouse Down    ${junior_membership_title}

Verify Navigation To Junior Membership Form
    Scroll Element Into View   ${gift_now_btn}
    Mouse Over    ${gift_now_btn}
    Click Element    ${gift_now_btn}

Verify Navigation To Pro Membership Form Page
    Scroll Element Into View    ${Join_now_btn1}
    Mouse Over    ${Join_now_pro_elite}
    Click Element    ${Join_now_pro_elite}

Enter Required Details For Junior Membership
    &{data}    fetch data by id    ${testdata}    12
    Scroll Element Into View    ${step_1_txt}
    Wait Until Page Contains Element    ${step_1_txt}
    Sleep    20s
    Mouse Over    ${Junior_Firstname}
    Input Text    ${Junior_Firstname}       ${data.firstname}
    Mouse Over    ${junior_lastname}
    Input Text    ${junior_lastname}    ${data.Lastname}
    Mouse Over    ${junior_dob}
    Input Text    ${junior_dob}    ${data.DOB}
    Mouse Over    ${female_radio_btn}
    Click Element    ${female_radio_btn}
    Wait Until Element Is Visible    ${delivery_address}    20s
    Input Text    ${delivery_address}    ${data.Address}
    Scroll Element Into View    ${pincode_purchase_membership}
    Wait Until Element Is Visible   ${country_field}    30s
    Select From List By Label    ${country_field}      ${data.Country}
    Wait Until Element Is Enabled    ${state_field}     20s
    Wait For Five Seconds
    Select From List By Value    ${state_field}    ${data.state}
    Wait Until Element Is Visible   ${city_field}   10s
    Input Text    ${city_field}    ${data.city}
    Capture Page Screenshot
    Wait Until Element Is Visible    ${pincode_purchase_membership}   5s
    Input Text    ${pincode_purchase_membership}   ${data.Pincode}

Verify Coupon Code Section On Required Feilds Screen For Membership Plan
    Mouse Over    ${coupon_code}
    Page Should Contain Element   ${coupon_code}

Enter Required Details For Pro Membership
    &{data}    fetch data by id    ${testdata}    12
    Wait Until Element Is Visible    ${delivery_address}    20s
    Input Text    ${delivery_address}    ${data.Address}
    Scroll Element Into View    ${pincode_purchase_membership}
    Wait Until Element Is Visible   ${country_field}    30s
    Select From List By Label    ${country_field}      ${data.Country}
    Wait Until Element Is Enabled    ${state_field}     20s
    Wait For Five Seconds
    Select From List By Value    ${state_field}    ${data.state}
    Wait Until Element Is Visible   ${city_field}   10s
    Input Text    ${city_field}    ${data.city}
    Capture Page Screenshot
    Wait Until Element Is Visible    ${pincode_purchase_membership}   5s
    Input Text    ${pincode_purchase_membership}    ${data.Pincode}
    Wait Until Element Is Visible    ${jerseysize_loc}     5s
    Select From List By Label   ${jersey_size_loc}    ${data.TshirtSize}
    Capture Page Screenshot

Enter Coupon In Coupon Feild
    [Arguments]     ${coupon_code_value}  ${discount_msg}
    Mouse Over    ${coupon_code}
    Input Text    ${coupon_code}    ${coupon_code_value}
    Mouse Over    ${discount_apply}
    Click Element    ${discount_apply}
    Wait For Five Seconds
    Scroll Element Into View    ${purchase_membership_btn}
    Wait Until Element Is Visible    ${discount_msg}   timeout=10s

Verify 10% Discount For Coupon Code
    Wait Until Element Is Visible    ${bank_loc}     30s
    Wait For Five Seconds
    Scroll Element Into View    ${Discounted_price}
    Wait Until Element Is Enabled    ${Discounted_price}    30s
    Page Should Contain Element    ${Discounted_price}

Submit The Data And Proceed To Payment Option
    Wait Until Element Is Visible    ${purchase_membership_btn}   5s
    Click Element    ${purchase_membership_btn}

Verify Payment Process For Membership Plan
    Wait For Five Seconds
    Wait Until Element Is Visible    ${bank_loc}
    Mouse Over    ${bank_loc}
    Click Element    ${bank_loc}
    Mouse Over    ${net_bank_dropdown}
    Click Element    ${net_bank_dropdown}
    Click Element    ${bank_name}

Verify Invoice Creation Of Payment
    Mouse Over    ${make_payment}
    Click Element    ${make_payment}
    Wait Until Page Contains Element    ${send_response}    timeout=20s
    Click Element    ${send_response}
    Wait Until Page Contains Element    ${transaction_Done}     timeout=20s
    Click Element    ${transaction_Done}

Verify Membership Plan Purchase Button Is Disable
    Wait Until Page Contains Element    ${membership_name}
    Click Element    ${membership_name}
    Wait Until Element Is Visible    ${Gift_now_disable_btn}    timeout=20s
    Scroll Element Into View    ${Gift_now_disable_btn}

Verify Logout Button Of Website
    Wait Until Element Is Visible    ${profile_btn}     timeout=30s
    Mouse Over    ${profile_btn}
    Click Element    ${profile_btn}
    Mouse Over    ${logout_btn}
    Click Element    ${logout_btn}
    Wait Until Element Is Visible    ${login_button}    timeout=30s

Verify State And City As Per Pincode
    &{data}    fetch data by id    ${testdata}    12
    Wait Until Page Contains Element    ${pincode_field}    timeout=20
    Input Text    ${pincode_field}    ${data.Pincode}
    Scroll Element Into View    ${submit_button}
    Press Keys    ${pincode_field}    \ue007  # Simulate "Enter" key press to submit
    ${city_text}=    Execute JavaScript    return document.querySelector('${city_field}').value
    Wait Until Element Contains   ${city_text} == 'Mumbai'    timeout=20
    Wait Until Element Contains    ${state_field}    ${data.state}    timeout=20

Verify Delete All Emails
     &{data}    fetch data by id    ${testdata}    12
     Delete All Emails Inbox    ${data.imapaddress}    ${data.port}   ${data.emailid_mail}     ${data.app_password}
     Log    deleted all mails

Verify Email
     [Arguments]     ${emailtitle}
     &{data}    fetch data by id    ${testdata}    12
     ${body}=  Search And Fetch Email    ${data.imapaddress}    ${data.port}   ${data.emailid_mail}     ${data.app_password}    ${emailtitle}
     Log   ${body}

Email Verification For Membership Type
     &{data}    fetch data by id    ${testdata}    12
     [Arguments]        ${memberships}
     ${body}=  Search And Fetch Email    ${data.imapaddress}    ${data.port}   ${data.emailid_mail}     ${data.app_password}    ${data.mail_title}
     Log   ${body}
     ${mailbody}  Convert To String    ${body}
     Log   ${mailbody}
     Should Contain   ${mailbody}    ${memberships}

Check Email Body And Verify The Details
    [Arguments]         ${firstvalue}           ${secondvalue}      ${thirdvalue}       ${forthvalue}       ${fifthvalue}   ${sixthvalue}
     &{data}    fetch data by id    ${testdata}    12
     ${body}=  Search And Fetch Email    ${data.imapaddress}    ${data.port}   ${data.emailid_mail}     ${data.app_password}    ${data.mail_title}
     Log   ${body}
     ${mailbody}  Convert To String    ${body}
     Log   ${mailbody}
     Should Contain   ${mailbody}    ${firstvalue}           ${secondvalue}      ${thirdvalue}       ${forthvalue}      ${fifthvalue}   ${sixthvalue}

Verify Dowload Invoice Button Is Visible And Able To Download The Invoice In Pdf Format
     &{data}    fetch data by id    ${testdata}    12
     ${body}=  Search And Fetch Email    ${data.imapaddress}    ${data.port}   ${data.emailid_mail}     ${data.app_password}    ${data.mail_title}
     Log   ${body}
     ${mailbody}  Convert To String    ${body}
     Log   ${mailbody}
     ${status}  Run Keyword And Return Status  Should Contain   ${mailbody}      ${data.Mailbodytxt_one}  ${data.mailbodytxt_two}    ${data.mailbodytxt_three}    ${data.mailbodytxt_four}
     Run Keyword If  '${status}' == 'true'  Log To Console  PDF is present on mail
     ...  ELSE  Log To Console  PDF is not present in mail




