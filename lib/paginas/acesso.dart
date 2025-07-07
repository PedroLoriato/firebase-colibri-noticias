import 'package:brasil_fields/brasil_fields.dart';
import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/campo_formulario.dart';
import 'package:colibri_noticias/main.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:colibri_noticias/utilitarios/validadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Acesso extends StatefulWidget {
  const Acesso({super.key});

  @override
  State<Acesso> createState() => _AcessoState();
}

class _AcessoState extends State<Acesso> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController senhaController;
  late FocusNode emailFocus;
  late FocusNode senhaFocus;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    senhaController = TextEditingController();
    emailFocus = FocusNode();
    senhaFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double responsiveWidth = width * 0.95;

    return Scaffold(
      appBar: CustomAppBar(title: "Acesso"),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: responsiveWidth,
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ACESSO',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      width: responsiveWidth,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CampoFormulario(
                            controller: emailController,
                            focusNode: emailFocus,
                            label: "Email",
                            placeholder: "seuemail@dominio",
                            prefixIcon: Icon(
                              Icons.account_box,
                              color: Colors.grey,
                              size: 24,
                            ),
                            validator: validarEmail,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')),
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                          ),
                          CampoFormulario(
                            controller: senhaController,
                            focusNode: senhaFocus,
                            label: "Senha",
                            placeholder: "Digite sua senha",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                              size: 24,
                            ),
                            validator: validarSenha,
                            inputFormatters: null,
                            isPasswordField: true,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                try {
                                  await GerenciadorColaborador.login(
                                    emailController.text,
                                    senhaController.text
                                  );
                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TelaPrincipal(),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Colaborador logado com sucesso!",
                                        ),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                  setState(() {
                                    emailController.clear();
                                    senhaController.clear();
                                  });
                                } on FormatException catch (error) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          error.message,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ), // Texto em branco para contraste
                                        ),
                                        backgroundColor: Colors.red,
                                        behavior:
                                            SnackBarBehavior
                                                .floating, // Define o fundo da SnackBar como vermelho
                                      ),
                                    );
                                  }
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Preencha todos os campos corretamente!",
                                      style: TextStyle(color: Colors.white), //
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior:
                                        SnackBarBehavior
                                            .floating, // Define o fundo da SnackBar como vermelho
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
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

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();

    emailFocus.dispose();
    senhaFocus.dispose();

    super.dispose();
  }
}
