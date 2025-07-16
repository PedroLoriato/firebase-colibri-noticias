import 'package:brasil_fields/brasil_fields.dart';
import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/campo_formulario.dart';
import 'package:colibri_noticias/componentes/cartao_noticia.dart';
import 'package:colibri_noticias/modelos/categoria.dart';
import 'package:colibri_noticias/modelos/noticia.dart';
import 'package:colibri_noticias/servicos/gerenciador_categoria.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:colibri_noticias/servicos/gerenciador_noticia.dart';
import 'package:colibri_noticias/utilitarios/validadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditarNoticias extends StatefulWidget {
  final CartaoNoticia noticia;

  const EditarNoticias({super.key, required this.noticia});

  @override
  State<EditarNoticias> createState() => _EditarNoticiasState();
}

class _EditarNoticiasState extends State<EditarNoticias> {
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

    imagemController = TextEditingController(
      text: widget.noticia.imagem.toString(),
    );
    fonteController = TextEditingController(text: widget.noticia.fonte);
    linkController = TextEditingController(
      text: widget.noticia.link.toString(),
    );
    tituloController = TextEditingController(text: widget.noticia.titulo);
    resumoController = TextEditingController(text: widget.noticia.resumo);
    dataHoraPublicacaoController = TextEditingController(
      text:
          '${UtilData.obterDataDDMMAAAA(widget.noticia.dataHoraPublicacao)} ${UtilData.obterHoraHHMM(widget.noticia.dataHoraPublicacao)}',
    );
    categoriaController = TextEditingController(text: widget.noticia.categoria);

    imagemFocus = FocusNode();
    fonteFocus = FocusNode();
    linkFocus = FocusNode();
    tituloFocus = FocusNode();
    resumoFocus = FocusNode();
    dataHoraPublicacaoFocus = FocusNode();
    categoriaFocus = FocusNode();
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double responsiveWidth = width * 0.95;

    return Scaffold(
      appBar: CustomAppBar(title: "Editar Notícia"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                'Editar Notícia',
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
                    children: [
                      CampoFormulario(
                        controller: imagemController,
                        focusNode: imagemFocus,
                        label: 'Imagem',
                        placeholder: 'URL da imagem',
                        prefixIcon: const Icon(Icons.image),
                        validator: validarUrl,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: fonteController,
                        focusNode: fonteFocus,
                        label: 'Fonte',
                        placeholder: 'Fonte da notícia',
                        prefixIcon: const Icon(Icons.newspaper),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: linkController,
                        focusNode: linkFocus,
                        label: 'Link',
                        placeholder: 'Link da fonte',
                        prefixIcon: const Icon(Icons.link),
                        validator: validarUrl,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: tituloController,
                        focusNode: tituloFocus,
                        label: 'Título',
                        placeholder: 'Título da notícia',
                        prefixIcon: const Icon(Icons.title),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: resumoController,
                        focusNode: resumoFocus,
                        label: 'Resumo',
                        placeholder: 'Resumo da notícia',
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
                          ? const CircularProgressIndicator(color: Colors.blue)
                          : ElevatedButton(
                            onPressed: () {
                              _editarNoticia();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
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
                              "Editar",
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

  Future<void> _editarNoticia() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      _mostrarSnackBar("Preencha todos os campos corretamente!", Colors.red);
      return;
    }
    setState(() {
      _carregando = true;
    });

    try {
      Categoria categoria =
          await GerenciadorCategoria.temCategoria(categoriaController.text) ??
          await GerenciadorCategoria.adicionarCategoria(
            Categoria(nome: categoriaController.text),
          );

      final noticiaEditada = Noticia(
        id: widget.noticia.id,
        imagem: Uri.parse(imagemController.text),
        fonte: fonteController.text,
        link: Uri.parse(linkController.text),
        titulo: tituloController.text,
        resumo: resumoController.text,
        dataHoraPublicacao: UtilData.obterDateTimeHora(
          dataHoraPublicacaoController.text,
        ),
        dataHoraAdicao: widget.noticia.dataHoraAdicao,
        categoria: categoria,
        colaborador: widget.noticia.colaborador,
      );
      await GerenciadorNoticia.editarNoticia(noticiaEditada);

      if (mounted) {
        Navigator.pop(context, true); 
        _mostrarSnackBar("Notícia atualizada com sucesso!", Colors.green);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        _mostrarSnackBar("Erro ao editar notícia: $e", Colors.red);
      }
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  void _mostrarSnackBar(String mensagem, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      ),
    );
  }
}
