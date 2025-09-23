*** Settings ***
Documentation        Validação de campos obrigatórios de cadastro de usuários e de produtos e o login

Resource            ../resources/base.resource
Resource            ../resources/cadastro.resource
Resource            ../resources/produtos.resource
Resource            ../resources/login.resource
Resource            ../resources/campos.resource

Test Setup          iniciar sessao
Test Teardown       Take Screenshot 

*** Test Cases ***
CT01:Não permitir campos vazios no cadastro de usuário
    [Tags]          cadastro_vazio

    ${user}         Create Dictionary
    ...             name=${EMPTY}
    ...             email=${EMPTY}
    ...             password=${EMPTY}
    ...             administrador=${EMPTY}

    ir para pagina de cadastro

    submeter o formulario de cadastro    ${user}

    Alert should be                      Nome é obrigatório
    Alert should be                      Email é obrigatório
    Alert should be                      Password é obrigatório

CT02:Não permitir campos vazios no cadastro de produto
    [Tags]          produto_vazio

    ${produto}      Create Dictionary
    ...             nome=${EMPTY}
    ...             preco=${EMPTY}
    ...             descricao=${EMPTY}
    ...             quantidade=${EMPTY}

    Criar e Logar como Administrador Dinâmico

    Acessar a página de cadastro de produtos

    Preencher formulário de produto    ${produto}

    Click           xpath=//button[text()="Cadastrar"]

    Alert should be                      Nome é obrigatório
    Alert should be                      Preco é obrigatório
    Alert should be                      Descricao é obrigatório
    Alert should be                      Quantidade é obrigatório

CT03:Não permitir campos vazios no login
    [Tags]          login_vazio

    ${login}        Create Dictionary
    ...             email=${EMPTY}
    ...             password=${EMPTY}

    submeter formulario de login    ${login}

    Alert should be                      Email é obrigatório
    Alert should be                      Password é obrigatório
