# <img src="assets/imagens/logo.png" alt="Logo do Colibri Notícias" width="45" style="vertical-align: middle;"> Colibri Notícias

![Flutter](https://img.shields.io/badge/Flutter-3.29.1-blue?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.7.0-blue?style=for-the-badge&logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-14.9.0-orange?style=for-the-badge&logo=firebase)

**Desenvolvido por:** Pedro Henrique Loriato & Katiane Maciel do Nascimento

> **Observação:** Este aplicativo é um projeto acadêmico, desenvolvido como requisito para obtenção de nota na disciplina de Desenvolvimento Mobile II. Ele não possui fins comerciais e foi criado exclusivamente para demonstração de aprendizado.

## 📌 Sobre o Projeto

O **Colibri Notícias** é um aplicativo de notícias multiplataforma (Android e Web) desenvolvido com **Flutter**. O projeto oferece uma experiência fluida e dinâmica para os usuários que desejam se manter informados com conteúdos focados na região de Santa Teresa, ES. O app possui uma interface moderna e intuitiva, permitindo a leitura e o gerenciamento de notícias com facilidade.

## ✨ Funcionalidades Principais

- **Visualização de Notícias**: Tela principal com a listagem de todas as notícias publicadas.
- **Filtro por Categoria**: Navegação intuitiva por categorias para encontrar notícias de interesse.
- **Autenticação Segura**: Área restrita para colaboradores com login e senha.
- **Gerenciamento de Conteúdo**: Colaboradores autenticados podem adicionar, editar e excluir notícias.
- **Design Responsivo**: Interface adaptada tanto para dispositivos móveis quanto para a web.

## 🛠️ Arquitetura e Tecnologias

O projeto foi construído utilizando o **Flutter** como framework de frontend e o **Firebase** como uma solução completa de *Backend as a Service* (BaaS), o que permitiu um desenvolvimento ágil e escalável.

### Frontend
- **Flutter**: Framework de desenvolvimento para criar interfaces nativas compiladas para mobile e web a partir de uma única base de código.
- **Dart**: Linguagem de programação principal, otimizada para a construção de interfaces de usuário.

### Backend e Banco de Dados (Firebase)

A plataforma Firebase foi utilizada para fornecer toda a infraestrutura de backend, incluindo:

-   **Firestore Database**: Utilizado como o banco de dados NoSQL principal. Ele armazena todas as informações da aplicação, como notícias, categorias e dados dos colaboradores. Sua natureza em tempo real garante que o frontend seja atualizado instantaneamente quando há novas publicações.

-   **Firebase Authentication**: Responsável por gerenciar a autenticação dos colaboradores de forma segura. Implementamos o método de login com e-mail e senha, garantindo que apenas usuários autorizados possam criar ou modificar o conteúdo do portal de notícias.

-   **Firebase Indexes**: Para otimizar as consultas no Firestore, foram configurados índices compostos. Isso permite que a aplicação realize buscas complexas de forma eficiente, como filtrar notícias por uma categoria específica e, ao mesmo tempo, ordená-las por data de publicação, garantindo uma experiência de usuário rápida e sem gargalos.

## 🚀 Como Testar

Existem duas maneiras de testar o aplicativo: instalando o APK pronto ou executando o projeto localmente.

### 1. Instalando o APK (Android)

A forma mais simples de testar é instalar o aplicativo diretamente no seu dispositivo Android.

1.  Baixe o arquivo `app-release.apk` presente neste repositório.
2.  Transfira o arquivo para o seu celular e permita a instalação de fontes desconhecidas, se solicitado.
3.  Instale o APK e o aplicativo estará pronto para uso.

### 2. Executando o Projeto Localmente

Para clonar e rodar o projeto em sua máquina, siga os passos:

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/PedroLoriato/firebase-colibri-noticias.git
    ```
2.  **Acesse o diretório:**
    ```bash
    cd colibri_noticias
    ```
3.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```
4.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```
> **Importante:** As pastas `assets` e `web` são essenciais para a identidade visual do app (logo, avatares, favicon, splash screen) e devem estar presentes no diretório local do projeto.

---

## 🔐 Dados de Acesso (Colaboradores)

Para testar as funcionalidades de gerenciamento de conteúdo, utilize as credenciais de um dos colaboradores abaixo na tela de acesso.

| Colaborador | Email | Senha |
| :--- | :--- | :--- |
| Pedro Henrique Loriato | `pedro@email.com` | `senha123` |
| Katiane Maciel do Nascimento | `katiane@email.com` | `senha234` |

## 🌐 Nota sobre CORS no Flutter Web

Durante o desenvolvimento no **Flutter Web** em modo *debug*, o navegador impõe restrições de **Same-Origin Policy**, o que pode impedir o carregamento de imagens de outras fontes. Para contornar isso, utilizamos um proxy:

`https://cors-anywhere.herokuapp.com/`

Caso as imagens ainda não sejam exibidas, pode ser necessário ativar o acesso temporário na página de demonstração do proxy:
[https://cors-anywhere.herokuapp.com/corsdemo](https://cors-anywhere.herokuapp.com/corsdemo)