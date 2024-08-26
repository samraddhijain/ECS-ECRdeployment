*** Settings ***
Library      SeleniumLibrary
Library      Collections
Resource    ../../Resources/Login/login_keywords.robot
Resource    ../../Resources/Profile/profile_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables    ../../../../CommonBase/Web/PageObjects/web_common_loc.py

Test Setup  Launch Application
Test Teardown  Close Browser

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}LoginTestdata.xlsx

*** Test Cases ***
#OTP less login
Tc01 Verify if new clicks on yes button
    &{data}    fetch data by id    ${testdata}      2
    Check Visibility And Click On Element   ${login_button}
    Enter Mobile Number     ${data['mobile_number']}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Verify OTP less sign in pop-up should get displayed to user

Tc0121 Verify if new clicks on yes button
    ${data}    fetch data by id    ${testdata}      2
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Verify OTP less sign in pop-up should get displayed to user

Tc02 Verify the click on whatsapp icon
    ${data}    fetch data by id    ${testdata}      1
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_yes_button}
    Click on whatsapp icon
    Verify User should able to view barcode to scan

Tc03 Login step with OTP existing user
    &{data}    fetch data by id    ${testdata}     2
    Check Visibility And Click On Element   ${login_button}
    Verify Mobile Number Field
    Validate Mobile Number According To Country Code  ${data.mobile_number}    91
    Validate Mobile Number Field    ${data.mobile_number}
    Mobile No Field Should not be blank     ${mobile_number_loc}
    Verify Error Message on Blank Login Field
    Capture Page Screenshot

Tc04 Verify if new user enters mobile number and clicks on no button
    ${data}    fetch data by id    ${testdata}     1
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Send OTP Via SMS Button Should Get Displayed To User

Tc05 Verify the OTP section
    ${data}    fetch data by id    ${testdata}     3
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    Verify User should Able To View Six Boxes To Enter Six Digit Received OTP

Tc06 Verify valid OTP
    &{data}    fetch data by id    ${testdata}      2
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    ${otp}  Login Into CMS And Get OTP    ${data.mobile_number}
    Enter OTP  ${otp}
    Verify System Should Accept The OTP

Tc07 Verify invalid OTP
    &{data}    fetch data by id    ${testdata}     1
    Login With Otp For Web    ${login_button}    ${mobile_number_field}    ${data}
    Check Visibility And Click On Element    ${whatsapp_no_button}
    Check Visibility And Click On Element    ${send_sms_button}
    Enter Wrong OTP
    Verify Failed Message Should Visible To User
    Capture Page Screenshot