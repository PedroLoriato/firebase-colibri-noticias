import 'package:colibri_noticias/servicos/gerenciador_categorias.dart';
import 'package:flutter/material.dart';
import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/cartao_noticia.dart';
import 'package:colibri_noticias/modelos/noticia.dart';
import 'package:colibri_noticias/modelos/categoria.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:colibri_noticias/servicos/gerenciador_noticia.dart';
import 'cadastrar_noticia.dart';

class Noticias extends StatefulWidget {
  const Noticias({super.key});

  @override
  State<Noticias> createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  late List<Categoria> categorias = [];

  String categoriaSelecionada = 'Todos';

  @override
  void initState() {
    super.initState();
    carregarCategorias();
  }

  Future<void> carregarCategorias() async {
    final List<Categoria> categoriasCarregadas =
        await GerenciadorCategoria.carregarCategorias();
    setState(() {
      categorias = [Categoria(nome: 'Todos'), ...categoriasCarregadas];
    });
  }

  Future<void> _carregarNoticias() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notícias"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                separatorBuilder: (context, __) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  final isSelected = categoria.nome == categoriaSelecionada;

                  return ChoiceChip(
                    label: Text(
                      categoria.nome,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                    selected: isSelected,
                    selectedColor: const Color.fromARGB(255, 0, 151, 5),
                    onSelected: (_) {
                      setState(() {
                        categoriaSelecionada = categoria.nome;
                      });
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    side: BorderSide(
                      color:
                          isSelected
                              ? const Color.fromARGB(0, 0, 0, 0)
                              : const Color.fromARGB(255, 0, 151, 5),
                      width: 1.5,
                    ),
                    showCheckmark: true,
                    elevation: isSelected ? 4 : 2,
                    shadowColor: Colors.black.withValues(alpha: 0.15),
                    pressElevation: 2,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Noticia>>(
                future:
                    categoriaSelecionada == 'Todos'
                        ? GerenciadorNoticia.carregarNoticias()
                        : GerenciadorNoticia.filtrarNoticiasPorCategoria(
                          categoriaSelecionada,
                        ),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Noticia>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString().contains('ERRO_SERVIDOR')
                            ? 'O servidor não está respondendo. Tente novamente mais tarde.'
                            : 'Ocorreu um erro ao carregar as notícias.',
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma notícia encontrada.'),
                    );
                  } else {
                    final noticiasExibidas = snapshot.data!;

                    return ListView.builder(
                      padding: EdgeInsets.only(
                        bottom:
                            GerenciadorColaborador.isLogado()
                                ? kBottomNavigationBarHeight + 70
                                : kBottomNavigationBarHeight,
                      ),
                      itemCount: noticiasExibidas.length,
                      itemBuilder: (context, index) {
                        final noticia = noticiasExibidas[index];
                        return CartaoNoticia(
                          id: noticia.id!,
                          imagem: noticia.imagemUrl,
                          fonte: noticia.fonte,
                          titulo: noticia.titulo,
                          resumo: noticia.resumo,
                          link: noticia.linkUrl,
                          dataHoraPublicacao: noticia.dataHoraPublicacao,
                          nomeColaborador: noticia.colaborador.primeiroNome(),
                          dataHoraAdicao: noticia.dataHoraAdicao,
                          categoria: noticia.categoria,
                          noticiasAtualizadas: _carregarNoticias,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          GerenciadorColaborador.isLogado()
              ? Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: FloatingActionButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CadastroNoticias(),
                      ),
                    );
                    setState(() {});
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.add, color: Colors.black),
                ),
              )
              : null,
    );
  }
}
