<h1 style="display: flex; align-items: center; justify-content: center; gap: 10px;"><img src="assets/imagens/logo.png" alt="Logo do Colibri Notícias" width="50">Colibri Notícias</h1>

![Flutter](https://img.shields.io/badge/Flutter-3.29.1-blue?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.7.0-blue?style=for-the-badge&logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-14.9.0-orange?style=for-the-badge&logo=firebase)

**Desenvolvido por:** Pedro Henrique Loriato & Katiane Maciel do Nascimento

> **Observação:** Este aplicativo é um projeto acadêmico, desenvolvido como requisito para obtenção de nota na disciplina de Desenvolvimento Mobile II. Ele não possui fins comerciais e foi criado exclusivamente para demonstração de aprendizado.

## 📌 Sobre o Projeto
O **Colibri Notícias** é um aplicativo de notícias multiplataforma (Android e Web) desenvolvido com **Flutter**. O projeto oferece uma experiência fluida e dinâmica para os usuários que desejam se manter informados com conteúdos focados na região de Santa Teresa, ES. O app possui uma interface moderna e intuitiva, permitindo a leitura e o gerenciamento de notícias com facilidade.

## ✨ Funcionalidades Principais
- **Visualização de Notícias:** Tela principal com a listagem de todas as notícias publicadas.
- **Filtro por Categoria:** Navegação intuitiva por categorias para encontrar notícias de interesse.
- **Autenticação de Colaboradores:** Sistema completo de login com e-mail e senha integrado ao Firebase Authentication.
- **Recuperação de Senha:** Funcionalidade que permite aos colaboradores redefinirem suas senhas através de um link enviado por e-mail.
- **Gerenciamento de Conteúdo:** Colaboradores autenticados podem adicionar, editar e excluir notícias e seus respectivos avatares.
- **Cadastro Restrito de Colaboradores:** Apenas usuários com permissão de administrador (os desenvolvedores) podem cadastrar novos colaboradores no sistema.
- **Design Responsivo:** Interface adaptada tanto para dispositivos móveis quanto para a web.

## 🛠️ Arquitetura e Tecnologias
O projeto foi construído utilizando o **Flutter** como framework de frontend e o **Firebase** como uma solução completa de *Backend as a Service* (BaaS), o que permitiu um desenvolvimento ágil e escalável.

### Frontend
- **Flutter:** Framework de desenvolvimento para criar interfaces nativas compiladas para mobile e web a partir de uma única base de código.
- **Dart:** Linguagem de programação principal, otimizada para a construção de interfaces de usuário.

### Backend e Banco de Dados (Firebase)
A plataforma Firebase foi utilizada para fornecer toda a infraestrutura de backend:

- **Firebase Authentication:** Gerencia todo o ciclo de vida da autenticação dos colaboradores.
    - **Login com E-mail e Senha:** Garante que apenas usuários autorizados possam acessar a área administrativa.
    - **Cadastro de Novos Usuários:** Permite a criação de novas contas de colaboradores.
    - **Recuperação de Senha:** Utiliza o serviço nativo do Firebase para enviar e-mails de redefinição de senha de forma segura.
    - **Controle de Acesso:** A lógica de permissão para cadastrar novos colaboradores é validada diretamente no backend, garantindo que apenas os UIDs dos administradores (Pedro e Katiane) possam executar essa ação.

- **Firestore Database:** Utilizado como o banco de dados NoSQL principal. Ele armazena todas as informações da aplicação, como notícias, categorias e os dados dos colaboradores (nome, e-mail, URL do avatar, etc.). Sua natureza em tempo real garante que o frontend seja atualizado instantaneamente quando há novas publicações.

- **Cloud Storage for Firebase:** Responsável pelo armazenamento de arquivos de mídia. Nesta aplicação, é utilizado para fazer o upload e hospedar as imagens de avatar dos colaboradores, que são selecionadas do dispositivo do usuário no momento do cadastro.

- **Firebase Indexes:** Para otimizar as consultas no Firestore, foram configurados índices compostos. Isso permite que a aplicação realize buscas complexas de forma eficiente, como filtrar notícias por categoria e ordená-las por data, garantindo uma experiência de usuário rápida e sem gargalos.

## 🚀 Como Testar
Existem duas maneiras de testar o aplicativo: instalando o APK pronto ou executando o projeto localmente.

### 1. Instalando o APK (Android)
A forma mais simples de testar é instalar o aplicativo diretamente no seu dispositivo Android.
1. Baixe o arquivo `colibri-noticias.apk` presente neste repositório.
2. Transfira o arquivo para o seu celular e permita a instalação de fontes desconhecidas, se solicitado.
3. Instale o APK e o aplicativo estará pronto para uso.

### 2. Executando o Projeto Localmente
Para clonar e rodar o projeto em sua máquina, siga os passos:

1. **Clone o repositório:**
   ```bash
   git clone [https://github.com/PedroLoriato/firebase-colibri-noticias.git](https://github.com/PedroLoriato/firebase-colibri-noticias.git)
