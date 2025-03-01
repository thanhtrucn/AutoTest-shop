*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections

*** Variables ***
${URL}            https://automationteststore.com/
${BROWSER}        chrome

*** Test Cases ***
TC1: Kiểm tra số lượng sản phẩm được cập nhật trên huy hiệu giỏ hàng khi thêm một sản phẩm vào giỏ hàng hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    ${cart_before}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_before}=    Get Text    ${cart_before}
    ${list_length}=    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    ${cart_after}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_after}=    Get Text    ${cart_after}
    ${cart}=    Evaluate    ${cart_before} + 1
    Should Be Equal    '${cart}'    '${cart_after}'
    ${length_list_cart}=    Execute JavaScript    return document.querySelectorAll("#top_cart_product_list > div > table > tbody > tr").length;
    Should Be Equal    '${length_list_cart}'    '1'
    [Teardown]    Close Browser

TC2: Kiểm tra số lượng sản phẩm được cập nhật trên huy hiệu giỏ hàng khi thêm nhiều sản phẩm vào giỏ hàng
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    ${cart_before}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_before}=    Get Text    ${cart_before}
    Add Items To Cart    ${cart_before}    3
    [Teardown]    Close Browser

TC3: Kiểm tra nút xóa của mỗi sản phẩm có tồn tại khi thêm mặt hàng vào giỏ hàng hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    ${cart_before}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_before}=    Get Text    ${cart_before}
    Check Button Remove Display To Cart    ${cart_before}    3
    [Teardown]    Close Browser

TC4: Kiểm tra nút xóa của mỗi sản phẩm có hoạt động khi thêm mặt hàng vào giỏ hàng hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    ${cart_before}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_before}=    Get Text    ${cart_before}
    Check Button Remove To Cart    ${cart_before}    2
    [Teardown]    Close Browser

TC5:  Kiểm tra thông tin của mỗi sản phẩm có hiển thị chính xác khi thêm mặt hàng vào giỏ hàng hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    ${cart_before}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_before}=    Get Text    ${cart_before}
    Check Information Of Items When Add Items To Cart    ${cart_before}    1
    [Teardown]    Close Browser

TC6: Kiểm tra xem người dùng có thể tiếp tục mua hàng từ giỏ hàng chứa sản phẩm hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Thêm sản phẩm
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart"]/div/div[3]/div/a[1]
    Click Element    xpath=//*[@id="cart"]/div/div[3]/div/a[1]
    Wait Until Element Is Visible    class=container-fixed
    Location Should Be    https://automationteststore.com/
    [Teardown]    Close Browser

TC7: Kiểm tra xem người dùng có thể tiếp tục mua hàng từ giỏ hàng rỗng hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="maincontainer"]/div/div/div/div/div/div/a
    Click Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div/div/a
    Wait Until Element Is Visible    class=container-fixed
    Location Should Be    https://automationteststore.com/
    [Teardown]    Close Browser

TC8:  Kiểm tra xem người dùng có thể cập nhật số lượng sản phẩm từ giỏ hàng hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Thêm sản phẩm
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart_update"]
    # update số lượng
    Input Text    //*[@id="cart_quantity50"]    2
    Click Element    xpath=//*[@id="cart_update"]
    ${number_now}=    Execute JavaScript    return document.querySelector("#cart_quantity50").value
    Should Be Equal    '2'    '${number_now}'
    [Teardown]    Close Browser

TC9: Kiểm tra giá tổng các sản phẩm sau khi cập nhật số lượng
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Thêm sản phẩm
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart_update"]
    # update số lượng
    Input Text    //*[@id="cart_quantity50"]    3
    # click update
    Click Element    xpath=//*[@id="cart_update"]
    # kiểm tra
    ${price}=    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr > td:nth-child(6)")[0]
    ${price}=    Get Text    ${price}
    Should Be Equal    '$88.50'    '${price}'
    [Teardown]    Close Browser

TC10: Xem chi tiết sản phẩm từ giỏ hàng và kiểm tra điều hướng trang đúng sản phẩm hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Thêm sản phẩm
    ${title_0}=    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.fixed_wrapper > div > a")[0].getAttribute('title')
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart_update"]
    # click link sản phẩm
    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr > td:nth-child(2) > a")[0].click();
    # kiểm tra
    ${title}=    Execute JavaScript    return document.querySelector("#product_details > div > div:nth-child(2) > div > div > h1 > span")
    ${title}=    Get Text    ${title}
    Should Be Equal    '${title_0}'    '${title}'
    Wait Until Element Is Visible    class=productpagecart
    [Teardown]    Close Browser

TC11: Kiểm tra thêm sản phẩm vào giỏ hàng từ trang chi tiết của sản phẩm đó
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Thêm sản phẩm
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # chuyển hướng trang
    Location Should Be    https://automationteststore.com/index.php?rt=product/product&product_id=50
    # click thêm giỏ hàng
    Click Element    //*[@id="product"]/fieldset/div[4]/ul/li/a
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/cart
    ${length}=    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr").length;
    ${length}=    Evaluate    ${length} - 1
    Should Be Equal    '${length}'    '1'
    [Teardown]    Close Browser

TC12: Kiểm tra xem người dùng thanh toán từ giỏ hàng khi chưa đăng nhập với button checkout1 hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Thêm sản phẩm
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart_update"]
    # click checkout
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=account/login

TC13: Kiểm tra xem người dùng thanh toán từ giỏ hàng khi chưa đăng nhập với button checkout2 hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Thêm sản phẩm
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart_update"]
    # click checkout
    Click Element    id=cart_checkout2
    Location Should Be    https://automationteststore.com/index.php?rt=account/login

TC14: Kiểm tra xem người dùng thanh toán từ giỏ hàng khi đã đăng nhập với button checkout1 hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Đăng nhập
    Click Element    //*[@id="customer_menu_top"]/li/a
    Type In Username    mn1234
    Type In Password    mn1234
    Click Element    //*[@id="loginFrm"]/fieldset/button
    # Thêm sản phẩm
    Click Element    //*[@id="categorymenu"]/nav/ul/li[1]/a
    Wait Until Element Is Visible    class=container-fixed
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart_update"]
    # click checkout
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm

TC15:  Kiểm tra xem người dùng thanh toán từ giỏ hàng khi đã đăng nhập với button checkout2 hay không
    Open Browser To Login Page
    Maximize Browser Window
    Wait Until Element Is Visible    class=container-fixed
    # Đăng nhập
    Click Element    //*[@id="customer_menu_top"]/li/a
    Type In Username    mn1234
    Type In Password    mn1234
    Click Element    //*[@id="loginFrm"]/fieldset/button
    # Thêm sản phẩm
    Click Element    //*[@id="categorymenu"]/nav/ul/li[1]/a
    Wait Until Element Is Visible    class=container-fixed
    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[0].click();
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    xpath=//*[@id="cart_update"]
    # click checkout
    Click Element    id=cart_checkout2
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm

#TC dành cho thanh toán

TC16 Thanh toán khi chưa đăng nhập
    Open Browser To Login Page
    # Add product to cart
    Wait Until Element Is Visible    class=productcart    timeout=10s
    Click Element    class=productcart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC17: Hoàn thành toàn bộ thủ tục thanh toán khi đi trực tiếp đến trang checkout để thanh toán
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    Go to Checkout
    Close Browser

TC18: Hoàn thành  thanh toán với nút cart_checkout2
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    #Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    Checkout with inf
    Click Element    id=cart_checkout2
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC19:  Hoàn thành toàn bộ thủ tục thanh toán khi đi trực tiếp đến trang checkout để thanh toán
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Checkout
    Go to    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC20: Hoàn thành hoàn toàn quá trình thanh toán bằng cách nhấn vào 1 loại sản phẩm bất kỳ
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    #Go any product type
    Go to    https://automationteststore.com/index.php?rt=product/category&path=68
    # Add product to cart
    Wait Until Element Is Visible    class=productcart    timeout=10s
    Click Element    class=productcart
    Click Element    id=option344747
    Select From List by Label    id=option345    red
    Input Text    id=product_quantity    1
    Click Element    class=cart
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/cart
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC21: Thanh toán và áp dụng coupon
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    Checkout with inf
    #Apply coupon
    Input Text    id=coupon_coupon    123
    Click button    id=apply_coupon_btn
    #Checkout
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC22: Cập nhật số lượng sp và thanh toán
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    #Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    #Update quantity
    Input Text    id=cart_quantity50    3
    Click button    id=cart_update
    #Checkout
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC23: Thêm sản phẩm, update và thanh toán
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    Wait Until Element Is Visible    class=productcart    timeout=10s
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    Click Element    xpath=//*[@id="cart"]/div/div[1]/table/tbody/tr[2]/td[7]/a
    #Country, state, postalCode
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC24: Không thay đổi thông tin và ấn nút Continue
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    #Country, state, postalCode
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    #Change information
    Click Element    xpath=//*[@id="maincontainer"]/div/div[1]/div/div[2]/table[1]/tbody/tr/td[4]/a
    Click button    xpath=//*[@id="shipping"]/div[3]/div[2]/div/button
    Close Browser

TC25 Completed checkout and change info in checkout confirmation, Click Change Address and change info
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    #Country, state, postalCode
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Change information
    Wait Until Element Is Visible    id=Address2Frm_zone_id    timeout=10s
    Select From List by Label    id=Address2Frm_zone_id    Ho Chi Minh City
    Input Text    id=Address2Frm_postcode    200
    Click element    xpath=//*[@id="Address2Frm"]/div/fieldset/div[10]/div/button
    Click Element    id=checkout_btn
    Close Browser

TC26: Completed checkout and change info in checkout confirmation, but don't change, click Back
    [Documentation]    Thanh toán --> vô trang thay đổi(click Edit Coupon) --> Không thay đổi thông tin --> Không click Return Policy --> Continue
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    #Country, state, postalCode
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    #Change information
    Click Element    xpath=//*[@id="maincontainer"]/div/div[1]/div/div[2]/table[2]/tbody/tr/td[4]/a[2]
    Click Element    xpath=//*[@id="payment"]/div[2]/div[2]/div/button
    Click Element    id=checkout_btn
    Close Browser

TC27: Hoàn thành thanh toán và chọn trang Edit Cart
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    #Country, state, postalCode
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    #Change information
    Click Element    xpath=//*[@id="maincontainer"]/div/div[1]/div/div[2]/h4[3]/a
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn
    Close Browser

TC28: Chọn thay đổi thông tin -> không thay đổi -> continue 2
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    #Country, state, postalCode
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    #Change information
    Click Element    xpath=//*[@id="maincontainer"]/div/div[1]/div/div[2]/table[1]/tbody/tr/td[4]/a    #Click Edit Shipping
    Click Element    xpath=//*[@id="shipping"]/div[1]/table/tbody/tr/td[2]/div/div/a    #Click Change Address
    Click element    xpath=//*[@id="Address2Frm"]/div/fieldset/div[10]/div/button
    Close Browser

TC29: Thay đổi thông tin nhưng điền thiếu thông tin
    Open Browser To Login Page
    Click Element    xpath=//*[@id="customer_menu_top"]/li/a
    # Login
    Input Username and Password
    Click Button    xpath=//*[@id="loginFrm"]/fieldset/button
    Go to Home Page
    Add product to cart
    # Go to Cart
    Go to    https://automationteststore.com/index.php?rt=checkout/cart
    #Country, state, postalCode
    Checkout with inf
    Click Element    id=cart_checkout1
    Location Should Be    https://automationteststore.com/index.php?rt=checkout/confirm
    #Change information
    Change information without first name
    Wait Until Element Is Visible    id=Address2Frm_zone_id    timeout=10s
    Select From List by Label    id=Address2Frm_zone_id    Ho Chi Minh City
    Input Text    id=Address2Frm_postcode    200
    Click element    xpath=//*[@id="Address2Frm"]/div/fieldset/div[10]/div/button
    Click Element    id=checkout_btn
    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}

Login With
    [Arguments]    ${username}    ${password}
    Open Browser To Login Page
    Input Text    id=loginFrm_loginname    ${username}
    Input Text    id=loginFrm_password    ${password}
    Click Button    id=login-button

Add Items To Cart
    [Arguments]    ${cart_before}    ${count_item}
    FOR    ${index}    IN RANGE    ${count_item}
            ${list_length}=    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[${index}].click();
    END
    ${cart_after}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_after}=    Get Text    ${cart_after}
    ${cart}=    Evaluate    ${cart_before} + ${count_item}
    Should Be Equal    '${cart}'    '${cart_after}'
    ${length_list_cart}=    Execute JavaScript    return document.querySelectorAll("#top_cart_product_list > div > table > tbody > tr").length;
    Should Be Equal    '${cart}'    '${length_list_cart}'
    [Teardown]    Close Browser

Check Button Remove Display To Cart
    [Arguments]    ${cart_before}    ${count_item}
    FOR    ${index}    IN RANGE    ${count_item}
            ${list_length}=    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[${index}].click();
    END
    ${cart_after}=    Execute JavaScript    return document.querySelector("body > div > header > div.container-fluid > div > div.block_7 > ul > li > a > span.label.label-orange.font14")
    ${cart_after}=    Get Text    ${cart_after}
    ${cart}=    Evaluate    ${cart_before} + ${count_item}
    Should Be Equal    '${cart}'    '${cart_after}'
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    id=cart_checkout1
    Sleep    2s
    ${length_remove_btn}=    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr > td:nth-child(7)").length;
    Should Be Equal    '${count_item}'    '${length_remove_btn}'
    [Teardown]    Close Browser

Check Button Remove To Cart
    [Arguments]    ${cart_before}    ${count_item}
    FOR    ${index}    IN RANGE    ${count_item}
            ${list_length}=    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[${index}].click();
    END
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    id=cart_checkout1
    # đếm sô lượng tổng button remove
    ${length_remove_btn_before}=    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr > td:nth-child(7)").length;
    # click button remove
    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr > td:nth-child(7) > a > i")[0].click();
    ${length_remove_btn_web}=    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr > td:nth-child(7)").length;
    ${length_remove_btn_test}=    Evaluate    ${length_remove_btn_before} - 1
    Should Be Equal    '${length_remove_btn_web}'    '${length_remove_btn_test}'
    [Teardown]    Close Browser

Check Information Of Items When Add Items To Cart
    [Arguments]    ${cart_before}    ${count_item}
    FOR    ${index}    IN RANGE    ${count_item}
            ${list_length}=    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.thumbnail > div.pricetag.jumbotron > a")[${index}].click();
            ${title_0}=    Execute JavaScript    return document.querySelectorAll("#block_frame_featured_1769 > div > div > div.fixed_wrapper > div > a")[${index}].getAttribute('title')
    END
    # click giỏ hàng
    Click Element    xpath=/html/body/div/header/div[2]/div/div[3]/ul/li
    Scroll Element Into View    id=cart_checkout1
    # \ kiêm tra danh sách tên mặt hàng trong giỏ hàng
    ${title}=    Execute JavaScript    return document.querySelectorAll("#cart > div > div.container-fluid.cart-info.product-list > table > tbody > tr > td:nth-child(2) > a")[0]
    ${title}=    Get Text    ${title}
    Should Be Equal    '${title_0}'    '${title}'
    [Teardown]    Close Browser

Input Username and Password
    Input Text    id=loginFrm_loginname    thanhtruc
    Input Text    id=loginFrm_password    123456789

Go to Home Page
    Wait Until Element Is Visible    xpath=//*[@id="categorymenu"]/nav/ul/li[1]/a    timeout=10s
    Click Element    xpath=//*[@id="categorymenu"]/nav/ul/li[1]/a

Add product to cart
    Wait Until Element Is Visible    class=productcart    timeout=10s
    Click Element    class=productcart

Go to Checkout
    Go to    https://automationteststore.com/index.php?rt=checkout/confirm
    Click Element    id=checkout_btn

Checkout with inf
    Select From List by Label    id=estimate_country    Viet Nam
    Select From List by Label    id=estimate_country_zones    Ho Chi Minh City
    Input Text    id=estimate_postcode    1234

Change information
    Click Element    xpath=//*[@id="maincontainer"]/div/div[1]/div/div[2]/table[1]/tbody/tr/td[4]/a    #Click Edit Shipping
    Click Element    xpath=//*[@id="shipping"]/div[1]/table/tbody/tr/td[2]/div/div/a    #Click Change Address
    Select From List by Label    id=Address2Frm_country_id    Viet Nam
    Input Text    id=Address2Frm_firstname    Thanh
    Input Text    id=Address2Frm_lastname    Truc
    Input Text    id=Address2Frm_company    TDT
    Input Text    id=Address2Frm_address_1    Quan7
    Input Text    id=Address2Frm_address_2    Binh Thanh
    Input Text    id=Address2Frm_city    TPHCM

Change information without first name
    Click Element    xpath=//*[@id="maincontainer"]/div/div[1]/div/div[2]/table[1]/tbody/tr/td[4]/a    #Click Edit Shipping
    Click Element    xpath=//*[@id="shipping"]/div[1]/table/tbody/tr/td[2]/div/div/a    #Click Change Address
    Select From List by Label    id=Address2Frm_country_id    Viet Nam
    Input Text    id=Address2Frm_lastname    Truc
    Input Text    id=Address2Frm_company    TDT
    Input Text    id=Address2Frm_address_1    Quan7
    Input Text    id=Address2Frm_address_2    Binh Thanh
    Input Text    id=Address2Frm_city    TPHCM
