# <div style="display:flex; align-items:center; gap:10px;"><img src="assets/imagens/logo.png" alt="Logo do Colibri Notícias" width="50">Colibri Notícias</div>

**Desenvolvido por:** Pedro Henrique Loriato & Katiane Maciel do Nascimento

## 📌 Sobre o Projeto
O **Colibri Notícias** é um aplicativo de notícias desenvolvido com **Flutter**, proporcionando uma experiência fluida e dinâmica para os usuários que desejam se manter informados com conteúdos atualizados sobre as notícias específicas de Santa Teresa. 

O app possui uma interface moderna e intuitiva, permitindo a leitura e gerenciamento de notícias com facilidade.

**OBS:** Este aplicativo é um projeto acadêmico, desenvolvido como requisito para obtenção de nota na disciplina de Desenvolvimento Mobile I. Ele não está disponível publicamente, não possui suporte para licenças comerciais, e foi criado exclusivamente para fins educacionais e demonstração de aprendizado.


## 📥 APK Buildado para Android

O aplicativo **Colibri Notícias** já está **buildado** para dispositivos Android e disponível no arquivo `app-release.apk`. Esse APK está pronto para ser **baixado e instalado** diretamente no seu dispositivo, oferecendo acesso completo às funcionalidades do app. Aproveite para explorar e se familiarizar com a interface e os recursos!


## 🔐 Dados de Login Padrão dos Colaboradores

Por padrão, o aplicativo conta com **dois colaboradores** cadastrados para testes. Use as credenciais abaixo para autenticar-se como colaborador:

### Colaborador 1:
- **Nome:** Pedro Henrique Loriato  
- **CPF:** 123.456.789-00  
- **Senha:** senha123  

### Colaboradora 2:
- **Nome:** Katiane Maciel do Nascimento  
- **CPF:** 123.456.789-01  
- **Senha:** senha234  

---
🛠 **Fique à vontade para testar o APK do Colibri Notícias!** Ele foi projetado para proporcionar uma experiência incrível enquanto você explora suas funcionalidades. Em caso de dúvidas ou feedbacks, não hesite em compartilhar. 🚀


## 📱 Telas do Aplicativo
O **Colibri Notícias** é estruturado em cinco telas principais:

1. **Início** - Tela de apresentação do aplicativo com opções de se o usuário é leitor ou colaborador.
2. **Acesso** - Tela para login e autenticação do colaborador.
3. **Notícias** - Lista completa das notícias publicadas.
4. **Cadastrar Notícia** - Interface para adicionar novas notícias ao sistema.
5. **Sobre** - Informações sobre o aplicativo e seus desenvolvedores/colaboradores.


## 🌐 CORS e Debug no Flutter Web

Durante o desenvolvimento no **Flutter Web**, algumas imagens podem enfrentar restrições devido à política de mesma origem (**Same-Origin Policy**). Para contornar esse problema no **modo debug**, as imagens são carregadas com o seguinte prefixo:

```
https://cors-anywhere.herokuapp.com/
```
Isso permite que as imagens sejam renderizadas corretamente no navegador. Para produção, recomenda-se o uso de um backend que gerencie essas requisições de forma segura.

Caso a imagem mesmo assim não renderize, pode ser preciso ativar a liberação do CORS temporariamente na api, utilizando este link:

```
https://cors-anywhere.herokuapp.com/corsdemo
```  
---


## 📂 Importação da Pasta `web`
Para garantir a identidade visual do aplicativo no Flutter Web, é **preferencial importar a pasta `web` no repositório local**, pois ela contém:

✅ **Favicon** - Ícone do app exibido na aba do navegador.  
✅ **Splash Screen** - Tela de carregamento inicial do aplicativo.

Essa pasta é essencial para uma experiência de usuário mais completa e profissional no ambiente web.


## 📂 Importação da Pasta `assets`
A pasta `assets` também é fundamental e deve ser importada no diretório local do projeto, pois contém arquivos essenciais para o design e funcionamento do aplicativo, como:

✅ **Logo** - Logotipo do app, exibido nas telas de início e outras partes do app.  
✅ **Avatares dos Colaboradores** - Imagens usadas para representar os colaboradores no app.  
✅ **Outras Imagens** - Qualquer outro recurso visual necessário para a interface, como banners e ícones.

Garantir que essa pasta esteja corretamente configurada e importada é essencial para manter a integridade visual e funcional do aplicativo.


## 🚀 Tecnologias Utilizadas
- **Flutter** para o desenvolvimento do app.
- **Dart** como linguagem principal.