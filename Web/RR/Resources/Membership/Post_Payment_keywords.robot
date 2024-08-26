*** Settings ***
Library  SeleniumLibrary
Library  Pdf2TextLibrary
Library    OperatingSystem
Library  ../../../../CommonBase/Utilities/user_keywords.py
Variables  ../../PageObjects/Membership/post_payment_locators.py
Resource   ../../Resources/Membership/membership_page_navigation.robot

*** Variables ***
${DOWNLOADS_DIR}        ${CURDIR}${/}..${/}..${/}..${/}..${/}Downloads${/}Files
${screenshot_path}      ${CURDIR}${/}..${/}..${/}TestData${/}Screenshots${/}actual_screenshots
${testdata}             ${CURDIR}${/}..${/}..${/}TestData${/}NewUserMultiple_membership_testdata.xlsx

*** Keywords ***
Homescreen Is Dispalyed
    [Documentation]     User should redirect to Homescreen.
    Wait Until Page Contains Element    ${RR_logo}     30s
    Page Should Contain Element    ${RR_logo}

Verify Text In Latest PDF
    [Documentation]    Verify that specific text exists in the latest PDF file downloaded in the default directory
    [Arguments]     ${text}     ${texttwo}
    Sleep    15
    ${latest_pdf}=    Get Latest Pdf    ${DOWNLOADS_DIR}
    ${pdf_text}=    Convert Pdf To Txt    ${latest_pdf}
    Log    ${pdf_text}
    ${pdftotext}     Convert To String    ${pdf_text}
    Should Contain    ${pdftotext}    ${text}    ${texttwo}

Verify Invoice Creation Of Payment Page
    [Documentation]         Verify Invoice Creation Of Payment Page
    Mouse Over    ${make_payment}
    Click Element    ${make_payment}
    Wait Until Page Contains Element    ${send_response}    timeout=20s
    Click Element    ${send_response}

Verify Text In Latest Image
    [Documentation]    Verify that specific text exists in the latest PDF file downloaded in the default directory
    [Arguments]     ${text}
    Sleep       10s
    screenshot.Set Screenshot Directory    ${screenshot_path}
    ${image_name}    Set Variable    Dummy.png
    SeleniumLibrary.capture page screenshot    ${image_name}
    ${image_path}    Set Variable    ${screenshot_path}${/}${image_name}
    ${img_text}=    Get Text From Image    ${image_path}
    Log    Extracted Text: ${img_text}
    ${textofimage}=    Convert To String    ${img_text}
    Should Contain    ${textofimage}    ${TEXT}

Verify And Click On Download Receipt Button
    [Documentation]     Download latest pdf file
    Sleep    10
    Wait Until Element Is Visible    ${download_recipt}     timeout=30
    Click Element    ${download_recipt}
    Sleep    5
    Wait Until Element Is Visible    ${download_recipt}     timeout=30
    Press Keys  ${download_recipt}      ENTER
    Click Element    ${download_recipt}



