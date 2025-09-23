Diretório de arquivos da squad TestMasters -  Setembro de 2025
Projeto de testes automatizados FrontEnd utilizando Robot Framework e Browser
Na pasta base, para rodar os testes utilize 
MacOS
python3 -m robot -d ./reports ./tests

Windows 
python -m robot -d ./reports ./tests


├── resources/        # Recursos compartilhados (keywords, variáveis, etc.)
├── tests/            # Casos de teste
│   ├── cadastro.robot
│   ├── login.robot
│   ├── produtos.robot
│   └── reports/      # Relatórios de execução
├── .gitignore
└── README.md

Requisitos
```bash
pip install robotframework
pip install robotframework-browser
rfbrowser init

