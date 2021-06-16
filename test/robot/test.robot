***Settings***
Library    ${EXECDIR}${/}playbot/Playbot.py    browser=firefox

***Test Cases***
Start browser, context and page and close
    [Documentation]    get it running
    New Context
    New Page
    Close