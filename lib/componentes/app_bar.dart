import 'package:colibri_noticias/paginas/inicio.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0), // Padding para ações
          child:
              GerenciadorColaborador.isLogado()
                  ? CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                      GerenciadorColaborador.colaboradorLogado!.avatar,
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'Sair') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Inicio(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Colaborador deslogado com sucesso!"),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                            ),
                          );
                          setState(() {
                            GerenciadorColaborador.logout();
                          });
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'Sair',
                            child: Text(
                              'Sair',
                              style: const TextStyle(
                                color: Colors.red, // Define o texto em vermelho
                                fontWeight: FontWeight.bold, // Aplica negrito
                              ),
                            ),
                          ),
                        ];
                      },
                      icon: Container(),
                      offset: const Offset(
                        0,
                        kToolbarHeight,
                      ), // Alinha o dropdown
                    ),
                  )
                  : IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Inicio()),
                      );
                    },
                    icon: const Icon(Icons.home),
                  ),
        ),
      ],
      title: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
      ),
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.50),
    );
  }
}
