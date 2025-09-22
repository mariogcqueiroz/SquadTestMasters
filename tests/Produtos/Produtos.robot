*** Settings ***
Documentation       Cenários de teste Web para o cadastro de produtos.
Resource            ../../resources/base.resource

# A keyword 'Do Login' virá do seu colega e será executada antes de todos os testes
Suite Setup         Do Login    fulano@qa.com    teste
Test Teardown       Take Screenshot

*** Test Cases ***
Cenário 1: Cadastrar produto com sucesso
    [Tags]    happy_path
    Dado que eu acesso a página de cadastro de produtos
    E tenho os dados de um novo produto
    Quando eu submeto o cadastro
    Então o produto deve ser cadastrado com sucesso

Cenário 2: Tentar cadastrar produto com campos obrigatórios em branco
    [Tags]    sad_path
    Dado que eu acesso a página de cadastro de produtos
    Quando eu submeto o cadastro sem preencher os campos
    Então devo ver as mensagens de alerta para campos obrigatórios

*** Keywords ***
# Keywords de alto nível que orquestram a execução
Dado que eu acesso a página de cadastro de produtos
    Click    css=a[href="/admin/cadastrarprodutos"]
    Wait For Elements State
    ...    css=h1 >> text=Cadastro de Produtos
    ...    visible
    ...    5s

E tenho os dados de um novo produto
    ${payload}=    Get Fixture    produtos.json    produto_valido
    Set Test Variable    ${produto}    ${payload}
    Preencher formulário de produto    ${produto}

Quando eu submeto o cadastro
    Submeter formulário de produto

Quando eu submeto o cadastro sem preencher os campos
    Submeter formulário de produto

Então o produto deve ser cadastrado com sucesso
    Verificar mensagem de sucesso    Cadastro realizado com sucesso

Então devo ver as mensagens de alerta para campos obrigatórios
    Verificar alertas dos campos obrigatórios