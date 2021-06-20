***Settings***
Library    ${EXECDIR}${/}playbot/Playbot.py    browser=chromium

Suite Setup       Start Browser    headless=${FALSE}
Suite Teardown    Close Browser

***Variables***
${TRUE}     Convert to boolean=True
${FALSE}    Convert to boolean=False

***Test Cases***
Start first context, page, goto Tesena
    [Documentation]    get it running
    ${context_one}=           New Context
    ${context_one_page}=      New Page
    Go To                     ${context_one_page}    https://www.tesena.com/en

Start second context, page, goto Youtube
    [Documentation]    get it running
    ${context_two}=           New Context
    ${context_two_page}=      New Page
    Go To                     ${context_two_page}    https://www.youtube.com