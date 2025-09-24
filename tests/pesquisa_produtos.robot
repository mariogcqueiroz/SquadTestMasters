*** Settings ***
Documentation       Casos de teste para pesquisa de produtos
Resource            ../resources/base.resource
Resource            ../resources/pesquisa.resource
Test Setup          iniciar sessao
Test Teardown       Take Screenshot

*** Test Cases ***

CT01: Pesquisar produto existente
    [Tags]    pesquisa    produto_existente
    Criar e Logar como Administrador Dinâmico
    pesquisa.Conferencia do teste

    Pesquisar produto que existe pelo nome    Mouse Gamer RGB


CT02: Pesquisar produto inexistente
    [Tags]    pesquisa    produto_inexistente
    Criar e Logar como Administrador Dinâmico
    pesquisa.Conferencia do teste

    Pesquisar produto que não existe pelo nome    IPhone 14 Pro Max
   