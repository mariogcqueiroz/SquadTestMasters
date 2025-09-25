# CodeReview do Squad 6

Autores: Squad TestMasters

Code Review da Squad F12

# Checklist de melhorias

## Geral

- \[ \] Há padronização de idioma (todo o código em português ou todo em inglês).
- \[ \] Nomes de arquivos seguem o mesmo padrão (`Login.robot`, `Signup.robot`, `ShoppingList.robot`).
- \[ \] Todos os casos têm tags coerentes (`login`, `signup`, `produto`, `busca`, `exclusao`, `smoke`, `negativo`).
- \[ \] Nenhum teste depende da execução de outro (independência garantida).
- \[ \] Massa de dados criada de forma dinâmica (e-mails randômicos, IDs únicos).
- \[ \] Teardown limpa dados criados (usuários, produtos, listas).
- \[ \] Não há uso de `Sleep`; somente `Wait For Elements State` ou equivalente.
- \[ \] Não existem warnings de sintaxe deprecada (`[Return]` → `RETURN`).
- \[ \] Keywords seguem padrão ação + objeto (ex.: `Add product to shopping list`).

## Login

- \[ \] Casos de teste possuem tags (`login`, `positivo`, `negativo`, etc.).
- \[ \] Nomes estão padronizados e consistentes (“Não deve permitir login com campos vazios”).
- \[ \] Há timeouts explícitos nos asserts pós-login (ex.: dashboard visível em 5s).
- Foram cobertos cenários:
  - \[ \] Login válido (usuário comum).
  - \[ \] Login inválido (campos vazios, senha incorreta, usuário inexistente).

## Módulo de Produtos (Adição e Limpeza de Lista de Compras)

- \[ \] Não há dependência de usuário fixo na base (fixture dinâmica ou `Ensure user exists`).
- \[ \] Cada teste inicia com lista de compras vazia.
- \[ \] Há keyword de Setup de massa (`Ensure product exists`).
- \[ \] Produtos adicionados são removidos no teardown.
- \[ \] Cobertura de cadastro de produtos está contemplada (não só a lista de compras).
- \[ \] Aviso de sintaxe deprecada foi resolvido (`RETURN` no lugar de `[Return]`).

## Busca e Exclusão (Produtos e Usuários)

- \[ \] Há testes de busca de produtos (nome válido, inexistente, acentos, paginação).
- \[ \] Há testes de busca de usuários (e-mail/nome).
- \[ \] Cobertura de exclusão de produtos inclui:
  - \[ \] Limpar toda lista.
  - \[ \] Excluir item específico.
  - \[ \] Excluir múltiplos itens.
- \[ \] Há testes de exclusão de usuários (via UI ou API).
- \[ \] Casos negativos estão presentes:
  - \[ \] Busca sem input.
  - \[ \] Exclusão sem seleção.
  - \[ \] Exclusão de item inexistente.
  - \[ \] Exclusão sem permissão.
- \[ \] Assert de feedback visual presente (toast, badge atualizado, contador de itens).
- \[ \] Estados intermediários (loading/disabled) são validados.

## Cadastro de Usuários (Signup)

- \[ \] Cobertura dos cenários principais:
  - \[ \] Cadastro com sucesso.
  - \[ \] Cadastro com e-mail duplicado.
  - \[ \] Campos obrigatórios não preenchidos.
  - \[ \] E-mail inválido.
- \[ \] Massa de dados criada com Faker/UUID.
- \[ \] Seletores seguem uma estratégia única (preferência CSS).
- \[ \] Campos do mesmo formulário usam mesmo tipo de seletor.

## Integração e Manutenção

- \[ \] Testes rodam em paralelo sem colisão de dados.
- \[ \] Há rotina de reset/seed previsível no ambiente antes dos testes.
- \[ \] Cada massa de dados é logada com identificador único (e-mail/ID) para rastreabilidade.
- \[ \] Métricas coletadas: tempo por caso, taxa de falhas/flakes, cobertura funcional.

* * *

Detalhamento dos pontos levantados

# **Login**

### **Pontos positivos**  

1. Organização clara
2. Nomes descritivos nos testes
3. Boa separação de casos
4. Uso de fixtures para dados
5. Setup/Teardown configurado

### **Sugestões**

### **1\. Adicionar TAGS**

\*\*\* Test Cases \*\*\*  
Deve permitir o login de um usuário comum pré-cadastrado  
\[Tags\] login positivo smoke  
${user} Get fixture credenciais usuario\_cadastrado

### **2\. Padronizar os nome**s

#### De:

Não deve permitir o login com campos vazios

#### Para:

Não deve permitir login com campos vazios  
\[Tags\] login negativo campos\_vazios

### **3\. Adicionar timeouts (importante!)**

```
Submit login form            ${user}
Wait For Elements State      css=.dashboard    visible    5    
User should be logged in
```

## Adição e limpeza de produtos na lista de compras (Módulo de produtos)  

### Pontos positivos

- Estrutura bem organizada em **arquivos separados** (`.resource` para keywords e `.robot` para testes).
- Uso de **fixtures** (`Get fixture credenciais usuario_cadastrado`) já mostra uma intenção de centralizar dados.
- Keywords bem nomeadas (`Product should be in shopping list`, `Clear shopping list`) → boa legibilidade.
- Boa prática de **esperas explícitas** (`Wait For Elements State`) em vez de sleeps fixos.

### Problemas encontrados

1. **Dependência da massa de dados**
  - `usuario_cadastrado` estático não garante que o usuário exista no banco.
  - Se alguém limpar a base, os testes quebram.
  - Isso gera fragilidade e impede execução paralela/independente.
2. **Acoplamento entre testes**
  - O primeiro teste adiciona um produto.
  - O segundo teste depende do estado da lista de compras (já populada).
  - Isso fere a regra de independência dos testes.
3. **Granularidade de keywords**
  - Keywords como `Add product to shopping list` e `Clear shopping list` são boas, mas seria interessante ter uma keyword de **Setup de massa**, por exemplo `Ensure user exists`.
4. **Falta de teardown de dados**
  - Após adicionar itens, eles ficam na lista (dependendo da ordem de execução, isso quebra outro teste).
5. **Nomenclatura inconsistente**
  - `shoppingList.robot` deveria seguir o mesmo padrão de capitalização dos outros (`Signup.robot`, `Login.robot`).

### Sugestões de melhoria

### 1\. **Repensar a geração de massa**

- Abandonar fixtures estáticas para usuários que podem deixar de existir.
- Criar **massa dinâmica** durante os testes (geração de usuário com e-mail randômico, por exemplo).
- Caso seja inevitável fixture estática (exemplo: admin fixo), deve haver rotina de reset ou mock do backend.

### **2\. Garantir independência dos testes**

- Cada teste deve criar seu próprio usuário e garantir login antes de rodar.
- Se necessário, criar keywords de **setup de massa** (`Ensure user exists)`, pois no estado atual os testes não chegam a rodar caso a base não tenha o usuário previamente cadastrado na base.

### **3\. Sintaxe**

- Ao executar a suíte de testes `shoppingList.robot`, há um warning:
  -
on line 25: The '[Return]' setting is deprecated. 
Use the 'RETURN' statement instead.


### **4\. Cobertura**

- Incorre-se que não há implementação de testes que abarcam a funcionalidade de cadastro ou demais ações no módulo de produtos, apenas a lista de compras.

* * *

# Busca e exclusão de elementos (produtos e usuários)

## Pontos Positivos

### 1\. Exclusão de produtos implementada via “limpeza”

Há um cenário explícito de remoção da lista de compras: `Deve permitir a limpeza dos produtos da lista de compras` que aciona a keyword **Clear shopping list**. Isso confirma que a funcionalidade de exclusão de produtos está coberta nos testes.

### 2\. Fluxos de autenticação e cadastro bem separados

Suites e casos de teste para **Login** e **Signup** estão isolados e com boa legibilidade, o que facilita preparar massa de dados para cenários de busca/exclusão mais complexos depois.

### 3\. Uso de pages/keywords

O log mostra chamadas de páginas/keywords como `ShoppingListPage`, `LoginPage`, etc., reforçando a boa prática de encapsular interação e deixar os testes legíveis.

## Problemas encontrados

### 1\. Busca de produtos não está clara/não aparece

Não há casos, passos ou keywords de **search/busca** por produtos na UI (ex.: filtrar por nome, pesquisar item). Os testes de lista de compras adicionam um item direto e depois limpam a lista; não há evidência de uma busca/filtragem na interface.

### 2\. Exclusão de usuários inexistente

Os suites e casos carregados no log cobrem **Login** e **Signup**; não há nenhum caso de **exclusão de usuário** na interface (ou via API) sendo exercitado. Ou seja, **delete de usuários não está coberto**.

### 3\. Busca de usuários também inexistente

Não consegui encontrar cenário/keyword que realize **busca/pesquisa de usuários** (ex.: filtrar por email/nome em uma tabela). Todos os cenários de usuários são de **criação** (CT001–CT004) e validações.

### 4\. Cobertura de exclusão de produtos restrita ao “clear all”

A remoção é feita pelo **Clear shopping list** (limpa tudo). Falta um cenário de **remoção pontual** (ex.: apagar apenas um item específico), que é essencial para cobrir regressões em botões “remover” por linha.

## Sugestão de melhoria

1. **Cobrir busca (produtos e usuários):** adicionar casos que validem filtro por termo, semântica de “zero resultados”, paginação e normalização (acentos/maiúsculas). Garantir asserts no contador de resultados e presença/ausência em tabela/lista.
2. **Exclusão granular e em massa:** além do “limpar tudo”, incluir remoção de item específico, múltipla seleção e confirmação/cancelamento. Validar efeitos colaterais (contadores, mensagens de feedback, estado do botão desfazer se existir).
3. **Independência de massa:** abandonar dependência de usuário fixo; criar massa dinâmica por teste (ou `Ensure … exists`) e desmontar ao final. Padronizar “pré-condição → ação → verificação → limpeza”.
4. **Resiliência e sinais de UI:** substituir sleeps por esperas condicionais e checkpoints visuais (toast, badge, mudança de linha). Validar estados intermediários (loading/disabled) para reduzir flakiness.
5. **Padronização e rastreabilidade:** tags coerentes (`busca`, `exclusao`, `produto`, `usuario`, `ui`, `smoke`), nomes de casos no imperativo e prefixos consistentes. Logar o identificador único da massa (email/ID) nos steps para auditoria.
6. **Negativos críticos:** busca sem input, termo inexistente, filtros combinados; exclusão sem seleção, tentativa de excluir item inexistente ou sem permissão; mensagens de erro e códigos de status (se API for usada).
7. **Page Objects/Resources coesos:** unificar seletores acessíveis e estáveis (data-testid), separar ações (interação) de asserções (estado), e evitar acoplamento entre casos (nenhum teste deve depender do anterior).
8. **Ciclo de vida em CI:** seed/reset previsível do ambiente, execução paralela sem colisão de dados, coleta de métricas (tempo por caso, taxa de flake) e relatório de cobertura funcional especificamente para “busca” e “exclusão”.

## Cadastro de usuários

**Pontos positivos:**  
. A organização do projeto segue excelentes práticas, como o uso do Page Object Model, a separação de código e a configuração centralizada.

. Os testes em signup.robot cobrem os cenários mais importantes: cadastro com sucesso; Cenário negativo com e-mail duplicado; Validação de campos e validação de formato com e-mail incorreto.

. A utilização da FakerLibrary para gerar e-mails únicos é uma boa prática, pois isso garante que os testes não falhem por dados pré-existentes no banco de dados

**Sugestão de melhorias:**

. No arquivo `signup.resource`, diferentes estratégias de seletores são usadas para campos do mesmo formulário. Embora todos funcionem, padronizar o uso de uma única estratégia, preferencialmente CSS Selectors por serem mais rápidos e legíveis que XPath, torna o código mais limpo e fácil de manter.