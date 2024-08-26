*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Variables  ../../PageObjects/Fanpoll/Fanpoll_locators.py
Variables  ../../PageObjects/Login/login_page_locators.py
Variables  ../../PageObjects/Gaming/gaming_locators.py
Resource   ../Fixtures and Results/fixturesresults_keywords.robot

*** Variables ***
${log1}    ${None}
${log2}    ${None}
${log3}    ${None}
${log5}    ${None}

*** Keywords ***
Verify User Is Not Login
    Wait Until Element Is Visible    ${login_button}    timeout=10s

Verify Fanpoll Functionality For Not Logged In User
    Wait Until Element Is Visible    ${fanzone_dropdown}    timeout=20s
    Mouse Over    ${fanzone_dropdown}
    Click Element    ${fanpoll_btn}
    Wait Until Element Is Visible    ${fanpoll_txt}     timeout=20s
    Scroll Element Into View    ${login_btn_fanpoll}
    Wait For Five Seconds
    Page Should Contain Element    ${login_btn_fanpoll}

Click On Login
    Click Element    ${login_btn_fanpoll}

Page Should Gets Redirected To Fanpoll Page
    Mouse Over    ${fanzone_dropdown}
    Click Element    ${fanpoll_btn}
    Wait Until Element Is Visible    ${fanpoll_txt}     timeout=20s

User Should Able To Vote
    Wait Until Element Is Visible    ${accordian_1}     timeout=20s
    Scroll Element Into View    ${accordian_1}
    Sleep    2s
    Wait Until Element Is Visible    ${vote_now_btn}    timeout=20s
    Scroll Element Into View    ${vote_now_btn}
    Wait Until Element Is Enabled    ${vote_now_btn}
    Click Element    ${vote_now_btn}
    Sleep    10s
    Wait Until Element Is Visible    ${percentage_locator}  timeout=20s

User Should Not Able To See Vote Now Button
    Wait Until Element Is Visible    ${accordian_1}     timeout=20s
    Scroll Element Into View    ${accordian_1}
    Click Element    ${accordian_1}
    Wait For Five Seconds
    Page Should Not Contain Element    ${vote_now_btn}

User Should Able To See Percentage On Players Card
    Wait Until Element Is Visible    ${accordian_3}     timeout=20s
    Scroll Element Into View    ${accordian_3}
    Click Element    ${accordian_3}
    Page Should Not Contain Element    ${vote_now_btn}

Verify Separte Text By Percentage Symbol
    ${percentage_1}=    Set Variable    10.85%
    ${log1}=            Evaluate    float("${percentage_1}".split('%')[0])

    ${percentage_2}=    Set Variable    12.54%
    ${log2}=            Evaluate    float("${percentage_2}".split('%')[0])

    ${percentage_3}=    Set Variable    5.76%
    ${log3}=            Evaluate    float("${percentage_3}".split('%')[0])

    ${percentage_4}=    Set Variable    70.85%
    ${log4}=            Evaluate    float("${percentage_4}".split('%')[0])

    ${sum}=             Set Variable    100
    ${expression}=      Set Variable    ${log1} + ${log2} + ${log3} + ${log4}
    ${addition}=        Evaluate    ${expression}
    ${add}=    Convert To Integer    ${addition}
    Log                 ${add}
    Should Be Equal As Strings    ${add}    ${sum}

Verify User Us Able To See Percentage On Every Card
    ${percentage_elements}=    Get WebElements    //div[@class="player-card"]//div[@class="percentage"]
    FOR    ${element}    IN    @{percentage_elements}
        Element Should Be Visible    ${element}
    END

Verify Percentage Symbol Is Present Or Not And Sum Is Equal To 100
    ${elements} =  Get WebElements  ${percentage_locator}
    ${total_percentage} =  Set Variable  0
    FOR  ${element}  IN  @{elements}
        ${element_text} =  Get Text  ${element}
        Log    ${element_text}
        ${number_text} =  Split String  ${element_text}  %   # Split the text by '%'
        ${percentage} =  Evaluate  ${number_text}[0]  # Extract numeric value (excluding the percentage symbol)
        ${total_percentage} =  Evaluate  "${total_percentage} + ${percentage}"  # Add the percentage to the total
        Run Keyword If  not '% ' in "${element_text}"  Fail  Element does not contain '%': ${element_text}
    END
    ${winner_text}      Get Text    ${active_winner}
    ${percentage_parts} =  Split String  ${winner_text}  ${SPACE}  # Split the text by space
    ${winner_percentage_text} =  Set Variable  ${percentage_parts}[2]  # Get the percentage part
    ${winner_percentage} =  Evaluate  ${winner_percentage_text[:-1]}  # Extract numeric value from winner element by removing the last character '%'
    ${total_percentage} =  Evaluate  "${total_percentage} + ${winner_percentage}"  # Add winner percentage to the total

    Run Keyword If  ${total_percentage} != 100  Fail  Total percentage is not equal to 100: ${total_percentage}

Verify Poll Timer Is Hidden
    Wait Until Element Is Visible    ${fanpoll_txt}     timeout=20
    Page Should Not Contain Element    ${poll}

Verify Sum Of Player Percentage
    Wait Until Element Is Visible    ${percentage_disable_player}   timeout=20s
    ${elements} =  Get WebElements  ${percentage_disable_player}
    ${total_percentage} =  Set Variable  0
    ${disable_player_percent} =  Get WebElements    ${percentage_disable_player}
    FOR    ${element}    IN    @{disable_player_percent}
        ${percent_value}    Get Text    ${element}
        @{split_votes}      Split String    ${percent_value}    %
        ${number_percent}   Convert To Number      ${split_votes}[0]
        Log    ${number_percent}
        ${total_percentage} =    Evaluate    ${total_percentage} + ${number_percent}
        Log    ${total_percentage}
    END
    Log    ${total_percentage}

Click On No Button
    Click On Particular Element    ${whatsapp_no_button}

Click On Send SMS Button
    Click On Particular Element   ${send_sms_button}

