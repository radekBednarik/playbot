***Settings***
Library           ${EXECDIR}${/}playbot${/}Playbot.py    browser=chromium
Library           ${EXECDIR}${/}test${/}helpers${/}TestUtils.py

Suite Setup       Start Browser   headless=${FALSE}
Suite Teardown    Close Browser

***Variables***
${TRUE}             Convert to boolean=True
${FALSE}            Convert to boolean=False
&{VP_1920_1080}     width=${1920}    height=${1080}   
&{VP_600_800}       width=${600}     height=${800}

***Test Cases***
Goto Tesena, Query Selector Via Page, Element
    [Documentation]    get it running
    ${context}=               New Context            viewport=&{VP_1920_1080}
    ${page}=                  New Page               ${context}
    Go To                     ${page}                https://www.tesena.com/en
    Wait For Timeout          ${page}                3000
    ${element}=               Query Selector         ${page}    xpath=//button[contains(@class, "btn-confirm")]
    Log                       ${element}
    ${banner}=                Query Selector         ${page}    xpath=//div[@id="panel-cookies"]
    Log                       ${banner}
    ${accept_button}=         Query Selector         ${banner}    xpath=//button[contains(@class, "btn-confirm")]
    Log                       ${accept_button}
    Close Context             ${context}

Go to YouTube, iHned
    [Documentation]    get it running
    ${context}=               New Context            viewport=&{VP_600_800}
    ${page}=                  New Page               ${context}
    Go To                     ${page}                https://www.youtube.com
    ${page_two}=              New Page               ${context}
    Go To                     ${page_two}            https://ihned.cz
    Close Context             ${context}

Wait For Selector via Page, Element
    [Documentation]    get it running
    ${context}=               New Context            viewport=&{VP_1920_1080}
    ${page}=                  New Page               ${context}
    ${locator_banner}=        Convert To String      xpath=//div[@id="panel-cookies"]
    ${locator_bttn}=          Convert To String      xpath=//button[contains(@class, "btn-confirm")]
    Go To                     ${page}                https://www.tesena.com/en
    ${banner}=                Wait For Selector      ${page}      ${locator_banner}
    Log                       ${banner}
    ${accept_button}=         Wait For Selector      ${banner}    ${locator_bttn}
    Log                       ${accept_button}
    Close Context             ${context}

Get cookies
    [Documentation]    get it running
    ${context}=               New Context            viewport=&{VP_1920_1080}
    ${page}=                  New Page               ${context}
    Go To                     ${page}                https://www.tesena.com
    @{all_cookies}=           Cookies                ${context}
    Log                       ${all_cookies}
    @{tesena_cookies}=        Cookies                ${context}    https://www.tesena.com
    Log                       ${tesena_cookies}
    @{urls}=                  Create List             https://www.tesena.com    https://www.youtube.com
    @{array_cookies}=         Cookies                ${context}    ${urls}
    Log                       ${array_cookies}
    Close Context             ${context}

Is Visible
    [Documentation]    get it running
    ${context}=               New Context            viewport=&{VP_1920_1080}
    ${page}=                  New Page               ${context}
    ${locator_banner}=        Convert To String      xpath=//div[@id="panel-cookies"]
    ${locator_bttn}=          Convert To String      xpath=//button[contains(@class, "btn-confirm")]
    Go To                     ${page}                https://www.tesena.com/en
    ${banner}=                Wait For Selector      ${page}     ${locator_banner}
    ${banner_visibility}=     Is Visible             ${banner}
    Should Be True            ${banner_visibility}==True
    ${bttn_visibility}=       Is Visible             ${page}     ${locator_bttn}    timeout=5000
    Should Be True            ${bttn_visibility}==True
    Close Context             ${context}

Wait For Element State
    [Documentation]    get it running
    ${context}=               New Context            viewport=&{VP_1920_1080}
    ${page}=                  New Page               ${context}
    ${locator_bttn}=          Convert To String      xpath=//button[contains(@class, "btn-confirm")]
    Go To                     ${page}                https://www.tesena.com/en
    ${bttn}=                  Wait For Selector      ${page}    ${locator_bttn}    state=attached
    Wait For Element State    ${bttn}                visible
    Close Context             ${context}

Click
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    ${locator_banner}=       Convert To String      xpath=//div[@id="panel-cookies"]
    ${locator_bttn}=         Convert To String       xpath=//button[contains(@class, "btn-confirm")]
    Go To                    ${page}                 https://www.tesena.com/en
    ${bttn}=                 Wait For Selector       ${page}    ${locator_bttn}    state=visible
    Click                    ${bttn}
    ${state}=                Is Visible              ${page}    ${locator_banner}  timeout=5000
    Should Not Be True       ${state}==True
    Close Context            ${context}

Wait For Load State
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en
    Wait For Load State      ${page}                 state=networkidle    timeout=10000
    Close Context            ${context}

Wait For Url
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    ${services_selector}=    Convert To String       //nav[@id="menu-main"]//a[contains(@href, "services")]/span
    Go To                    ${page}                 https://www.tesena.com/en    wait_until=domcontentloaded
    Click                    ${page}                 ${services_selector}
    Wait For Url             ${page}                 **/services    wait_until=networkidle    timeout=${30000}
    Close Context            ${context}

Query Selector All
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    ${menu_sel}=             Convert To String       xpath=//ul[@id="menu-1"]
    ${menu_items_sel}=       Convert To String       xpath=//ul[@id="menu-1"]/li
    ${menu_items_only_sel}=  Convert To String       xpath=//li
    Go To                    ${page}                 https://www.tesena.com/en     wait_until=domcontentloaded
    @{menu_items}=           Query Selector All      ${page}                       ${menu_items_sel}
    Should Not Be Empty      ${menu_items}
    ${menu}=                 Query Selector          ${page}                       ${menu_sel}
    @{menu_items_2}=         Query Selector All      ${menu}                       ${menu_items_only_sel}
    Should Not Be Empty      ${menu_items_2}
    Close Context            ${context}

Close Page
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en    wait_until=domcontentloaded
    Close Page               ${page}
    Close Context            ${context}

Frame
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://ihned.cz/    wait_until=networkidle
    ${frame}=                Frame                   ${page}              name=__tcfapiLocator
    Close Context            ${context}

Content Frame
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/insights     wait_until=networkidle
    @{iframes}=              Query Selector All      ${page}                                xpath=//iframe
    Should Not Be Empty      ${iframes}
    ${frame}=                Content Frame           ${iframes}[0]
    Close Context            ${context}

Check
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/career     wait_until=networkidle
    ${checkbox_sel}=         Convert To String       //input[@type="checkbox" and contains(@aria-label, "consent")]
    # Page and selector
    ${ret}=                  Check                   ${page}                 ${checkbox_sel}
    ${type_check}=           Is Type                 ${ret}                  None
    Should Be True           ${type_check}==True
    # element
    ${checkbox}=             Query Selector          ${page}    ${checkbox_sel}
    ${ret2}=                 Check                   ${checkbox}
    ${type_check2}=          Is Type                 ${ret2}                  None
    Should Be True           ${type_check2}==True
    Close Context            ${context}

Fill
    [Documentation]    get it running
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/career     wait_until=networkidle
    ${first_name_sel}=       Convert To String       xpath=//input[@name="First Name"]
    ${last_name_sel}=        Convert To String       xpath=//input[@name="Last Name"]
    ${test_phrase}=          Convert To String       this is a test
    ${fn_ret}=               Fill                    ${page}                    ${first_name_sel}    value=${test_phrase}
    ${type_check1}=          Is Type                 ${fn_ret}                  None
    Should Be True           ${type_check1}==True
    ${ln_element}=           Query Selector          ${page}                    ${last_name_sel}
    ${ln_ret}=               Fill                    ${ln_element}              value=${test_phrase}
    ${type_check2}=          Is Type                 ${ln_ret}                  None
    Should Be True           ${type_check2}==True
    Close Context            ${context}
