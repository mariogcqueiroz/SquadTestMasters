*** Settings ***

Library    Browser

*** Keywords ***

submeter formulario de login
    [Arguments]    ${user}
    Fill Text    css=input[placeholder="Digite seu email"]    ${user}[email] 
                
    Fill Text    css=input[placeholder="Digite sua senha"]    ${user}[password] 

    Click    css=button >> text=Entrar
           
