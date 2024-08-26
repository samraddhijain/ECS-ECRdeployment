*** Settings ***
Library      SeleniumLibrary
Library      OperatingSystem
Resource    ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py
Variables   ../../PageObjects/Menu/Menu_locators.py
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Variables   ../../PageObjects/Royals Rajasthan Foundation/Royals_rajasthan_foundation_locators.py
Resource    ../../Resources/Royals Rajasthan Foundation/Royals_rajasthan_foundation_keywords.robot
Resource    ../../Resources/Membership/membership_page_navigation.robot
Resource   ../../Resources/Membership/Post_Payment_keywords.robot
Resource    ../../Resources/Hindi_homescreen/hindi_homescreen_keywords.robot

Test Setup  Launch Application
Test Teardown   Close Browser

*** Variables ***
${url_filepath}    ${CURDIR}${/}..${/}..${/}TestData${/}URL_RR.xlsx
${royal_foundation_testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}RoyalFoundation.xlsx

*** Test Cases ***
TC168 Verify Autofilled data on donation form of Elite User
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    1
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Verify Fields Are Autofilled

TC169 Verify Mandatory fields on donation form
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    2
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Check Visibility And Click On Element    ${donate_now_button}
    Verify Mandatory Fields For Donation Form

TC170 Verify Donate form Submission
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    3
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill All Fields In Profile Fields For Registration    ${data.email}
    Click And Verify Submit Button
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Verify Redirection to Donation Payment Page

TC171 Verify Manual amount entered in Any other amount field on payment gateway screen
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    4
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill All Fields In Profile Fields For Registration    ${data.email}
    Click And Verify Submit Button
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Check Total Amount On Payment Screen

TC172 Verify Data on Payment gateway screen
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    5
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill All Fields In Profile Fields For Registration    ${data.email}
    Click And Verify Submit Button
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Check Total Amount On Payment Screen
    Verify Order Amount Is Equal To Enter Amount On Donation Form

TC173 Verify sucessfully payment process
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    6
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Make Donation payment
    Verify Sucessful Payment For Donation
    ${url_data}     Fetch Data By Id    ${url_filepath}    successful_donation
    Verify Navigation Link     ${url_data['url']}

TC175 Verify Receipt date in downloaded PDF
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    11
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Make Donation payment
    Verify Sucessful Payment For Donation
    ${formatted_date}   Fetching The Transatction Date
    Wait For Five Seconds
    Verify And Click On Download Receipt Button
    Verify The Date In Downloaded PDF   ${formatted_date}

TC174 Verify Downloaded invioce PDF
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    4
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Make Donation payment
    Verify Sucessful Payment For Donation
    ${formatted_date}   Fetching The Transatction Date
    Wait For Five Seconds
    Verify And Click On Download Receipt Button
    Invoice Should Consist Of Following Data
    Verify The Date In Downloaded PDF   ${formatted_date}

TC176 Verify PAN Number in downloaded PDF
    [Tags]      RoyalsRajasthanFoundation       DemoSprint7
    &{data}    fetch data by id    ${royal_foundation_testdata}    5
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Make Donation payment
    Verify Sucessful Payment For Donation
    Wait For Five Seconds
    Verify And Click On Download Receipt Button
    Verify Text In Latest PDF    ${pan_number}      ${EMPTY}

TC181 Verify Email post sucessfull donation payment
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    12
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill All Fields In Profile Fields For Registration    ${data.email}
    Click And Verify Submit Button
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Make Donation payment
    Verify Sucessful Payment For Donation
    Wait For Five Seconds
    Verify And Click On Download Receipt Button
    Verify Email    ${data.mail_title}

TC182 Verify subject of donation email
    [Tags]      RoyalsRajasthanFoundation
    &{data}    fetch data by id    ${royal_foundation_testdata}    12
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill All Fields In Profile Fields For Registration    ${data.email}
    Click And Verify Submit Button
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Make Donation payment
    Verify Sucessful Payment For Donation
    Wait For Five Seconds
    Verify And Click On Download Receipt Button
    Verify Email        ${data.mail_title}

TC183 Verify donation details with downloaded invoice in
    [Tags]      RoyalsRajasthanFoundation       DemoSprint7
    &{data}    fetch data by id    ${royal_foundation_testdata}    12
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill All Fields In Profile Fields For Registration    ${data.email}
    Click And Verify Submit Button
    Wait For Five Seconds
    Navigation Keyword    ${royal_rajasthan_foundation}    ${royal_rajasthan_foundation_page}
    Navigation Keyword    ${donation_nav}    ${donation_page}
    Wait For Five Seconds
    Enter Mandatory Field In Donation Form
    Enter Manual Amount
    Verify Redirection to Donation Payment Page
    Make Donation payment
    Verify Sucessful Payment For Donation
    Wait For Five Seconds
    Verify And Click On Download Receipt Button
    ${reciptdate}   Get Text    ${transaction_date}
    Check Email Body And Verify The Details     ${reciptdate}      ${pan_number}   ${address}      ${custom_amount}    ${purposeofdonation}    ${panoffoundation}

TC184 Verify download image functionality on photo detail page
    [Tags]      RoyalsRajasthanFoundation
    Click On Hindi Menu
    Verify Hindi Photo Redirection
    Click On Photo Card
    Click On Photo Buttons
    Download Photo
    Verify downloaded Photo