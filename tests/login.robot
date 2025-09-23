*** Settings ***
Documentation    casos te teste de login de usuarios
Library    Browser
Library    FakerLibrary
Resource    ../resources/base.resource


Test Setup        iniciar sessao
Test Teardown    Take Screenshot      

*** Variables ***
  

*** Test Cases ***

CT02:fazer login
    [Tags]    login user comum
#cadastrando usuario
     ${email_random}     FakerLibrary.Email
    ${user}    Create Dictionary    
    ...    name=tester    
    ...    email= ${email_random}   
    ...    password=senha123

    ir para pagina de cadastro
    submeter o formulario de cadastro    ${user}
    
    conferencia do teste    Serverest Store 
      
    Go To    ${BASE_URL}
    ${user}    Create Dictionary      
    ...    email= ${email_random}      
    ...    password=senha123

   submeter formulario de login   ${user}
    
    conferencia do teste    Serverest Store 
       
