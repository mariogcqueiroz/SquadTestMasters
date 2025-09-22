*** Settings ***
Documentation       Cenários de teste para o cadastro de produtos no ServeRest.
Resource            ../resources/base.resource


# O Suite Setup executa o login UMA VEZ antes de todos os testes desta suíte.
Suite Setup         iniciar sessao
...    AND            submeter formulario de login    ${user}
...    AND            Wait For Elements State    css=h1 >> text=Bem Vindo    visible    5s

Test Teardown       Take Screenshot

*** Variables ***
${user}    Create Dictionary    
    ...    name=tester    
    ...    email=teste@mail.com    
    ...    password=senha123
*** Test Cases ***
CT01: Cadastrar produto com sucesso
    [Tags]    happy_path    produtos
    Dado que eu acesso a página de cadastro de produtos
    E tenho os dados de um produto válido
    Quando eu submeto o cadastro
    Então o produto deve ser cadastrado com sucesso

CT02: Tentar cadastrar produto com campos obrigatórios em branco
    [Tags]    sad_path    produtos
    Dado que eu acesso a página de cadastro de produtos
    Quando eu submeto o cadastro sem preencher os campos
    Então devo ver as mensagens de alerta para campos obrigatórios

*** Keywords ***
# Keywords de alto nível (BDD-style) que orquestram a execução
Dado que eu acesso a página de cadastro de produtos
    Acessar a página de cadastro de produtos

E tenho os dados de um produto válido
    ${payload}=    Get Fixture    produtos.json    produto_valido
    Set Test Variable    ${produto}    ${payload}
    Preencher formulário de produto    ${produto}

Quando eu submeto o cadastro
    Submeter formulário de produto

Quando eu submeto o cadastro sem preencher os campos
    Submeter formulário de produto

Então o produto deve ser cadastrado com sucesso
    Página de listagem de produtos deve ser exibida

Então devo ver as mensagens de alerta para campos obrigatórios
    Verificar alertas dos campos obrigatórios