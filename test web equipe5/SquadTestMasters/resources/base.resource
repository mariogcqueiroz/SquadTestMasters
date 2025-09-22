*** Settings ***
Library    Browser
Resource    cadastro.resource
Resource    login.resource

*** Variables ***
${BASE_URL}  https://compassuolfront.serverest.dev


*** Keywords ***
iniciar sessao
    New Browser    browser=chromium    headless=false
    New Page    ${BASE_URL}