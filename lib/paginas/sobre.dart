import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/botao_social.dart';
import 'package:colibri_noticias/componentes/cartao_colaborador.dart';
import 'package:colibri_noticias/main.dart';
import 'package:colibri_noticias/servicos/gerenciador_noticia.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  List<int> listaNumPublicacoes = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarContagens();
  }

  Future<void> carregarContagens() async {
    try {
      List<int> contagens = [];
      for (var colaborador in listaColaboradores) {
        final count = await GerenciadorNoticia.contarNoticiasPorColaborador(
          colaborador.nomeCompleto(),
        );
        contagens.add(count);
      }
      setState(() {
        listaNumPublicacoes = contagens;
        carregando = false;
      });
    } catch (e) {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sobre"),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                minimum: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "O Aplicativo",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Nosso aplicativo de notícias foi criado para trazer informações relevantes e positivas da sua cidade. Com uma interface intuitiva e de fácil acesso, buscamos manter você sempre atualizado com conteúdos de qualidade. Nosso objetivo é fornecer notícias que impactam a comunidade de maneira construtiva, destacando histórias inspiradoras, iniciativas locais e acontecimentos que fazem a diferença.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Colaboradores",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    /// Primeiro colaborador
                    CartaoColaborador(
                      imagem: listaColaboradores[0].imagem,
                      nomeCompleto: listaColaboradores[0].nomeCompleto(),
                      numPublicacoes: listaNumPublicacoes.isNotEmpty
                          ? listaNumPublicacoes[0]
                          : 0,
                      botoesSociais: [
                        BotaoSocial(
                          link: Uri.parse(
                              "https://www.github.com/PedroLoriato"),
                          nomeBotao: "GitHub",
                          primeiraCorGradiente:
                              const Color.fromARGB(255, 30, 30, 30),
                          segundaCorGradiente:
                              const Color.fromARGB(255, 60, 60, 60),
                        ),
                        BotaoSocial(
                          link: Uri.parse(
                              "https://www.linkedin.com/in/pedroloriato/"),
                          nomeBotao: "Linkedin",
                          primeiraCorGradiente:
                              const Color.fromARGB(255, 0, 90, 234),
                          segundaCorGradiente:
                              const Color.fromARGB(255, 0, 108, 224),
                        ),
                        BotaoSocial(
                          link: Uri.parse(
                              "https://www.instagram.com/pedroloriato"),
                          nomeBotao: "Instagram",
                          primeiraCorGradiente:
                              const Color.fromARGB(255, 158, 0, 97),
                          segundaCorGradiente:
                              const Color.fromARGB(255, 107, 0, 207),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Segundo colaborador
                    CartaoColaborador(
                      imagem: listaColaboradores[1].imagem,
                      nomeCompleto: listaColaboradores[1].nomeCompleto(),
                      numPublicacoes: listaNumPublicacoes.length > 1
                          ? listaNumPublicacoes[1]
                          : 0,
                      botoesSociais: [
                        BotaoSocial(
                          link: Uri.parse(
                              "https://www.github.com/katiane-nascimento"),
                          nomeBotao: "GitHub",
                          primeiraCorGradiente:
                              const Color.fromARGB(255, 30, 30, 30),
                          segundaCorGradiente:
                              const Color.fromARGB(255, 60, 60, 60),
                        ),
                        BotaoSocial(
                          link: Uri.parse(
                              "https://www.linkedin.com/in/katiane-maciel-do-nascimento-a26951260/"),
                          nomeBotao: "Linkedin",
                          primeiraCorGradiente:
                              const Color.fromARGB(255, 0, 90, 234),
                          segundaCorGradiente:
                              const Color.fromARGB(255, 0, 108, 224),
                        ),
                        BotaoSocial(
                          link: Uri.parse(
                              "https://www.instagram.com/katiane.maciel.nascimento/"),
                          nomeBotao: "Instagram",
                          primeiraCorGradiente:
                              const Color.fromARGB(255, 158, 0, 97),
                          segundaCorGradiente:
                              const Color.fromARGB(255, 107, 0, 207),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Faça Parte desse Projeto!",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Ajude a manter a população de Santa Teresa sempre bem informada! Nosso aplicativo reúne todas as notícias da região em um só lugar, centralizando as principais fontes de informação para que ninguém fique de fora dos acontecimentos. Seja um colaborador e contribua para levar informação de qualidade à nossa comunidade!",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Entre em contato conosco pelo nosso WhatsApp!",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          fixedSize: const Size(150, 50),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Essa funcionalidade estará disponível em breve!"),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.whatsapp,
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "WhatsApp",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}