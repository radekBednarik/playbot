***Settings***
Library    ${EXECDIR}${/}playbot${/}Playbot.py    browser=chromium

Suite Setup       Start Browser   headless=${FALSE}
Suite Teardown    Close Browser

***Variables***
${TRUE}             Convert to boolean=True
${FALSE}            Convert to boolean=False
&{VP_1920_1080}     width=${1920}    height=${1080}   
&{VP_600_800}       width=${600}     height=${800}

***Test Cases***
Start first context, page, goto Tesena, close context
    [Documentation]    get it running
    ${context_one}=           New Context            viewport=&{VP_1920_1080}
    ${context_one_page}=      New Page               ${context_one}
    Go To                     ${context_one_page}    https://www.tesena.com/en
    Wait For Timeout          ${context_one_page}    3000
    Close Context             ${context_one}

Start second context, page, goto Youtube
    [Documentation]    get it running
    ${context_two}=           New Context                viewport=&{VP_600_800}
    ${context_two_page}=      New Page                   ${context_two}
    Go To                     ${context_two_page}        https://www.youtube.com
    Wait For Timeout          ${context_two_page}        3000
    ${context_two_page_two}=  New Page                   ${context_two}
    Go To                     ${context_two_page_two}    https://ihned.cz
    Wait For Timeout          ${context_two_page_two}    3000