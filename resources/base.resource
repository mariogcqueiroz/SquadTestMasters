*** Settings ***
Documentation       Arquivo base que importa todos os recursos do projeto
Library             Browser
Library             JSONLibrary
Resource            env.resource
Resource            pages/ProdutosCreatePage.resource

*** Keywords ***
Start Session
    New Browser     browser=${BROWSER}    headless=False
    New Page        ${BASE_URL}

Get Fixture
    [Arguments]    ${file_name}    ${scenario}
    ${data}=       Load Json From File
    ...            ${EXECDIR}/resources/fixtures/${file_name}.json
    ...            encoding=utf-8
    [RETURN]       ${data}[${scenario}]