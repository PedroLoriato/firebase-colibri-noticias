import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/campo_formulario.dart';
import 'package:colibri_noticias/modelos/colaborador.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

class CadastrarColaborador extends StatefulWidget {
  const CadastrarColaborador({super.key});

  @override
  State<CadastrarColaborador> createState() => _CadastrarColaboradorState();
}

class _CadastrarColaboradorState extends State<CadastrarColaborador> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _avatarSelecionado;

  final _nomeFocus = FocusNode();
  final _sobrenomeFocus = FocusNode();
  final _cpfFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _senhaFocus = FocusNode();

  final List<String> _avataresDisponiveis = [
    'assets/imagens/avatar1.png',
    'assets/imagens/avatar2.png',
    'assets/imagens/avatar3.png',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _nomeFocus.dispose();
    _sobrenomeFocus.dispose();
    _cpfFocus.dispose();
    _emailFocus.dispose();
    _senhaFocus.dispose();
    super.dispose();
  }

  Future<void> _selecionarAvatar() async {
    FocusScope.of(context).unfocus();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecione um Avatar'),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: _avataresDisponiveis.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final avatar = _avataresDisponiveis[index];
                return GestureDetector(
                  onTap: () {
                    setState(() => _avatarSelecionado = avatar);
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatar),
                    radius: 30,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _cadastrar() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_avatarSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione um avatar.'),
          backgroundColor: Colors.orangeAccent,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await GerenciadorColaborador.cadastrarColaborador(
        Colaborador(
          nome: _nomeController.text,
          sobrenome: _sobrenomeController.text,
          cpf: _cpfController.text,
          email: _emailController.text,
          senha: _senhaController.text,
          avatar: _avatarSelecionado!,
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Colaborador cadastrado com sucesso!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                e.toString().replaceAll("Exception: ", "")),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Cadastrar Colaborador", mostrarAcoes: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _selecionarAvatar,
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _avatarSelecionado != null
                          ? AssetImage(_avatarSelecionado!)
                          : null,
                      child: _avatarSelecionado == null
                          ? Icon(Icons.add_a_photo,
                              size: 40, color: Colors.grey.shade600)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Toque no ícone para escolher um avatar',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                const SizedBox(height: 20),
                CampoFormulario(
                  controller: _nomeController,
                  focusNode: _nomeFocus,
                  label: 'Nome',
                  placeholder: 'Digite o nome',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo obrigatório' : null,
                  inputFormatters: [],
                ),
                CampoFormulario(
                  controller: _sobrenomeController,
                  focusNode: _sobrenomeFocus,
                  label: 'Sobrenome',
                  placeholder: 'Digite o sobrenome',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo obrigatório' : null,
                  inputFormatters: [],
                ),
                CampoFormulario(
                  controller: _cpfController,
                  focusNode: _cpfFocus,
                  label: 'CPF',
                  placeholder: '000.000.000-00',
                  prefixIcon: const Icon(Icons.badge_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                ),
                CampoFormulario(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  label: 'E-mail',
                  placeholder: 'exemplo@email.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Formato de e-mail inválido';
                    }
                    return null;
                  },
                  inputFormatters: [],
                ),
                CampoFormulario(
                  controller: _senhaController,
                  focusNode: _senhaFocus,
                  label: 'Senha',
                  placeholder: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(Icons.lock_outline),
                  isPasswordField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                  inputFormatters: [],
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _cadastrar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cadastrar Colaborador',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}