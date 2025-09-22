*** Settings ***
Documentation    casos te teste de  cadastro de usuarios
Library    Browser
Resource    ../resources/base.resource


Test Setup        iniciar sessao
Test Teardown    Take Screenshot      

*** Variables ***
  

*** Test Cases ***

CT01:cadastrar um novo usuario
    [Tags]    cadastro 
#definindo variaveis do teste

    ${user}    Create Dictionary    
    ...    name=tester    
    ...    email=test@mail.com    
    ...    password=senha123

    ir para pagina de cadastro
    submeter o formulario de cadastro    ${user}
    Sleep   1
    conferencia do teste    Serverest Store 
    Sleep   1   
