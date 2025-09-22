*** Settings ***

Documentation       Cenários de teste para as funcionalidades de produtos.
Resource            ../resources/base.resource

Suite Setup         Criar e Logar como Administrador Dinâmico
Test Teardown       Take Screenshot


*** Test Cases ***
CT01: Cadastrar produto com sucesso
    [Tags]    happy_path    produtos
    Dado que eu acesso a página de cadastro de produtos
    E tenho os dados de um produto válido
    Quando eu submeto o cadastro

    Então a página de listagem de produtos deve ser exibida

CT02: Acessar a listagem de produtos
    [Tags]    navegacao    produtos
    Quando eu acesso a página de listagem de produtos
    Então a página de listagem de produtos deve ser exibida

*** Keywords ***


# Keywords de alto nível (BDD-style)

Dado que eu acesso a página de cadastro de produtos
    Acessar a página de cadastro de produtos

E tenho os dados de um produto válido

    ${nome_produto}    FakerLibrary.Word
    ${preco}           FakerLibrary.Random Int    min=100    max=5000
    ${descricao}       FakerLibrary.Sentence
    ${quantidade}      FakerLibrary.Random Int    min=1      max=50

    &{produto}=        Create Dictionary
    ...    nome=${nome_produto}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}

    Preencher Formulário de Produto    ${produto}

Quando eu submeto o cadastro
    Submeter Formulário de Produto

Quando eu acesso a página de listagem de produtos
    Página de listagem de produtos deve ser exibida

Então a página de listagem de produtos deve ser exibida
    Página de listagem de produtos deve ser exibida

