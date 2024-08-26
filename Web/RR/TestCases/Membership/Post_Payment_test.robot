*** Settings ***
Library  SeleniumLibrary
Library    ImapLibrary2
Resource   ../../Resources/Membership/membership_keywords.robot
Resource   ../../Resources/Profile/profile_keywords.robot
Resource   ../../Resources/Login/login_keywords.robot
Resource   ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource   ../../Resources/Gaming/gaming_keywords.robot
Resource   ../../Resources/Membership/membership_page_navigation.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py
Resource   ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Resource   ../../Resources/Membership/Post_Payment_keywords.robot
Variables  ../../../../CommonBase/Web/PageObjects/web_common_loc.py
Resource   ../../Resources/Membership/Api_Keywords.robot
Resource   ../../Resources/User Profile/userprofile_keywords.robot

Test Setup      Launch Application
Test Teardown   Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}postpayment_testdata.xlsx

*** Test Cases ***
Tc020 Verify user redirects on Home screen post payment process
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    3
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify User Should Redirect To Payment Gateway Screen
    Homescreen Is Dispalyed

TC021 Verify the functionality of download Receipt button post payment process
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    4
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify And Click On Download Receipt Button
    Verify Downloaded PDF

TC022 Verify Membership name in Downloaded invoice PDF as Pro
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    5
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify And Click On Download Receipt Button
    Verify Text In Latest PDF      ${pro_membership}     ${EMPTY}

TC023 Verify User's name in Downloaded invoice PDF
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    6
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify And Click On Download Receipt Button
    Verify Text In Latest PDF      ${data.firstname}     ${data.Lastname}

TC024 Verify User received Email after Payment on registered Email address
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Click On Particular Element    ${transaction_Done}
    Verify Email        ${data.mail_title}

TC025 Verify Dowload invoice button is visible and able to download the invoice in pdf format
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Check Visibility And Click On Element    ${transaction_Done}
    Verify Dowload Invoice Button Is Visible And Able To Download The Invoice In Pdf Format

TC026 Verify Membership Type in email as Pro
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Check Visibility And Click On Element    ${transaction_Done}
    Email Verification For Membership Type      ${pro_membership}

TC027 Verify Membership ID is generated for Pro
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Click On Particular Element    ${transaction_Done}
    Post Api Send OTP       ${data.mobile_number}
    ${user_guid}    ${user_token}     Post Api Signup With OTP     ${data.mobile_number}
    ${membership_expiry_date}     ${membership_code}      ${membership_type}  Validate GET Profile        ${user_guid}    ${user_token}
    Email Verification For Membership Type      ${membership_code}

TC028 Verify Memberhsip ID in email and on card present in My profile Screen for Pro Membership
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Check Visibility And Click On Element    ${transaction_Done}
    Post Api Send OTP       ${data.mobile_number}
    ${user_guid}    ${user_token}     Post Api Signup With OTP     ${data.mobile_number}
    ${membership_expiry_date}     ${membership_code}      ${membership_type}  Validate GET Profile        ${user_guid}    ${user_token}
    Email Verification For Membership Type      ${membership_code}
    Launch Application
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Click On User Profile Button
    Capture Page Screenshot
    Verify Text In Latest Image     ${membership_code}

TC033 Verify Membership name in Downloaded invoice PDF as Elite
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    7
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify And Click On Download Receipt Button
    Verify Text In Latest PDF      ${juinor_membership}     ${EMPTY}

TC034 Verify User's name in Downloaded invoice PDF
    [Tags]      Membership      Demo
    &{data}    Fetch Data By Id    ${testdata}    8
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify And Click On Download Receipt Button
    Verify Text In Latest PDF      ${data.firstname}     ${data.Lastname}

TC035 Verify User received Email after Payment on registered Email address
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Check Visibility And Click On Element   ${transaction_Done}
    Verify Email        ${data.mail_title}

TC036 Verify Dowload invoice button is visible and able to download the invoice in pdf format for elite membership
    [Tags]      Membership      Demo
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Check Visibility And Click On Element    ${transaction_Done}
    Verify Dowload Invoice Button Is Visible And Able To Download The Invoice In Pdf Format

TC037 Verify Membership Type in email as Elite
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Check Visibility And Click On Element    ${transaction_Done}
    Email Verification For Membership Type      ${elite_membership}

TC039 Verify Memberhsip ID in email and on card present in My profile Screen For Elite Membership
    [Tags]      Membership      Demo
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Click On Particular Element    ${transaction_Done}
    Post Api Send OTP       ${data.mobile_number}
    ${user_guid}    ${user_token}     Post Api Signup With OTP     ${data.mobile_number}
    ${membership_code}   ${membership_expiry_date}    ${membership_type}  Validate GET Profile        ${user_guid}    ${user_token}
    Email Verification For Membership Type      ${membership_code}
    Launch Application
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Click On User Profile Button
    Capture Page Screenshot
    Verify Text In Latest Image     ${membership_code}

TC044 Verify Membership name in Downloaded invoice PDF as Junior
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Submit the data and proceed to payment option
    Verify Payment Process For Membership Plan
    Verify Invoice Creation Of Payment Page
    Verify And Click On Download Receipt Button
    Verify Text In Latest PDF      ${juinor_membership}     ${EMPTY}

TC045 Verify user's name in Downloaded invoice PDF as Junior
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    4
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify Invoice Creation Of Payment Page
    Verify And Click On Download Receipt Button
    Verify Text In Latest PDF      ${data.firstname}     ${data.Lastname}

TC046 Verify User received Email after Payment on registered Email address
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify Invoice Creation Of Payment Page
    Verify Email        ${data.mail_title}

TC047 Verify User name and Junior's name in email body
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify Invoice Creation Of Payment Page
    Click On Particular Element    ${transaction_Done}
    Check Email Body And Verify The Details     ${data.Juniorfirstname}    ${data.Juniorlastname}      ${data.JuniorFullname}     ${data.Juniorfullnametwo}     ${EMPTY}    ${EMPTY}

TC048 Verify Dowload invoice button is visible and able to download the invoice in pdf format for Junior
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify Invoice Creation Of Payment Page
    Click On Particular Element   ${transaction_Done}
    Verify Dowload Invoice Button Is Visible And Able To Download The Invoice In Pdf Format

TC049 Verify Membership Type in email as Junior
    [Tags]      Membership
    &{data}    Fetch Data By Id    ${testdata}    1
    Verify Delete All Emails
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify Invoice Creation Of Payment Page
    Click On Particular Element    ${transaction_Done}
    Email Verification For Membership Type      ${juinor_membership}