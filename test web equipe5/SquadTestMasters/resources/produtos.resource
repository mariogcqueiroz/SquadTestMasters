*** Settings ***
Documentation       Ações e elementos da página de cadastro de produtos
Library             Browser

*** Keywords ***
Acessar a página de cadastro de produtos
    Click    css=[data-testid="cadastrarProdutos"]
    # Checkpoint para garantir que estamos na página certa
    Wait For Elements State
    ...    css=h1 >> text=Cadastro de Produtos
    ...    visible
    ...    5s

Preencher formulário de produto
    [Arguments]    ${produto}
    Fill Text    css=[data-testid="nome"]        ${produto}[nome]
    Fill Text    css=[data-testid="preco"]        ${produto}[preco]
    Fill Text    css=[data-testid="descricao"]     ${produto}[descricao]
    Fill Text    css=[data-testid="quantity"]    ${produto}[quantidade]

Submeter formulário de produto
    Click        css=button[type=submit] >> text=Cadastrar

Página de listagem de produtos deve ser exibida
    Wait For Elements State
    ...    css=h1 >> text=Lista dos Produtos
    ...    visible
    ...    2s
Verificar alertas dos campos obrigatórios
    Get Text    css=.form-text >> nth=0    equal    Nome é obrigatório
    Get Text    css=.form-text >> nth=1    equal    Preco é obrigatório
    Get Text    css=.form-text >> nth=2    equal    Descricao é obrigatório
    Get Text    css=.form-text >> nth=3    equal    Quantidade é obrigatório