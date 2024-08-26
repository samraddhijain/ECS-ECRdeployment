*** Settings ***
Library     SeleniumLibrary
Resource       ../../Resources/Stats/stats_keywords.robot
Resource      ../../Resources/Royals_academy/royals_academy_keywords.robot
Variables     ../../PageObjects/Stats/stats_locator.py
Variables    ../../PageObjects/Menu/Menu_locators.py
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Resource    ../../Resources/Membership/Api_Keywords.robot

Test Setup      Launch Application
Test Teardown   Close Browser

*** Variables ***
${academy_url}=  https://stg-rr.sportz.io/cricket-academies
${academy_registration_url}=  https://stg-rr.sportz.io/academy/registration
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}postpayment_testdata.xlsx

*** Test Cases ***
TC162 Verify Registration form submition
    [Tags]      RoyalsAcademy
    Click On Royals Academy Link
    Click On Academy Register Link
    &{registration_details}  Create Dictionary    academy_name=Nagpur (India)    first_name=sumi    last_name=jain   email=asas@gmail.com    mobile_number=8839037878   date_of_birth=07/10/1977    country=India    state=Maharashtra    city=Pune    language=english
    Fill Academy Registration Details    ${registration_details}
    Click On Submit Button
    Get values From CMS    8839037878
    ${file_path}  Verify File Is Downloaded
    ${user_data}  Fetch User Data By Number  ${file_path}  8839037878