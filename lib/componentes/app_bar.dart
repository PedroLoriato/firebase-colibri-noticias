import 'package:colibri_noticias/paginas/cadastrar_colaborador.dart';
import 'package:colibri_noticias/paginas/inicio.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool mostrarAcoes;

  const CustomAppBar({
    super.key,
    required this.title,
    this.mostrarAcoes = true, 
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'Cadastrar':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CadastrarColaborador()),
        );
        break;
      case 'Sair':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Inicio(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Colaborador deslogado com sucesso!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
        );
        setState(() {
          GerenciadorColaborador.logout();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: widget.mostrarAcoes
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GerenciadorColaborador.isLogado()
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          GerenciadorColaborador.colaboradorLogado!.avatar,
                        ),
                        child: PopupMenuButton<String>(
                          onSelected: _handleMenuSelection,
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              if (GerenciadorColaborador.podeCadastrar())
                                const PopupMenuItem<String>(
                                  value: 'Cadastrar',
                                  child: Text('Cadastrar Colaborador'),
                                ),
                              const PopupMenuItem<String>(
                                value: 'Sair',
                                child: Text(
                                  'Sair',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ];
                          },
                          icon: Container(),
                          offset: const Offset(0, kToolbarHeight),
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
            ]
          : [],
      title: Padding(
        padding: const EdgeInsets.only(left: 5),
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
      shadowColor: Colors.black.withValues(alpha: 0.5),
    );
  }
}