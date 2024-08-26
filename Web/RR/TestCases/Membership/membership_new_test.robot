*** Settings ***
Library  SeleniumLibrary
Library    DocTest.VisualTest
Resource    ../../Resources/Membership/membership_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource  ../../Resources/Gaming/gaming_keywords.robot
Resource    ../../Resources/Membership/membership_page_navigation.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables    ../../../../CommonBase/Web/PageObjects/web_common_loc.py
Resource   ../../Resources/Membership/Post_Payment_keywords.robot

Test Setup      Launch Application
Test Teardown   Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}membershipnewTCs_testdata.xlsx

*** Test Cases ***
TC62 Verify that coupon functionality available
    &{data}    fetch data by id    ${testdata}    5
    [Tags]      NewMembership
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
    Close Window
    Launch Application
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    COMJUN    ${coupon_Code_discount_msg}
    Click On Particular Element    ${purchase_membership_btn}
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Click On Particular Element    ${transaction_Done}
    Select Membership Button From Header
    Check Visibility And Click On Element    ${purchase_membership_joinbtn}
    Memership Is Already Purchased

TC63 Verify that user already purchased Pro plan then that membership plan button will disable
    &{data}    fetch data by id    ${testdata}    3
    [Tags]      NewMembership       Sprint6
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Select Membership Button From Header
    Check Visibility And Click On Element    ${purchase_membership_joinbtn}
    Memership Is Already Purchased

TC64 Verify that user already purchased Elite plan then that membership plan button will disable
    [Tags]      NewMembership
    &{data}    fetch data by id    ${testdata}    9
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Select Membership Button From Header
    Check Visibility And Click On Element    ${purchase_membership_joinbtn}
    Memership Is Already Purchased

TC65 Verify that user already purchased Junior plan then that membership plan button will disable
    [Tags]      NewMembership
    &{data}    fetch data by id    ${testdata}    10
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Select Membership Button From Header
    Check Visibility And Click On Element    ${purchase_membership_joinbtn}
    Memership Is Already Purchased

TC68 Verify that when user use 100% off coupon then user will not get invoice
    [Tags]      NewMembership
    &{data}    fetch data by id    ${testdata}      5
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
    Enter Required Details For Pro Membership
    Verify Coupon Code Section On Required Feilds Screen For Membership Plan
    Enter Coupon In Coupon Feild    SIUNIQUE    ${discount_msg}
    Click On Particular Element    ${purchase_membership_btn}
    User Should Not Redirect To Payment Gateway Screen

TC69 Verify that user can use this coupon multiple times for junior
    [Tags]      NewMembership           NewMembershiptwo
    &{data}    fetch data by id    ${testdata}      6
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify User Should Redirect To Payment Gateway Screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    COMJUN    ${discount_msg_junior}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code
    Launch Application
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Select Elite Membership Plan
    Enter Required Details For Membership
    Verify If User Selectes Pro Plan And Fill The Required Detail
    Verify User Should Redirect To Payment Gateway Screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    COMJUN    ${discount_msg_junior}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code

TC70 Verify that user can use this coupon multiple times for PRO
    [Tags]      NewMembership       NewMembershiptwo
    &{data}    fetch data by id    ${testdata}      10
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For pro Membership
    Verify coupon code section on required feilds screen for membership plan
    Enter Coupon In Coupon Feild    COMPRO    ${discount_msg}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code
    Launch Application
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Select Pro Membership Plan
    Enter Required Details For pro Membership
    Verify coupon code section on required feilds screen for membership plan
    Enter Coupon In Coupon Feild    COMPRO    ${discount_msg}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code

TC71 Verify that the unique coupon code will be used only once for JUNIOR
    [Tags]      NewMembership       NewMembershiptwo
    &{data}    fetch data by id    ${testdata}      1
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Wait For Five Seconds
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${junior_membership_card}
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    UNIJUN3    ${discount_msg_junior}
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify Invoice Creation Of Payment Page
    Click On Particular Element    ${transaction_Done}
    Verify Logout Button Of Website
    &{data}    fetch data by id    ${testdata}      7
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Verify Membership Plan In Card Format
    Check Visibility And Click On Element    ${junior_membership_card}
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    UNIJUN3    ${discount_msg_one_time}
    Submit The Data And Proceed To Payment Option

TC72 Verify the UI of Membership page
    [Tags]      NewMembership
    &{data}    fetch data by id    ${testdata}    14
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Check Visibility And Click On Element   ${memership_header}
    Image Should Same As Figma Desgin