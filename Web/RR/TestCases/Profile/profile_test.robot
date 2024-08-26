*** Settings ***
Library  SeleniumLibrary
Resource  ../../Resources/Login/login_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource  ../../Resources/Membership/membership_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables    ../../../../CommonBase/Web/PageObjects/web_common_loc.py

Test Setup  Launch Application
Test Teardown  Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}ProfileTestcases_testdata.xlsx


*** Test Cases ***
Tc03 Verify the fields on incomplete profile
    &{data}    Fetch Data By Id    ${testdata}    1
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Verify all fields on incomplete profile

Tc04 Verify already used email id
    &{data}    Fetch Data By Id    ${testdata}    3
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    User Should Able To View Error Message Of Email Already In Use

Tc05 Verify if user enter unique and corrcet format email id click on login button
    &{data}    Fetch Data By Id    ${testdata}      2
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration       ${data.email_id}
    Validate Email Address   ${data.email_id}

Tc06 Verify pin code field
    &{data}    Fetch Data By Id    ${testdata}    4
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    User Is Able To Fill Pin Code
    Able To View Maharastra As State And Mumbai As City

Tc07 Verify if user enter pincode
    #REPEATED Verify if user enter pincode TCO6
    &{data}    Fetch Data By Id    ${testdata}    5
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Able To View Maharastra As State And Mumbai As City

Tc08 Verify submit button functionality once all the mandatory fields get filled
    &{data}    Fetch Data By Id    ${testdata}    6
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Login To CMS And Delete User From CMS   ${data.mobile_number}

Tc09 Verify user is able to skip membership screen
    &{data}    Fetch Data By Id    ${testdata}    7
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email_id}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Verify Skip Button
    User Should Get Redirected To Congratulations Screen
    Login To CMS And Delete User From CMS   ${data.mobile_number}

Tc010 Verify If user fills all mandatory fields and click on purchase membership button
    #REPEATED   "Verify if user selectes pro plan and fill the
                    #required detail"     TC017
    &{data}    Fetch Data By Id    ${testdata}      8
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
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
    Login To CMS And Delete User From CMS   ${data.mobile_number}