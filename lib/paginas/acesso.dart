import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/campo_formulario.dart';
import 'package:colibri_noticias/main.dart'; // Supondo que sua TelaPrincipal esteja aqui
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:colibri_noticias/utilitarios/validadores.dart';
import 'package:flutter/material.dart';

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

  bool _estaCarregando = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    senhaController = TextEditingController();
    emailFocus = FocusNode();
    senhaFocus = FocusNode();
  }

  void _mostrarSnackBarDeErro(String mensagem) {
    final mensagemLimpa = mensagem.replaceFirst('Exception: ', '');
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagemLimpa),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _fazerLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _estaCarregando = true;
    });

    try {
      await GerenciadorColaborador.login(
        emailController.text,
        senhaController.text,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TelaPrincipal()),
        );
      }

    } on Exception catch (e) {
      _mostrarSnackBarDeErro(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _estaCarregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double responsiveWidth = width > 600 ? 500 : width * 0.95;

    return Scaffold(
      appBar: CustomAppBar(title: "Acesso"),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: responsiveWidth,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ACESSO',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CampoFormulario(
                          controller: emailController,
                          focusNode: emailFocus,
                          label: "Email",
                          placeholder: "seuemail@dominio.com",
                          prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                          validator: validarEmail,
                          inputFormatters: null,
                        ),
                        CampoFormulario(
                          controller: senhaController,
                          focusNode: senhaFocus,
                          label: "Senha",
                          placeholder: "Digite sua senha",
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                          validator: validarSenha,
                          inputFormatters: null,
                          isPasswordField: true,
                        ),
                        const SizedBox(height: 24),
                        _estaCarregando
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _fazerLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColorDark,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
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