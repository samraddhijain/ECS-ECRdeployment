*** Settings ***
Library  SeleniumLibrary
Resource  ../Login/login_keywords.robot
Variables  ../../PageObjects/Login/login_page_locators.py

*** Keywords ***
Verify All Fields On Incomplete Profile
    Wait Until Page Contains Element   ${first_name_field}   60s
    Wait Until Page Contains Element    ${last_name_field}
    Wait Until Page Contains Element    ${country_dropdown}
    Wait Until Page Contains Element    ${gender_female_radio_button}
    Wait Until Page Contains Element    ${date_of_birth_field}
    Wait Until Page Contains Element    ${submit_button}
    Wait Until Page Contains Element    ${terms_checkbox}

Fill All The Manadatory Fields For Creating The Profile Page
    [Arguments]  ${user_data}
    Log    ${user_data}
    Wait For Five Seconds
    Wait Until Element Is Visible   ${first_name_field}   60s
    Input Text    ${first_name_field}   ${user_data.first_name}
    Wait Until Element Is Visible    ${last_name_field}   30s
    Input Text  ${last_name_field}    ${user_data.last_name}
    Verify Email Id field   ${user_data.email_id}
    Click On Particular Element    ${country_dropdown}
    Select From List By Label    ${country_dropdown}      ${user_data.country}
    Verify & Enter pin code field    ${user_data.pin_code}
    ${gender}   replace string  ${gender_female_radio_button}  gender   ${user_data.gender}
    Click Element     ${gender}
    Wait Until Element Is Visible    ${date_of_birth_field}
    Input Text    ${date_of_birth_field}     ${user_data.date_of_birth}
    Wait For Five Seconds
    Scroll Element Into View    ${submit_button}
    Press Keys  ${terms_checkbox}  Enter

Verify & Enter Pin Code Field
    [Arguments]    ${pin_code}
    Wait Until Element Is Enabled    ${pincode_field}   timeout=20
    Input Text    ${pincode_field}    ${pin_code}

Fill All Fields In Profile Fields For Registration
    [Arguments]  ${email}
    Wait For Five Seconds
    Scroll Element Into View    ${last_name_field}
    Wait Until Element Is Visible   ${first_name_field}   60s
    Input Text    ${first_name_field}   Suman
    Wait Until Element Is Visible    ${last_name_field}   30s
    Input Text  ${last_name_field}    sharma
    Verify Email Id field   ${email}
    Wait Until Element Is Visible   ${country_dropdown}    30s
    Click Element    ${country_dropdown}
    Select From List By Label    ${country_dropdown}      India
    Click Element    ${country_dropdown}
    User Is Able To Fill Pin Code
    Wait For Five Seconds
    Click Element    ${gender_female_radio_button}
    Wait Until Element Is Visible    ${date_of_birth_field}
    Input Text    ${date_of_birth_field}    06/17/2000
    Wait Until Element Is Visible    ${submit_button}   timeout=30s
    Scroll Element Into View    ${submit_button}
    Press Keys  ${terms_checkbox}  Enter
    Wait For Five Seconds
    Able To View Maharastra As State And Mumbai As City

Click And Verify Submit Button
    Wait For Five Seconds
    Click On Particular Element    ${submit_button}
    Wait Until Page Contains Element    ${purchase_membership_heading}  timeout=30

