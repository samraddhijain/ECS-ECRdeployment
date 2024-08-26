*** Settings ***
Library     SeleniumLibrary
Variables   ../../PageObjects/Fanpoll/Fanpoll_locators.py
Resource    ../../Resources/fanPoll/FanPoll_Keywords.robot
Resource    ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource    ../../Resources/Membership/membership_page_navigation.robot
Resource    ../../Resources/Fanpoll/fanpoll_keywords.robot
Library    ../../../../CommonBase/Utilities/user_keywords.py

Test Setup      Launch Application
Test Teardown   Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}postpayment_testdata.xlsx

*** Test Cases ***
TC107 Verify vote functionality if user is logged in and voting for the first time
    [Tags]      FanPoll     Demo
    &{data}    Fetch Data By Id    ${testdata}    13
    Login To CMS And Delete User From CMS   ${data.mobile_number}
    Verify User Is Not Login
    Verify Fanpoll Functionality For Not Logged In User
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Fill all fields in profile fields For Registration  ${data.email}
    Click And Verify Submit Button
    Page Should Gets Redirected To Fanpoll Page
    User Should Able To Vote
    Verify Sum Of Player Percentage





