*** Settings ***
Library  SeleniumLibrary
Library  DateTime
Library  OperatingSystem
Variables  ../../PageObjects/User Profile/userprofile_locators.py
Resource   ../Fixtures and Results/fixturesresults_keywords.robot
Resource   ../Membership/membership_keywords.robot

*** Variables ***
${testdata}    ${CURDIR}${/}..${/}..${/}TestData${/}userprofiledatafile.xlsx
${actualpath}  Cutedoggy.png
${dogimage}    ${CURDIR}${/}..${/}..${/}TestData${/}Cutedoggy.png

*** Keywords ***
Click On User Profile Button
    [Documentation]     Click on user profile page button.
    Wait Until Element Is Visible    ${user_profile_title}      timeout=60s
    Click On Particular Element    ${profileicon_dropdown}
    Click On Particular Element    ${profileicon_icon}
    Wait Until Element Is Visible    ${editprofileicon_xpath}   timeout=60s

Match The Data On Profile Page And Incomplete Profile
    [Documentation]     Match the data on incomplete profile page and profile page.
    &{data}    fetch data by id    ${testdata}    3
    Wait Until Element Is Visible    ${firstname_profilepage_text}       30s
    ${first_name}   Get Text    ${firstname_profilepage_text}
    ${last_name}   Get Text    ${lastname_profilepage_text}
    ${firstname_lower}      Convert To Lower Case     ${first_name}
    Should Be Equal    ${firstname_lower}        ${data.first_name}
    ${lastname_lower}      Convert To Lower Case     ${last_name}
    Should Be Equal   ${lastname_lower}          ${data.last_name}
    FOR    ${index}    IN RANGE    1    5
        ${xpath} =    Set Variable    ${user_profile_data_xpath.replace("{index}", str(${index}))}
        ${elements}     Get Text    ${xpath}
        Log    ${elements}
    END
    Wait Until Element Is Visible    ${lastname_profilepage_text}       timeout=30
    ${gerseyname}   Get Text    ${lastname_profilepage_text}
    Log    ${gerseyname}
    Wait Until Element Is Visible    ${jersy_number}       timeout=30
    ${jersynumberplayer}    Get Text    ${jersy_number}
    Log    ${jersynumberplayer}
    Scroll Page Down slowly   ${for_you_section}
    Page Should Contain Element    ${for_you_section}

Should Show Last Name On Jersey In Caps
    [Documentation]     Should show Last name on Jersey in Capital letter.
    [Arguments]         ${value}
    Wait Until Element Is Visible    ${lastname_profilepage_text}       timeout=30
    ${gerseyname}   Get Text    ${lastname_profilepage_text}
    Log    ${gerseyname}
    ${string_name_upper}=    Evaluate    "${value}".upper()
    Log    ${string_name_upper}
    Should Be True    '${string_name_upper}' == '${gerseyname}'

Click On Edit Button
    [Documentation]    Click on Edit Button on user profile page
    Click On Particular Element    ${editprofileicon_xpath}
    
Click On Edit Icon
    [Documentation]     Click on edit icon of profile picture
    Wait For Five Seconds
    Click On Particular Element    ${editprofilephoto_icon}
    
CLick On Remove Profile Button
    [Documentation]     CLick on remove profile button
    Click On Particular Element    ${removeprofile_photo}

CLick On Confirm Changes Button
    [Documentation]     CLick on confirm changes button
    Scroll Element Into View    ${confirmchanges_button}
    Click On Particular Element    ${confirmchanges_button}
    
Display Membership page
    [Documentation]     Should redirect user to Membership page
    Page Should Contain Element    ${joinnow_button}

CLick On Upload Button For Image
    [Documentation]      CLick On Upload Button For Image
    ${filepath}     Normalize Path    ${dogimage}
    Choose File    ${uploadphoto_xpath}    ${filepath}

Upload Images From Computer And Image Should Upload Successfully
    [Documentation]     User should able to select images from computer and image should upload successfully
    Wait Until Element Is Visible    ${upload_img_button}        30
    ${uploaded_file}=    Get Value    ${uploadphoto_xpath}
    Should Contain    ${uploaded_file}  ${actualpath}

Should Show Register Date And Fav Player Name
    [Documentation]     SHould show register date and fav player name choose during registration.
    Wait Until Element Is Visible    ${fav_player_name}          10
    ${favouritplayer}       Get Text    ${fav_player_name}
    Log    ${favouritplayer}
    Wait Until Element Is Visible    ${registered_date_xpath}     10s
    ${registerddate}    Get Text    ${registered_date_xpath}
    Log    ${registerddate}

Click On Setting Button And Click On Edit Profile Button
    [Documentation]     Click On Setting Button on My profile Page
    Click On Particular Element    ${setting_button}
    Click On Particular Element    ${setting_editprofile_button}

User Should Able To Edit Below Fields
    [Documentation]     "User should able to edit below fields, Gender, DOB, Jersey number, Fav. player.
    FOR    ${index}    IN RANGE    1    5
        ${xpath} =    Set Variable    ${user_edit_button.replace("{index}", str(${index}))}
        Log    ${xpath}
        Page Should Contain Element    ${xpath}
    END

Update The Jersey No and Save The Changes
    [Documentation]    User Should Able To View Jersey Number.
    [Arguments]     ${jersynum}
    Scroll Element Into View   ${fav_player_name}
    Click On Particular Element    ${update_jersey_numberbtn}
    Input Text    ${update_jersey_no_inputbox}    ${jersynum}
    Click On Particular Element    ${jersy_no_save_button}
    Scroll Element Into View    ${confirmchanges_button}
    Click On Particular Element    ${confirmchanges_button}

Should Show Updated Jersey Number On Jersey
    [Documentation]     Should show Updated jersey number on jersey.
    Page Should Contain    09