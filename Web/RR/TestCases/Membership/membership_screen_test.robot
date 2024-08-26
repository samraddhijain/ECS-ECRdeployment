*** Settings ***
Library  SeleniumLibrary
Resource    ../../Resources/Membership/membership_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource  ../../Resources/Gaming/gaming_keywords.robot
Resource    ../../Resources/Membership/membership_page_navigation.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables    ../../../../CommonBase/Web/PageObjects/web_common_loc.py


Test Setup      Launch Application
Test Teardown   Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}purchase_membershipscreen_data.xlsx

*** Test Cases ***
TC_018 Verify user contain 3 membership plan on page
    &{data}    Fetch Data By Id    ${testdata}      1
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Check Visibility And Click On Element    ${submit_button}
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Sleep    10s
    Login To CMS And Delete User From CMS  ${data.mobile_number}

TC_019 Verify that user can purchase junior membership plan
    &{data}    Fetch Data By Id    ${testdata}      2
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Sleep    20s
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Sleep    20s
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify invoice creation of payment
    Login To CMS And Delete User From CMS   ${data.mobile_number}

TC_020 Verify coupon code section on required feilds screen for junior membership plan
    &{data}    fetch data by id    ${testdata}      3
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Sleep    20s
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Verify coupon code section on required feilds screen for membership plan
    Login To CMS And Delete User From CMS   ${data.mobile_number}

TC_021 Verify that post completon of payment gateway
    &{data}    fetch data by id    ${testdata}      9
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    verify delete all emails
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Sleep    20s
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Sleep    20s
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify invoice creation of payment
    Sleep    10s
    Verify Email

TC_022 Verify that user already purchased this plan then that membership plan button will disable
    &{data}    fetch data by id    ${testdata}      4
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Sleep    20s
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Sleep    20s
    Submit the data and proceed to payment option
    verify payment process for membership plan
    Verify invoice creation of payment
    Verify membership plan purchase button is disable
    Login To CMS And Delete User From CMS   ${data.mobile_number}

TC_023 Verify that when user use 100% off coupon then user will not get invoice
    &{data}    fetch data by id    ${testdata}      5
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    SIUNIQUE    ${discount_msg}
    Sleep    20s
    Submit the data and proceed to payment option
    Sleep    60s
    Verify 10% discount for coupon code
    verify payment process for membership plan
    Verify invoice creation of payment
    Login To CMS And Delete User From CMS   ${data.mobile_number}

TC_024 Verify that multiple users can use 10% off coupon for Junior membership plan
    &{data}    fetch data by id    ${testdata}      6
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    COMJUN    ${discount_msg_junior}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code
    verify payment process for membership plan
    Verify invoice creation of payment
    Verify logout button of website
    &{data}    fetch data by id    ${testdata}      7
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    COMJUN    ${discount_msg_junior}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code
    verify payment process for membership plan
    Verify invoice creation of payment
    Login To CMS And Delete User From CMS   ${data.mobile_number}

TC_025 Verify that multiple users can use 10% off coupon for pro membership plan
    &{data}    fetch data by id    ${testdata}      8
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to pro membership form page
    Enter Required Details For pro Membership
    Verify coupon code section on required feilds screen for membership plan
    Enter Coupon In Coupon Feild    COMPRO    ${discount_msg}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code
    verify payment process for membership plan
    Verify invoice creation of payment
    Verify logout button of website
    &{data}    fetch data by id    ${testdata}      10
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to pro membership form page
    Enter Required Details For pro Membership
    Verify coupon code section on required feilds screen for membership plan
    Enter Coupon In Coupon Feild    COMPRO    ${discount_msg}
    Submit the data and proceed to payment option
    Verify 10% discount for coupon code
    verify payment process for membership plan
    Verify invoice creation of payment
    Login To CMS And Delete User From CMS   ${data.mobile_number}

TC_026 Verify that UNIJUN coupon code can be used only once
    &{data}    fetch data by id    ${testdata}      11
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all the manadatory Fields for creating the Profile Page    ${data}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    verify next button to congratulations screen
    Check Visibility And Click On Element    ${membership_name}
    Verify 3 membership plan are display on screen
    Verify navigation to junior membership form
    Enter Required Details For Junior Membership
    Enter Coupon In Coupon Feild    UNIJUN    ${discount_msg_one_time}
    Login To CMS And Delete User From CMS   ${data.mobile_number}