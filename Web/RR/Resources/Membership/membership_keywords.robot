*** Settings ***
Library  SeleniumLibrary
Library    String
Library    DocTest.VisualTest
Library     Screenshot
Variables  ../../PageObjects/Membership/membership_locators.py
Variables  ../../PageObjects/Login/login_page_locators.py
Resource    ../Fixtures and Results/fixturesresults_keywords.robot
Resource    membership_page_navigation.robot

*** Variables ***
${screenshot_actual_dir}   ${CURDIR}${/}..${/}..${/}TestData/Screenshots/actual_screenshots

*** Keywords ***
Verify Membership Plan In Card Format
    Scroll Element Into View    ${purchase_membership_heading}
    Wait Until Page Contains Element    ${elite_membership_card}    timeout=30
    Wait Until Page Contains Element    ${pro_membership_card}
    Wait Until Page Contains Element    ${junior_membership_card}

Verify Skip Button
    Click On Particular Element    ${skip_button}
    Wait Until Page Contains Element    ${next_button}  timeout=30

Select Pro Membership Plan
    Click On Particular Element    ${pro_membership_card}

Select Elite Membership Plan
    Click On Particular Element    ${elite_membership_card}

Enter Required Details For Membership
    Scroll Element Into View    ${delivery_address}
    Wait Until Element Is Visible    ${delivery_address}    20s
    Input Text    ${delivery_address}    Oyo Workflow Baner
    Scroll Element Into View    ${pincode_purchase_membership}
    Click On Particular Element    ${country_field}
    Select From List By Label    ${country_field}      India
    Click Element    ${country_field}
    Wait Until Element Is Enabled    ${state_field}     20s
    Wait For Five Seconds
    Select From List By Value    ${state_field}    Maharashtra
    Wait Until Element Is Visible   ${city_field}   30s
    Input Text    ${city_field}    Pune
    Wait Until Element Is Visible    ${pincode_purchase_membership}   5s
    Input Text    ${pincode_purchase_membership}    411045
    Wait Until Element Is Visible    ${jersey_size_loc}     5s
    Select From List By Label   ${jersey_size_loc}    T-Shirt Size S
    Capture Page Screenshot
    Click On Particular Element    ${purchase_membership_btn}

Verify If User Selectes Pro Plan And Fill The Required Detail
    Wait Until Element Is Enabled    ${bank_loc}    30s
    Click Element    ${bank_loc}
    Wait Until Element Is Visible    ${net_bank_dropdown}    30s
    Select From List By Label    ${net_bank_dropdown}     Avenues Test for New TC
    Wait Until Element Is Visible    ${make_payment}     30s
    Click Element    ${make_payment}
    Capture Page Screenshot
    Wait Until Element Is Enabled    ${send_response}   30s
    Click Element    ${send_response}
    Wait For Five Seconds

Verify User Should Redirect To Payment Gateway Screen
    Wait Until Element Is Visible    ${success_message}     30s
    Wait Until Element Is Visible    ${payment_done}    5s
    Click Element    ${payment_done}

User Should Get Redirected To Purchase Membership Screen
    Wait Until Element Is Visible    ${purchase_membership_txt}  timeout=20s
    Page Should Contain Element    ${purchase_membership_txt}
    Wait Until Page Contains Element    ${purchase_membership_txt}

User Should Get Redirected To Congratulations Screen
    Wait Until Page Contains Element    ${congratualtion_txt}     timeout=20s
    Page Should Contain Element  ${congratualtion_txt}

Select Membership Plan
    [Arguments]    ${membership}
    Wait For Five Seconds
    ${dynamic_xpath}    Replace String    ${dynamic_membership}    membership-type    ${membership}
    Scroll Element Into View    ${dynamic_xpath}
    Wait Until Element Is Visible    ${dynamic_xpath}      timeout=30s
    Click Element    ${dynamic_xpath}
    ${status}    ${result}    Run Keyword And Ignore Error   Wait Until Element Is Visible   ${Junior_Firstname}    timeout=20
    Run Keyword If    '${status}' == 'PASS'    Enter Junior Membership Data And Purchase
    ...    ELSE    Enter Required Details For Membership
    [Return]    ${dynamic_xpath}

Enter Junior Membership Data And Purchase
    Enter Required Details For Junior Membership
    Submit the data and proceed to payment option

Select Second Membership Plan
    Click Element    ${membership_name}
    Wait Until Element Is Visible    ${Pro_membership_title}    timeout=20s
    Wait Until Element Is Visible    ${purchase_membership_joinbtn}      timeout=30s
    Click On Particular Element     ${purchase_membership_joinbtn}
    Wait For Five Seconds

Select Membership Button From Header
    Wait Until Element Is Visible    ${user_profile_title}      timeout=60s
    Check Visibility And Click On Element   ${memership_header}
    Wait Until Element Is Visible    ${purchase_membership_joinbtn}     timeout=60s

Memership Is Already Purchased
    Wait Until Element Is Visible   ${already_purchase_membership_txt}  timeout=60s
    Wait Until Page Contains Element    ${already_purchase_membership_txt}  timeout=60s
    Page Should Contain Element    ${already_purchase_membership_txt}

Coupen Should Be Unique Or One Time Use Only
    [Documentation]     coupen should be unique or one time use only.
    Element Should Be Enabled    ${purchase_membership_joinbtn}

Image Should Same As Figma Desgin
    screenshot.set screenshot directory    ${screenshot_actual_dir}
    Wait Until Element Is Visible    ${purchase_membership_joinbtn}     timeout=60s
    Wait Until Element Is Enabled    ${purchase_membership_joinbtn}     timeout=60s
    ${actualimage}  Capture Page Screenshot    Actual_Image
    ${image_path}    Set Variable    ${screenshot_actual_dir}/Actual_Image
#    ${cropped_image}    user_keywords.crop_image    ${image_path}   ${image_path}   375     281
    Compare Images    C:\\Users\\Samraddhi\\Desktop\\IQA-63\\wm-si-qa-automation\\Web\\RR\\TestData\\Screenshots\\reference_screenshots\\membershipheaderFigmaImage.png    ${actualimage}     timeout=60s     resize_candidate=true

Theme Should Get Change To Dark
    screenshot.set screenshot directory    ${screenshot_actual_dir}
    ${actualimage}  Capture Page Screenshot    Actual_Image
    ${image_path}    Set Variable    ${screenshot_actual_dir}/Actual_Image
    ${actualimage}  Capture Page Screenshot    Actual_Image
    Compare Images    C:\\Users\\Samraddhi\\Desktop\\IQA-63\\wm-si-qa-automation\\Web\\RR\\TestData\\Screenshots\\reference_screenshots\\Dark mode header.png    ${actualimage}  resize_candidate=true

User Should Not Redirect To Payment Gateway Screen
    [Documentation]     user should not redirect to payment gateway screen and instead he should show sucessful window with no invoice to download.
    Page Should Not Contain Element    ${download_recipt}   
    Wait Until Element Is Not Visible    ${download_recipt}
    

