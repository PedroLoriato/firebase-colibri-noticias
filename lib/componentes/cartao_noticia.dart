import 'package:brasil_fields/brasil_fields.dart';
import 'package:colibri_noticias/paginas/editar_noticia.dart';
import 'package:colibri_noticias/servicos/gerenciador_colaborador.dart';
import 'package:colibri_noticias/servicos/gerenciador_noticia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CartaoNoticia extends StatefulWidget {
  final String id;
  final Uri imagem;
  final String titulo;
  final String resumo;
  final String fonte;
  final Uri link;
  final DateTime dataHoraPublicacao;
  final String nomeColaborador;
  final DateTime dataHoraAdicao;
  final String categoria;
  final VoidCallback? noticiasAtualizadas;

  const CartaoNoticia({
    super.key,
    required this.id,
    required this.imagem,
    required this.titulo,
    required this.resumo,
    required this.fonte,
    required this.link,
    required this.dataHoraPublicacao,
    required this.nomeColaborador,
    required this.dataHoraAdicao,
    required this.categoria,
    this.noticiasAtualizadas,
  });

  @override
  State<CartaoNoticia> createState() => _CartaoNoticiaState();
}

class _CartaoNoticiaState extends State<CartaoNoticia> {
  String tempoAdicao() {
    final now = DateTime.now();
    if (kDebugMode) {
      print(now);
      print(widget.dataHoraAdicao);
    }
    final difference = now.difference(widget.dataHoraAdicao);
    if (kDebugMode) {
      print(difference);
    }
    if (UtilData.obterDataDDMMAAAA(now) ==
        UtilData.obterDataDDMMAAAA(widget.dataHoraAdicao)) {
      return 'Hoje';
    } else if (difference.inDays <= 1) {
      return 'Ontem';
    } else if (difference.inDays < 7) {
      return 'Há ${difference.inDays} dias';
    } else if (difference.inDays < 30) {
      return 'Há uma semana';
    } else if (difference.inDays < 365) {
      return 'Há ${difference.inDays ~/ 30} mês(es)';
    } else {
      return 'Há ${difference.inDays ~/ 365} ano(s)';
    }
  }

  Future<void> _abrirURL(Uri url) async {
    if (kIsWeb) {
      await launchUrl(url, webOnlyWindowName: '_blank');
    } else {
      await launchUrl(url);
    }
  }

  Future<void> _confirmarAcao(BuildContext context) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Opções'),
          content: const Text('O que você deseja fazer?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.pop(context);
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarNoticias(noticia: widget),
                  ),
                );

                if (resultado == true) {
                  widget.noticiasAtualizadas?.call();
                }
              },
              child: const Text('Editar', style: TextStyle(color: Colors.blue)),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                _confirmarExclusao(context);
              },
              child: const Text('Deletar', style: TextStyle(color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmarExclusao(BuildContext context) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text(
            'Deseja mesmo deletar? Esta ação é irreversível.',
          ),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.pop(context);
                await _deletarNoticia(context);
                widget.noticiasAtualizadas?.call();
              },
              child: const Text('Sim', style: TextStyle(color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletarNoticia(BuildContext context) async {
    try {
      await GerenciadorNoticia.deletarNoticia(widget.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notícia deletada com sucesso!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao deletar: $e',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${UtilData.obterDataDDMMAAAA(widget.dataHoraPublicacao)} '
              '${UtilData.obterHoraHHMM(widget.dataHoraPublicacao) != "00:00" ? UtilData.obterHoraHHMM(widget.dataHoraPublicacao) : ""}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onLongPress: () {
              GerenciadorColaborador.isLogado() ? _confirmarAcao(context) : null;
            },
            onTap: () {
              _abrirURL(widget.link);
            },
            child: Stack(
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(widget.imagem.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: MediaQuery.of(context).size.width * 3 / 4,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withValues(alpha: 0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        widget.fonte,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.85),
                          Colors.black.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.titulo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.resumo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  children: [
                    const TextSpan(text: 'Adicionada por '),
                    TextSpan(
                      text: widget.nomeColaborador,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                tempoAdicao(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
