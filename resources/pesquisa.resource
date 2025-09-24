*** Keywords ***

# Aguardar e realizar a pesquisa de produto que existe
Pesquisar produto que existe pelo nome
    [Arguments]    ${nome_produto}
    Wait For Elements State    //h5[normalize-space()='Listar Produtos']    visible    10
    Click    //a[@data-testid='listarProdutos']
    
    # Aguardar resultados
    Wait For Elements State    //td[normalize-space()='Mouse Gamer RGB']    

# Aguardar e realizar a pesquisa de produto que não existe
Pesquisar produto que não existe pelo nome
    [Arguments]    ${nome_produto}
    Wait For Elements State    //h5[normalize-space()='Listar Produtos']    visible    10
    Click    //a[@data-testid='listarProdutos']
    


# Verificação genérica de que está logado e na tela correta
Conferencia do teste
    Wait For Elements State    .lead    visible    5