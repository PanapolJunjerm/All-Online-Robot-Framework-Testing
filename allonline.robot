*** Settings ***
Library    SeleniumLibrary

Test Setup    open browser and go to allonline    ${URL}    ${BROWSER}
Test Teardown    Close Browser

*** Variables ***
${URL}    https://allonline.7eleven.co.th/
${BROWSER}    Chrome

*** Test Cases ***

ลูกค้าสั่งซื้อสินค้าสำเร็จ
    เลือกซื้อสินค้า
    เลือกวิธีการจัดส่ง
    เลือกวิธีการชำระเงิน

*** Keywords ***
เลือกซื้อสินค้า
    Input Text    name=q    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม
    Press Keys    None    ENTER
    Wait Until Page Contains    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม
    Click Element    xpath://*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[1]/div
    Input Text    name:order_count    5
    Click Element    xpath://*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button

expect order
    Element Should Contain    xpath://*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[2]    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม (20 กรัม X 6 ซอง)
    Element Should Contain    xpath://*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[3]    5
    Element Should Contain    xpath://*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[4]    160
    Element Should Contain    xpath://*[@id="js-invoice-details-tbody"]/tr[2]/td[2]    35
    Element Should Contain    xpath://*[@id="totalAmount"]    195.00
    Element Should Contain    xpath://*[@id="js-invoice-details-tbody"]/tr[17]/td[2]    548
    
เลือกวิธีการจัดส่ง
    login
    Wait Until Page Contains    ตะกร้าสินค้า
    Wait Until Page Contains    5
    Sleep    3
    Click Element    xpath://*[@id="mini-basket"]
    Wait Until Page Contains    ชำระค่าสินค้า
    Click Element    xpath://*[@id="mini-basket-val"]/li[5]/a[2]
    Wait Until Page Contains    รายละเอียดการจัดส่งสินค้า
    Click Element    xpath://*[@id="address-tabs"]/ul/li[2]/a
    ${element_exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@id="addressbook"]/div/div[2]/div[2]
    Run Keyword If    ${element_exists}    Click ELement    xpath://*[@id="addressbook"]/div/div[2]/div[2]
    Click Element    xpath://*[@id="btn-accept-gdpr"]
    Click Element    xpath://*[@id="address"]/div[1]/div[2]

    input user information
    Wait Until Page Contains    ระบุที่อยู่จัดส่ง
    Wait Until Page Contains    เลือกที่อยู่
    Wait Until Element Is Visible    id:formatted-location
    Wait Until Element Is Visible    id:selected-location
    Sleep    3
    Click Element    id:selected-location
    Sleep    3
    Scroll Element Into View    xpath://*[@id="continue-payment-btn"]
    Click Element    xpath://*[@id="continue-payment-btn"]
    Wait Until Element Is Visible    xpath://*[@id="payment-options"]/div[1]/button
    Click Element    xpath://*[@id="payment-options"]/div[1]/button
    Sleep    3
    expect order
    expect address

expect address
    Element Should Contain    xpath://*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[1]/td/div[2]/span    พันกร ชมจันทร์    เบอร์โทรติดต่อ : 0619917765
    Element Should Contain    xpath://*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[1]/td/div[2]/span    45/9  7,  , บางปลา บางพลี สมุทรปราการ 10540

เลือกวิธีการชำระเงิน
    Wait Until Element Is Visible    xpath://*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button
    Click Element    xpath://*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button
    Sleep    3
    Wait Until Element Is Visible    xpath//*[@id="csModalContent"]
    Input Text    id:cardName    พันกร ชมจันทร์
    Input Text    id:cardNumber    46246977491778712
    Input Text    id:expiryDate    01/29
    Input Text    id:cvCode    476
    Click Element    id:subFormPay

input user information
    Input Text    name:shippingData.homeShippingData.newShippingAddress.firstname    พันกร
    Input Text    name:shippingData.homeShippingData.newShippingAddress.lastname    ชมจันทร์
    Input Text    name:shippingData.homeShippingData.newShippingAddress.mobilePhone    0619917765
    Input Text    name:shippingData.homeShippingData.newShippingAddress.addrNo    45/9
    Input Text    name:shippingData.homeShippingData.newShippingAddress.moo    7
    Select From List By Label    id:new-address-province    สมุทรปราการ
    Select From List By Label    id:new-address-district    บางพลี
    Select From List By Label    id:new-address-sub-district    บางปลา 

login
    Input Text    name:email    example@gmail.com
    Input Text    name:password    example
    Click Element    xpath://*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]
    
open browser and go to allonline
    [Arguments]    ${URL}    ${BROWSER}
    Open Browser    url=${URL}    browser=${BROWSER}