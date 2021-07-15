***Settings***
Library           ${EXECDIR}${/}playwbot${/}Playwbot.py    browser=chromium                                               
Library           ${EXECDIR}${/}test${/}helpers${/}TestUtils.py
Library           OperatingSystem

Suite Setup       Start Browser    headless=${False}    persistent=${True}
...                                user_data_dir=${EXECDIR}${/}persistentData    viewport=&{VP_1920_1080}
Suite Teardown    Teardown with deletion  ${EXECDIR}${/}persistentData

***Variables***
&{VP_1920_1080}        width=${1920}    height=${1080}

***Test Cases***
Persistent Context
    [Documentation]    get it running
    [Tags]             persistent_context
    ${context}=        New Context
    ${page}=           New Page                        ${context}                     
    ${check}=          Is Type                         ${context}     playwbotContext
    Should Be True     ${check}==True

***Keywords***
Teardown with deletion
    [Documentation]    Closes browser with persistent context and then
    ...                deletes the folder
    [Arguments]        ${dir_to_remove}

    Close Browser
    Sleep              1
    Remove Directory    ${dir_to_remove}    recursive=${True}
