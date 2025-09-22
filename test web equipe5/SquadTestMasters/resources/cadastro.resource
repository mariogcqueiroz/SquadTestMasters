*** Settings ***
Documentation    Elementos e ações da pagina singup

Library    Browser
Resource    ../resources/base.resource


*** Keywords ***

ir para pagina de cadastro

#iniciandoa sessão
    
    Go To    ${BASE_URL}/cadastrarusuarios

#checkpoint
     Wait For Elements State    xpath=//h2    visible    5
                                
     Get Text    xpath=//h2    equal    Cadastro  

submeter o formulario de cadastro
    [Arguments]    ${user}


#prennchendo campos
     Fill Text    css=input[name=nome]        ${user}[name]
     Fill Text    css=input[name=email]      ${user}[email]
     Fill Text    css=input[name=password]    ${user}[password]

#cliando no botão
     Click    css=button[type=submit] >> text=Cadastrar


conferencia do teste
    [Arguments]    ${txt_esperado}    
    ${element}    Set Variable    css=.jumbotron h1
#verificação
     Wait For Elements State    ${element}   visible    5                         
     Get Text    ${element}   equal    ${txt_esperado}    
         

