*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    SeleniumLibrary
Library     JSONLibrary
Resource  ${CURDIR}${/}..${/}..${/}..${/}..${/}CommonBase${/}Utilities${/}user_keywords.py

*** Variables ***
${base_url}  https://stg-rr.sportz.io
${get_profile_url}  https://stg-rr.sportz.io/apiv3/auth/getprofile?
${expected_response_1}  {"status":200,"ApplicationDomain":null,"data":{"status":"1","message":"Success","otp_duration":"120"},"content":null,"ImagesData":null,"Authodata":null,"NextPrev":null,"EntityData":null,"RelatedArticle":null,"message":null,"response_status":null,"fetchfromcache":false,"asycncall":false,"time":null,"meta":null}
${expected_response_2}  {"status":200,"ApplicationDomain":null,"data":{"status":"1","message":"Success","otp_duration":"120"},"content":null,"ImagesData":null,"Authodata":null,"NextPrev":null,"EntityData":null,"RelatedArticle":null,"message":null,"response_status":null,"fetchfromcache":false,"asycncall":false,"time":null,"meta": null}
${expected_response_3}  {"status":200,"ApplicationDomain":null,"data":{"status":"1","message":"Success"},"content":null,"ImagesData":null,"Authodata":null,"NextPrev":null,"EntityData":null,"RelatedArticle":null,"message":null,"response_status":null,"fetchfromcache":false,"asycncall":false,"time":null,"meta":null}
${expected_response_4}     { "status": 200,"ApplicationDomain": null,"data": {"user_guid": "2fdb3cb3-8bbe-4b7c-a86b-f3f4c7ee50aa-10042024073911034","user_id": "1477806","email_id": "adi15jan@gmail.com","status": "1","message": "Success", "subject": null}}
${update_profile_data}     {"data": {"email_id": "TEST@6cibsz.cashbenties.com", "otp": "captcha": "","is_app": "","platform_version": "","platform_type": 3,"device_name": "","user": {"mobile_no":"9000000023","pincode": "","dob": "2008-11-21","gender": "male","country_id": "","country_name": "","country_code": "91","city": "","favourite_player_id": "","favourite_player_name": "","jersey_number": 13,"jersey_name": "","first_name": "aj","last_name": "sk", "membership_code": "","Internal_referral_code": "","subscribe_for_email": true,"accept_tnc": true,"accept_disclaimer": true},"imagejson": {"imageName": "","imageUrl": "","imageJson": "","userguid": "","is_app": "","userid": ""}}}
${expected_response_5}    {"status": 200,"ApplicationDomain": null,"data": {"user_guid": "cf189d3e-e2a8-4271-931c-ba92ee7a210f-08052024085012447","user_id":"2410225","email_id":"TEST@66cibsz.cashbenties.com","status": "1","message": "Profile updated successfully.","subject": null,"user": {"name": "","edition": "","favourite_club": "","favourite_team": null,"favourite_team_logo": null,"social_user_image": "","mobile_no": "9000000023","profile_completion_percentage": null,"first_name": "aj","last_name": "sk","pug_first_name": null,"pug_last_name": null,"profile_page_enabled": null,"campaign_id": "","address": "","pincode": "","campaign_json": null,"membership_related_json": null,"ext_info": null,"membership_code": "","gender": "male","city": "","social_user_name": "","country_id": "","country_code": "91","state_name": "","country_name": "","city_id": "","state_id": "","subscribe_for_email": true,"previous_subscription_key": false,"dob": "2008-11-21","sportsbet_username": null,"jersey_number": 13,"jersey_name": "","favourite_player_id": "","favourite_player_name": "","subscribe_for_watsapp": false,"accept_tnc": false,"internal_referral_code": "","referal_user_guid": null, "is_referred": null,"accept_disclaimer": false,"asc_with_hockey": null,"age_group": null},"created_date": "2024-05-08 08:42:16.078124","updated_date": "2024-05-08 08:50:12.349983","is_first_login": "0","is_custom_image": "0","client_id": null,"waf_user_guid": "4a3786ff-f3da-44fa-a9cb-ef3de7e717d3","user_data_store_type": null,"last_recover_date": null,"email_verified": "0","mobile_verified": "0","pass_type": null,"password": null,"cc": null,"bcc": null,"addtional_info": {"push_flag": false,"install_id": "","push_token": "","sync_status": 1,"web_subs_id": "","web_attributes": null,"device_attributes": null,"service_type_status": "2","is_app": "1"}, "platform_type": 0,"token": "6eb9c703-1dd5-44a8-b206-9ce1c2c34bec","epoch_timestamp": "1715158212","is_first_registered": null,"loggedin_device_info": null,"t": 525600},"content": null,"ImagesData": null,"Authodata": null,"NextPrev": null,"EntityData": null,"RelatedArticle": null,"message": null,"response_status": null,"fetchfromcache": false,"asycncall": false,"time": null,"meta": null}

*** Keywords ***
Post Api Send OTP
    [Tags]      SendOTP
    [Documentation]     Verify Post Method send otp
    [Arguments]     ${mobile_number}
    Create Session    mysession    ${base_url}
    ${header}=      Create Dictionary   auth=q4F6aFKgfg123  Content-Type=application/json
    ${params}=    Create Dictionary    is_serverside=1    is_app=1
    ${data}=      Create Dictionary    mobile_no=${mobile_number}  email_id=  captcha=  type=1  opt=1  country_code=+91  is_app=1
    ${payload}=   Create Dictionary    data=${data}
    ${response}=    POST On Session    mysession    apiv3/auth/sendotp  params=${params}  json=${payload}  headers=${header}
    ${code}=    Convert To String    ${response.status_code}
    Should Be Equal     ${code}    200
    ${res}=    Convert To String    ${response.content}
    Should Be Equal    ${res}    ${expected_response_1}

Post Api Signup With OTP
    [Tags]      Signin
    [Documentation]     Verify Post Method to signup with otp
    [Arguments]     ${mobile_number}
    Open CMS for RR
    Login To CMS
    ${otp}=  Get Otp From CMS   ${mobile_number}
    ${otp}=  Convert To String    ${otp}
    Set Global Variable    ${otp}
    Close Browser
    Create Session    mysession    ${base_url}
    ${data}=      Create Dictionary    mobile_no=${mobile_number}  otp=${otp}  captcha=  is_app=1  platform_version=1  platform_type=1  device_name=web
    ${payload}=   Create Dictionary    data=${data}
    ${header}=      Create Dictionary   auth=q4F6aFKgfg123  Content-Type=application/json
    ${params}=    Create Dictionary    is_serverside=1    is_app=1
    ${response}=    POST On Session    mysession    apiv3/auth/signinwithotp  params=${params}  json=${payload}  headers=${header}
    ${code}=    Convert To String    ${response.status_code}
    Should Be Equal     ${code}    200
    &{res_data}=  Set Variable  ${response.json()}
    &{res_header}=  Set Variable    ${response.headers}
    ${user_guid}=  Set Variable  ${res_data.data.user_guid}
    ${user_token}=  Set Variable    ${res_header.usertoken}
    Set Global Variable  ${user_token}
    [RETURN]      ${user_guid}      ${user_token}

Verify Otp Api
    [Tags]      VerifyOtp
    [Documentation]     Verify Post Method to verify otp
    [Arguments]     ${mobile_number}  ${otp}
    Create Session    mysession    ${base_url}
    ${data}=      Create Dictionary    mobile_no=${mobile_number}  email_id=  otp=${otp}  type=1  country_code=+91  is_app=1  captcha=
    ${payload}=   Create Dictionary    data=${data}
    ${header}=      Create Dictionary   auth=q4F6aFKgfg123  Content-Type=application/json
    ${params}=    Create Dictionary    is_serverside=1    is_app=1
    ${response}=    POST On Session    mysession    apiv3/auth/verifyotp  params=${params}  json=${payload}  headers=${header}
    ${code}=    Convert To String    ${response.status_code}
    Should Be Equal     ${code}    200


Convert Response Content To JSON
    [Arguments]    ${response}
    ${response_string}    Convert To String    ${response.content}
    Log     ${response_string}
    ${response_json}=    Convert String To Json    ${response_string}
    Log     ${response_json}
    [Return]    ${response_json}

Validate GET Profile
    [Tags]    Profile
    [Documentation]   Verify Get Profile
    [Arguments]     ${user_guid}    ${user_token}
    Create Session    mysession    ${base_url}
    ${header}=      Create Dictionary   auth=q4F6aFKgfg123  Content-Type=application/json  usertoken=${user_token}
    ${params} =    Create Dictionary   token=${user_guid}   is_app=1
    ${response}=   Get Request   mysession   apiv3/auth/getprofile   params=${params}  headers=${header}
    ${response_json}    Convert Response Content To JSON    ${response}
    ${membership_id}      Extract Response Values    ${response_json}    membership_code
    Log    ${membership_id}[0]
#    ${update_mem_code}      Convert To String    ${membership_id}[0]
#    ${split_string} =    Evaluate    ''.join('${update_mem_code}'.split('-'))
#    ${membership_code} =    Evaluate    '${split_string}'.strip()
#    Log    ${membership_code}
    ${membership_expiry_date}      Extract Response Values    ${response_json}    membership_expiry_date
    Log     ${membership_expiry_date}[0]
    ${membership_type}      Extract Response Values    ${response_json}    membership_type
    Log    ${membership_type}[0]
    [Return]    ${membership_id}[0]   ${membership_expiry_date}[0]    ${membership_type}[0]

