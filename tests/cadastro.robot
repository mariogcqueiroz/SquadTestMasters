*** Settings ***
Documentation    casos te teste de  cadastro de usuarios
Library    Browser
Library    FakerLibrary
Resource    ../resources/base.resource


Test Setup        iniciar sessao
Test Teardown    Take Screenshot      

*** Variables ***
  

*** Test Cases ***

CT01:cadastrar um novo usuario
    [Tags]    cadastro 
#definindo variaveis do teste
    ${email_random}    FakerLibrary.Email
    ${user}    Create Dictionary    
    ...    name=tester    
    ...    email= ${email_random}   
    ...    password=senha123

    ir para pagina de cadastro
    submeter o formulario de cadastro    ${user}
    
    conferencia do teste    Serverest Store 

CT02:cadastrar um novo usuario administrador
    [Tags]    cadastro    admin
#definindo variaveis do teste
    ${email_random}    FakerLibrary.Email
    ${user}    Create Dictionary    
    ...    name=admin_tester    
    ...    email= ${email_random}   
    ...    password=senha123
    ...    administrador=true    
    ir para pagina de cadastro
    submeter o formulario de cadastro como admin    ${user}
    conferencia do teste    Bem Vindo admin_tester  
