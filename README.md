# Projeto de Gerenciamento de Clientes em Java (Estilo "Page-centric")

**Status do Projeto:** Em Execução

## Resumo do Projeto

O projeto consiste em um sistema de gerenciamento de clientes desenvolvido em Java utilizando a abordagem "page-centric". O sistema oferece funcionalidades básicas de cadastro e consulta de clientes e utiliza o PostgreSQL como banco de dados e o Apache Tomcat 9 como servidor web Java.

### Estilo de Arquitetura "Page-centric"

O projeto adota uma abordagem "page-centric", onde a lógica do aplicativo é incorporada diretamente nas páginas JSP (JavaServer Pages). Isso significa que as páginas JSP contêm não apenas a marcação HTML, mas também o código Java para manipular a lógica do aplicativo.

### Funcionalidades do Sistema

- **Cadastro de Clientes:** Os usuários podem preencher um formulário HTML para cadastrar novos clientes. A lógica de validação e inserção de dados no banco de dados é tratada nas páginas JSP.
- **Consulta de Clientes:** Os usuários podem consultar a lista de clientes existentes, e os resultados da consulta são exibidos nas páginas JSP.
- **Banco de Dados PostgreSQL:** O projeto utiliza o PostgreSQL como sistema de gerenciamento de banco de dados para armazenar informações de clientes.

### Teste e Depuração

O projeto inclui testes e depuração para garantir que as funcionalidades funcionem conforme o esperado. O Apache Tomcat 9 é usado para executar o aplicativo localmente e depurar problemas.

### Fins de Estudo

Este projeto é criado principalmente para fins de estudo, permitindo que você explore a implementação de uma aplicação web Java usando uma abordagem "page-centric". Embora essa abordagem não seja a mais indicada para projetos de produção, ela fornece uma compreensão valiosa das JSPs e como o Java pode ser incorporado diretamente nas páginas HTML.
