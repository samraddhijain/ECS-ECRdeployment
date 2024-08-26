*** Settings ***
Library    AppiumLibrary
Library    OperatingSystem
Library    Collections
Library    String
Library    ../../../../CommonBase/Utilities/user_keywords.py

*** Keywords ***
Open Application On Real Device
    [Arguments]    ${env_data}
    open application      ${env_data.host}    platformName=${env_data.platformName}   deviceName=${env_data.deviceName}   app=${env_data.application_sdk}      autoGrantPermissions=true    automationName=${env_data.automationName}    noReset=false

Open New Application On Real Device
    [Arguments]    ${env_data}
    open application      ${env_data.host}    platformName=${env_data.platformName}   deviceName=${env_data.deviceName}   app=${env_data.application_sdk}    autoGrantPermissions=true    automationName=${env_data.automationName}    noReset=false        platformVersion=${env_data.platformVersion}

Open Application On Lamda Test
    [Arguments]    ${env_data}
    open application
        ...    ${env_data.lt_host}
        ...    deviceName=${env_data.deviceName}
        ...    platformVersion=${env_data.platformVersion}
        ...    platformName=${env_data.platformName}
        ...    isRealMobile=true
        ...    app=${env_data.lt_app_url}
        ...    name=Android
        ...    automationName=${env_data.automationName}

Open Application On Browserstack
    [Arguments]    ${env_data}
    open application
        ...    ${env_data.browserstack_host}
        ...    deviceName=Samsung Galaxy S22 Ultra
        ...    platformVersion=${env_data.platformVersion}
        ...    platformName=${env_data.platformName}
        ...    isRealMobile=true
        ...    app=${env_data.browserstack_app_url}
        ...    name=Android
        ...    automationName=${env_data.automationName}



Wait For 2 Seconds
    sleep    2s


Wait And Click On Element
    [Arguments]    ${element}
    wait until page contains element    ${element}    timeout=10
    click element    ${element}

Verify Element Is Visible
    [Arguments]    ${element}
    wait until page contains element    ${element}     timeout=30

Verify Checkbox Is Unchecked
    [Arguments]    ${checkbox}
    wait until page contains element    ${checkbox}
    ${value}    get element attribute    ${checkbox}    value
    should be equal    ${value}     ${None}

Verify Button Is Disabled
    [Arguments]    ${button}
    wait until page contains element    ${button}
    ${enabled}    get element attribute     ${button}    enabled
    log to console    ${enabled}
    should be equal    ${enabled}    false

Verify Button Is Enabled
    [Arguments]    ${button}
    wait until page contains element    ${button}
    ${enabled}    get element attribute     ${button}    enabled
    log to console    ${enabled}
    should be equal    ${enabled}    true


Swipe Down Until Element Is Visible
    [Arguments]    ${element}
    FOR    ${count}    IN RANGE    0    20
        Swipe    ${438}    ${999}    ${438}    ${444}
        ${status}    run keyword and return status    element should be visible    ${element}
        IF    ${status}    BREAK
    END

Swipe Up Until Element Is Visible
    [Arguments]    ${element}
    FOR    ${count}    IN RANGE    0    10
        Swipe    ${718}    ${207}    ${658}    ${1507}
        ${status}    run keyword and return status    element should be visible    ${element}
        IF    ${status}    BREAK
    END

Swipe Down Until Text Is InVisible
    [Arguments]    ${element}
    FOR    ${count}    IN RANGE    0    10
        Swipe    ${438}    ${999}    ${438}    ${444}
        ${status}    run keyword and return status    Page Should Not Contain Text  ${element}
        IF    ${status}    BREAK
    END
