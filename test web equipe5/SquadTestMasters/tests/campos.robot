*** Settings ***
Documentation        Validação de campos obrigatórios de cadastro e produtos

Resource            ../resources/base.resource
Resource            ../resources/cadastro.resource
Resource            ../resources/produtos.resource
Resource            ../resources/campos.resource

Test Setup          iniciar sessao
Test Teardown       Take Screenshot 

*** Test Cases ***
CT01:Não permitir campos vazios no cadastro
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

