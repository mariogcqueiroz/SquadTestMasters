*** Settings ***
Documentation       Ações e elementos da página de cadastro de produtos
Library             Browser

*** Keywords ***
Preencher formulário de produto
    [Arguments]    ${produto}
    Fill Text    id:nome         ${produto}[nome]
    Fill Text    id:preco        ${produto}[preco]
    Fill Text    id:descricao    ${produto}[descricao]
    Fill Text    id:quantidade   ${produto}[quantidade]

Submeter formulário de produto
    Click        css=button[type=submit]

Verificar mensagem de sucesso
    [Arguments]    ${mensagem_esperada}
    Wait For Elements State
    ...    css=.alert-link >> text=${mensagem_esperada}
    ...    visible
    ...    5s

Verificar alertas dos campos obrigatórios
    Get Text    css=.form-text >> nth=0    equal    Nome é obrigatório
    Get Text    css=.form-text >> nth=1    equal    Preco é obrigatório
    Get Text    css=.form-text >> nth=2    equal    Descricao é obrigatório
    Get Text    css=.form-text >> nth=3    equal    Quantidade é obrigatório