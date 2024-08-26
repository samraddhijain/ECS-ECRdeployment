*** Settings ***
Library  SeleniumLibrary
Resource  ../../Resources/Login/login_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource  ../../Resources/Membership/membership_keywords.robot
Resource  ../../Resources/User Profile/userprofile_keywords.robot
Resource   ../../Resources/Membership/Post_Payment_keywords.robot
Resource   ../../Resources/Membership/Api_Keywords.robot

Test Setup  Launch Application
Test Teardown  Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}userprofiledatafile.xlsx

*** Test Cases ***
TC109 Verify newly registered data on user profile screen
    [Tags]      User Profile
    &{data}    Fetch Data By Id    ${testdata}    4
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    Check Visibility And Click On Element    ${nextbutton_loc}
    Click On User Profile Button
    Match The Data On Profile Page And Incomplete Profile

TC110 Verify following date and fav player name
    [Tags]      User Profile
    &{data}    Fetch Data By Id    ${testdata}    3
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    Verify Skip Button
    Check Visibility And Click On Element    ${nextbutton_loc}
    Click On User Profile Button
    Should Show Register Date And Fav Player Name

TC111 Verify Name on Jersey
    [Tags]      UserProfile
    &{data}    Fetch Data By Id    ${testdata}    4
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    Verify Skip Button
    Check Visibility And Click On Element    ${nextbutton_loc}
    Click On User Profile Button
    Should Show Last Name On Jersey In Caps     ${data.last_name}

TC112 Verify Membership Card on profile page
    [Tags]      UserProfile        Sprint6      fiveone
    &{data}    Fetch Data By Id    ${testdata}    5
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Click On Particular Element    ${transaction_Done}
    Post Api Send OTP       ${data.mobile_number}
    ${user_guid}    ${user_token}     Post Api Signup With OTP     ${data.mobile_number}
    ${membership_code}   ${membership_expiry_date}    ${membership_type}      Validate GET Profile        ${user_guid}    ${user_token}
    Launch Application
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Click On User Profile Button
    Verify Text In Latest Image     ${membership_code}

TC113 Verify Membership Validity date on membership card if user bought the membership this year i.e; 2024
    [Tags]      UserProfile     Sprint6
    &{data}    Fetch Data By Id    ${testdata}    8
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Click On Particular Element    ${transaction_Done}
    Post Api Send OTP       ${data.mobile_number}
    ${user_guid}    ${user_token}     Post Api Signup With OTP     ${data.mobile_number}
    ${membership_expiry_date}     ${membership_code}      ${membership_type}     Validate GET Profile        ${user_guid}    ${user_token}

TC122 Verify Edit functionlity in settings
    [Tags]      UserProfile
    &{data}    Fetch Data By Id    ${testdata}    6
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify User Should Redirect To Payment Gateway Screen
    Click On User Profile Button
    Click On Particular Element    ${setting_button}
    Click On Particular Element    ${setting_editprofile_button}
    User Should Able To Edit Below Fields

TC122 Verify if user edit Jersey Number and click on confirm changes button
    [Tags]      UserProfile
    &{data}    Fetch Data By Id    ${testdata}    7
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    Check Visibility And Click On Element    ${nextbutton_loc}
    Click On User Profile Button
    Click On Particular Element    ${setting_button}
    Click On Particular Element    ${setting_editprofile_button}
    Update The Jersey No and Save The Changes   09

TC121 Verify Upload functionality
    [Tags]      UserProfile
    &{data}    Fetch Data By Id    ${testdata}    5
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    Verify Skip Button
    Check Visibility And Click On Element    ${nextbutton_loc}
    Sleep    10
    Click On User Profile Button
    Click On Edit Button
    Click On Edit Icon
    CLick On Upload Button For Image
    CLick On Confirm Changes Button
    Upload Images From Computer And Image Should Upload Successfully