*** Settings ***
Library  SeleniumLibrary
Resource  ../../Resources/Membership/membership_keywords.robot
Resource  ../../Resources/Profile/profile_keywords.robot
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource    ../../Resources/Gaming/gaming_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables    ../../../../CommonBase/Web/PageObjects/web_common_loc.py

Test Setup      Launch Application
Test Teardown   Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}Gaming_testdata.xlsx

*** Test Cases ***
Tc10 Verify if user is logged and redirecting quizer page
    &{data}    fetch data by id    ${testdata}    1
    Check Visibility And Click On Element    ${login_button}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Navigation Keyword    ${fanzone_nav}    ${quizzerr_page}    ${quizzerr}
    User Shouldn't Ask For Login Again Will Able To View Play Now Button

Tc11 Verify if user is not logged in and try to access quizer
    &{data}    fetch data by id    ${testdata}    2
    Check Visibility And Click On Element    ${login_button}
    Navigation Keyword    ${fanzone_nav}    ${quizzerr_page}    ${quizzerr}
    Check Visibility And Click On Element    ${login_button_quizzer}
    Enter Mobile Number     ${data.mobile_number}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Getting Login Screen And Play Now Button