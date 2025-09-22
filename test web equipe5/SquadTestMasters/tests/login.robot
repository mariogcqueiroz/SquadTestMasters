*** Settings ***
Documentation    casos te teste de login de usuarios
Library    Browser
Resource    ../resources/base.resource


Test Setup        iniciar sessao
Test Teardown    Take Screenshot      

*** Variables ***
  

*** Test Cases ***

CT02:fazer login
    [Tags]    login user comum
#definindo variaveis do teste

    ${user}    Create Dictionary      
    ...    email=test@mail.com    
    ...    password=senha123

   submeter formulario de login   ${user}
    Sleep   1
    conferencia do teste    Serverest Store 
    Sleep   1   
