Language: en

*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           BuiltIn

*** Variables ***
${URL}            https://automationteststore.com/
${URL_Login}      https://automationteststore.com/index.php?rt=account/login
${URL_Register}    https://automationteststore.com/index.php?rt=account/create
${BROWSER}        chrome
${NO_RESULT_MESSAGE}    xpath=//*[@id="maincontainer"]/div/div/div/div/div[2]
${URL_SEARCH}     https://automationteststore.com/index.php?rt=product/search
${RESULT_ITEM}    xpath=//*[@id="maincontainer"]//div[contains(@class, 'col-md-3 col-sm-6 col-xs-12')]
${URL}            https://automationteststore.com/
${TWITTER_URL}    https://x.com/
${Linkedin_URL}    https://uk.linkedin.com/
${DEFAULT_CURRENCY}    $
${EURO_CURRENCY}    €
${GBP_CURRENCY}    £
${EUR_LINK}       https://automationteststore.com/index.php?rt=index/home&currency=EUR
@{CART_ITEMS}     #Sử dụng để lưu thông tin sản phẩm
${PRODUCT_IMAGE_SRC}    //img[contains(@src, 'new_ladies_red3_jpg-100225-250x250.jpg')]
${PRODUCT_ADD_BUTTON}    xpath=//div[@id='block_frame_featured_1769']//div[contains(@class, 'pricetag')]/a

*** Test Cases ***
# Test Cases cho Đăng ký tài khoản

TC1: Đăng ký tài khoản với thông tin hợp lệ
    Open Browser    ${URL_Register}    ${BROWSER}
    Wait Until Element Is Visible    id=AccountFrm
    Fill Registration Form With Valid Data
    Scroll Element Into View    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Click Button    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Location should be    https://automationteststore.com/index.php?rt=account/success
    Capture Page Screenshot
    [Teardown]    Close Browser

TC2: Đăng ký với email đã tồn tại
    Open Browser    ${URL_Register}    ${BROWSER}
    Wait Until Element Is Visible    id=AccountFrm
    Fill Registration Form With Exist Email
    Scroll Element Into View    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Click Button    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: E-Mail Address is already registered!
    Capture Page Screenshot
    [Teardown]    Close Browser

TC3: Đăng ký với mật khẩu nhập lại không khớp
    Open Browser    ${URL_Register}    ${BROWSER}
    Wait Until Element Is Visible    id=AccountFrm
    Fill Registration Form With Non-Matching Password
    Scroll Element Into View    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Click Button    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Log    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Password confirmation does not match password!
    Capture Page Screenshot
    [Teardown]    Close Browser

TC4: Đăng ký bỏ trống các trường bắt buộc
    Open Browser    ${URL_Register}    ${BROWSER}
    Wait Until Element Is Visible    id=AccountFrm
    Click Element    xpath=//*[@id="AccountFrm_agree"]
    Scroll Element Into View    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Click Button    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Login name must be alphanumeric only and between 5 and 64 characters!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    First Name must be between 1 and 32 characters!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Last Name must be between 1 and 32 characters!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Email Address does not appear to be valid!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Address 1 must be between 3 and 128 characters!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    City must be between 3 and 128 characters!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Zip/postal code must be between 3 and 10 characters!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Please select a region / state!
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Password must be between 4 and 20 characters!
    Capture Page Screenshot
    [Teardown]    Close Browser

TC5: Đăng ký mà không chấp nhận các điều khoản
    Open Browser    ${URL_Register}    ${BROWSER}
    Wait Until Element Is Visible    id=AccountFrm
    Scroll Element Into View    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Click Button    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Scroll Element Into View    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Click Button    xpath=//*[@id="AccountFrm"]/div[5]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: You must agree to the Privacy Policy!
    Location should be    https://automationteststore.com/index.php?rt=account/create
    Capture Page Screenshot
    [Teardown]    Close Browser

# Test Cases cho Đăng nhập

TC6: Đăng nhập với tài khoản hợp lệ
    Login With    thanhtruc    123456789
    Location should be    https://automationteststore.com/index.php?rt=account/account
    Capture Page Screenshot
    [Teardown]    Close Browser

TC7: Đăng nhập sai mật khẩu
    Login With    thanhtruc    111111
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: Incorrect login or password provided.
    Location should be    https://automationteststore.com/index.php?rt=account/login
    Capture Page Screenshot
    [Teardown]    Close Browser

TC8: Đăng nhập sai username
    Login With    thanh    123456789
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: Incorrect login or password provided.
    Location should be    https://automationteststore.com/index.php?rt=account/login
    Capture Page Screenshot
    [Teardown]    Close Browser

TC9:Để trống ô username
    Open Browser To Login Page
    Input Text    id=loginFrm_password    123456
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: Incorrect login or password provided.
    Location should be    https://automationteststore.com/index.php?rt=account/login
    Capture Page Screenshot
    [Teardown]    Close Browser

TC10: Để trống ô password
    Open Browser To Login Page
    Input Text    id=loginFrm_loginname    thanhtruc
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: Incorrect login or password provided.
    Location should be    https://automationteststore.com/index.php?rt=account/login
    Capture Page Screenshot
    [Teardown]    Close Browser

# Quên mật khẩu

TC11:Xác minh rằng liên kết đặt lại mật khẩu đang hoạt động
    Open Browser To Login Page
    Click Element    xpath=//*[@id="loginFrm"]/fieldset/a[1]
    Wait Until Element Is Visible    id=forgottenFrm_loginname
    Wait Until Element Is Visible    id=forgottenFrm_email
    Element Should Be Visible    id=forgottenFrm_email
    Element Should Be Visible    id=forgottenFrm_loginname
    Capture Page Screenshot
    [Teardown]    Close Browser

TC12:Yêu cầu đặt lại mật khẩu bằng email hợp lệ
    Open Browser To Login Page
    Click Element    xpath=//*[@id="loginFrm"]/fieldset/a[1]
    Wait Until Element Is Visible    id=forgottenFrm_loginname
    Wait Until Element Is Visible    id=forgottenFrm_email
    Input Text    id=forgottenFrm_loginname    kieuhuynhTDT
    Input Text    id=forgottenFrm_email    knnhuynh03@gmail.com
    Click Button    xpath=//*[@id="forgottenFrm"]/div[2]/div/button
    Element Should Contain    xpath=//div[contains(@class, 'alert-success')]    Success: Password reset link has been sent to your e-mail address.
    Capture Page Screenshot
    [Teardown]    Close Browser

TC11: Đặt lại mật khẩu với email không hợp lệ
    Open Browser To Login Page
    Click Element    xpath=//*[@id="loginFrm"]/fieldset/a[1]
    Wait Until Element Is Visible    id=forgottenFrm_loginname
    Wait Until Element Is Visible    id=forgottenFrm_email
    Input Text    id=forgottenFrm_loginname    thanhtruc
    Input Text    id=forgottenFrm_email    truc055@gmail.com
    Click Button    xpath=//*[@id="forgottenFrm"]/div[2]/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: No records found matching information your provided, please check your information and try again!
    Capture Page Screenshot
    [Teardown]    Close Browser

TC12: Yêu cầu đặt lại mật khẩu với tên người dùng không hợp lệ
    Open Browser To Login Page
    Click Element    xpath=//*[@id="loginFrm"]/fieldset/a[1]
    Wait Until Element Is Visible    id=forgottenFrm_loginname
    Wait Until Element Is Visible    id=forgottenFrm_email
    Input Text    id=forgottenFrm_email    truc02@gmail.com
    Click Button    xpath=//*[@id="forgottenFrm"]/div[2]/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]
    Element Should Contain    xpath=//div[contains(@class, 'alert-danger')]    Error: The Login name was not provided or not found in our records, please try again!
    Capture Page Screenshot
    [Teardown]    Close Browser

# Test Cases cho Đăng xuất

TC13
    [Documentation]    Đăng xuất
    Login With    thanhtruc    123456789
    Location should be    https://automationteststore.com/index.php?rt=account/account
    Mouse Over    xpath=//*[@id="customer_menu_top"]/li/a/div
    Click Element    xpath=//*[@id="customer_menu_top"]/li/ul/li[10]
    Location Should Be    https://automationteststore.com/index.php?rt=account/logout
    Capture Page Screenshot
    [Teardown]    Close Browser

# Test Cases cho xem sản phẩm

TC14: Xem chi tiết sản phẩm bằng Search
    [Documentation]    Xác minh rằng chi tiết sản phẩm có thể được xem bằng cách tìm kiếm sản phẩm
    Open Browser To Home Page
    Search For Product
    Verify Product Details
    [Teardown]    Close Browser

TC15: Xem chi tiết sản phẩm bằng Category Navigation
    [Documentation]    Verify that product details can be viewed by navigating through categories
    Open Browser To Home Page
    Navigate To Category
    Select Product From Category    Skinsheen Bronzer Stick
    Verify Product Details
    [Teardown]    Close Browser

TC16: Xem chi tiết sản phẩm theo Featured Products
    [Documentation]    Xác minh rằng chi tiết sản phẩm có thể được xem từ phần sản phẩm nổi bật
    Open Browser To Home Page
    Select Featured Product
    Verify Product Details
    [Teardown]    Close Browser

TC17: Kiểm Tra Sản Phẩm Còn Hàng Hoặc Hết Hàng
    [Documentation]    Trường hợp thử nghiệm này kiểm tra xem sản phẩm còn hàng hay hết hàng.
    Open Browser To Home Page
    Search For Product
    Verify Product Details

#TC cho tìm kiếm sản phẩm

TC18: Tìm sản phẩm
    [Documentation]    Xác minh chức năng tìm kiếm với từ khóa "skin"
    Open Browser To Home Page
    Input Text    css=#filter_keyword    Skin
    Wait Until Element Is Visible    css=.button-in-search
    Scroll Element Into View    css=.button-in-search
    Click Element    css=.button-in-search
    Wait Until Page Contains    Skin
    Sleep    5 seconds
    Verify Search Results
    [Teardown]    Close Browser

TC19: Tìm kiếm không có kết quả
    [Documentation]    Kiểm tra chức năng tìm kiếm với từ khóa không tồn tại "noresultkeyword"
    Open Browser To Home Page
    Input Text    css=#filter_keyword    noresultkeyword
    Wait Until Element Is Visible    css=.button-in-search
    Scroll Element Into View    css=.button-in-search
    Click Element    css=.button-in-search
    Element Should Contain    ${NO_RESULT_MESSAGE}    There is no product that matches the search criteria.
    [Teardown]    Close Browser

TC20: Tìm kiếm sau khi chọn danh mục
    [Documentation]    Kiểm tra chức năng tìm kiếm sau khi chọn danh mục
    Open Browser To Home Page
    Click Element    xpath=//*[@id="filter_keyword"]
    Wait Until Element Is Visible    xpath=//*[@id="category_43"]
    Scroll Element Into View    xpath=//*[@id="category_43"]
    Click Element    xpath=//*[@id="category_43"]
    Input Text    css=#filter_keyword    skin
    Wait Until Element Is Visible    css=.button-in-search
    Scroll Element Into View    css=.button-in-search
    Click Element    css=.button-in-search
    Verify Search Results
    [Teardown]    Close Browser

TC21: Tìm kiếm sản phẩm với các bước chi tiết
    [Documentation]    Xác minh chức năng tìm kiếm trên trang tìm kiếm chuyên dụng với các bước chi tiết
    Open Browser    ${URL_SEARCH}    ${BROWSER}
    Maximize Browser Window
    Input Text    xpath=//*[@id='keyword']    skin
    Wait Until Element Is Visible    xpath=//*[@id='category_id']    15s
    Search product
    Verify Search Results
    [Teardown]    Close Browser

TC22: Tìm kiếm sản phẩm với các bước chi tiết không điền tên
    [Documentation]    Xác minh chức năng tìm kiếm trên trang tìm kiếm chuyên dụng với các bước chi tiết
    Open Browser    ${URL_SEARCH}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//*[@id='category_id']    15s
    Search product
    Element Should Contain    ${NO_RESULT_MESSAGE}    There is no product that matches the search criteria.
    [Teardown]    Close Browser

TC23: Tìm kiếm sản phẩm với các bước chi tiết và không chọn danh mục
    [Documentation]    Xác minh chức năng tìm kiếm trên trang tìm kiếm chuyên dụng với các bước chi tiết và không chọn danh mục
    Open Browser    ${URL_SEARCH}    ${BROWSER}
    Maximize Browser Window
    Input Text    xpath=//*[@id='keyword']    skin
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[3]/label
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[4]/label
    Click Button    xpath=//*[@id="search_button"]
    Verify Search Results
    [Teardown]    Close Browser

TC24: Tìm kiếm sản phẩm với các bước chi tiết và không tìm kiếm lựa chọn trong mô tả sản phẩm
    [Documentation]    Xác minh chức năng tìm kiếm trên trang tìm kiếm chuyên dụng với các bước chi tiết và không chọn tìm kiếm trong mô tả sản phẩm
    Open Browser    ${URL_SEARCH}    ${BROWSER}
    Maximize Browser Window
    Input Text    xpath=//*[@id='keyword']    skin
    Wait Until Element Is Visible    xpath=//*[@id='category_id']    15s
    Click Element    xpath=//*[@id='category_id']
    Click Element    xpath=//*[@id="category_id"]/option[4]
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[4]/label
    Click Button    xpath=//*[@id="search_button"]
    Verify Search Results
    [Teardown]    Close Browser

TC25: Tìm kiếm sản phẩm với các bước chi tiết và không tìm kiếm lựa chọn trong mẫu sản phẩm
    Open Browser    ${URL_SEARCH}    ${BROWSER}
    Maximize Browser Window
    Input Text    xpath=//*[@id='keyword']    skin
    Wait Until Element Is Visible    xpath=//*[@id='category_id']    15s
    Click Element    xpath=//*[@id='category_id']
    Click Element    xpath=//*[@id="category_id"]/option[4]
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[3]/label
    Click Button    xpath=//*[@id="search_button"]
    Verify Search Results
    [Teardown]    Close Browser

TC26:Tìm kiếm và sắp xếp sản phẩm từ A đến Z
    Open Browser    ${URL_SEARCH}    ${BROWSER}
    Maximize Browser Window
    Input Text    xpath=//*[@id='keyword']    skin
    Wait Until Element Is Visible    xpath=//*[@id='category_id']    15s
    Click Element    xpath=//*[@id='category_id']
    Click Element    xpath=//*[@id="category_id"]/option[4]
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[3]/label
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[4]/label
    Click Button    xpath=//*[@id="search_button"]
    Verify Search Results
    Click Element    xpath=//*[@id="sort"]
    Click Element    xpath=//*[@id="sort"]/option[2]
    ${product_elements}    Get WebElements    ${RESULT_ITEM}
    ${product_names}    Create List
    FOR    ${element}    IN    @{product_elements}
        ${name}    Get Text    ${element}
        Append To List    ${product_names}    ${name}
    END
    ${sorted_names}    Copy List    ${product_names}
    Sort List    ${sorted_names}
    Log    ${product_names}
    Log    ${sorted_names}
    Should Be Equal    ${product_names}    ${sorted_names}
    [Teardown]    Close Browser

TC27:Tìm kiếm và sắp xếp sản phẩm từ Z đến A
    [Documentation]    Verify the search functionality on the dedicated search page with detailed steps, and sort by Name Z - A
    Open Browser    ${URL_SEARCH}    ${BROWSER}
    Maximize Browser Window
    Input Text    xpath=//*[@id='keyword']    skin
    Wait Until Element Is Visible    xpath=//*[@id='category_id']    15s
    Click Element    xpath=//*[@id='category_id']
    Click Element    xpath=//*[@id="category_id"]/option[4]
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[3]/label
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[4]/label
    Click Button    xpath=//*[@id="search_button"]
    Verify Search Results
    Click Element    xpath=//*[@id="sort"]
    Click Element    xpath=//*[@id="sort"]/option[3]
    ${product_elements}    Get WebElements    ${RESULT_ITEM}
    ${product_names}    Create List
    FOR    ${element}    IN    @{product_elements}
        ${name}    Get Text    ${element}
        Append To List    ${product_names}    ${name}
    END
    ${sorted_names}    Copy List    ${product_names}
    ${sorted_list}    Evaluate    sorted($sorted_names, reverse=True)
    Log    ${product_names}
    Log    ${sorted_names}
    Should Be Equal    ${product_names}    ${sorted_names}
    [Teardown]    Close Browser

#TC cho thay đổi đơn vị tiền tệ

TC28: Kiểm tra tiền tệ mặc định được hiển thị là USD
    Open Browser To Automation Test Store
    Verify Default Currency
    [Teardown]    Close Browser

TC29: Kiểm tra cập nhật giá sản phẩm tương ứng khi thay đổi tiền tệ sang EUR
    Open Browser To Automation Test Store
    Change Currency To EUR
    Verify Currency Changed To EUR
    [Teardown]    Close Browser

TC30: Kiểm tra cập nhật giá sản phẩm tương ứng khi thay đổi tiền tệ sang GBP
    Open Browser To Automation Test Store
    Change Currency To GBP
    Verify Currency Changed To GBP
    [Teardown]    Close Browser

TC31: Kiểm tra giỏ hàng hiển thị giá bằng EUR khi tiền tệ được đặt là EUR.
    Open Browser To Automation Test Store
    Change Currency To EUR
    Add Product To Cart And Verify Currency EUR
    [Teardown]    Close Browser

TC32: Kiểm tra giỏ hàng hiển thị giá bằng GBP khi tiền tệ được đặt là GBP.
    Open Browser To Automation Test Store
    Change Currency To GBP
    Add Product To Cart And Verify Currency GBP
    [Teardown]    Close Browser

TC33: Xác minh rằng thay đổi tiền tệ trở lại USD cập nhật giá sản phẩm tương ứng.
    Open Browser To Automation Test Store
    Change Currency To GBP
    Revert Currency To USD And Verify
    [Teardown]    Close Browser

TC34: Kiểm tra đơn vị tiền giỏ hàng khi thay đổi tiền tệ thành EUR
    Open Browser To Automation Test Store
    Change Currency To EUR
    Add Product To Cart And Verify Currency EUR
    Go to Cart and check currency    ${EURO_CURRENCY}

TC35: Kiểm tra đơn vị tiền giỏ hàng khi thay đổi tiền tệ thành GBP
    Open Browser To Automation Test Store
    Change Currency To GBP
    Add Product To Cart And Verify Currency GBP
    Go to Cart and check currency    ${GBP_CURRENCY}
    [Teardown]    Close Browser

TC36: Kiểm tra đơn vị tiền giỏ hàng khi thay đổi tiền tệ thành USD
    Open Browser To Automation Test Store
    Change Currency To GBP
    Add Product To Cart And Verify Currency GBP
    Revert Currency To USD And Verify
    Go to Cart and check currency    ${DEFAULT_CURRENCY}
    [Teardown]    Close Browser

TC37: Kiểm tra nút liên kết Facebook
    [Documentation]    Xác minh rằng liên kết Facebook dẫn đến trang Facebook chính xác.
    [Tags]    SocialMedia1
    Open Browser To Automation Test Store
    Click Social Media Link    class:facebook
    Switch To New Window
    Verify URL    facebook
    [Teardown]    Close Browser

TC38: Kiểm tra nút liên kết Twitter
    [Documentation]    Xác minh rằng liên kết Twitter dẫn đến trang Twitter chính xác.
    [Tags]    SocialMedia2
    Open Browser To Automation Test Store
    Click Social Media Link    class:twitter
    Switch To New Window
    Verify URL    ${TWITTER_URL}
    [Teardown]    Close Browser

TC39: Kiểm tra nút liên kết LinkedIn
    [Documentation]    Xác minh rằng liên kết LinkedIn dẫn đến trang LinkedIn chính xác.
    [Tags]    SocialMedia3
    Open Browser To Automation Test Store
    Click Social Media Link    class:linkedin
    Switch To New Window
    Verify URL    ${Linkedin_URL}
    [Teardown]    Close Browser

TC40: Thêm sản phẩm vào giỏ hàng
    Login With    thanhtruc    123456789
    Click Element    xpath=//a[@class='active menu_home' and @href='https://automationteststore.com/']
    Add Product To Cart    123
    Log    ${CART_ITEMS}
    Go To Cart
    Verify Cart Items
    Close Browser

TC41: Thêm sản phẩm mà không cần chọn kích thước
    Login With    thanhtruc    123456789
    Click Home Link
    Add Product Without Selecting Size    123    # Assuming '123' is the product ID
    Close Browser

TC42: Kiểm tra liên kết View
    [Documentation]    Kiểm tra liên kết "View" chuyển hướng đến trang sản phẩm đúng sau khi trỏ chuột vào hình ảnh.
    Login With    thanhtruc    123456789
    Click Element    //nav[@class='subnav']//a[contains(text(),'Apparel')]
    Mouse Over    ${PRODUCT_IMAGE_SRC}
    Wait Until Element Is Visible    xpath=//a[contains(text(), 'View')]    5s
    Click Element    xpath=//a[contains(text(), 'View')]
    Location Should Contain    product_id=116
    Capture Page Screenshot
    Close Browser

TC43: Kiểm tra liên kết Write Review
    [Documentation]    Kiểm tra liên kết "Write Review" chuyển hướng đến đúng phần đánh giá trên trang sản phẩm sau khi trỏ chuột vào hình ảnh.
    Login With    thanhtruc    123456789
    Click Element    //nav[@class='subnav']//a[contains(text(),'Apparel')]
    Mouse Over    ${PRODUCT_IMAGE_SRC}
    Wait Until Element Is Visible    xpath=//a[contains(text(), 'Write Review')]    5s
    Click Element    xpath=//a[contains(text(), 'Write Review')]
    Location Should Contain    product_id=116
    Capture Page Screenshot
    Close Browser

TC44: Kiểm tra khi để trống size giày có hiện thông báo hay không
    Login With    thanhtruc    123456789
    Click Element    //nav[@class='subnav']//a[contains(text(),'Apparel')]
    Mouse Over    ${PRODUCT_IMAGE_SRC}
    Wait Until Element Is Visible    xpath=//a[contains(text(), 'View')]    5s
    Click Element    xpath=//a[contains(text(), 'View')]
    Click Element    xpath=//a[contains(@class, 'cart')]
    Element Should Contain    xpath=//div[contains(@class, 'alert alert-error alert-danger')]    UK size: Please select all required options!
    Wait Until Element Is Visible    css:.alert-danger    timeout=5s
    Capture Page Screenshot
    Close Browser

*** Keywords ***
#Cho đăng ký và đăng nhập

Open Browser To Login Page
    Open Browser    ${URL_Login}    ${BROWSER}

Fill Registration Form With Valid Data
    #Thông tin cá nhân
    Input Text    name=firstname    thanh
    Input Text    name=lastname    truc
    Input Text    name=email    truc03@gmail.com    #đổi email
    Input Text    name=telephone    123456789
    Input Text    name=fax    123456789
    #Đia chỉ
    Input Text    name=company    TDTU
    Input Text    name=address_1    Quan 7, Ho Chi Minh
    Input Text    name=address_2    Quan 7, Ho Chi Minh city
    Input Text    name=city    Ho Chi Minh
    Select From List By Label    name=country_id    Viet Nam
    Input Text    name=postcode    123456
    #Thông tin đăng nhập
    Input Text    name=loginname    thanhtruccc    #Đổi tên đăng nhâp
    Input Text    name=password    123456789
    Input Text    name=confirm    123456789
    Click Element    xpath=//input[@name='newsletter' and @value='1']
    Click Element    xpath=//*[@id="AccountFrm_agree"]
    Sleep    2s
    Select From List By Label    id=AccountFrm_zone_id    Ho Chi Minh City

Fill Registration Form With Exist Email
    #Thông tin cá nhân
    Input Text    name=firstname    thanh
    Input Text    name=lastname    truc
    Input Text    name=email    truc03@gmail.com    #đổi email
    Input Text    name=telephone    123456789
    Input Text    name=fax    123456789
    #Đia chỉ
    Input Text    name=company    TDTU
    Input Text    name=address_1    Quan 7, Ho Chi Minh
    Input Text    name=address_2    Quan 7, Ho Chi Minh city
    Input Text    name=city    Ho Chi Minh
    Select From List By Label    name=country_id    Viet Nam
    Input Text    name=postcode    123456
    #Thông tin đăng nhập
    Input Text    name=loginname    thanhtruccc
    Input Text    name=password    123456789
    Input Text    name=confirm    123456789
    Click Element    xpath=//input[@name='newsletter' and @value='1']
    Click Element    xpath=//*[@id="AccountFrm_agree"]
    Sleep    2s
    Select From List By Label    id=AccountFrm_zone_id    Ho Chi Minh City

Fill Registration Form With Non-Matching Password

#Thông tin cá nhân
    Input Text    name=firstname    thanh
    Input Text    name=lastname    truc
    Input Text    name=email    truc04@gmail.com    #đổi email
    Input Text    name=telephone    123456789
    Input Text    name=fax    123456789
    #Đia chỉ
    Input Text    name=company    TDTU
    Input Text    name=address_1    Quan 7, Ho Chi Minh
    Input Text    name=address_2    Quan 7, Ho Chi Minh city
    Input Text    name=city    Ho Chi Minh
    Select From List By Label    name=country_id    Viet Nam
    Input Text    name=postcode    123456
    #Thông tin đăng nhập
    Input Text    name=loginname    thanhtruccc    #Đổi tên đăng nhâp
    Input Text    name=password    123456789
    Input Text    name=confirm    1234
    Click Element    xpath=//input[@name='newsletter' and @value='1']
    Click Element    xpath=//*[@id="AccountFrm_agree"]
    Sleep    2s
    Select From List By Label    id=AccountFrm_zone_id    Ho Chi Minh City

Login With
    [Arguments]    ${username}    ${password}
    Open Browser To Login Page
    Wait Until Element Is Visible    id=loginFrm_loginname    timeout=30s
    Input Text    id=loginFrm_loginname    ${username}
    Input Text    id=loginFrm_password    ${password}
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button

Open Browser To Home Page
    Open Browser    ${URL}    ${BROWSER}    headless=True
    Maximize Browser Window
    Wait Until Element Is Visible    css=.info_links_footer

Search For Product
    Input Text    css=#filter_keyword    Skinsheen Bronzer Stick
    Wait Until Element Is Visible    css=.button-in-search
    Scroll Element Into View    css=.button-in-search
    Click Element    css=.button-in-search
    Wait Until Page Contains    Skinsheen Bronzer Stick
    Sleep    5 seconds

Verify Product Details
    Wait Until Element Is Visible    xpath=//h1[@class='productname']
    Element Should Contain    xpath=//h1[@class='productname']    Skinsheen Bronzer Stick
    Capture Page Screenshot

Navigate To Category
    # Navigate to Makeup category
    Wait Until Element Is Visible    //*[@id="categorymenu"]/nav/ul/li[3]/a
    Scroll Element Into View    //*[@id="categorymenu"]/nav/ul/li[3]/a
    Click Element    //*[@id="categorymenu"]/nav/ul/li[3]/a
    Wait Until Page Contains    Makeup
    # Navigate to Cheek subcategory
    Wait Until Element Is Visible    //*[@id="maincontainer"]/div/div/div/div/ul/li[1]
    Scroll Element Into View    //*[@id="maincontainer"]/div/div/div/div/ul/li[1]
    Click Element    //*[@id="maincontainer"]/div/div/div/div/ul/li[1]
    Wait Until Page Contains    Cheek

Select Product From Category
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    xpath=//a[text()="${product_name}"]
    Scroll Element Into View    xpath=//a[text()="${product_name}"]
    Click Element    xpath=//a[text()="${product_name}"]
    Wait Until Page Contains    ${product_name}

Select Featured Product
    Wait Until Page Contains Element    xpath=//a[text()="Skinsheen Bronzer Stick"]
    Click Link    xpath=//a[text()="Skinsheen Bronzer Stick"]

Check Stock Status
    ${status}    Get Text    css:.cart
    Run Keyword If    '${status}' == 'Add to Cart'    Log    Product is in stock
    ...    ELSE    Log    Product is out of stock

# Keyword for search

Verify Search Results
    ${elements}=    Get WebElements    xpath=//*[@id="maincontainer"]//div[contains(@class, 'col-md-3 col-sm-6 col-xs-12')]
    ${number_of_elements}=    Get Length    ${elements}
    Should Be True    ${number_of_elements} > 0    Search results should display at least one product

Search product
    Click Element    xpath=//*[@id='category_id']
    Click Element    xpath=//*[@id="category_id"]/option[4]
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[3]/label
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[1]/fieldset/div[4]/label
    Click Button    xpath=//*[@id="search_button"]

#Keywords Cho thay đổi đơn vị tiền tệ và liên kết mạng xã hội

Open Browser To Automation Test Store
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

Verify Default Currency
    ${default_currency} =    Get Text    class:label.label-orange.font14
    Should Be Equal As Strings    ${default_currency}    ${DEFAULT_CURRENCY}

Change Currency To EUR
    Click Element    class:dropdown-toggle
    Go To    https://automationteststore.com/index.php?rt=index/home&currency=EUR

Change Currency To GBP
    Click Element    class:dropdown-toggle
    Go To    https://automationteststore.com/index.php?rt=index/home&currency=GBP

Verify Currency Changed To EUR
    ${new_currency} =    Get Text    class:label.label-orange.font14
    Should Be Equal As Strings    ${new_currency}    ${EURO_CURRENCY}
    ${product_price} =    Get Text    class:pricenew
    Should Contain    ${product_price}    €

Verify Currency Changed To GBP
    ${new_currency} =    Get Text    class:label.label-orange.font14
    Should Be Equal As Strings    ${new_currency}    ${GBP_CURRENCY}
    ${product_price} =    Get Text    class:pricenew
    Should Contain    ${product_price}    ${GBP_CURRENCY}

Add Product To Cart And Verify Currency EUR
    Click Element    class:productcart
    ${cart_price} =    Get Text    class:cart_total
    Should Contain    ${cart_price}    €

Add Product To Cart And Verify Currency GBP
    Click Element    class:productcart
    ${cart_price} =    Get Text    class:cart_total
    Should Contain    ${cart_price}    ${GBP_CURRENCY}

Revert Currency To USD And Verify
    Go To    https://automationteststore.com/index.php?rt=index/home&currency=USD
    ${reverted_currency} =    Get Text    class:label.label-orange.font14
    Should Be Equal As Strings    ${reverted_currency}    ${DEFAULT_CURRENCY}

Go to Cart and check currency
    [Arguments]    ${Currency}
    Go To    https://automationteststore.com/index.php?rt=checkout/cart
    Sleep    5s
    ${total}=    Get Text    css=.bold.totalamout:not(.extra)
    Should Contain    ${total}    ${Currency}

Click Social Media Link
    [Arguments]    ${selector}
    Click Element    ${selector}

Switch To New Window
    Switch Window    NEW

Verify URL
    [Arguments]    ${expected_url}
    ${current_url} =    Get Location
    Should Contain    ${current_url}    ${expected_url}

#Keyword dành cho mua sản phẩm
