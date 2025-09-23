*** Settings ***
Documentation        Elementos e ações para a validação de campos obrigatórios vazios

Resource             base.resource

*** Keywords ***
Alert should be
    [Arguments]      ${expected_text}

    Wait For Elements State              xpath=//span[text()="${expected_text}"]
    ...             visible              5