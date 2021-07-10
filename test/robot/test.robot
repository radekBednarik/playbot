***Settings***
Library           ${EXECDIR}${/}playwbot${/}Playwbot.py    browser=chromium
Library           ${EXECDIR}${/}test${/}helpers${/}TestUtils.py
Library           OperatingSystem
Library           String

Suite Setup       Start Browser   headless=${FALSE}
Suite Teardown    Close Browser

***Variables***
${TESTS_RESULT_DIR}=    ${EXECDIR}${/}test
${TRUE}                 Convert to boolean=True
${FALSE}                Convert to boolean=False
&{VP_1920_1080}         width=${1920}    height=${1080}   
&{VP_600_800}           width=${600}     height=${800}

***Test Cases***
Query Selector
    [Documentation]    get it running
    [Tags]             query_selector
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

Multiple Pages
    [Documentation]    get it running
    [Tags]             multiple_pages
    ${context}=               New Context            viewport=&{VP_600_800}
    ${page}=                  New Page               ${context}
    Go To                     ${page}                https://www.youtube.com
    ${page_two}=              New Page               ${context}
    Go To                     ${page_two}            https://ihned.cz
    Close Context             ${context}

Wait For Selector
    [Documentation]    get it running
    [Tags]             wait_for_selector
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
    [Tags]             get_cookies
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

Is Hidden
    [Documentation]    get it running
    [Tags]             is_hidden
    ${context}=               New Context                viewport=&{VP_1920_1080}
    ${page}=                  New Page                   ${context}
    Go To                     ${page}                    https://www.tesena.com/en
    ${element}=               Query Selector             ${page}    //button[contains(@class, "btn-confirm")]
    ${banner}=                Query Selector             ${page}    //div[@id="panel-cookies"]
    Click                     ${element}
    Wait For Element State    ${banner}                  hidden
    ${is_hidden_via_el}=      Is Hidden                  ${banner}
    Should Be True            ${is_hidden_via_el}==True
    ${is_hidden_via_page}=    Is Hidden                  ${page}    //div[@id="panel-cookies"]
    Should Be True            ${is_hidden_via_page}==True
    Close Context             ${context}

Is Visible
    [Documentation]    get it running
    [Tags]             is_visible
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
    [Tags]             wait_for_element_state
    ${context}=               New Context            viewport=&{VP_1920_1080}
    ${page}=                  New Page               ${context}
    ${locator_bttn}=          Convert To String      xpath=//button[contains(@class, "btn-confirm")]
    Go To                     ${page}                https://www.tesena.com/en
    ${bttn}=                  Wait For Selector      ${page}    ${locator_bttn}    state=attached
    Wait For Element State    ${bttn}                visible
    Close Context             ${context}

Click
    [Documentation]    get it running
    [Tags]             click
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    ${locator_banner}=       Convert To String       xpath=//div[@id="panel-cookies"]
    ${locator_bttn}=         Convert To String       xpath=//button[contains(@class, "btn-confirm")]
    Go To                    ${page}                 https://www.tesena.com/en
    ${bttn}=                 Wait For Selector       ${page}    ${locator_bttn}    state=visible
    Click                    ${bttn}
    ${state}=                Is Visible              ${page}    ${locator_banner}  timeout=5000
    Should Not Be True       ${state}==True
    Close Context            ${context}

Wait For Load State
    [Documentation]    get it running
    [Tags]             wait_for_load_state
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en
    Wait For Load State      ${page}                 state=networkidle    timeout=10000
    Close Context            ${context}

Wait For Url
    [Documentation]    get it running
    [Tags]             wait_for_url
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    ${services_selector}=    Convert To String       //nav[@id="menu-main"]//a[contains(@href, "services")]/span
    Go To                    ${page}                 https://www.tesena.com/en    wait_until=domcontentloaded
    Click                    ${page}                 ${services_selector}
    Wait For Url             ${page}                 **/services    wait_until=networkidle    timeout=${30000}
    Close Context            ${context}

Query Selector All
    [Documentation]    get it running
    [Tags]             query_selector_all
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
    [Tags]             close_page
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en    wait_until=domcontentloaded
    Close Page               ${page}
    Close Context            ${context}

Frame
    [Documentation]    get it running
    [Tags]             frame
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://ihned.cz/    wait_until=networkidle
    ${frame}=                Frame                   ${page}              name=__tcfapiLocator
    Close Context            ${context}

Content Frame
    [Documentation]    get it running
    [Tags]             content_frame
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/insights     wait_until=networkidle
    @{iframes}=              Query Selector All      ${page}                                xpath=//iframe
    Should Not Be Empty      ${iframes}
    ${frame}=                Content Frame           ${iframes}[0]
    Close Context            ${context}

Check
    [Documentation]    get it running
    [Tags]             check
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
    [Tags]             fill
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

Screenshot
    [Documentation]    get it running
    [Tags]             screenshot
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/     wait_until=networkidle
    ${filepath_1}=           Convert To String       ${TESTS_RESULT_DIR}${/}screenshot_1.png
    ${filepath_2}=           Convert To String       ${TESTS_RESULT_DIR}${/}screenshot_2.png
    # page screenshot test
    Screenshot               ${page}                 path=${filepath_1}
    File Should Exist        ${filepath_1}
    # elem screenshot test
    ${elem_loc}=             Convert To String       xpath=//button[contains(@class, "btn-confirm")]
    ${element}=              Query Selector          ${page}                    ${elem_loc}
    Screenshot               ${element}              path=${filepath_2}
    File Should Exist        ${filepath_2}
    # Cleanup
    Remove File              ${filepath_1}
    Remove File              ${filepath_2}
    Close Context            ${context}

Reload
    [Documentation]    get it running
    [Tags]             reload
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/     wait_until=networkidle
    Reload                   ${page}                 wait_until=networkidle         timeout=${10000}
    Close Context            ${context}

Bring To Front
    [Documentation]    get it running
    [Tags]             bring_to_front
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/             wait_until=networkidle
    ${page2}=                New Page                ${context}
    Go To                    ${page2}                https://www.tesena.com/en/insights     wait_until=networkidle
    ${ret}=                  Bring To Front          ${page}
    ${type_check}=           Is Type                 ${ret}                  None
    Should Be True           ${type_check}==True
    Close Context            ${context}

Title
    [Documentation]    get it running
    [Tags]             title
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/insights     wait_until=networkidle
    ${page_title}=           Title                   ${page}
    Should Be String         ${page_title}
    ${iframe_element}=       Query Selector          ${page}                                //iframe
    ${frame}=                Content Frame           ${iframe_element}
    ${frame_title}=          Title                   ${frame}
    Should Be String         ${frame_title}
    Close Context            ${context}

Evaluate
    [Documentation]    get it running
    [Tags]             evaluate
    ${context}=              New Context             viewport=&{VP_1920_1080}
    ${page}=                 New Page                ${context}
    Go To                    ${page}                 https://www.tesena.com/en/insights     wait_until=networkidle
    ${page_title}=           Playwbot.Evaluate                ${page}                                document.title
    Should Be String         ${page_title}
    ${iframe_element}=       Query Selector          ${page}                                //iframe
    ${frame}=                Content Frame           ${iframe_element}
    ${frame_title}=          Playwbot.Evaluate                ${frame}                               document.title
    Should Be String         ${frame_title}
    Close Context            ${context}

Expect Request
    [Documentation]    get it running
    [Tags]             expect_request
    ${context}=              New Context                           viewport=&{VP_1920_1080}
    ${page}=                 New Page                              ${context}
    ${request_url}=          Convert To String                     https://www.tesena.com/files/logo-tesena.svg
    @{args}=                 Create List                           https://www.tesena.com/en
    &{kwargs}=               Create Dictionary                     wait_until=networkidle    timeout=${10000}
    @{action_args}=          Create List                           ${args}                   ${kwargs}
    ${request}=              Expect Request          ${page}       ${request_url}
    ...                                              go to         action_args=${action_args}
    ${check}=                Is Type                 ${request}    request
    Should Be True           ${check}==True
    Close Context            ${context}

Expect Event
    [Documentation]    get it running
    [Tags]             expect_event
    ${context}=              New Context                           viewport=&{VP_1920_1080}
    ${page}=                 New Page                              ${context}
    @{args}=                 Create List                           https://www.tesena.com/en
    &{kwargs}=               Create Dictionary                     wait_until=networkidle    timeout=${10000}
    @{action_args}=          Create List                           ${args}                   ${kwargs}
    ${request}=              Expect Event            ${page}       request
    ...                                              go to         action_args=${action_args}
    ...                                              timeout=${5000}
    ${check}=                Is Type                 ${request}    request
    Should Be True           ${check}==True
    Close Context            ${context}
