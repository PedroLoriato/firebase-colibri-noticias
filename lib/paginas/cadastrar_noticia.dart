import 'package:brasil_fields/brasil_fields.dart';
import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/campo_formulario.dart';
import 'package:colibri_noticias/modelos/categoria.dart';
import 'package:colibri_noticias/modelos/noticia.dart';
import 'package:colibri_noticias/servicos/gerenciador_categoria.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:colibri_noticias/servicos/gerenciador_noticia.dart';
import 'package:colibri_noticias/utilitarios/validadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroNoticias extends StatefulWidget {
  const CadastroNoticias({super.key});

  @override
  State<CadastroNoticias> createState() => _CadastroNoticiasState();
}

class _CadastroNoticiasState extends State<CadastroNoticias> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController imagemController;
  late TextEditingController fonteController;
  late TextEditingController linkController;
  late TextEditingController tituloController;
  late TextEditingController resumoController;
  late TextEditingController dataHoraPublicacaoController;
  late TextEditingController categoriaController;

  late FocusNode imagemFocus;
  late FocusNode fonteFocus;
  late FocusNode linkFocus;
  late FocusNode tituloFocus;
  late FocusNode resumoFocus;
  late FocusNode dataHoraPublicacaoFocus;
  late FocusNode categoriaFocus;

  bool _carregando = false;

  @override
  void initState() {
    super.initState();
    imagemController = TextEditingController();
    fonteController = TextEditingController();
    linkController = TextEditingController();
    tituloController = TextEditingController();
    resumoController = TextEditingController();
    dataHoraPublicacaoController = TextEditingController();
    categoriaController = TextEditingController();

    imagemFocus = FocusNode();
    fonteFocus = FocusNode();
    linkFocus = FocusNode();
    tituloFocus = FocusNode();
    resumoFocus = FocusNode();
    dataHoraPublicacaoFocus = FocusNode();
    categoriaFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double responsiveWidth = width * 0.95;

    return Scaffold(
      appBar: CustomAppBar(title: "Cadastro de Notícias"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Cadastrar Notícia',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
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
                        controller: imagemController,
                        focusNode: imagemFocus,
                        label: 'Imagem',
                        placeholder: 'Coloque a URL da imagem',
                        prefixIcon: const Icon(Icons.image),
                        validator: validarUrl,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: fonteController,
                        focusNode: fonteFocus,
                        label: 'Fonte',
                        placeholder: 'Coloque o nome da fonte da notícia',
                        prefixIcon: const Icon(Icons.newspaper),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: linkController,
                        focusNode: linkFocus,
                        label: 'Link',
                        placeholder: 'Coloque a URL da fonte da notícia',
                        prefixIcon: const Icon(Icons.link),
                        validator: validarUrl,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: tituloController,
                        focusNode: tituloFocus,
                        label: 'Título',
                        placeholder: 'Coloque o título da notícia',
                        prefixIcon: const Icon(Icons.title),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: resumoController,
                        focusNode: resumoFocus,
                        label: 'Resumo',
                        placeholder: 'Coloque o resumo da notícia',
                        prefixIcon: const Icon(Icons.text_snippet),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: dataHoraPublicacaoController,
                        focusNode: dataHoraPublicacaoFocus,
                        label: 'Data e Hora de Publicação',
                        placeholder: 'DD/MM/AAAA HH:MM',
                        prefixIcon: const Icon(Icons.calendar_today),
                        validator: validarDataHora,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        isDateField: true,
                      ),
                      FutureBuilder<List<String>>(
                        future: GerenciadorCategoria.carregarNomesCategorias(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Erro: ${snapshot.error}');
                          } else {
                            final categorias = snapshot.data ?? [];

                            return CampoFormulario(
                              controller: categoriaController,
                              focusNode: categoriaFocus,
                              label: 'Categoria',
                              placeholder:
                                  'Selecione ou adicione uma categoria',
                              prefixIcon: const Icon(Icons.category),
                              validator: validarCampoTexto,
                              inputFormatters: [],
                              isSelectField: true,
                              selectOptions: categorias,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      _carregando
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                            onPressed: _cadastrarNoticia,
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
                            child: const Text(
                              "Cadastrar",
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
    );
  }

  void _cadastrarNoticia() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Preencha todos os campos corretamente!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        ),
      );
      return;
    }

    setState(() {
      _carregando = true;
    });

    try {
      Categoria categoria = await GerenciadorCategoria.temCategoria(categoriaController.text) ?? await GerenciadorCategoria.adicionarCategoria(
        Categoria(nome: categoriaController.text),
      );

      Noticia novaNoticia = Noticia(
        imagem: Uri.parse(imagemController.text),
        fonte: fonteController.text,
        link: Uri.parse(linkController.text),
        titulo: tituloController.text,
        resumo: resumoController.text,
        dataHoraPublicacao: UtilData.obterDateTimeHora(
          dataHoraPublicacaoController.text,
        ),
        categoria: categoria,
        colaborador: GerenciadorColaborador.colaboradorLogado!,
      );
      await GerenciadorNoticia.adicionarNoticia(novaNoticia);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Notícia adicionada com sucesso!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
        );
      }
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  void dispose() {
    imagemController.dispose();
    fonteController.dispose();
    linkController.dispose();
    tituloController.dispose();
    resumoController.dispose();
    dataHoraPublicacaoController.dispose();
    categoriaController.dispose();

    imagemFocus.dispose();
    fonteFocus.dispose();
    linkFocus.dispose();
    tituloFocus.dispose();
    resumoFocus.dispose();
    dataHoraPublicacaoFocus.dispose();
    categoriaFocus.dispose();

    super.dispose();
  }
}
