***Settings***
Library    ${EXECDIR}${/}playbot/Playbot.py    browser=chromium

Suite Setup    Start Browser    headless=${FALSE}
Suite Teardown    Close Browser

***Variables***
${TRUE}     Convert to boolean=True
${FALSE}    Convert to boolean=False

***Test Cases***
Start first context, page, goto Tesena
    [Documentation]    get it running
    New Context
    New Page
    Go To    https://www.tesena.com/en

Start second context, page, goto Youtube
    [Documentation]    get it running
    New Context
    New Page
    Go To    https://www.youtube.com