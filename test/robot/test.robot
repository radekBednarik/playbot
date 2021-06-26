***Settings***
Library           ${EXECDIR}${/}playbot${/}Playbot.py    browser=chromium

Suite Setup       Start Browser   headless=${FALSE}
Suite Teardown    Close Browser

***Variables***
${TRUE}             Convert to boolean=True
${FALSE}            Convert to boolean=False
&{VP_1920_1080}     width=${1920}    height=${1080}   
&{VP_600_800}       width=${600}     height=${800}

***Test Cases***
Goto Tesena, Query Selector Via Page
    [Documentation]    get it running
    ${context}=               New Context            viewport=&{VP_1920_1080}
    ${page}=                  New Page               ${context}
    Go To                     ${page}                https://www.tesena.com/en
    Wait For Timeout          ${page}                3000
    ${element}=               Query Selector         ${page}    xpath=//button[contains(@class, "btn-confirm")]
    ${test_result}=           Is Visible             ${element}
    Should Be True            ${test_result}==True
    Close Context             ${context}

# Go to YouTube, iHned
#     [Documentation]    get it running
#     ${context}=               New Context            viewport=&{VP_600_800}
#     ${page}=                  New Page               ${context}
#     Go To                     ${page}                https://www.youtube.com
#     ${page_two}=              New Page               ${context}
#     Go To                     ${page_two}            https://ihned.cz
#     Close Context             ${context}

# Go to Tesena, Query selector Via element
#     [Documentation]    get it running
#     ${context}=               New Context            viewport=&{VP_1920_1080}
#     ${page}=                  New Page               ${context}
#     Go To                     ${page}                https://www.tesena.com/en
#     ${banner}=                Query Selector         ${page}      xpath=//div[@id="panel-cookies"]
#     ${accept_bttn}=           Query Selector         ${banner}    xpath=//button[contains(@class, "btn-confirm")]
#     ${test_result}=           Is Visible             ${accept_bttn}
#     Should Be True            ${test_result}==True
#     Close Context             ${context}

# Get cookies
#     [Documentation]    get it running
#     ${context}=               New Context            viewport=&{VP_1920_1080}
#     ${page}=                  New Page               ${context}
#     Go To                     ${page}                https://www.tesena.com
#     @{all_cookies}=           Cookies                ${context}
#     Log                       ${all_cookies}
#     @{tesena_cookies}=        Cookies                ${context}    https://www.tesena.com
#     Log                       ${tesena_cookies}
#     @{urls}=                  Create List             https://www.tesena.com    https://www.youtube.com
#     @{array_cookies}=         Cookies                ${context}    ${urls}
#     Log                       ${array_cookies}
#     Close Context             ${context}