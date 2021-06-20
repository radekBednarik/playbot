***Settings***
Library    ${EXECDIR}${/}playbot/Playbot.py    browser=chromium

***Variables***
${TRUE}     Convert to boolean=True
${FALSE}    Convert to boolean=False

***Test Cases***
Start browser, context and page and close
    [Documentation]    get it running
    Start Browser    headless=${FALSE}
    New Context
    New Page
    Go To    https://www.tesena.com/en
    Close