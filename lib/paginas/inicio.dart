import 'package:colibri_noticias/paginas/acesso.dart';
import 'package:colibri_noticias/main.dart';
import 'package:colibri_noticias/servicos/gerenciador_inicio.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double responsiveWidth = width * 0.95; // 80% da largura da tela

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: responsiveWidth,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/imagens/logo.png',
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "COLIBRI NOTÍCIAS",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Bem-vindo ao Colibri Notícias!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "O Colibri Notícias conecta você às principais novidades de Santa Teresa, no Espírito Santo. ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Atualizações diárias ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "garantem que moradores, turistas e apaixonados pela cidade fiquem sempre bem informados.\n\n",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Aqui você encontra o melhor da ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "cultura, lazer, gastronomia e esportes, ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "além de eventos, saúde e política. ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Tudo em um só lugar.\n\n",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text:
                              "Acompanhe notícias de última hora, cobertura de eventos e informações relevantes para o seu dia a dia.\n\n",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text:
                              "Fique por dentro de tudo o que realmente importa em Santa Teresa – ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "rápido, fácil e confiável.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Para continuar, selecione uma das opções abaixo:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      await GerenciadorInicio.salvarOpcao("leitor");
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaPrincipal(),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(
                        double.infinity,
                        50,
                      ), // Largura 100% da tela, altura 50
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor:
                          Colors.transparent, // Cor de fundo normal
                      side: BorderSide(
                        color: Colors.black.withValues(
                          alpha: 0.5,
                        ), // Cor e opacidade da borda
                        width: 0.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Bordas arredondadas
                      ),
                      splashFactory: InkRipple.splashFactory,
                      overlayColor: Colors.black.withValues(
                        alpha: 0.2,
                      ), // Efeito de toque
                    ),
                    child: Text(
                      "SOU UM LEITOR",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500, // Peso de fonte mais forte
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      await GerenciadorInicio.salvarOpcao("colaborador");
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Acesso()),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(
                        double.infinity,
                        50,
                      ), // Largura 100% da tela, altura 50
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor:
                          Theme.of(context).primaryColorDark, // Cor do tema
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Bordas arredondadas
                      ),
                      splashFactory: InkRipple.splashFactory,
                      overlayColor: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withValues(alpha: 0.2),
                    ),
                    child: Text(
                      "SOU UM COLABORADOR",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
