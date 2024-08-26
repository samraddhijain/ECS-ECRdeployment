*** Settings ***
Library  SeleniumLibrary
Resource  ../../Resources/Membership/membership_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables    ../../../../CommonBase/Web/PageObjects/web_common_loc.py


Test Setup      Launch Application
Test Teardown   Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}purchasemembership_data.xlsx

*** Test Cases ***
Tc011 Verify membership plans
    &{data}    fetch data by id    ${testdata}    1
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    User Should Get Redirected To Purchase Membership Screen
    Verify Membership Plan In Card Format
    Login To CMS And Delete User From CMS   ${data.mobile_number}

Tc12 Verify if user selectes pro plan and fill the required detail
    &{data}    fetch data by id    ${testdata}    2
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
    Login To CMS And Delete User From CMS   ${data.mobile_number}