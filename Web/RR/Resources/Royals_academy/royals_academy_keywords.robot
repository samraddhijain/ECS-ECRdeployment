*** Settings ***
Library     SeleniumLibrary
Resource  ../../Resources/Login/login_keywords.robot
Resource    ../../../../CommonBase/Cms/Resources/otp_keywords.robot
Resource    ../../../../CommonBase/Web/Resources/Web_Common_Keywords.robot
Variables       ../../PageObjects/Royals_academy/royals_academy_locators.py

*** Variables ***
${academy_welcome_title}=  Welcome to the Rajasthan Royals Academy
${academy_register_page_title}=  Register Your Interest
@{academy_form_validation_messages}    Select an academy    First name is required    Last name is required    Email is required    The Mobile Number field must be at least 5 characters.    Date of birth is required    State is required    City is required    Select a language

*** Keywords ***
Click On Royals Academy Link
    Wait Until Element Is Visible    ${royals_academy_link}
    Click Element    ${royals_academy_link}

Click On Academy Register Link
    Wait Until Element Is Visible    ${academy_registration_link}
    Click Element    ${academy_registration_link}
    Wait Until Page Contains    ${academy_register_page_title}

Verify Academy Dropdown List
    Wait Until Element Is Visible    ${select_academy_dropdown}
    Click Element    ${select_academy_dropdown}
    Wait Until Element Is Visible    ${academy_nagpur_option}
    Wait Until Element Is Visible    ${academy_dubai_option}
    Wait Until Element Is Visible    ${academy_conrwall_option}
    Wait Until Element Is Visible    ${academy_surrey_option}

Click On Submit Button
    Wait For Five Seconds
    Scroll Element Into View    ${registration_submit_button}
    Wait Until Element Is Visible    ${registration_submit_button}      timeout=30
    Double Click Element   ${registration_submit_button}
    Sleep    10s
    Capture Page Screenshot

Verify Validation Messages For Academy Registration
    FOR    ${message}    IN    @{academy_form_validation_messages}
        Wait Until Page Contains    ${message}
    END

Fill Academy Registration Details
    [Arguments]  ${academy_registration_details}
    Wait Until Element Is Visible    ${select_academy_dropdown}
    Select From List By Label    ${select_academy_dropdown}    ${academy_registration_details.academy_name}
    Input Text    ${first_name_academy}    ${academy_registration_details.first_name}
    Input Text    ${last_name_academy}    ${academy_registration_details.last_name}
    Input Text    ${email_academy}    ${academy_registration_details.email}
    Input Text    ${mobile_number_academy}    ${academy_registration_details.mobile_number}
    Input Text    ${date_of_birth_academy}    ${academy_registration_details.date_of_birth}
    Select From List By Label   ${country_dropdown_academy}    ${academy_registration_details.country}
    Select From List By Label    ${state_dropdown_academy}      ${academy_registration_details.state}
    Input Text    ${city_field_academy}    ${academy_registration_details.city}
    Select Radio Button    language    ${academy_registration_details.language}





